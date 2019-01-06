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
  let prev_args = (ref 0);;


  (* Helper function, scan AST & collect const sexprs, return sexprs list *)
  let rec scan_ast asts consts = 
    match asts with
      | car :: cdr -> 
         (match car with
              | Const' Sexpr expr -> scan_ast cdr [expr] @ consts
              | Var' (VarFree str) -> scan_ast cdr ([String str] @ consts)
              | Var' (VarParam (str, pos)) -> scan_ast cdr ([String str] @ consts)
              | Var' (VarBound (str, depth, pos)) -> scan_ast cdr ([String str] @ consts)
              | Set' (expr1, expr2) | Def' (expr1, expr2) -> scan_ast cdr consts @ (scan_ast ([expr1] @ [expr2]) consts) 
              | If' (test, dit, dif) -> scan_ast cdr consts @ (scan_ast ([test] @ [dit] @ [dif]) consts) 
              | Seq' exprs | Or' exprs  -> scan_ast cdr consts @ (scan_ast exprs consts) 
              | LambdaSimple' (_, body) | LambdaOpt' (_, _, body) | BoxSet' (_, body) -> 
                  scan_ast cdr consts @ (scan_ast [body] consts)
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
    let lst_string = List.map (fun s -> "const_tbl + " ^ string_of_int (get_const_addr (Sexpr s) tbl)) vec in
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
            cons_tbl cdr (tbl @ [(Sexpr(Pair (f, s)), (addr, "MAKE_LITERAL_PAIR(const_tbl + " ^ string_of_int (get_const_addr (Sexpr f) tbl) ^ 
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
     
  (* TODO: implement apply (variadic) *)

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
      (* Helper function for Lcode of LambdaSimple *)
      let lcodeSimple vars body curr_count = 
        prev_args := List.length vars;
        "\n\t" ^ "Lcode" ^ (string_of_int curr_count) ^ ":\n" ^
        "\t" ^ "push rbp\n" ^
        "\t" ^ "mov rbp , rsp ; parse of lambdaSimple body below: \n" ^
        (generate consts fvars body) ^ 
        "\t" ^ "leave ; done parsing lambdaSimple body above \n" ^
        "\t" ^ "ret\n" ^
        "\n\t" ^ "Lcont" ^ (string_of_int curr_count) ^ ":\n" in

      (* Helper function, for generate LambdaSimple *)
      let assemLambda vars body curr_count curr_env len =
        "\t" ^ "lambdaSimple" ^ (string_of_int curr_count) ^ ":\n" ^ 
        "\t" ^ "MALLOC r10, 8 * (1 + " ^ (string_of_int curr_env) ^ ") ; Allocate ExtEnv\n" ^
        "\t" ^ "mov r11, r10 ; copy of ExtEnv address\n" ^
        "\t" ^ "mov r12, 0 ; i\n" ^
        "\t" ^ "mov r13, 1 ; j\n" ^
        "\t" ^ "mov r15, qword[rbp + 16] ; lexical env\n" ^
        "\n\t" ^ ".copy_env:\n" ^
        "\t\t" ^ "cmp r12, " ^ (string_of_int curr_env) ^ " ; |env|\n" ^
        "\t\t" ^ "je .done_copy_env\n" ^
        "\t\t" ^ "mov r14, qword[r15 + 8 * r12] ; r14 = Env[i]\n" ^
        "\t\t" ^ "mov [r11 + 8 * r13], r14 ; ExtEnv[j] = r14\n" ^
        "\t\t" ^ "inc r12" ^ " ; inc counter of loop\n" ^ 
        "\t\t" ^ "inc r13" ^ " ; inc counter of loop\n" ^ 
        "\t\t" ^ "jmp .copy_env" ^ " ; back to loop\n" ^
        "\n\t" ^ ".done_copy_env:\n" ^
        "\t\t" ^ "mov r12, 0 ; i\n" ^
        "\t\t" ^ "mov r15, rbp ; r15 = rbp\n" ^
        "\t\t" ^ "add r15, 32 ; r15 = address of first arg\n" ^
        "\t\t" ^ "MALLOC r14, 8*" ^ (string_of_int len) ^ " ; allocate ExtEnv[0]\n" ^
        "\t\t" ^ "mov r11, r14 ; copy of ExtEnv[0] \n" ^
        "\n\t" ^ ".copy_params:\n" ^
        "\t\t" ^ "cmp r12, " ^ (string_of_int len) ^ " ; " ^ (string_of_int len) ^ " arguments\n" ^
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

      (* Helper function for Lcode of LambdaOpt *)
      let lcodeOpt vars opt body curr_count = 
        prev_args := List.length vars + 1;
        let len = List.length vars in
        "\n\t" ^ "Lcode" ^ (string_of_int curr_count) ^ ":\n" ^
        "\t" ^ "push rbp\n" ^
        "\t" ^ "mov rbp , rsp ; parse of lambdaOpt body below: \n" ^
        (* Adjust stack for opt *)
        "\t" ^ ";;; Closure body \n" ^ 
        "\t" ^ "mov r13, " ^ (string_of_int len) ^ " ; |Params| ;;;;; mov r13, <nParams>\n" ^
        "\t" ^ ";;;;; mov rcx, 1 ; |Args|\n" ^ 
        "\t" ^ "sub rcx, r13 ; |Opt list|\n" ^
        "\t" ^ "mov r12, rcx\n" ^
        "\t" ^ "add r12, 0\n" ^
        "\t" ^ "mov r9, const_tbl + 1 ; Nil element \n" ^
        "\t" ^ "mov r14, 0 ; counter end of loop \n" ^
        "\t" ^ "cmp r13, 0 ; Variadic case \n" ^
        "\t" ^ "jne .non_variadic ; \n" ^
        "\t" ^ "sub r12, 1 ; go to prev param \n" ^
        "\t" ^ "sub r14, 1 ; let us do one more loop \n" ^
        "\t" ^ ".non_variadic: \n" ^    
        "\t" ^ ".create_opt_list: \n" ^
        "\t\t" ^ "cmp r12, r14 ; new counter end of loop \n" ^
        "\t\t" ^ "je .done_create_opt_list \n" ^
        "\t\t" ^ "mov r8, PVAR(r12)\n" ^
        "\t\t" ^ "dec r12\n" ^ 
        "\t\t" ^ "MAKE_PAIR(rax, r8, r9) ;;; List of Opt args, into rax\n" ^
        "\t\t" ^ "mov r9, rax\n" ^
        "\t\t" ^ "jmp .create_opt_list \n" ^
        "\t" ^ ".done_create_opt_list: \n" ^
        "\t" ^ "mov rax, r9 ;; if bo params, so, rax will got r9, that is originally, nil \n" ^
        "\t" ^ ";;; Put list (rax) in last param location\n" ^
        "\t" ^ "mov r10, rbp\n" ^
        "\t" ^ "add r13, 0 \n" ^
        "\t" ^ "shl r13, 3 \n" ^
        "\t" ^ "add r10, r13\n" ^
        "\t" ^ "add r10, 8 * 4 \n" ^
        "\t" ^ "mov [r10], rax \n" ^
        "\t" ^ ";;;; Original body of closure.\n" ^
        (generate consts fvars body) ^ 
        "\t" ^ "leave ; done parsing lambdaOpt body above \n" ^
        "\t" ^ "ret\n" ^
        "\n\t" ^ "Lcont" ^ (string_of_int curr_count) ^ ":\n" in

      (* Helper function, for generate LambdaOpt *)
      let assemOpt vars opt body curr_count curr_env len = 
        "\t" ^ "lambdaOpt" ^ (string_of_int curr_count) ^ ":\n" ^ 
        "\t" ^ "mov rsi, " ^ (string_of_int (List.length vars)) ^ " ; store num of params in rsi \n" ^ (* sotre num of params in rsi *)
        "\t" ^ "MALLOC r10, 8 * (1 + " ^ (string_of_int curr_env) ^ ") ; Allocate ExtEnv\n" ^
        "\t" ^ "mov r11, r10 ; copy of ExtEnv address\n" ^
        "\t" ^ "mov r12, 0 ; i\n" ^
        "\t" ^ "mov r13, 1 ; j\n" ^
        "\t" ^ "mov r15, qword[rbp + 16] ; lexical env\n" ^
        "\n\t" ^ ".copy_env:\n" ^
        "\t\t" ^ "cmp r12, " ^ (string_of_int curr_env) ^ " ; |env|\n" ^
        "\t\t" ^ "je .done_copy_env\n" ^
        "\t\t" ^ "mov r14, qword[r15 + 8 * r12] ; r14 = Env[i]\n" ^
        "\t\t" ^ "mov [r11 + 8 * r13], r14 ; ExtEnv[j] = r14\n" ^
        "\t\t" ^ "inc r12" ^ " ; inc counter of loop\n" ^ 
        "\t\t" ^ "inc r13" ^ " ; inc counter of loop\n" ^ 
        "\t\t" ^ "jmp .copy_env" ^ " ; back to loop\n" ^
        "\n\t" ^ ".done_copy_env:\n" ^
        "\t\t" ^ "mov r12, 0 ; i\n" ^
        "\t\t" ^ "mov r15, rbp ; r15 = rbp\n" ^
        "\t\t" ^ "add r15, 32 ; r15 = address of first arg\n" ^
        "\t\t" ^ "MALLOC r14, 8*" ^ (string_of_int len) ^ " ; allocate ExtEnv[0]\n" ^ (* another param for opt *)
        "\t\t" ^ "mov r11, r14 ; copy of ExtEnv[0] \n" ^
        "\n\t" ^ ".copy_params:\n" ^
        "\t\t" ^ "cmp r12, " ^ (string_of_int len) ^ " ; " ^ (string_of_int len) ^ " arguments\n" ^
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
    | Const' (expr) -> "\t" ^ "mov rax, const_tbl+" ^ (string_of_int (get_const_addr expr consts)) ^ " ; mov rax, AddressInConstTable\n"
    | Var'(VarFree v) -> "\t" ^ "mov rax, qword [fvar_tbl+" ^ (string_of_int (get_fvar_addr v fvars)) ^ "*WORD_SIZE]" ^
                                                                                                       " ; put fvar v in rax register\n"
    | Var'(VarParam(_, pos)) -> "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ") ; mov rax, qword[rbp + 8 * (4 + minor)], pos (= minor) \n"
    | Var'(VarBound(_, depth, pos)) -> "\t" ^ "mov rax, qword [rbp + 16]" ^ " ; mov rax, qword[rbp + 8 * 2] \n" ^
                                       "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")" ^ " ; major is depth in this case \n" ^
                                       "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")" ^ " ; minor is pos in this case \n" 
    | Def'(Var'(VarFree(name)), expr) -> (generate consts fvars expr) ^ (* generate expr (= "value") *)
                                        "\t" ^ "mov qword [fvar_tbl+" ^ (string_of_int (get_fvar_addr name fvars)) ^ "*WORD_SIZE], rax" ^  
                                        ";; define case in generate func, the \"generated expr\" is in rax" ^ "\n" ^
                                        "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n" 
    | Set'(Var'(VarFree(v)), expr) -> (generate consts fvars expr) ^ (* generate "Epsilon" (from Lecture) *)
                                        "\t" ^ "mov qword [fvar_tbl+" ^ (string_of_int (get_fvar_addr v fvars)) ^ "*WORD_SIZE], rax" ^ 
                                        " ; mov rax, qword[LabelInFVarTable(v)] \n" ^
                                        "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
    | Set'(Var'(VarParam(_, pos)), expr) -> (generate consts fvars expr) ^ 
                                            "\t" ^ "mov qword PVAR(" ^ (string_of_int pos) ^ "), rax" ^ "\n" ^
                                            "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
    | Set'(Var'(VarBound(_, depth, pos)), expr) -> (generate consts fvars expr) ^
                                                "\t" ^ "mov rbx, qword [rbp + 16]" ^ "\n" ^
                                                "\t" ^ "mov rbx, BVARX(" ^ (string_of_int depth)^ ")" ^ 
                                                " ; mov rbx, qword [rbx+WORD_SIZE*depth] \n" ^
                                                "\t" ^ "mov BVARX(" ^ (string_of_int pos) ^ "), rax" ^ "\n" ^
                                                "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
    | Seq'(exprs) -> String.concat "\n" (List.map (generate consts fvars) exprs) (* generate "Epsilons" (=exprs), separated by "newline" *)
    | Or'(exprs) -> let current = !count in
                    count := !count + 1;
                    (* Helper function to generate Or' *)
                    let or_gen consts fvars expr =
                      (generate consts fvars expr) ^ 
                      "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ "\n" ^
                      "\t" ^ "jne LexitOr" ^ (string_of_int current) ^ "\n" in
                    String.concat "\n" (List.map (or_gen consts fvars) exprs) ^
                    "\t" ^ "LexitOr" ^ (string_of_int current) ^ ":\n"
    | If'(test, dit, dif) -> let current = !count in
                              count := !count + 1;
                              (generate consts fvars test) ^ (* generate test *)
                              "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ "\n" ^
                              "\t" ^ "je Lelse" ^ (string_of_int current) ^ "\n" ^ (* Lelse of current (number) If' *)
                              (generate consts fvars dit) ^ (* generate dit *)
                              "\t" ^ "jmp LexitIf" ^ (string_of_int current) ^ "\n" ^
                              "\t" ^ "Lelse" ^ (string_of_int current) ^ ":\n" ^
                              (generate consts fvars dif) ^ 
                              "\t" ^ "LexitIf" ^ (string_of_int current) ^ ":\n"
    | BoxGet'(VarParam(_, pos)) -> "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")" ^ "\n" ^ 
                                   "\t" ^ "mov rax, qword [rax]" ^ "\n"
    | BoxGet'(VarBound(_, depth, pos)) -> "\t" ^ "mov rax, qword [rbp + 16]" ^ "\n" ^
                                          "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")\n" ^
                                          "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")\n" ^
                                          "\t" ^ "mov rax, qword [rax]" ^ "\n"
    | BoxSet'(VarParam(_, pos), expr) -> (generate consts fvars expr) ^ (* generate "Epsilon" (=expr) *)
                                         "\t" ^ "push rax\n" ^
                                         "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")\n" ^ (* put Var'(v) into rax *)
                                         "\t" ^ "pop qword [rax]\n" ^
                                         "\t" ^ "mov rax, SOB_VOID_ADDRESS\n"
    | BoxSet'(VarBound(_, depth, pos), expr) -> (generate consts fvars expr) ^ 
                                                "\t" ^ "push rax\n" ^
                                                "\t" ^ "mov rax, qword [rbp +16]\n" ^
                                                "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")\n" ^
                                                "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")\n" ^
                                                "\t" ^ "pop qword [rax]\n" ^
                                                "\t" ^ "mov rax, SOB_VOID_ADDRESS\n"
    | Box'(VarParam (_, pos)) -> "\tmov rax, PVAR(" ^ (string_of_int pos) ^ ") ;\n"^
                                  "\tMALLOC rbx, 8 ;\n"^
                                  "\tmov [rbx], rax ;\n"^
                                  "\tmov rax, rbx ;\n"
    | LambdaSimple'(vars, body) -> 
        let (curr_count, curr_env) = (!count, !env_count) in
        count := !count + 1;
        env_count := !env_count + 1;
        let len = !prev_args in
        let out = "\n"^(assemLambda vars body curr_count curr_env len) ^ (lcodeSimple vars body curr_count) in
        env_count := !env_count - 1; out
    | LambdaOpt'(vars, opt, body) -> 
        let (curr_count, curr_env) = (!count, !env_count) in
        count := !count + 1;
        env_count := !env_count + 1;
        let len = !prev_args in
        let out = "\n" ^ (assemOpt vars opt body curr_count curr_env len) ^ (lcodeOpt vars opt body curr_count) in
        env_count := !env_count - 1; out
    | Applic'(op, args) | ApplicTP'(op, args) -> 
        let args = List.rev args in
        let len = List.length args in
        let current = !count in
        count := !count + 1;
        let rec applic_rec args =
          match args with
          | car :: cdr -> 
            (generate consts fvars car) ^
            "\t" ^ "push rax\n" ^ 
            applic_rec cdr
          | [] -> 
            "\t" ^ "mov rcx, " ^ (string_of_int len) ^ " ; number of arguments \n" ^
            "\t" ^ "push " ^ (string_of_int len) ^ " ; parsing of operator below:\n" ^
            (generate consts fvars op) ^
            "\tmov rbx, [rax+TYPE_SIZE] ; closure's env\n" ^
            "\tpush rbx ; push env\n" ^
            "\tmov rbx, [rax+TYPE_SIZE+WORD_SIZE] ; clousre's code\n" ^
            "\tcall rbx ; call code\n\tadd rsp, 8*1 ; pop env\n\tpop rbx ; pop arg count\n" ^
            "\tinc rbx\n" ^
            "\tshl rbx, 3 ; rbx = rbx * 8\n" ^
            "\tadd rsp, rbx ; pop args\n"
        in 
        "\n\t" ^ "mov rax, const_tbl + 1 ; applic \n" ^
        "\t" ^ "push rax ; Nil as Magic \n" ^
        (applic_rec args)
    | ApplicTP'(op, args) -> let args = List.rev args in
                              let len = List.length args in
                              let rec applicTP_rec args =
                              match args with
                              | car :: cdr -> 
                              (generate consts fvars car) ^ 
                              "\tpush rax\n" ^ 
                              applicTP_rec cdr
                              | [] -> 
                              "\tpush "^(string_of_int len)^" ; parsing of operator below:\n"^
                              (generate consts fvars op)^
                              "\tmov r9, [rax+TYPE_SIZE] ; closure's env\n"^
                              "\tpush r9 ; push env\n"^
                              "\tpush qword [rbp + 8] ; old ret addr\n"^
                              "\tmov r9, qword[rbp]\n"^
                              "\tSHIFT_FRAME "^(string_of_int (len+5))^"\n"^
                              "\tmov rbp, r9\n"^
                              "\tjmp [rax+TYPE_SIZE+WORD_SIZE] ; clousre's code\n"
                              in 
                              "\tmov rax, 9999 ; begin applicTP\n"^
                              "\tpush rax\n"^
                              (applicTP_rec args)
    | _ -> raise X_not_yet_implemented;; (* TODO: check if all cases are checked. *)

end;;
