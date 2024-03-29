#use "semantic-analyser.ml";;

module type CODE_GEN = sig
  val make_consts_tbl : expr' list -> (constant * (int * string)) list
  val make_fvars_tbl : expr' list -> (string * int) list
  val generate : (constant * (int * string)) list -> (string * int) list -> expr' -> string

  (* Added funcs to Signature *)
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
  let prev_params = (ref 0);;


  (* Helper function, scan AST & collect const sexprs, return sexprs list *)
  let rec scan_ast asts consts = 
    match asts with
      | car :: cdr -> 
        (match car with 
          | Const' Sexpr expr -> scan_ast cdr [expr] @ consts
          | Set' (expr1, expr2) | Def' (expr1, expr2) -> scan_ast cdr consts @ (scan_ast ([expr1] @ [expr2]) consts) 
          | If' (test, dit, dif) -> scan_ast cdr consts @ (scan_ast ([test] @ [dit] @ [dif]) consts) 
          | Seq' exprs | Or' exprs  -> scan_ast cdr consts @ (scan_ast exprs consts) 
          | LambdaSimple' (_, body) | LambdaOpt' (_, _, body) | BoxSet' (_, body) -> scan_ast cdr consts @ (scan_ast [body] consts)
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

  (* Helper functiom, support for special chars *)
  let str_const str = 
    let str = string_to_list str in (* remove tbl from signature *)
    let lst_string = List.map (fun ch -> string_of_int (Char.code ch)) str in
    String.concat ", " lst_string;; 

  (* Helper func, got consts, tbl and addr, return tbl (at the end of recursion) *)
  let rec cons_tbl consts tbl addr =
    match consts with
      | car :: cdr -> 
        (match car with
          | Bool _ | Nil -> cons_tbl cdr tbl addr
          | Char ch -> cons_tbl cdr (tbl @ [(Sexpr(Char ch), (addr, "MAKE_LITERAL_CHAR(" ^ string_of_int (Char.code ch) ^ ") ; my address is " ^ 
              (string_of_int addr)))]) (addr + size_of car)
          | String str -> cons_tbl cdr (tbl @ [(Sexpr(String str), (addr, "MAKE_LITERAL_STRING " ^ str_const str ^ " ; my address is " ^ 
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
          | Def'(Var'(VarFree expr), _) -> scan_fvars cdr ([expr] @ fvars)
          | LambdaSimple' (_, body) | LambdaOpt' (_, _, body) -> scan_fvars cdr fvars @ (scan_fvars [body] fvars)
          | Or' exprs | Seq' exprs -> scan_fvars cdr fvars @ List.concat ((List.map (fun expr -> scan_fvars [expr] fvars)) exprs)
          | If' (test, dit, dif) -> scan_fvars cdr fvars @ scan_fvars [test; dit; dif] fvars
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
     "car", "car"; "cdr", "cdr"; "set-car!", "set_car"; "set-cdr!", "set_cdr"; "cons", "cons"; "apply", "apply"
     ];;
     
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
        prev_params := Pervasives.max (!prev_params) (List.length vars);
        "\n" ^ "Lcode" ^ (string_of_int curr_count) ^ ":\n" ^
        "\t" ^ "push rbp \n" ^
        "\t" ^ "mov rbp, rsp ; parse lambdaSimple body below: \n" ^
        (generate consts fvars body) ^ 
        "\t" ^ "leave ; done parsing lambdaSimple body above \n" ^
        "\t" ^ "ret \n\n" ^
        "Lcont" ^ (string_of_int curr_count) ^ ":\n" in

      (* Helper function, for generate LambdaSimple *)
      let assemLambda vars body curr_count curr_env len =
        "lambdaSimple" ^ (string_of_int curr_count) ^ ":\n" ^ 
        "\t" ^ "MALLOC r10, 8 * (1 + " ^ (string_of_int curr_env) ^ ") ; Allocate ExtEnv\n" ^
        "\t" ^ "mov r11, r10 ; copy of ExtEnv address \n" ^
        "\t" ^ "mov r12, 0 ; i \n" ^
        "\t" ^ "mov r13, 1 ; j \n" ^
        "\t" ^ "mov r15, qword[rbp + 16] ; lexical env \n\n" ^
        ".copy_env:\n" ^
        "\t" ^ "cmp r12, " ^ (string_of_int curr_env) ^ " ; |env| \n" ^
        "\t" ^ "je .done_copy_env\n" ^
        "\t" ^ "mov r14, qword[r15 + 8 * r12] ; r14 = Env[i] \n" ^
        "\t" ^ "mov [r11 + 8 * r13], r14 ; ExtEnv[j] = r14 \n" ^
        "\t" ^ "inc r12" ^ " ; inc counter of loop \n" ^ 
        "\t" ^ "inc r13" ^ " ; inc counter of loop \n" ^ 
        "\t" ^ "jmp .copy_env" ^ " ; back to loop \n\n" ^
        ".done_copy_env:\n" ^
        "\t" ^ "mov r12, 0 ; i \n" ^
        "\t" ^ "mov r15, rbp \n" ^
        "\t" ^ "add r15, 32 ; r15 got Addrs of first arg \n" ^
        "\t" ^ "MALLOC r14, 8*" ^ (string_of_int len) ^ " ; allocate ExtEnv[0] \n" ^
        "\t" ^ "mov r11, r14 ; copy of ExtEnv[0] \n\n" ^
        ".copy_params:\n" ^
        "\t" ^ "cmp r12, " ^ (string_of_int len) ^ " ; " ^ (string_of_int len) ^ " arguments \n" ^
        "\t" ^ "je .done_copy_params \n" ^
        "\t" ^ "mov r9, [r15] ; r9 = Param(i) \n" ^
        "\t" ^ "mov [r14], r9 ; ExtEnv [0][i] = r9 \n" ^
        "\t" ^ "add r14, 8 \n" ^
        "\t" ^ "add r15, 8 \n" ^
        "\t" ^ "inc r12 \n" ^
        "\t" ^ "jmp .copy_params \n\n" ^
        ".done_copy_params: \n" ^
        "\t" ^ "mov [r10], r11\n" ^
        "\t" ^ "MAKE_CLOSURE(rax, r10, Lcode" ^ (string_of_int curr_count) ^ ")\n" ^
        "\t" ^ "jmp Lcont" ^ (string_of_int curr_count) ^ "\n" in

      (* Helper function for Lcode of LambdaOpt *)
      let lcodeOpt vars opt body curr_count = 
        prev_params := Pervasives.max (!prev_params) ((List.length vars) + 1); 
        let len = List.length vars in
        (* Explain: to Get Rev Args, Start by Count |<OptList>|, and then, caten Pairs from <EndOptList> to <StartOptList> *)
        "\n" ^ "Lcode" ^ (string_of_int curr_count) ^ ":\n" ^
        "\t" ^ "push rbp\n" ^
        "\t" ^ "mov rbp , rsp ; parse of lambdaOpt body below: \n\n" ^
        "\n\t" ^ "; Closure Body \n" ^ 
        "\t" ^ "mov r13, " ^ (string_of_int len) ^ " ; Start From Last Param \n" ^
        "\t" ^ "mov r15, r13 ; Save last Param Idx \n" ^
	      "\t" ^ "mov r9, const_tbl+1 ; Nil, for first pair \n\n" ^
        ".get_opt_args: \n" ^
 	      "\t" ^ "mov r8, PVAR(r15) ; Index Of Curr Param  \n" ^
        "\t" ^ "cmp r8, 6666 ; If Magic, is Last Param \n" ^
	      "\t" ^ "je .create_opt_list \n" ^
        "\t" ^ "add r15, 1 ; Add each Iter, till reach Idx Last Arg in Opt List \n" ^
	      "\t" ^ "jmp .get_opt_args \n\n" ^
        ".create_opt_list: \n" ^
        "\t" ^ "add r15, -1 ; Dec each Iter \n" ^
        "\t" ^ "mov r8, PVAR(r15) ; Index Of Curr Param  \n" ^
        "\t" ^ "MAKE_PAIR(rax, r8, r9) ; Make List \n" ^
        "\t" ^ "cmp r15, r13 ; Go BackWard, till Last Param of Regular Params \n" ^
        "\t" ^ "jl .done_create_opt_list \n" ^
        "\t" ^ "mov r9, rax ; Caten to next List \n " ^
        "\t" ^ "jmp .create_opt_list \n" ^ 
        "\t" ^ "cmp r15, r13 \n" ^ 
        "\t" ^ "jne .create_opt_list \n\n " ^
        ".done_create_opt_list: \n" ^
        "\t" ^ "mov rax, r9 ; By default Nil \n" ^
        "\t" ^ "mov r10, rbp ; Put list in Opt loc \n" ^
        "\t" ^ "shl r13, 3 ; <nParams> * 8 \n" ^
        "\t" ^ "add r10, r13 ; rbp + <sizeParams> \n" ^
        "\t" ^ "add r10, 8 * 4  \n" ^
        "\t" ^ "mov [r10], rax ; Put list \n\n" ^
        "\t" ^ "; Original Closure Body \n" ^
        (generate consts fvars body) ^ 
        "\t" ^ "leave ; done parsing lambdaOpt body above \n\n" ^
        "\t" ^ "ret \n\n" ^
        "Lcont" ^ (string_of_int curr_count) ^ ":\n" in

      (* Helper function, for generate LambdaOpt *)
      let assemOpt vars opt body curr_count curr_env len = 
        "\nlambdaOpt" ^ (string_of_int curr_count) ^ ":\n" ^ 
        "\t" ^ "mov rsi, " ^ (string_of_int (List.length vars)) ^ " ; Store <nParams> in rsi \n" ^
        "\t" ^ "MALLOC r10, 8 * (1 + " ^ (string_of_int curr_env) ^ ") ; Allocate ExtEnv\n" ^
        "\t" ^ "mov r11, r10 ; copy of ExtEnv address \n" ^
        "\t" ^ "mov r12, 0 ; i\n" ^
        "\t" ^ "mov r13, 1 ; j\n" ^
        "\t" ^ "mov r15, qword[rbp + 16] ; lexical env \n\n" ^
        ".copy_env:\n" ^
        "\t" ^ "cmp r12, " ^ (string_of_int curr_env) ^ " ; |env|\n" ^
        "\t" ^ "je .done_copy_env\n" ^
        "\t" ^ "mov r14, qword[r15 + 8 * r12] ; r14 = Env[i]\n" ^
        "\t" ^ "mov [r11 + 8 * r13], r14 ; ExtEnv[j] = r14\n" ^
        "\t" ^ "inc r12" ^ " ; inc counter of loop \n" ^ 
        "\t" ^ "inc r13" ^ " ; inc counter of loop \n" ^ 
        "\t" ^ "jmp .copy_env" ^ " ; back to loop \n\n" ^
        ".done_copy_env:\n" ^
        "\t" ^ "mov r12, 0 ; i\n" ^
        "\t" ^ "mov r15, rbp ; r15 = rbp\n" ^
        "\t" ^ "add r15, 32 ; r15 = address of first arg\n" ^
        "\t" ^ "MALLOC r14, 8*" ^ (string_of_int len) ^ " ; allocate ExtEnv[0]\n" ^ 
        "\t" ^ "mov r11, r14 ; copy of ExtEnv[0] \n\n" ^
        ".copy_params:\n" ^
        "\t" ^ "cmp r12, " ^ (string_of_int len) ^ " ; " ^ (string_of_int len) ^ " arguments\n" ^
        "\t" ^ "je .done_copy_params\n" ^
        "\t" ^ "mov r9, [r15] ; r9 = Param(i)\n" ^
        "\t" ^ "mov [r14], r9 ; ExtEnv [0][i] = r9\n" ^
        "\t" ^ "add r14, 8\n" ^
        "\t" ^ "add r15, 8\n" ^
        "\t" ^ "inc r12\n" ^
        "\t" ^ "jmp .copy_params \n\n" ^
        ".done_copy_params:\n" ^
        "\t" ^ "mov [r10], r11\n" ^
        "\t" ^ "MAKE_CLOSURE(rax, r10, Lcode" ^ (string_of_int curr_count) ^ ")\n" ^
        "\t" ^ "jmp Lcont" ^ (string_of_int curr_count) ^ "\n" in

    match e with
      | Const' (expr) -> "\t" ^ "mov rax, const_tbl+" ^ (string_of_int (get_const_addr expr consts)) ^ " ; Const \n"
      | Var'(VarFree v) -> "\t" ^ "mov rax, qword [fvar_tbl+" ^ (string_of_int (get_fvar_addr v fvars)) ^ "*WORD_SIZE]" ^ " ; VarFree \n"
      | Var'(VarParam(_, pos)) -> "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")" ^ " ; VarParam \n"
      | Var'(VarBound(_, depth, pos)) -> "\t" ^ "mov rax, qword [rbp + 16]" ^ " ; VarBound \n" ^
                                         "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")" ^ " \n" ^
                                         "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")" ^ "  \n" 
      | Def'(Var'(VarFree(name)), expr) ->
          (generate consts fvars expr) ^ 
          "\t" ^ "mov qword [fvar_tbl+" ^ (string_of_int (get_fvar_addr name fvars)) ^ "*WORD_SIZE], rax" ^ " ; define " ^ "\n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n" 
      | Set'(Var'(VarFree(v)), expr) -> (
            generate consts fvars expr) ^ 
            "\t" ^ "mov qword [fvar_tbl+" ^ (string_of_int (get_fvar_addr v fvars)) ^ "*WORD_SIZE], rax" ^ " ; VarFree, Set \n" ^
            "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      | Set'(Var'(VarParam(_, pos)), expr) -> 
          (generate consts fvars expr) ^ 
          "\t" ^ "mov qword PVAR(" ^ (string_of_int pos) ^ "), rax" ^ " ; VarParam, Set \n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      | Set'(Var'(VarBound(_, depth, pos)), expr) -> (
          generate consts fvars expr) ^
          "\t" ^ "mov rbx, qword [rbp + 16]" ^ " ; VarBound, Set \n" ^
          "\t" ^ "mov rbx, BVARX(" ^ (string_of_int depth)^ ")" ^ " ; mov rbx, qword [rbx+WORD_SIZE*depth] \n" ^
          "\t" ^ "mov BVARX(" ^ (string_of_int pos) ^ "), rax" ^ "\n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      | Seq'(exprs) -> String.concat "\n" (List.map (generate consts fvars) exprs) (* generate "Epsilons" (=exprs), separated by "newline" *)
      | Or'(exprs) -> 
          let current = !count in
          count := !count + 1;
          (* Helper function to generate Or' *)
          let or_gen consts fvars expr =
            (generate consts fvars expr) ^ 
            "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ "\n" ^
            "\t" ^ "jne LexitOr" ^ (string_of_int current) ^ "\n" in
          String.concat "\n" (List.map (or_gen consts fvars) exprs) ^
          "\n\t" ^ "LexitOr" ^ (string_of_int current) ^ ":\n"
      | If'(test, dit, dif) -> 
          let current = !count in
          count := !count + 1;
          (generate consts fvars test) ^ 
          "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ "\n" ^
          "\t" ^ "je Lelse" ^ (string_of_int current) ^ "\n" ^ 
          (generate consts fvars dit) ^ 
          "\t" ^ "jmp LexitIf" ^ (string_of_int current) ^ "\n\n" ^
          "Lelse" ^ (string_of_int current) ^ ":\n" ^
          (generate consts fvars dif) ^ "\n\n" ^ 
          "LexitIf" ^ (string_of_int current) ^ ":\n"
      | BoxGet'(VarParam(_, pos)) -> 
          "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")" ^ " ; BoxGet, VarParam \n" ^ 
          "\t" ^ "mov rax, qword [rax]" ^ "\n"
      | BoxGet'(VarBound(_, depth, pos)) -> 
          "\t" ^ "mov rax, qword [rbp + 16]" ^ " ; BoxGet, VarBound \n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")\n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")\n" ^
          "\t" ^ "mov rax, qword [rax]" ^ "\n"
      | BoxSet'(VarParam(_, pos), expr) -> 
          (generate consts fvars expr) ^
          "\t" ^ "push rax ; BoxSet, VarParam \n" ^
          "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")\n" ^ 
          "\t" ^ "pop qword [rax]\n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS\n"
      | BoxSet'(VarBound(_, depth, pos), expr) -> 
          (generate consts fvars expr) ^ 
          "\t" ^ "push rax ; BoxSet, VarBound \n" ^
          "\t" ^ "mov rax, qword [rbp +16]\n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")\n" ^
          "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")\n" ^
          "\t" ^ "pop qword [rax]\n" ^
          "\t" ^ "mov rax, SOB_VOID_ADDRESS\n"
      | Box'(VarParam (_, pos)) -> 
          "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ") ; Box, VarParam \n" ^
          "\t" ^ "MALLOC rbx, 8 \n" ^
          "\t" ^ "mov [rbx], rax \n" ^
          "\t" ^ "mov rax, rbx \n"
      | LambdaSimple'(vars, body) -> 
          let (curr_count, curr_env) = (!count, !env_count) in
          count := !count + 1;
          env_count := !env_count + 1;
          let len = !prev_params in
          let out = "\n" ^ (assemLambda vars body curr_count curr_env len) ^ (lcodeSimple vars body curr_count) in
          env_count := !env_count - 1; out
      | LambdaOpt'(vars, opt, body) -> 
          let (curr_count, curr_env) = (!count, !env_count) in
          count := !count + 1;
          env_count := !env_count + 1;
          let len = !prev_params in
          let out = "\n" ^ (assemOpt vars opt body curr_count curr_env len) ^ (lcodeOpt vars opt body curr_count) in
          env_count := !env_count - 1; out
      | Applic'(op, args) -> 
          let args = List.rev args in 
          let len = List.length args in
          count := !count + 1;
          (* Helper function, for generate applic *)
          let rec applic_rec args =
            match args with
              | car :: cdr -> 
                (generate consts fvars car) ^
                "\t" ^ "push rax \n" ^ 
                applic_rec cdr
              | [] -> 
                "\t" ^ "mov rcx, " ^ (string_of_int len) ^ " ; <nArgs> \n" ^ 
                "\t" ^ "push " ^ (string_of_int len) ^ " ; parse <op> below: \n" ^
                (generate consts fvars op) ^
                "\t" ^ "mov rbx, [rax+TYPE_SIZE] ; env \n" ^
                "\t" ^ "push rbx ; push env \n" ^
                "\t" ^ "mov rbx, [rax+TYPE_SIZE+WORD_SIZE] ; code \n" ^
                "\t" ^ "call rbx ; call code\n " ^ 
                "\t" ^ "add rsp, 8*1 ; pop env \n" ^ 
                "\t" ^ "pop rbx ; pop arg count \n" ^
                "\t" ^ "inc rbx \n" ^
                "\t" ^ "shl rbx, 3 ; rbx = rbx * 8 \n" ^
                "\t" ^ "add rsp, rbx ; pop args \n\n"
          in 
          (* Explain use: push 6666 Magic at end, sign for EndArgs of LambdaOpt *)
          "\n\t" ^ "mov rax, 6666 ; applic \n" ^
          "\t" ^ "push rax ; 6666 As Magic, At the End of Args \n" ^
          (applic_rec args)
      | ApplicTP'(op, args) ->
          let args = List.rev args in 
          let len = List.length args in
          (* Helper function, for generate applic in tail position *)
          let rec applicTP_rec args =
            match args with
              | car :: cdr -> 
                (generate consts fvars car) ^ 
                "\t" ^ "push rax \n" ^ 
                applicTP_rec cdr
              | [] -> 
                "\t" ^ "mov rcx, " ^ (string_of_int len) ^ " ; <nArgs> \n" ^
                "\t" ^ "push " ^ (string_of_int len) ^ " ; parsing of operator below: \n" ^
                (generate consts fvars op) ^
                "\t" ^ "mov r9, [rax+TYPE_SIZE] ; env \n" ^
                "\t" ^ "push r9 \n" ^
                "\t" ^ "mov r10, [rax+TYPE_SIZE+WORD_SIZE] ; code \n" ^
                "\t" ^ "push qword [rbp + 8] ; old ret addr \n" ^
                "\t" ^ "mov r15, qword[rbp] \n" ^
                "\t" ^ "SHIFT_FRAME " ^ (string_of_int (len + 5)) ^ "\n" ^
                "\t" ^ "mov rbp, r15 \n" ^
                "\t" ^ "jmp r10 ; code \n\n"
          in 
          (* Explain use: push 6666 Magic at end, sign for EndArgs of LambdaOpt *)
          "\t" ^ "mov rax, 6666 ; applic tail position \n" ^
          "\t" ^ "push rax ; 6666 As Magic, At the End of Args \n" ^
          (applicTP_rec args)
      | _ -> raise X_not_yet_implemented;;

end;;
