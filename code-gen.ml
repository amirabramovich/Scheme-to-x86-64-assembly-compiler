#use "semantic-analyser.ml";;

module type CODE_GEN = sig
  val make_consts_tbl : expr' list -> (constant * ('a * string)) list
  val make_fvars_tbl : expr' list -> (string * 'a) list
  val generate : (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string
end;;

module Code_Gen : CODE_GEN = struct
  (*  expr' list -> (constant * ('a * string)) list *)
  let make_consts_tbl asts = 
    (* 1. Scan the AST (one recursive pass) & collect the sexprs in all
    Const records - The result is a list of sexprs *)
    let rec scan_ast asts consts = 
      match asts with
      | car::cdr -> (match car with
                    | Const' expr -> scan_ast cdr [expr]@consts
                    | _ -> scan_ast cdr consts)
      | _ -> [](*or consts*) in
    let scan_ast asts = scan_ast asts [] in
    (* 2. Convert the list to a set (removing duplicates) *)
    let rec remove_dups lst = 
      match lst with
      | [] -> []
      | car::cdr -> car::(remove_dups (List.filter (fun e -> e <> car) cdr)) in
    (* 3. Expand the list to include all sub-constants
    The list should be sorted topologically *)
    let rec expand_lst lst newLst =
      match lst with
      | car :: cdr -> raise X_not_yet_implemented
      | _ -> [] in
    (* 4. Convert the resulting list into a set (remove all duplicates, again) *)
    (* 5,  Go over the list, from first to last, and create the
    constants-table *)
    raise X_not_yet_implemented;;
  (* expr' list -> (string * 'a) list *)
  let make_fvars_tbl asts = raise X_not_yet_implemented;;
  (* (constant * ('a * string)) list -> (string * 'a) list -> expr' -> string *)
  let generate consts fvars e = raise X_not_yet_implemented;;
end;;

