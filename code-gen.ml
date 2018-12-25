#use "semantic-analyser.ml";;

module type CODE_GEN = sig
  val make_consts_tbl : expr' list -> (constant * ('a * string)) list
  val make_fvars_tbl : expr' list -> (string * 'a) list
  val generate : (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string

  (* Add funcs for tests *)
  (* TODO: delete later *)
  val scan_ast : expr' list -> sexpr list
  val remove_dups : 'a list -> 'a list
  val expand_lst : sexpr list -> sexpr list
end;;

module Code_Gen : CODE_GEN = struct


  (* 25.12, 12:10 update
    TODO:
        .1. Add tests 
        .2. check and fix pair in cons_tbl.
  *)


  (* 1. Scan the AST (one recursive pass) & collect the sexprs in all Const records - The result is a list of sexprs *)
  let rec scan_ast asts consts = 
    match asts with
      | car :: cdr -> (match car with
                        | Const' Sexpr expr -> scan_ast cdr [expr] @ consts
                        | Applic' (_,exprs) -> scan_ast cdr consts @ (scan_ast exprs consts) 
                        | _ -> scan_ast cdr consts)
      | _ -> consts ;;

  let scan_ast asts = scan_ast asts [] ;;

  (* 2. Convert the list to a set (removing duplicates) *)
  let rec remove_dups lst = 
    match lst with
      | [] -> []
      | car :: cdr -> car :: (remove_dups (List.filter (fun e -> e <> car) cdr)) ;;

  (* Recieves pairs and flattens them to list *)
  (* Taken from tag-parser.ml *)
  (* Idea: take helper functions of code-gen.ml, and helpers funcs that appear in multiple files, into one lib.ml file in Struct *)
  let rec flatPair = function
    | Nil -> []
    | Pair(a, Nil) -> [a]
    | Pair(a, Pair(b, c)) -> a :: (flatPair(Pair(b, c)))
    | Pair(a, b) -> [a; b]
    | _ -> raise X_syntax_error;;

  (* 3. Expand the list to include all sub-constants
  The list should be sorted topologically *)
  (* Logic of code is from ps #11, 2.2.1 *)
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

  (* 4. Convert the resulting list into a set (remove all duplicates, again) *)

  (* 5. Go over the list, from first to last, and create the constants-table *)

  (* [(Void, 0, "MAKE_VOID");
  (Sexpr(Nil), 1, "MAKE_NIL");
  (Sexpr(Bool false), 2, "MAKE_BOOL(0)");
  (Sexpr(Bool true), 4, "MAKE_BOOL(1)");
  (Sexpr(String "ab"), 6, "MAKE_LITERAL_STRING(\"ab\")");
  (Sexpr(Number(Int 1)), 17, "MAKE_LITERAL_INT(1)");
  (Sexpr(Number(Int 2)), 26, "MAKE_LITERAL_INT(2)");
  (Sexpr(Pair(Number(Int 2),
  Nil)), 35, "MAKE_LITERAL(consts+26, consts+1");
  (Sexpr(Pair(Number(Int 1),
  Pair(Number(Int 2)), Nil)), 52, "MAKE_LITERAL(consts+17, consts+35");
  (Sexpr(String "c"), 69, "MAKE_LITERAL_STRING(\"c\")");
  (Sexpr(Symbol "c"), 79, "MAKE_LITERAL_SYMBOL(consts+69)");
  (Sexpr(Symbol "ab"), 88, "MAKE_LITERAL_SYMBOL(consts+6)")] *)

  let rec size_of expr =
    match expr with
      | Nil -> 1
      | Bool _ | Char _ -> 2
      | Number _ | Symbol _ -> 9
      | String(s) -> 9 + (String.length s)
      | Pair _ -> 17
      | Vector(v) -> 9 + (8 * (List.length v));;

  let get_const const tbl = List.assoc const tbl;;

  let get_const_addr const tbl =
    let (addr, _) = get_const const tbl 
  in addr;;

  let rec cons_tbl consts tbl addr =
    match consts with
    | car :: cdr -> (match car with
                        | Char ch -> raise X_not_yet_implemented
                        | String expr -> cons_tbl cdr (tbl @ [(Sexpr(String expr), (addr, "MAKE_LITERAL_STRING(\"" ^ expr ^ "\")"))]) (addr + size_of car)
                        | Number(Int num) -> 
                          cons_tbl cdr (tbl @ [(Sexpr(Number(Int num)), (addr, "MAKE_LITERAL_INT(" ^ (string_of_int num) ^ ")"))]) (addr + size_of car)
                        | Number(Float num) -> 
                          cons_tbl cdr (tbl @ [(Sexpr(Number(Float num)), (addr, "MAKE_LITERAL_FLOAT(" ^ (string_of_float num) ^ ")"))]) (addr + size_of car)
                        | Symbol sym -> 
                          cons_tbl cdr (tbl @ [(Sexpr(Symbol sym), (addr, "MAKE_LITERAL_SYMBOL(consts+" ^ string_of_int (get_const_addr (Sexpr(String sym)) tbl) ^ ")"))]) (addr + size_of car) 
                        | Pair (f, s) -> 
                          cons_tbl cdr (tbl @ [(Sexpr(Pair (f, s)), (addr, "MAKE_LITERAL_PAIR(consts+" ^ string_of_int (get_const_addr (Sexpr f) tbl) ^ ", consts+" ^ string_of_int (get_const_addr (Sexpr s) tbl) ^ ")"))]) (addr + size_of car)
                        | Vector v -> raise X_not_yet_implemented 
                        | _ -> raise X_syntax_error) 
    | [] -> tbl ;;
    
  let cons_tbl consts = cons_tbl consts [
    (Void, (0, "MAKE_VOID"));
    (Sexpr(Nil), (1, "MAKE_NIL"));
    (Sexpr(Bool false), (2, "MAKE_BOOL(0)"));
    (Sexpr(Bool true), (4, "MAKE_BOOL(1)"));
    ] 6;;

    (* ----------TESTS----------- *)
    (* #use "code-gen.ml";; *)
    (* open Semantics;;
    open Tag_Parser;;
    open Reader;;
    open PC;;
    let multi_annotate_lexical_addresses exprs = List.map annotate_lexical_addresses exprs;;
    let scan_test x = scan_ast (multi_annotate_lexical_addresses (tag_parse_expressions (read_sexprs x)));;
    scan_test "1";;
    scan_test "1 1";;
    scan_test "'(1)";;
    scan_test "'(1 2 3 4)";;
    scan_test "(foo 2)";;
    scan_test "(+ 1 2)";;
    scan_test "'a";;
    scan_test "'(1 (2 3))";;
    scan_test "'(1 .(2 3))";;
    scan_test "#( #t )";;
    scan_test "#( 37392 )";;
    scan_test "#( 37392.39382 )";;
    scan_test "#( #\\c 37392.39382 )";; 
    let dups_test x = remove_dups(scan_test x) ;;
    dups_test "1";;
    dups_test "1 1";; 
    dups_test "'(1 (2 3))";; 
    dups_test "#( #\\c 37392.39382 )";; 
    let expand_test x = expand_lst(dups_test x) ;;
    expand_test "1";;
    expand_test "1 1";; 
    expand_test "'a";;
    expand_test "'(1)";;
    expand_test "#( #\\c 37392.39382 )";; 
    expand_test "'(1 (2 3))";; 
    let dups2_test x = remove_dups(expand_test x) ;;
    dups2_test "1";;
    dups2_test "1 1";; 
    dups2_test "'a";;
    dups2_test "'(1)";;
    dups2_test "#( #\\c 37392.39382 )";; 
    dups2_test "'(1 (2 3))";;
    dups2_test "'((1 2) (2 3))";;
    dups2_test "\"This is a string\"";;
    let tbl_test x = cons_tbl(dups2_test x) ;;
    tbl_test "\"This is first string\" \"This is second string\" ";;
    tbl_test "1 2 1 (1 2)";; *)
     (* ----------TESTS-END----------- *)

  (*  expr' list -> (constant * ('a * string)) list *)
  let make_consts_tbl asts = raise X_not_yet_implemented;;


  (* expr' list -> (string * 'a) list *)
  let make_fvars_tbl asts = raise X_not_yet_implemented;;


  (* (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string *)
  let generate consts fvars e = raise X_not_yet_implemented;;
end;;

