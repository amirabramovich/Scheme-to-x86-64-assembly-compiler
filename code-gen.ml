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
  val cons_tbl : sexpr list -> (string * (int * string)) list
end;;

module Code_Gen : CODE_GEN = struct


  (* 23.12, 22.49 update
     Done:
        .1. Add tests

    TODO:
        .1. In expand_lst: fix pair case
        .2. Add tests
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

  (* 3. Expand the list to include all sub-constants
  The list should be sorted topologically *)
  (* Logic of code is from ps #11, 2.2.1 *)
  let rec expand_lst lst newLst =
    match lst with
      | car :: cdr -> 
          (match car with
            | Symbol (str) -> expand_lst cdr ([String str; car] @ newLst)
            | Pair(currCar, currCdr) -> expand_lst cdr [currCar; currCdr; car] @ newLst

              (* let rec expand_pair car currCar currCdr newLst = 
              (match currCdr with
                | Pair (f, s) -> [currCar] @ expand_pair car f s [] @ [car] @ newLst
                | _ -> expand_lst cdr ([currCar; currCdr; car] @ newLst))
              in
              expand_pair car currCar currCdr newLst *)

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

  let rec get_const const tbl =
    match tbl with
      | (sexpr, info) :: cdr -> if sexpr_eq const sexpr then info 
                                else get_const const cdr
      | [] -> raise X_not_yet_implemented;;

  let get_const_addr const tbl =
    let (addr, _) = get_const const tbl 
  in addr;;

  let rec cons_tbl consts tbl addr =
    match consts with
    | car :: cdr -> (match car with
                        | String expr -> cons_tbl cdr (tbl @ [(expr, (addr, "test"))]) (addr + size_of car)
                        | _ -> raise X_not_yet_implemented) (* Added due to Warning: "pattern-matching not exhaustive" *)
    | _ -> tbl ;;

  let cons_tbl consts = cons_tbl consts [
    ("Void", (0, "MAKE_VOID"));
    ("Nil", (1, "MAKE_NIL"));
    ("Bool false", (2, "MAKE_BOOL(0)"));
    ("Bool true", (4, "MAKE_BOOL(1)"));
    ] 6;;


  (*  expr' list -> (constant * ('a * string)) list *)
  let make_consts_tbl asts = raise X_not_yet_implemented;;


  (* expr' list -> (string * 'a) list *)
  let make_fvars_tbl asts = raise X_not_yet_implemented;;


  (* (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string *)
  let generate consts fvars e = raise X_not_yet_implemented;;
end;;

