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
end;;

module Code_Gen : CODE_GEN = struct


  (* 25.12, 22.37 update
    TODO:
        .1. In cons_tbl: implement pair & vector & char.
        .2. Add tests.
        .3. check and fix pair in cons_tbl.
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

  let rec filter_const lst const = 
    match lst with
      | car :: cdr ->
          (match car with
            | Bool _ | Number _ | Nil | Char _ | String _ | Symbol _ | Pair _ | Vector _ -> 
              if List.mem car const then filter_const cdr const else filter_const cdr (const @ [car])
            | _ -> filter_const cdr const) (* TODO: fix warning *)
      | [] -> const;;

  let filter_const lst = filter_const lst [];;

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
            (* | Nil -> raise X_not_yet_impleneted *)
      | [] -> newLst ;;

  let expand_lst lst = expand_lst lst [] ;;

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
    

  (*  expr' list -> (constant * ('a * string)) list *)
  let make_consts_tbl asts = raise X_not_yet_implemented;;


  (* expr' list -> (string * 'a) list *)
  let make_fvars_tbl asts = raise X_not_yet_implemented;;


  (* (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string *)
  let generate consts fvars e = raise X_not_yet_implemented;;
end;;

