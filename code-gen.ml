#use "semantic-analyser.ml";;

module type CODE_GEN = sig
  val make_consts_tbl : expr' list -> (constant * ('a * string)) list
  val make_fvars_tbl : expr' list -> (string * 'a) list
  val generate : (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string
end;;

module Code_Gen : CODE_GEN = struct


  (* 23.12 update
     Done:
        .1. Continue expand_lst    
        .2. A bit order
        .3. Add helper.ml (and add function expr'_of_string to the Compiler_helper module)

    TODO:
        .1. Continue expand_lst, and code make_consts_tbl function
        .2. Add tests to check make_consts_tbl (and other helper functions inside if needed)
  *)

  (*  expr' list -> (constant * ('a * string)) list *)
  let make_consts_tbl asts = 
    (* 1. Scan the AST (one recursive pass) & collect the sexprs in all
    Const records - The result is a list of sexprs *)
    let rec scan_ast asts consts = 
      match asts with
        | car :: cdr -> (match car with
                          | Const' expr -> scan_ast cdr [expr] @ consts
                          | _ -> scan_ast cdr consts)
        | _ -> [] (* or consts *) 
    in

    let scan_ast asts = scan_ast asts [] in

    (* 2. Convert the list to a set (removing duplicates) *)
    let rec remove_dups lst = 
      match lst with
        | [] -> []
        | car :: cdr -> car :: (remove_dups (List.filter (fun e -> e <> car) cdr)) 
    in

    (* 3. Expand the list to include all sub-constants
    The list should be sorted topologically *)
    (* Logic of code is from ps #11, 2.2.1 *)
    let rec expand_lst lst newLst =
      match lst with
        | car :: cdr -> 
            (match car with
              | Symbol (str) -> expand_lst cdr ([String str; car] @ newLst)
              | Pair(currCar, currCdr) -> expand_lst cdr ([currCar; currCdr; car] @ newLst)
              | Vector (elems) -> 
                  let vecLst = expand_lst elems [] in
                  expand_lst cdr (newLst @ vecLst)
              | _ -> expand_lst cdr ([car] @ newLst))
        | [] -> newLst
        (* | _ -> [] *) (* TODO: remove this match case if not needed, because it cause to warning *)
    in

  (* 4. Convert the resulting list into a set (remove all duplicates, again) *)
  (* 5. Go over the list, from first to last, and create the constants-table *)
  raise X_not_yet_implemented;;


  (* expr' list -> (string * 'a) list *)
  let make_fvars_tbl asts = raise X_not_yet_implemented;;


  (* (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string *)
  let generate consts fvars e = raise X_not_yet_implemented;;
end;;

