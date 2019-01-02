#use "semantic-analyser.ml";;

module type CODE_GEN = sig
  val make_consts_tbl : expr' list -> (constant * (int * string)) list
  val make_fvars_tbl : expr' list -> (string * int) list
  val generate : (constant * (int * string)) list -> (string * int) list -> expr' -> string
  val get_const_addr : 'a -> ('a * ('b * 'c)) list -> 'b 
  val get_fvar_addr : 'a -> ('a * 'b) list -> 'b
  val primitive_names_to_labels : (string * string) list

  (* Add funcs for tests *)
  (* TODO: delete later *)
  val scan_ast : expr' list -> sexpr list
  val remove_dups : 'a list -> 'a list
  val expand_lst : sexpr list -> sexpr list
  val cons_tbl : sexpr list -> (constant * (int * string)) list
end;;

(* 
  update 2.1, 14:20
      .1. Done lambda simple, ! should to understand where to decrement the env_count counter !

  update 2.1, 3:05
    Done:
      .1. cons, car, cdr, set-car!, set-cdr! (here and assembly code in prims.s)
      
    TODO:
      .1. finish LambdaSimple' & check it
      .2. continue to other LambdaOPT & ApplicTP'.
      .3. write apply variadic in assembly
      .4. check unimplemented functions in scheme (via pdf) and implement them.
      .5. Make order in code & run tests (e.g, from facebook) 
  *)

let count = (ref 0);;
let env_count = (ref 0);;

