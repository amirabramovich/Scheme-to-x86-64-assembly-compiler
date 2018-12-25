#use "semantic-analyser.ml";;

module type CODE_GEN = sig
  val make_consts_tbl : expr' list -> (constant * ('a * string)) list
  val make_fvars_tbl : expr' list -> (string * 'a) list
  val generate : (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string

  (* Add funcs for tests *)
  (* TODO: delete later *)
  val scan_ast : expr' list -> sexpr list
  val remove_dups : 'a list -> 'a list
  val filter_const : sexpr list -> sexpr list
  val expand_lst : sexpr list -> sexpr list
  val cons_tbl : sexpr list -> (constant * (int * string)) list
end;;

module Code_Gen : CODE_GEN = struct


  (* 24.12, 02.24 update
     Done:
        .1. In expand_lst: fix pair ? => not sure (but maybe ... no time to validate : \)
        .2. Expand const_tbl => need to check ..
        .3. Add tests & order in tests ..

    TODO:
        .1. Add tests (cons_tbl and more ..).
        .2. Make order in code: "clean" un necessary comments (move to tests or notes ..).
  *)


  (* 1. Scan the AST (one recursive pass) & collect the sexprs in all
  Const records - The result is a list of sexprs *)
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

  let rec filter_const lst const = 
    match lst with
      | car :: cdr ->
          (match car with
            | Bool _ | Number _ | Nil | Char _ | String _ | Symbol _ | Pair _ | Vector _ -> 
              if List.mem car const then filter_const cdr const else filter_const cdr (const @ [car])
            | _ -> filter_const cdr const) (* TODO: fix warning *)
      | [] -> const;;

  let filter_const lst = filter_const lst [];;

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
            (* | Nil -> raise X_not_yet_impleneted *)
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

  let rec get_const const tbl =
    match tbl with
      | (Sexpr sexpr, info) :: cdr -> if sexpr_eq const sexpr then info 
                                      else get_const const cdr
      | [] -> raise X_not_yet_implemented
      | _ -> raise X_not_yet_implemented;; (* fix warning *)

  let get_const_addr const tbl =
    let (addr, _) = get_const const tbl 
  in addr;;

  let sexp_eq s1 s2 = (* s1 = Sexpr (String str1), s2 = Sexpr(String str2) *)
    match s1, s2 with
      | (Symbol sym), (String str) -> sym = str
      | (Number n1), (Number n2) -> n1 = n2
      | (Bool b1), (Bool b2) -> b1 = b2
      | s_1, s_2 -> s_1 = s_2;;

  let rec orig_addr s tbl = 
    let filt = List.map (fun (_,(a, _)) -> a) (List.filter (fun (Sexpr sexpr, (_, _)) -> sexp_eq s sexpr) tbl) in
    if (List.length filt) = 0 then -1 else (List.nth filt 0);;

  let rec cons_tbl consts tbl addr =
    match consts with
    | car :: cdr -> 
      (match car with
        | Nil | Bool _ -> cons_tbl cdr tbl addr
        | String expr -> cons_tbl cdr (tbl @ [(Sexpr(String expr), (addr, "MAKE_LITERAL_STRING(\"" ^ expr ^ "\")"))]) (addr + size_of car)
        | Number(Int num) -> 
          cons_tbl cdr (tbl @ [(Sexpr(Number(Int num)), (addr, "MAKE_LITERAL_INT(" ^ (string_of_int num) ^ ")"))]) (addr + size_of car)
        (*  
          TODO: 
            .1. complete function
            .2. test Number and func. 
        *)
        | Number(Float num) -> cons_tbl cdr (tbl @ [(Sexpr(Number(Float num)), (addr, 
            "MAKE_LITERAL_FLOAT(" ^ (string_of_int (int_of_float num)) ^ ")"))]) (addr + size_of car)
        | Symbol sym -> cons_tbl cdr (tbl @ [(Sexpr(Symbol sym), (addr, 
          "MAKE_LITERAL_SYMBOL(consts+" ^ string_of_int (orig_addr car tbl) ^ ")"))]) (addr + size_of car)
        | Pair (f, s) -> cons_tbl cdr (tbl @ [(Sexpr car, (addr, 
          "MAKE_LITERAL_PAIR(const+" ^ string_of_int (orig_addr f tbl) ^ ", const+" ^ string_of_int (orig_addr s tbl) ^ ")"))]) (addr + size_of car)
        | Vector v -> raise X_not_yet_implemented
        | _ -> raise X_not_yet_implemented) (* Added due to Warning: "pattern-matching not exhaustive" *)
    | _ -> tbl ;;

  let cons_tbl consts = cons_tbl consts [
    (Void, (0, "MAKE_VOID"));
    (Sexpr(Nil), (1, "MAKE_NIL"));
    (Sexpr(Bool false), (2, "MAKE_BOOL(0)"));
    (Sexpr(Bool true), (4, "MAKE_BOOL(1)"));
    ] 6;;


  (*  expr' list -> (constant * ('a * string)) list *)
  let make_consts_tbl asts = raise X_not_yet_implemented;;


  (* expr' list -> (string * 'a) list *)
  let make_fvars_tbl asts = raise X_not_yet_implemented;;


  (* (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string *)
  let generate consts fvars e = raise X_not_yet_implemented;;
end;;

