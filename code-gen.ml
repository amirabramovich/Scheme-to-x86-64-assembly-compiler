#use "semantic-analyser.ml";;

module type CODE_GEN = sig
  val make_consts_tbl : expr' list -> (constant * (int * string)) list
  val make_fvars_tbl : expr' list -> (string * int) list
  val generate : (constant * (int * string)) list -> (string * int) list -> expr' -> string

  (* Add funcs for tests *)
  (* TODO: delete later *)
  val scan_ast : expr' list -> sexpr list
  val remove_dups : 'a list -> 'a list
  val expand_lst : sexpr list -> sexpr list
  val cons_tbl : sexpr list -> (constant * (int * string)) list
end;;

module Code_Gen : CODE_GEN = struct


  (* 27.12, 10:00 update
      Done:
        .1. make_consts_tbl : expr' list -> (constant * (int * string)) list
        .2. make_fvars_tbl : expr' list -> (string * int) list

      TODO:
        .1. make tests for them both.
  *)

  (* 26.12, 02:55 update
      Done:
        .1. Add vector to cons_tbl.
        .2. Add tests for pair & vector.
        .3. A bit order
  
      TODO:
        .1. check: pair & vector & char.
        .2. Add tests.
        .3. Document code (and tests).
        .4. Order in code (and tests).
  *)


  (* 1. Scan the AST (one recursive pass) & collect the sexprs in all Const records - The result is a list of sexprs *)
  let rec scan_ast asts consts = 
    match asts with
      | car :: cdr -> (match car with
                        | Const' Sexpr expr -> scan_ast cdr [expr] @ consts
                        | Applic' (op, exprs) -> scan_ast cdr consts @ (scan_ast ([op] @ exprs) consts) 
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
    let lst_string = List.map (fun s -> "consts+" ^ string_of_int (get_const_addr (Sexpr s) tbl)) vec in
    String.concat ", " lst_string;;

  (* Cons_tbl helper func, got consts, tbl and addr, return tbl (at the end of recursion) *)
  let rec cons_tbl consts tbl addr =
    match consts with
    | car :: cdr -> 
      (match car with
        | Bool _ | Nil -> cons_tbl cdr tbl addr
        | Char ch -> cons_tbl cdr (tbl @ [(Sexpr(Char ch), (addr, "MAKE_LITERAL_CHAR(" ^ String.make 1 ch ^ ")" ))]) (addr + size_of car)
        | String expr -> cons_tbl cdr (tbl @ [(Sexpr(String expr), (addr, "MAKE_LITERAL_STRING(\"" ^ expr ^ "\")"))]) (addr + size_of car)
        | Number(Int num) -> 
          cons_tbl cdr (tbl @ [(Sexpr(Number(Int num)), (addr, "MAKE_LITERAL_INT(" ^ (string_of_int num) ^ ")"))]) (addr + size_of car)
        | Number(Float num) -> 
          cons_tbl cdr (tbl @ [(Sexpr(Number(Float num)), (addr, "MAKE_LITERAL_FLOAT(" ^ (string_of_float num) ^ ")"))]) (addr + size_of car)
        | Symbol sym -> 
          cons_tbl cdr (tbl @ [(Sexpr(Symbol sym), (addr, "MAKE_LITERAL_SYMBOL(consts+" ^ 
            string_of_int (get_const_addr (Sexpr(String sym)) tbl) ^ ")"))]) (addr + size_of car) 
        | Pair (f, s) -> 
          cons_tbl cdr (tbl @ [(Sexpr(Pair (f, s)), (addr, "MAKE_LITERAL_PAIR(consts+" ^ 
            string_of_int (get_const_addr (Sexpr f) tbl) ^ ", consts+" ^ string_of_int (get_const_addr (Sexpr s) tbl) ^ ")"))]) (addr + size_of car)
        | Vector vec -> cons_tbl cdr (tbl @ [(Sexpr(Vector vec)), (addr, "MAKE_LITERAL_VECTOR(" ^ vec_const vec tbl ^ ")")]) (addr + size_of car))
    | [] -> tbl ;;
    
  (* Cons_tbl main func *)
  let cons_tbl consts = cons_tbl consts [
    (Void, (0, "MAKE_VOID"));
    (Sexpr(Nil), (1, "MAKE_NIL"));
    (Sexpr(Bool false), (2, "MAKE_BOOL(0)"));
    (Sexpr(Bool true), (4, "MAKE_BOOL(1)"));
    ] 6;;
    

  (*  expr' list -> (constant * (int * string)) list *)
  let make_consts_tbl asts = cons_tbl(remove_dups(expand_lst(remove_dups(scan_ast asts))));;

  (* ----------------------fvar table---------------------- *)
  let rec scan_fvars asts fvars = 
    match asts with
      | car :: cdr -> (match car with
                        | Var'(VarFree expr) -> scan_fvars cdr [expr] @ fvars
                        | Applic' (op, exprs) -> scan_fvars cdr fvars @ (scan_fvars ([op] @ exprs) fvars) 
                        | _ -> scan_fvars cdr fvars)
      | _ -> fvars ;;

  let scan_fvars asts = scan_fvars asts [] ;;

  let rec cons_fvars fvars tbl addr =
    match fvars with
    | car :: cdr -> cons_fvars cdr (tbl @ [(car,addr)]) (addr + 1)
    | [] -> tbl ;;
    
  let cons_fvars fvars = cons_fvars fvars [
    ("car", 0);
    ("cdr", 1);
    ("map", 2)]
    3;;

  (* expr' list -> (string * int) list *)
  let make_fvars_tbl asts = cons_fvars(remove_dups(scan_fvars asts));;


  (* (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string *)
  let generate consts fvars e = raise X_not_yet_implemented;;
end;;

