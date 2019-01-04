#use "semantic-analyser.ml";;

module type CODE_GEN = sig
  val make_consts_tbl : expr' list -> (constant * (int * string)) list
  val make_fvars_tbl : expr' list -> (string * int) list
  val generate : (constant * (int * string)) list -> (string * int) list -> expr' -> string

  (* TODO: delete later *)
  val get_const_addr : 'a -> ('a * ('b * 'c)) list -> 'b 
  val get_fvar_addr : 'a -> ('a * 'b) list -> 'b
  val primitive_names_to_labels : (string * string) list
  val scan_ast : expr' list -> sexpr list
  val remove_dups : 'a list -> 'a list
  val expand_lst : sexpr list -> sexpr list
  val cons_tbl : sexpr list -> (constant * (int * string)) list
end;;

module Code_Gen : CODE_GEN = struct


  let count = (ref 0);;
  let env_count = (ref 0);;


  (* Helper function, scan AST & collect const sexprs, return sexprs list *)
  let rec scan_ast asts consts = 
    match asts with
      | car :: cdr -> (match car with
                        | Const' Sexpr expr -> scan_ast cdr [expr] @ consts
                        | Var' (VarFree str) -> scan_ast cdr ([String str] @ consts) (* Add support for Var' *)
                        | Var' (VarParam (str, pos)) -> scan_ast cdr ([String str] @ consts)
                        | Var' (VarBound (str, depth, pos)) -> scan_ast cdr ([String str] @ consts)
                        | Set' (expr1, expr2) | Def' (expr1, expr2) -> scan_ast cdr consts @ (scan_ast ([expr1] @ [expr2]) consts) 
                        | If' (test, dit, dif) -> scan_ast cdr consts @ (scan_ast ([test] @ [dit] @ [dif]) consts) 
                        | Seq' exprs | Or' exprs  -> scan_ast cdr consts @ (scan_ast exprs consts) 
                        | LambdaSimple' (_, body) | LambdaOpt' (_, _, body) | BoxSet' (_, body) -> 
                            scan_ast cdr consts @ (scan_ast [body] consts) (* Add support for LambdaOpt' & BoxSet' *)
                        | Applic' (op, exprs) | ApplicTP' (op, exprs) -> scan_ast cdr consts @ (scan_ast ([op] @ exprs) consts) 
                        | _ -> scan_ast cdr consts)
      | _ -> consts ;;

  let scan_ast asts = scan_ast asts [] ;;

  (* Helper function, convert the list to a set (remove duplicates) *)
  let rec remove_dups lst = 
    match lst with
      | [] -> []
      | car :: cdr -> car :: (remove_dups (List.filter (fun e -> e <> car) cdr)) ;;

  (* Helper func, expand lst include all sub-consts, lst should be sorted topologically (code logic from ps #11, 2.2.1) *)
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

  (* Helper func, got consts, tbl and addr, return tbl (at the end of recursion) *)
  let rec cons_tbl consts tbl addr =
    match consts with
    | car :: cdr -> 
      (match car with
        | Bool _ | Nil -> cons_tbl cdr tbl addr
        | Char ch -> cons_tbl cdr (tbl @ [(Sexpr(Char ch), (addr, "MAKE_LITERAL_CHAR('" ^ String.make 1 ch ^ "') ; my address is " ^ 
            (string_of_int addr)))]) (addr + size_of car)
        | String expr -> cons_tbl cdr (tbl @ [(Sexpr(String expr), (addr, "MAKE_LITERAL_STRING \"" ^ expr ^ "\" ; my address is " ^ 
            (string_of_int addr)))]) (addr + size_of car)
        | Number(Int num) ->
            cons_tbl cdr (tbl @ [(Sexpr(Number(Int num)), (addr, "MAKE_LITERAL_INT(" ^ (string_of_int num) ^ ") ; my address is " ^
              (string_of_int addr)))]) (addr + size_of car)
        | Number(Float num) -> 
            cons_tbl cdr (tbl @ [(Sexpr(Number(Float num)), (addr, "MAKE_LITERAL_FLOAT(" ^ (string_of_float num) ^ ") ; my address is " ^ 
              (string_of_int addr)))]) (addr + size_of car)
        | Symbol sym -> 
            cons_tbl cdr (tbl @ [(Sexpr(Symbol sym), (addr, "MAKE_LITERAL_SYMBOL(const_tbl + " ^ 
              string_of_int (get_const_addr (Sexpr(String sym)) tbl) ^ ") ; my address is " ^ (string_of_int addr)))]) (addr + size_of car) 
        | Pair (f, s) -> 
            cons_tbl cdr (tbl @ [(Sexpr(Pair (f, s)), (addr, "MAKE_LITERAL_PAIR(const_tbl+" ^ string_of_int (get_const_addr (Sexpr f) tbl) ^ 
              ", const_tbl + " ^ string_of_int (get_const_addr (Sexpr s) tbl) ^ ") ; my address is " ^ (string_of_int addr)))]) (addr + size_of car)
        | Vector vec -> cons_tbl cdr (tbl @ [(Sexpr(Vector vec)), (addr, "MAKE_LITERAL_VECTOR " ^ vec_const vec tbl ^ " ; my address is " ^ 
            (string_of_int addr))]) (addr + size_of car))
    | [] -> tbl ;;
    
  (* Cons_tbl main func *)
  let cons_tbl consts = cons_tbl consts [
    (Void, (0, "MAKE_VOID ; my address is 0"));
    (Sexpr(Nil), (1, "MAKE_NIL ; my address is 1"));
    (Sexpr(Bool false), (2, "MAKE_BOOL(0) ; my address is 2"));
    (Sexpr(Bool true), (4, "MAKE_BOOL(1) ; my address is 4"));
    ] 6;;
  
  (* Signature func, expr' list -> (constant * (int * string)) list *)
  let make_consts_tbl asts = cons_tbl (remove_dups (expand_lst (remove_dups (scan_ast asts))));;


  (* fvar table *)
  let rec scan_fvars asts fvars = 
    match asts with
      | car :: cdr -> 
        (match car with
          | Var'(VarFree expr) -> scan_fvars cdr [expr] @ fvars
          | Def'(Var'(VarFree expr), _) -> scan_fvars cdr ([expr] @ fvars) (* TODO: check if add more cases *)
          | LambdaSimple' (_, body) | LambdaOpt' (_, _, body) -> 
              scan_fvars cdr fvars @ (scan_fvars [body] fvars)
          | Or' exprs | Seq' exprs -> 
              scan_fvars cdr fvars @ List.concat ((List.map (fun expr -> scan_fvars [expr] fvars)) exprs)
          | If' (test, dit, dif) -> 
              scan_fvars cdr fvars @ scan_fvars [test; dit; dif] fvars
          | Set'(_ , expr) -> scan_fvars cdr fvars @ scan_fvars [expr] fvars
          | Applic' (op, exprs) | ApplicTP' (op, exprs) -> 
              scan_fvars cdr fvars @ List.concat (List.map (fun expr -> scan_fvars [expr] fvars) ([op] @ exprs))
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
     "car", "car"; "cdr", "cdr"; "set-car!", "set_car"; "set-cdr!", "set_cdr"; "cons", "cons"
     ];;
     (* TODO: implement append (variadic), apply (variadic), equal?, length, list (variadic), 
     map (variadic), not, number?, zero? *)

  let first (x, y) = x;;

  let saved_fvars = List.map first primitive_names_to_labels;;

  let rec cons_fvars fvars tbl addr =
    match fvars with
      | car :: cdr -> cons_fvars cdr (tbl @ [(car, addr)]) (addr + 1) 
      | [] -> tbl ;;
    
  let cons_fvars fvars = cons_fvars (remove_dups (saved_fvars @ fvars)) [] 0;;

  (* Signature func, expr' list -> (string * int) list *)
  let make_fvars_tbl asts = cons_fvars (scan_fvars asts);;


  let get_fvar_addr fvar tbl = List.assoc fvar tbl;;

  (* Signature func, (constant * (int * string)) list -> (string * int) list -> expr' -> string *)
  let rec generate consts fvars e = 
      (* Helper function for Lcode of LambdaSimple' *)
      let lcodeSimple body curr_count = 
        "\n\t" ^ "Lcode" ^ (string_of_int curr_count) ^ ":\n" ^
        "\t" ^ "push rbp\n" ^
        "\t" ^ "mov rbp , rsp\n" ^
        (generate consts fvars body) ^ 
        "\t" ^ "leave\n" ^
        "\t" ^ "ret\n" ^
        "\n\t" ^ "Lcont" ^ (string_of_int curr_count) ^ ":\n" in

      (* Helper function for Lcode of LamdaOpt' *)
      let lcodeOpt body curr_count =
        "\t" ^ "Lcode" ^ (string_of_int curr_count) ^ ":\n" ^
        ";; adjust stack for opt args\n" ^ (* TODO: implement Lcode of LambdaOpt' (adjust stack for optional arguments) *)
        "\t" ^ "xor r15, r15 ; clean r15 (=magic) ? \n" ^
        "\t" ^ "push r15 ; push magic ? \n" ^ 
        "\t" ^ "push rbp\n" ^
        "\t" ^ "mov rbp, rsp\n" ^
        (generate consts fvars body) ^ 
        "\t" ^ "leave\n" ^
        "\t" ^ "ret\n" ^
        "\t" ^ "Lcont" ^ (string_of_int curr_count) ^ ":\n" in

      (* Helper function, for generate Lambda *)
      let assemLambda vars body curr_count curr_env =
        let len = List.length vars in
        "\n\n\t" ^ "lambdaSimple" ^ (string_of_int curr_count) ^ ":\n" ^ 
        "\t" ^ "MALLOC r10, 8 * (1 + " ^ (string_of_int curr_env) ^ ") ; Allocate ExtEnv\n" ^
        "\t" ^ "mov r11, r10 ; copy of ExtEnv address\n" ^
        "\t" ^ "mov r12, 0 ; i\n" ^
        "\t" ^ "mov r13, " ^ (string_of_int curr_env) ^ " ; |env|\n" ^
        "\t" ^ "mov r15, rbp ; copy of rbp\n" ^
        "\n\t" ^ ".copy_env:\n" ^
        "\t\t" ^ "cmp r12, r13\n" ^
        "\t\t" ^ "je .done_copy_env\n" ^
        "\t\t" ^ "add r11, 8\n" ^
        "\t\t" ^ "mov r14, qword[r15 + 16] ; r14 = Env[i]\n" ^
        "\t\t" ^ "mov [r11], r14 ; ExtEnv[j] = r14\n" ^
        "\t\t" ^ "mov r15, qword[r15] ; jmp to next env\n" ^
        "\t\t" ^ "inc r12" ^ " ; inc counter of loop\n" ^ 
        "\t\t" ^ "jmp .copy_env" ^ " ; back to loop\n" ^
        "\n\t" ^ ".done_copy_env:\n" ^
        "\t\t" ^ "mov r12, 0 ; i\n" ^
        "\t\t" ^ "mov r13, " ^ (string_of_int len) ^ " ; " ^ (string_of_int len) ^ " arguments\n" ^
        "\t\t" ^ "mov r15, rbp ; r15 = rbp\n" ^
        "\t\t" ^ "add r15, 32 ; r15 = address of first arg\n" ^
        "\t\t" ^ "MALLOC r14, 8*" ^ (string_of_int len) ^ " ; allocate ExtEnv[0]\n" ^
        "\t\t" ^ "mov r11, r14 ; copy of ExtEnv[0] \n" ^
        "\n\t" ^ ".copy_params:\n" ^
        "\t\t" ^ "cmp r12, r13\n" ^
        "\t\t" ^ "je .done_copy_params\n" ^
        "\t\t" ^ "mov r9, [r15] ; r9 = Param(i)\n" ^
        "\t\t" ^ "mov [r14], r9 ; ExtEnv [0][i] = r9\n" ^
        "\t\t" ^ "add r14, 8\n" ^
        "\t\t" ^ "add r15, 8\n" ^
        "\t\t" ^ "inc r12\n" ^
        "\t\t" ^ "jmp .copy_params\n" ^
        "\n\t" ^ ".done_copy_params:\n" ^
        "\t\t" ^ "mov [r10], r11\n" ^
        "\t\t" ^ "MAKE_CLOSURE(rax, r10, Lcode" ^ (string_of_int curr_count) ^ ")\n" ^
        "\t\t" ^ "jmp Lcont" ^ (string_of_int curr_count) ^ "\n" in

    match e with
      | Const' (expr) -> "\t" ^ "mov rax, const_tbl + " ^ (string_of_int (get_const_addr expr consts)) ^ " ; Const \n"
      | Var'(VarFree v) -> "\t" ^ "mov rax, qword [fvar_tbl + " ^ (string_of_int (get_fvar_addr v fvars)) ^ " * WORD_SIZE]" ^ " ; VarFree \n"
      | Var'(VarParam(_, pos)) -> "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ") ; VarParam \n"
      | Var'(VarBound(_, depth, pos)) -> 
          "\t" ^ "mov rax, qword [rbp + 16]" ^ " ; VarBound \n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")" ^ "\n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")" ^ "\n" 
      | Def'(Var'(VarFree(name)), expr) -> 
          (generate consts fvars expr) ^
          "\t" ^ "mov qword [fvar_tbl + " ^ (string_of_int (get_fvar_addr name fvars)) ^ " * WORD_SIZE], rax" ^  
          "; Def' " ^ "\n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n" 
      | Set'(Var'(VarFree(v)), expr) -> 
          (generate consts fvars expr) ^
          "\t" ^ "mov qword [fvar_tbl + " ^ (string_of_int (get_fvar_addr v fvars)) ^ " * WORD_SIZE], rax" ^ 
          " ; Set VarFree \n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      | Set'(Var'(VarParam(_, pos)), expr) -> 
          (generate consts fvars expr) ^ 
          "\t" ^ "mov qword PVAR(" ^ (string_of_int pos) ^ "), rax" ^ " ; Set VarParam \n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      | Set'(Var'(VarBound(_, depth, pos)), expr) -> 
          (generate consts fvars expr) ^
          "\t" ^ "mov rbx, qword [rbp + 16]" ^ " ; Set VarBound \n" ^
          "\t" ^ "mov rbx, BVARX(" ^ (string_of_int depth)^ ")" ^ 
          " ; mov rbx, qword [rbx + WORD_SIZE * depth] \n" ^
          "\t" ^ "mov BVARX(" ^ (string_of_int pos) ^ "), rax" ^ "\n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      | Seq'(exprs) -> String.concat "\n" (List.map (generate consts fvars) exprs) (* generate "Epsilons" (=exprs), separated by "newline" *)
      | Or'(exprs) -> 
          let current = !count in
          count := !count + 1;
          (* Helper function to generate Or' *)
          let or_gen consts fvars expr =
            (generate consts fvars expr) ^ 
            "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ " ; Or \n" ^
            "\t" ^ "jne LexitOr" ^ (string_of_int current) ^ "\n" in

          String.concat "\n" (List.map (or_gen consts fvars) exprs) ^
          "\t" ^ "LexitOr" ^ (string_of_int current) ^ ":\n"
      | If'(test, dit, dif) -> 
          let current = !count in
          count := !count + 1;
          (generate consts fvars test) ^ (* generate test *)
          "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ " ; If \n" ^
          "\t" ^ "je Lelse" ^ (string_of_int current) ^ "\n" ^ (* Lelse of current (number) If' *)
          (generate consts fvars dit) ^ (* generate dit *)
          "\t" ^ "jmp LexitIf" ^ (string_of_int current) ^ "\n" ^
          "\t" ^ "Lelse" ^ (string_of_int current) ^ ":\n" ^
          (generate consts fvars dif) ^ 
          "\t" ^ "LexitIf" ^ (string_of_int current) ^ ":\n"
      | BoxGet'(VarParam(_, pos)) -> 
          "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")" ^ "\n" ^ 
          "\t" ^ "mov rax, qword [rax]" ^ "\n"
      | BoxGet'(VarBound(_, depth, pos)) -> 
          "\t" ^ "mov rax, qword [rbp + 16]" ^ "\n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")\n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")\n" ^
          "\t" ^ "mov rax, qword [rax]" ^ "\n"
      | BoxSet'(VarParam(_, pos), expr) -> 
          (generate consts fvars expr) ^ (* generate "Epsilon" (=expr) *)
          "\t" ^ "push rax\n" ^
          "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")\n" ^ (* put Var'(v) into rax *)
          "\t" ^ "pop qword [rax]\n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS\n"
      | BoxSet'(VarBound(_, depth, pos), expr) ->
          (generate consts fvars expr) ^ 
          "\t" ^ "push rax\n" ^
          "\t" ^ "mov rax, qword [rbp + 16]\n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")\n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")\n" ^
          "\t" ^ "pop qword [rax]\n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS\n"
      | LambdaSimple'(vars, body) -> 
          let (curr_count, curr_env) = (!count, !env_count) in
          count := !count + 1;
          env_count := !env_count + 1;
          (assemLambda vars body curr_count curr_env) ^ (lcodeSimple body curr_count)
      | LambdaOpt'(vars, opt, body) -> raise X_not_yet_implemented
          (* let (curr_count, curr_env) = (!count, !env_count) in
          count := !count + 1;
          env_count := !env_count + 1;
          assemLambda vars body ^ (lcodeOpt body curr_count) *)
      | Applic'(op, args) -> 
          let args = List.rev args in
          let len = List.length args in
          (* Helper function, gnenerate applic *)
          let rec applic_rec args =
              match args with
                | car :: cdr -> 
                    (generate consts fvars car) ^
                    "\t" ^ "push rax ; Applic \n" ^ 
                    applic_rec cdr
                | [] -> 
                    "\t" ^ "push " ^ (string_of_int len) ^ "\n\n" ^
                    (generate consts fvars op) ^
                    "\t" ^ "mov rbx, [rax + TYPE_SIZE] ; closure's env \n" ^
                    "\t" ^ "push rbx ; push env \n" ^
                    "\t" ^ "mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code \n" ^
                    "\t" ^ "call rbx ; call code \n" ^ 
                    "\t" ^ "add rsp, 8*1 ; pop env \n" ^ 
                    "\t" ^ "pop rbx ; pop arg count \n" ^
                    (* "\tinc rbx\n"^ *)
                    "\t" ^ "shl rbx, 3 ; rbx = rbx * 8 \n" ^
                    "\t" ^ "add rsp, rbx ; pop args \n" in 
                    (* "\tmov rax, 6666\n"^
                    "\tpush rax\n"^ *)

          (applic_rec args)
      | ApplicTP'(op, args) -> 
          let args = List.rev args in
          let len = List.length args in
          (* Helper function, gnenerate applic_tp *)
          let rec applic_rec args =
            match args with
              | car :: cdr -> 
                  (generate consts fvars car) ^ 
                  "\t" ^ "push rax ; ApplicTP \n" ^ 
                  applic_rec cdr
              | [] -> 
                  "\t" ^ "push " ^ (string_of_int len) ^ "\n" ^
                  (generate consts fvars op) ^
                  "\t" ^ "mov r9, [rax + TYPE_SIZE] ; closure's env \n" ^
                  "\t" ^ "push r9 ; push env\n" ^
                  "\t" ^ "push qword[rbp + 8] ; old ret addr \n" ^
                  "\t" ^ "mov r9, qword [rbp] \n" ^
                  "\t" ^ "SHIFT_FRAME " ^ (string_of_int (len + 4)) ^ "\n" ^
                  "\t" ^ "mov rbp, r9 \n" ^
                  "\t" ^ "jmp [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code\n"
                  (*"\tadd rsp, 8*1 ; pop env\n"^
                  "\tpop rbx ; pop arg count\n"^ *)
                  (* "\tinc rbx\n"^ *)
                  (* "\tshl rbx, 3 ; rbx = rbx * 8\n"^
                  "\tadd rsp, rbx ; pop args\n"  *)
          in 

          (* "\tmov rax, 9999\n"^
          "\tpush rax\n"^ *)
          (applic_rec args)
      | _ -> raise X_not_yet_implemented;; (* TODO: check if all cases are checked. *)

end;;