module Code_Gen : CODE_GEN = struct

  (* 1. Scan the AST (one recursive pass) & collect the sexprs in all Const records - The result is a list of sexprs *)
  let rec scan_ast asts consts = 
    match asts with
      | car :: cdr -> (match car with
                        | Const' Sexpr expr -> scan_ast cdr [expr] @ consts
                        | Set' (expr1, expr2) | Def' (expr1, expr2) -> scan_ast cdr consts @ (scan_ast ([expr1] @ [expr2]) consts) 
                        | If' (test, dit, dif) -> scan_ast cdr consts @ (scan_ast ([test]@[dit]@[dif]) consts) 
                        | Seq' exprs | Or' exprs  -> scan_ast cdr consts @ (scan_ast exprs consts) 
                        | LambdaSimple' (_, body) -> scan_ast cdr consts @ (scan_ast [body] consts) 
                        | LambdaOpt' (_, _, body) | BoxSet' (_,body) -> raise X_not_yet_implemented
                        | Applic' (op, exprs) | ApplicTP' (op, exprs) -> scan_ast cdr consts @ (scan_ast ([op] @ exprs) consts) 
                        | _ -> scan_ast cdr consts)
      | _ -> consts ;;

  let scan_ast asts = scan_ast asts [] ;;

  (* 2. Convert the list to a set (removing duplicates) *)
  let rec remove_dups lst = 
    match lst with
      | [] -> []
      | car :: cdr -> car :: (remove_dups (List.filter (fun e -> e <> car) cdr)) ;;

  (* 3. Expand list include all sub-constants, list should be sorted topologically, Logic of code from ps #11, 2.2.1 *)
  let rec expand_lst lst newLst =
    match lst with
      | car :: cdr -> 
          (match car with
            | Symbol (str) -> expand_lst cdr ([String str; car] @ newLst)
            | Pair(currCar, currCdr) -> expand_lst cdr ((expand_lst [currCar] []) @ (expand_lst [currCdr] []) @ [car] @ newLst)
            | Vector (elems) -> 
                let vecLst = expand_lst elems [] in
                expand_lst cdr (newLst @ vecLst @ [car])
            | _ -> expand_lst cdr ([car] @ newLst))
      | [] -> newLst ;;

  let expand_lst lst = expand_lst lst [] ;;

  (* Helper func, got sexpr, return size_of it *)
  let rec size_of sexpr =
    match sexpr with
      | Nil -> 1
      | Bool _ | Char _ -> 2
      | Number _ | Symbol _ -> 9
      | String(s) -> 9 + (String.length s)
      | Pair _ -> 17
      | Vector(v) -> 9 + (8 * (List.length v));;

  let get_const const tbl = List.assoc const tbl;;

  (* Helper func, got const and tbl, return addr of const *)
  let get_const_addr const tbl =
    let (addr, _) = get_const const tbl 
  in addr;;

  (* Helper func for parse vec to tbl, got vec and tbl => return string of consts + addr of all elems in vec *)
  let vec_const vec tbl = 
    let lst_string = List.map (fun s -> "const_tbl+" ^ string_of_int (get_const_addr (Sexpr s) tbl)) vec in
    String.concat ", " lst_string;;

  (* Cons_tbl helper func, got consts, tbl and addr, return tbl (at the end of recursion) *)
  let rec cons_tbl consts tbl addr =
    match consts with
    | car :: cdr -> 
      (match car with
        | Bool _ | Nil -> cons_tbl cdr tbl addr
        | Char ch -> cons_tbl cdr (tbl @ [(Sexpr(Char ch), (addr, "MAKE_LITERAL_CHAR('" ^ String.make 1 ch ^ "') ;my address is "^ (string_of_int addr) ))]) (addr + size_of car)
        | String expr -> cons_tbl cdr (tbl @ [(Sexpr(String expr), (addr, "MAKE_LITERAL_STRING \"" ^ expr ^ "\" ;my address is "^ (string_of_int addr)))]) (addr + size_of car)
        | Number(Int num) -> 
          cons_tbl cdr (tbl @ [(Sexpr(Number(Int num)), (addr, "MAKE_LITERAL_INT(" ^ (string_of_int num) ^ ") ;my address is "^ (string_of_int addr)))]) (addr + size_of car)
        | Number(Float num) -> 
          cons_tbl cdr (tbl @ [(Sexpr(Number(Float num)), (addr, "MAKE_LITERAL_FLOAT(" ^ (string_of_float num) ^ ") ;my address is "^ (string_of_int addr)))]) (addr + size_of car)
        | Symbol sym -> 
          cons_tbl cdr (tbl @ [(Sexpr(Symbol sym), (addr, "MAKE_LITERAL_SYMBOL(const_tbl+" ^ 
            string_of_int (get_const_addr (Sexpr(String sym)) tbl) ^ ") ;my address is "^ (string_of_int addr)))]) (addr + size_of car) 
        | Pair (f, s) -> 
          cons_tbl cdr (tbl @ [(Sexpr(Pair (f, s)), (addr, "MAKE_LITERAL_PAIR(const_tbl+" ^ 
            string_of_int (get_const_addr (Sexpr f) tbl) ^ ", const_tbl+" ^ string_of_int (get_const_addr (Sexpr s) tbl) ^ ") ;my address is "^ (string_of_int addr)))]) (addr + size_of car)
        | Vector vec -> cons_tbl cdr (tbl @ [(Sexpr(Vector vec)), (addr, "MAKE_LITERAL_VECTOR " ^ vec_const vec tbl ^" ;my address is "^ (string_of_int addr))]) (addr + size_of car))
    | [] -> tbl ;;
    
  (* Cons_tbl main func *)
  let cons_tbl consts = cons_tbl consts [
    (Void, (0, "MAKE_VOID ;my address is 0"));
    (Sexpr(Nil), (1, "MAKE_NIL ;my address is 1"));
    (Sexpr(Bool false), (2, "MAKE_BOOL(0) ;my address is 2"));
    (Sexpr(Bool true), (4, "MAKE_BOOL(1) ;my address is 4"));
    ] 6;;
    

  (*  expr' list -> (constant * (int * string)) list *)
  let make_consts_tbl asts = cons_tbl(remove_dups(expand_lst(remove_dups(scan_ast asts))));;

  (* ----------------------fvar table---------------------- *)
  let rec scan_fvars asts fvars = 
    match asts with
      | car :: cdr -> (match car with
                        | Var'(VarFree expr) -> scan_fvars cdr [expr] @ fvars
                        | Def'(Var'(VarFree expr), _) -> scan_fvars cdr ([expr] @ fvars) (*TODO: check if add more cases*)
                        | Applic' (op, exprs) -> scan_fvars cdr fvars @ (scan_fvars ([op] @ exprs) fvars) 
                        | LambdaSimple' (_,body) -> scan_fvars cdr fvars @ (scan_fvars [body] fvars)
                        | _ -> scan_fvars cdr fvars)
      | _ -> fvars ;;

  let scan_fvars asts = scan_fvars asts [] ;;

  let primitive_names_to_labels = 
    ["boolean?", "is_boolean"; "float?", "is_float"; "integer?", "is_integer"; "pair?", "is_pair";
     "null?", "is_null"; "char?", "is_char"; "vector?", "is_vector"; "string?", "is_string";
     "procedure?", "is_procedure"; "symbol?", "is_symbol"; "string-length", "string_length";
     "string-ref", "string_ref"; "string-set!", "string_set"; "make-string", "make_string";
     "vector-length", "vector_length"; "vector-ref", "vector_ref"; "vector-set!", "vector_set";
     "make-vector", "make_vector"; "symbol->string", "symbol_to_string"; 
     "char->integer", "char_to_integer"; "integer->char", "integer_to_char"; "eq?", "is_eq";
     "+", "bin_add"; "*", "bin_mul"; "-", "bin_sub"; "/", "bin_div"; "<", "bin_lt"; "=", "bin_equ";
     "car", "car"; "cdr", "cdr"; "set-car!", "set_car"; "set-cdr!", "set_cdr";
     "cons", "cons"
     ];;
     (*TODO: check if need to add here car,cdr,map*)

  let first (x, y) = x;;

  let saved_fvars = List.map first primitive_names_to_labels;;

  let rec cons_fvars fvars tbl addr =
    match fvars with
    | car :: cdr -> cons_fvars cdr (tbl @ [(car,addr)]) (addr + 1) 
    | [] -> tbl ;;
    
  let cons_fvars fvars = cons_fvars (remove_dups(saved_fvars@fvars)) [] 0;;

  (* expr' list -> (string * int) list *)
  let make_fvars_tbl asts = cons_fvars(scan_fvars asts);;

  let get_fvar_addr fvar tbl = List.assoc fvar tbl;;

  (* (constant * (int * string)) list -> (string * int) list -> expr' -> string *)
  let rec generate consts fvars e = 
    match e with
    | Const' (expr) -> "\tmov rax, const_tbl+" ^ (string_of_int(get_const_addr expr consts)) ^ "\n"
    | Var'(VarParam(_,pos)) -> "\tmov rax, PVAR("^ (string_of_int pos) ^")\n"
    | Def'(Var'(VarFree(name)),expr) -> (generate consts fvars expr) ^
                                        "\tmov qword [fvar_tbl+"^(string_of_int(get_fvar_addr name fvars))^"*WORD_SIZE], rax ;; define case in generate func\n" ^
                                        "\tmov rax, SOB_VOID_ADDRESS\n" 
    | Set'(Var'(VarParam(_, pos)),expr) -> (generate consts fvars expr) ^ 
                                            "\tmov qword PVAR("^(string_of_int pos)^"), rax\n"^
                                            "\tmov rax, SOB_VOID_ADDRESS\n"
    | Var'(VarBound(_,depth,pos)) -> "\tmov rax, qword [rbp + 8 ∗ 2]\n" ^
                                      "\tmov rax, qword [rax + 8 ∗ " ^ (string_of_int depth) ^ "]\n" ^
                                      "\tmov rax, qword [rax + 8 ∗ " ^ (string_of_int pos) ^ "]\n" 
    | Set'(Var'(VarBound(_,depth,pos)),expr) -> (generate consts fvars expr) ^
                                                "\tmov rbx, qword [rbp + 8 ∗ 2]\n" ^
                                                "\tmov rbx, qword [rbx + 8 ∗ "^(string_of_int depth)^"]\n"^
                                                "\tmov qword [rbx + 8 ∗ "^(string_of_int pos)^"], rax\n" ^
                                                "\tmov rax, SOB_VOID_ADDRESS\n"
    | Var'(VarFree v) -> "\tmov rax, qword [fvar_tbl+"^ (string_of_int(get_fvar_addr v fvars)) ^"*WORD_SIZE]\n"
    | Set'(Var'(VarFree(v)),expr) -> (generate consts fvars expr) ^ 
                                      "\tmov qword [fvar_tbl+"^(string_of_int(get_fvar_addr v fvars))^"*WORD_SIZE], rax\n"^
                                      "\tmov rax, SOB_VOID_ADDRESS\n"
    | Seq'(exprs) -> String.concat "\n" (List.map (generate consts fvars) exprs)
    | Or'(exprs) -> let current = !count in
                    count := !count +1;
                    let or_gen consts fvars expr =
                      (generate consts fvars expr) ^ 
                      "\t" ^ "cmp rax, SOB_FALSE_ADDRESS\n" ^
                      "\t" ^ "jne LexitOr" ^ (string_of_int current) ^ "\n" in
                      String.concat "\n" (List.map (or_gen consts fvars) exprs) ^
                      "\t" ^ "LexitOr" ^ (string_of_int current) ^ ":\n"
    | If'(test, dit, dif) -> let current = !count in
                              count := !count + 1;
                              (generate consts fvars test) ^ 
                              "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ "\n" ^
                              "\t" ^ "je Lelse" ^ (string_of_int current) ^ "\n" ^
                              (generate consts fvars  dit) ^ 
                              "\t" ^ "jmp LexitIf" ^ (string_of_int current) ^ "\n" ^
                              "\t" ^ "Lelse" ^ (string_of_int current) ^ ":\n" ^
                              (generate consts fvars  dif) ^ 
                              "\t" ^ "LexitIf" ^ (string_of_int current) ^ ":\n"
    | BoxGet'(VarParam(_,pos)) -> "\tmov rax, qword [rbp + 8 ∗ (4 + "^ (string_of_int pos) ^")]\n"^
                                  "\tmov rax, qword [rax]\n"
    | BoxGet'(VarBound(_,depth,pos)) -> "\tmov rax, qword [rbp + 8 ∗ 2]\n" ^
                                        "\tmov rax, qword [rax + 8 ∗ " ^ (string_of_int depth) ^ "]\n" ^
                                        "\tmov rax, qword [rax + 8 ∗ " ^ (string_of_int pos) ^ "]\n" ^
                                        "\tmov rax, qword [rax]\n"
    | BoxSet'(VarParam(_,pos),expr) -> (generate consts fvars expr) ^ 
                                        "\tpush rax\n" ^
                                        "\tmov rax, qword [rbp + 8 ∗ (4 + "^ (string_of_int pos) ^")]\n"^
                                        "\tpop qword [rax]\n" ^
                                        "\tmov rax, SOB_VOID_ADDRESS\n"
    | BoxSet'(VarBound(_,depth,pos),expr) -> (generate consts fvars expr) ^ 
                                             "\tpush rax\n" ^
                                             "\tmov rax, qword [rbp + 8 ∗ 2]\n" ^
                                             "\tmov rax, qword [rax + 8 ∗ " ^ (string_of_int depth) ^ "]\n" ^
                                             "\tmov rax, qword [rax + 8 ∗ " ^ (string_of_int pos) ^ "]\n" ^
                                             "\tpop qword [rax]\n" ^
                                             "\tmov rax, SOB_VOID_ADDRESS\n"
    | LambdaSimple'(vars, body) -> let len = List.length vars in
                                    let (curr_count,curr_env) = (!count,!env_count) in
                                    count := !count +1;
                                    env_count := !env_count +1;
                                    "\tlambdaSimple"^(string_of_int curr_count)^":\n"^
                                    "\tMALLOC r10, 8*(1+"^(string_of_int curr_env)^") ; Allocate ExtEnv\n"^
                                    "\tmov r11, r10 ; copy of ExtEnv address\n"^
                                    "\tmov r12, 0 ; i\n"^
                                    "\tmov r13, "^(string_of_int curr_env)^" ; |env|\n"^
                                    "\tmov r15, rbp ; copy of rbp\n"^
                                    "\t.copy_env:\n"^
                                    "\t\tcmp r12, r13\n"^
                                    "\t\tje .done_copy_env\n"^
                                    "\t\tadd r11, 8\n"^
                                    "\t\tmov r11, qword[r15 + 16] ; ExtEnv[j] = Env[i]\n"^
                                    "\t\tmov r15, qword[r15] ; jmp to next env\n"^
                                    "\t\tinc r12\n"^
                                    "\t\tjmp .copy_env\n"^
                                    "\t.done_copy_env:\n"^
                                    "\tmov r12, 0 ; i\n"^
                                    "\tmov r13, "^(string_of_int len)^" ; "^(string_of_int len)^" arguments\n"^
                                    "\tmov r15, qword[rbp+32] ; copy of first arg\n"^
                                    "\tMALLOC r14, 8*"^(string_of_int len)^" ; allocate ExtEnv[0]\n"^
                                    "\tmov r11, r14 ; copy of ExtEnv[0] \n"^
                                    "\t.copy_params:\n"^
                                    "\t\tcmp r12, r13\n"^
                                    "\t\tje .done_copy_params\n"^
                                    "\t\tmov r14, r15 ; ExtEnv [0][i] = Param(i)\n"^
                                    "\t\tadd r14, 8\n"^
                                    "\t\tadd r15, 8\n"^
                                    "\t\tinc r12\n"^
                                    "\t\tjmp .copy_params\n"^
                                    "\t.done_copy_params:\n"^
                                    "\tMAKE_CLOSURE(rax, r10, .Lcode)\n"^
                                    "\tjmp .Lcont\n"^
                                    "\t.Lcode:\n"^
                                    "\tpush rbp\n"^
                                    "\tmov rbp , rsp\n"^
                                    (generate consts fvars body) ^ 
                                    "\tleave\n"^
                                    "\tret\n"^
                                    "\t.Lcont:\n"

                                    

    | LambdaOpt'(vars, opt, body) -> raise X_not_yet_implemented
    | Applic'(op, args) | ApplicTP'(op, args) -> let args = List.rev args in
                            let len = List.length args in
                            let rec applic_rec args =
                            match args with
                            | car :: cdr -> (generate consts fvars car) ^ "\tpush rax ;; applic case in generate func\n" ^ applic_rec cdr
                            | [] -> "\tpush "^(string_of_int len)^"\n"^(generate consts fvars op)^
                            "\tmov rbx, [rax+TYPE_SIZE] ; closure's env\n"^"\tpush rbx ; push env\n"^"\tmov rbx, [rax+TYPE_SIZE+WORD_SIZE] ; clousre's code\n"^
                            "\tcall rbx ; call code\n\tadd rsp, 8*1 ; pop env\n\tpop rbx ; pop arg count\n"^
                            "\tshl rbx, 3 ; rbx = rbx * 8\n\tadd rsp, rbx ; pop args\n" in applic_rec args
    | _ -> raise X_not_yet_implemented;; (* TODO: check if all cases are checked. *)

end;;

