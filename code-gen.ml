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

  (* Update 5.1, 3:41
        Done:
          .1. Fix bugs in Box
          .2. Add more tests
          .3. A bit order in tests & code
          .4. Try Implement ApplicTP'

        TODO:
          .1. Check more cases of LambdaOpt', and fix if needed.
          .2. Finish Implement ApplicTP', and check it.
          .3. check again all tests of box, and fix box if needed.
          .4. Make code more simple and nice (use defines, macros, enums (for example: different enum for MAGIC for each different use), etc).
              Put functions of each similar code, think of the most exact names (funcs, params), try to make smaller number of params and code.
              Delete (only!) un necessary code, comments, etc (think of clean and exact code).
              Think of this code as going to preset it. (Look at semantic-analyser.ml for example).
          .5. Expand tests and make order in them, use tests of others from facebook (can add to our tests, or just use).
          .6. At the end, remove added (for check only) functions to code-gen.ml signature, and put GB(4) at proloug (at rdi register).
          .7. Implement apply assembly function, and check it.
          .8. Go to the rest of files (compiler.ml, compiler.s, prims.s, stdlib.scm) and think what need to implement or improve.
          .9. Prepare for submit: think (and know) which files exactly should be on the final patch.
  *)

  let count = (ref 0);;
  let env_count = (ref 0);;
  let prev_args = (ref 0);;

  (* Helper function, scan AST & collect const sexprs, return sexprs list *)
  let rec scan_ast asts consts = 
    match asts with
      | car :: cdr -> 
         (match car with
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
    (* Helper function for Lcode of LambdaSimple' *)
    let lcodeSimple vars body curr_count = 
        prev_args := List.length vars;
        "\n\t" ^ "Lcode" ^ (string_of_int curr_count) ^ ":\n" ^
        "\t" ^ "push rbp\n" ^
        "\t" ^ "mov rbp , rsp ; parse of lambdaSimple body below: \n" ^
        (generate consts fvars body) ^ 
        "\t" ^ "leave ; done parsing lambdaSimple body above \n" ^
        "\t" ^ "ret\n" ^
        "\n\t" ^ "Lcont" ^ (string_of_int curr_count) ^ ":\n" in

     (* Helper function, for generate Lambda *)
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

    match e with
      | Const' (expr) -> "\t" ^ "mov rax, const_tbl + " ^ (string_of_int (get_const_addr expr consts)) ^ " ; Const \n"
      | Var'(VarFree v) -> "\t" ^ "mov rax, qword [fvar_tbl + " ^ (string_of_int (get_fvar_addr v fvars)) ^ " * WORD_SIZE]" ^ " ; VarFree \n"
      (* Add Box' *)
      | Var'(VarParam(_, pos)) | Box'(VarParam(_, pos)) ->
          "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ") ; Var' or Box' of VarParam \n" ^
          "\t" ^ "mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param \n"
      | Var'(VarBound(_, depth, pos)) | Box'(VarBound(_, depth, pos)) -> 
          "\t" ^ "mov rax, qword [rbp + 16]" ^ " ; Var' or Box' of VarBound \n" ^
                                        "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")" ^ "\n" ^
                                        "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")" ^ "\n" 
      | Def'(Var'(VarFree(name)), expr) -> (generate consts fvars expr) ^ 
                                          "\t" ^ "mov qword [fvar_tbl + " ^ (string_of_int (get_fvar_addr name fvars)) ^ " * WORD_SIZE], rax" ^  
                                          "; Define " ^ "\n" ^
                                          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n" 
      | Set'(Var'(VarFree(v)), expr) -> (generate consts fvars expr) ^
                                          "\t" ^ "mov qword [fvar_tbl + " ^ (string_of_int (get_fvar_addr v fvars)) ^ " * WORD_SIZE], rax" ^ 
                                          " ; VarFree, Set \n" ^
                                          "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      | Set'(Var'(VarParam(_, pos)), expr) -> (generate consts fvars expr) ^ (* works *)
                                              "\t" ^ "mov qword PVAR(" ^ (string_of_int pos) ^ "), rax" ^ " ; VarParam, Set \n" ^
                                              "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      | Set'(Var'(VarBound(_, depth, pos)), expr) -> (generate consts fvars expr) ^ (* works *)
                                                  "\t" ^ "mov rbx, qword [rbp + 16]" ^ " ; VarBound, Set \n" ^
                                                  "\t" ^ "mov rbx, BVARX(" ^ (string_of_int depth)^ ")" ^  "\n" ^
                                                  "\t" ^ "mov BVARX(" ^ (string_of_int pos) ^ "), rax" ^ "\n" ^
                                                  "\t" ^ "mov rax, SOB_VOID_ADDRESS" ^ "\n"
      (* TODO: Implement Box with MALLOC *)
      | BoxGet'(VarParam(_, pos)) -> "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")" ^ " ; VarParam, BoxGet' \n" (* fix bug here *)
                                   (* ^ "\t" ^ "mov rax, qword[rax] \n" *)
      | BoxGet'(VarBound(_, depth, pos)) -> "\t" ^ "mov rax, qword [rbp + 16]" ^ " ; VarBound, BoxGet' \n" ^ (* works *)
                                            "\t" ^ "mov rax, BVAR(" ^ (string_of_int depth) ^ ")\n" ^
                                            "\t" ^ "mov rax, BVAR(" ^ (string_of_int pos) ^ ")\n" ^
                                            "\t" ^ "mov rax, qword [rax]" ^ "\n"
      | BoxSet'(VarParam(_, pos), expr) -> (generate consts fvars expr) ^ (* works *)
                                          "\t" ^ "push rax" ^ " ; VarParam, BoxSet' \n" ^
                                          "\t" ^ "mov rax, PVAR(" ^ (string_of_int pos) ^ ")\n" ^
                                          "\t" ^ "pop qword [rax]\n" ^
                                          "\t" ^ "mov rax, SOB_VOID_ADDRESS\n"
      | BoxSet'(VarBound(_, depth, pos), expr) -> (generate consts fvars expr) ^ (* fix bug here *)
                                                  "\t" ^ "push rax ; VarBound, BoxSet' \n" ^
                                                  "\t" ^ "mov rax, qword [rbp +16]\n" ^
                                                  "\t" ^ "mov rax, BVARX(" ^ (string_of_int depth) ^ ")\n" ^
                                                  "\t" ^ "mov rax, BVARX(" ^ (string_of_int pos) ^ ")\n" ^
                                                  "\t" ^ "pop qword [rax]\n" ^
                                                  "\t" ^ "mov rax, SOB_VOID_ADDRESS\n"
      | Seq'(exprs) -> String.concat "\n" (List.map (generate consts fvars) exprs) 
      | Or'(exprs) -> 
          let currIdx = !count in
          count := !count + 1;
          (* Helper function to generate Or' *)
          let or_gen consts fvars expr =
            (generate consts fvars expr) ^ 
            "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ " ; Or \n" ^
            "\t" ^ "jne LexitOr" ^ (string_of_int currIdx) ^ "\n"
          in
          String.concat "\n" (List.map (or_gen consts fvars) exprs) ^
          "\t" ^ "LexitOr" ^ (string_of_int currIdx) ^ ":\n"
      | If'(test, dit, dif) ->
          let currIdx = !count in
          count := !count + 1;
          (generate consts fvars test) ^ (* generate test *)
          "\t" ^ "cmp rax, SOB_FALSE_ADDRESS" ^ " ; If \n" ^
          "\t" ^ "je Lelse" ^ (string_of_int currIdx) ^ "\n" ^ (* Lelse of current (number) If' *)
          (generate consts fvars dit) ^ (* generate dit *)
          "\t" ^ "jmp LexitIf" ^ (string_of_int currIdx) ^ "\n" ^
          "\t" ^ "Lelse" ^ (string_of_int currIdx) ^ ":\n" ^
          (generate consts fvars dif) ^ 
          "\t" ^ "LexitIf" ^ (string_of_int currIdx) ^ ":\n"
      | LambdaSimple'(vars, body) -> 
          let (curr_count, curr_env) = (!count, !env_count) in
          count := !count + 1;
          env_count := !env_count + 1;
          let len = !prev_args in
          let out = "\n"^(assemLambda vars body curr_count curr_env len) ^ (lcodeSimple vars body curr_count) in
          env_count := !env_count - 1; out
      (* TODO: check more cases of LambdaOpt', and fix if needed *)
      | LambdaOpt'(vars, opt, body) ->
          let vars = vars @ [opt] in
          let (curr_count, curr_env) = (!count, !env_count) in
          count := !count + 1;
          env_count := !env_count + 1;
          prev_args := !prev_args + (List.length vars); 
          let len = !prev_args in
          let out = "\n\t" ^ ";LambdaOpt \n" ^ (assemLambda vars body curr_count curr_env len) ^ (lcodeSimple vars body curr_count) in
          env_count := !env_count - 1; prev_args := !prev_args - (List.length vars); out
      | Applic'(op, args) | ApplicTP'(op, args) -> 
          let args = List.rev args in
          let len = List.length args in
          (* Helper function, generate applic *)
          let rec applic_gen args =
            match args with
              | car :: cdr -> 
                (generate consts fvars car) ^
                "\t" ^ "push rax" ^ " ; push arg \n" ^ 
                applic_gen cdr
              | [] -> 
                "\t" ^ "push " ^ (string_of_int len) ^ " ; push number args \n" ^ 
                "\t" ^ "; start parse op \n" ^
                (generate consts fvars op) ^
                "\t" ^ "; finish parse op \n " ^
                "\t" ^ "mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx \n" ^
                "\t" ^ "push rbx ; push env (args) to stack (rsp stack pointer) \n" ^
                "\t" ^ "mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx \n" ^
                "\t" ^ "call rbx ; call code (of closure) \n" ^
                "\t" ^ "add rsp, 8*1 ; pop env (args) \n" ^ 
                "\t" ^ "pop rbx ; pop number args \n" ^
                "\t" ^ "inc rbx ; add magic as param (in counter) for pop \n" ^ 
                "\t" ^ "shl rbx, 3 ; rbx = rbx * 8 (calc size args) \n" ^
                "\t" ^ "add rsp, rbx ; pop args \n\n" 
          in
          "\n\t" ^ "mov rax, MAGIC ; Applic \n" ^
          "\t" ^ "push rax ; push magic to stack \n" ^
          (applic_gen args)
      | ApplicTP'(op, args) ->
          let currIdx = !count in
          count := !count + 1;
          let revArgs = List.rev args in
          let numArgs = List.length args in
          (* Helper function, generate applic, in tail position *)
          let rec applicTP_gen args =
            match args with
              | car :: cdr -> 
                (generate consts fvars car) ^
                "\t" ^ "push rax" ^ " ; push arg \n" ^
                applicTP_gen cdr
              | [] -> 
                "\t" ^ "push " ^ (string_of_int numArgs) ^ "; push number args \n" ^
                "\t" ^ "; start parse op \n" ^
                (generate consts fvars op) ^
                "\t" ^ "; finish parse op \n" ^
                "\t" ^ "mov rbx, [rax + TYPE_SIZE] ; closure's env \n" ^
                "\t" ^ "push rbx ; push env (args) \n" ^
                (* Add code for ApplicTP' (Logic of code is from Lecture #5, pages 44-46) *)
                "\t" ^ "push qword[rbp + 8*1] ; push old ret addr \n" ^ 
                "\t" ^ "mov rsp, rbp ; restore old frame ptr register \n" ^
                (* Fix the stack *)
                "\t" ^ "cmp r15, IS_PARAM ; if arg is param, need to add 8 to rsp \n" ^
                "\t" ^ "jne .not_param" ^ (string_of_int currIdx) ^ "\n" ^
                "\t" ^ "add rsp, 8 ; for my check \n" ^ (* added, for my check *)
                "\t" ^ "mov r15, 0 \n" ^
                "\t" ^ ".not_param" ^ (string_of_int currIdx) ^ ": \n" ^
                "\t" ^ "SHIFT_FRAME " ^ (string_of_int (numArgs + 5)) ^ " ; shift frame, where frame size is " ^ (string_of_int (numArgs + 5)) ^ "\n" ^
                (generate consts fvars op) ^ (* parse op again, for closure code *)
                "\t" ^ "mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code \n" ^
                "\t" ^ "jmp rbx ; jmp to code (closure) \n" ^ (* change call to jmp *)
                "\t" ^ "add rsp, 8*1 ; pop env (args) \n" ^ 
                "\t" ^ "pop rbx ; pop number args \n" ^
                "\t" ^ "inc rbx ; add magic as param (for pop) \n" ^ 
                "\t" ^ "shl rbx, 3 ; rbx = rbx * 8 (calc size args) \n" ^
                "\t" ^ "add rsp, rbx ; pop args \n" 
          in
          "\n\t" ^ "mov rax, MAGIC ; ApplicTP \n" ^
          "\t" ^ "push rax ; push magic to stack \n" ^
          (applicTP_gen revArgs)

      | _ -> raise X_not_yet_implemented;; (* TODO: check if all cases are checked. *)

end;;

