(* tag-parser.ml
 * A compiler from Scheme to CISC
 *
 * Programmer: Mayer Goldberg, 2018
 *)

 #use "tag-parser.ml";;

 type var = 
   | VarFree of string
   | VarParam of string * int
   | VarBound of string * int * int;;
 
 type expr' =
   | Const' of constant
   | Var' of var
   | Box' of var
   | BoxGet' of var
   | BoxSet' of var * expr'
   | If' of expr' * expr' * expr'
   | Seq' of expr' list
   | Set' of expr' * expr'
   | Def' of expr' * expr'
   | Or' of expr' list
   | LambdaSimple' of string list * expr'
   | LambdaOpt' of string list * string * expr'
   | Applic' of expr' * (expr' list)
   | ApplicTP' of expr' * (expr' list);;
 
   let rec expr'_eq e1 e2 =
     match e1, e2 with
     | Const' Void, Const' Void -> true
     | Const'(Sexpr s1), Const'(Sexpr s2) -> sexpr_eq s1 s2
     | Var'(VarFree v1), Var'(VarFree v2) -> String.equal v1 v2
     | Var'(VarParam (v1,mn1)), Var'(VarParam (v2,mn2)) -> String.equal v1 v2 && mn1 = mn2
     | Var'(VarBound (v1,mj1,mn1)), Var'(VarBound (v2,mj2,mn2)) -> String.equal v1 v2 && mj1 = mj2  && mn1 = mn2
     | If'(t1, th1, el1), If'(t2, th2, el2) -> (expr'_eq t1 t2) &&
                                               (expr'_eq th1 th2) &&
                                                 (expr'_eq el1 el2)
     | (Seq'(l1), Seq'(l2)
     | Or'(l1), Or'(l2)) -> List.for_all2 expr'_eq l1 l2
     | (Set'(var1, val1), Set'(var2, val2)
     | Def'(var1, val1), Def'(var2, val2)) -> (expr'_eq var1 var2) &&
                                                (expr'_eq val1 val2)
     | LambdaSimple'(vars1, body1), LambdaSimple'(vars2, body2) ->
        (List.for_all2 String.equal vars1 vars2) &&
          (expr'_eq body1 body2)
     | LambdaOpt'(vars1, var1, body1), LambdaOpt'(vars2, var2, body2) ->
        (String.equal var1 var2) &&
          (List.for_all2 String.equal vars1 vars2) &&
            (expr'_eq body1 body2)
     | Applic'(e1, args1), Applic'(e2, args2)
     | ApplicTP'(e1, args1), ApplicTP'(e2, args2) ->
      (expr'_eq e1 e2) &&
        (List.for_all2 expr'_eq args1 args2)
     | _ -> false;;
   
                        
 exception X_syntax_error;;
 
 module type SEMANTICS = sig
   val run_semantics : expr -> expr'
   val annotate_lexical_addresses : expr -> expr'
   val annotate_tail_calls : expr' -> expr'
   val box_set : expr' -> expr'
 end;;
 
 module Semantics : SEMANTICS = struct
 
(* TODO:
   .1. Run struct tests of Mayer
   .2. Add more test => change code if necessary
*)

(* Annotate lexical addresses, expr -> expr' *)
 let annotate_lexical_addresses e = 
  (* Main helper function *)
   let rec lex_addr e env params = 
     let isParam var params = ormap (fun param -> var = param) params in
     let isBound var env = ormap (fun param -> (isParam var param)) env in 
 
     (* Helper function, returns position of var in params *)
     let rec indexOf var params pos = 
       match params with
        | car :: cdr -> if car = var then pos else indexOf var cdr (pos + 1) 
        | _ -> raise X_syntax_error in
     let indexOf var params = indexOf var params 0 in
 
     (* Helper functuin, returns depth and position of var in env *)
     let rec findVar var env depth =
       match env with
        | car :: cdr -> if isParam var car then (depth, (indexOf var car)) else findVar var cdr (depth + 1) 
        | _ -> raise X_syntax_error in
     let findVar var env = findVar var env 0 in
 
     match e with
       | Const expr -> Const' expr
       (* Case of Var, parse Var' *)
       | Var expr ->
           if isParam expr params then Var' (VarParam (expr, (indexOf expr params)))
           else if isBound expr env then 
             let (depth, pos) = findVar expr env in 
             Var' (VarBound (expr, depth, pos))
           else Var' (VarFree expr)
       (* Other cases, parse Var' recursively *)
       | If (test, dit, dif) -> If' (lex_addr test env params, lex_addr dit env params, lex_addr dif env params)
       | Set (var, value) -> Set' (lex_addr var env params, lex_addr value env params)
       | Def (name, value) -> Def' (lex_addr name env params, lex_addr value env params)
       | Seq exprs -> Seq' (List.map (fun exp -> lex_addr exp env params) exprs)
       | Or exprs -> Or' (List.map (fun exp -> lex_addr exp env params) exprs)
       | LambdaSimple (args, body) -> LambdaSimple' (args, lex_addr body ([params] @ env) args)
       | LambdaOpt (args, opt, body) -> LambdaOpt' (args, opt, lex_addr body ([params] @ env) (args @ [opt]))
       | Applic (op, exprs) -> Applic' (lex_addr op env params, List.map (fun exp -> lex_addr exp env params) exprs)
   in lex_addr e [] [];;
 

 (* Annotate tail calls, expr' -> expr' *)
 let annotate_tail_calls e = 
   (* Main helper function *)
   let rec tail_call e isTail =
     match e with
       (* Case of Applic', parse ApplicTP' *)
       | Applic' (op, exprs) -> 
          if isTail then ApplicTP' ((tail_call op false), (List.map (fun e -> tail_call e false) exprs))
          else Applic' ((tail_call op false), (List.map (fun e -> tail_call e false) exprs))
       (* Other cases, parse ApplicTP' recuresuvely *)
       | If' (test, dit, dif) -> If' (tail_call test false, tail_call dit isTail, tail_call dif isTail)
       | Set' (var, value) -> Set' (var, tail_call value false)
       | Def' (name, value) -> Def' (name, tail_call value false)
       | LambdaSimple' (args, body) -> LambdaSimple' (args, tail_call body true)
       | LambdaOpt' (args, opt, body) -> LambdaOpt' (args, opt, tail_call body true)
       | Seq' exprs -> Seq' (List.fold_right (fun expr last -> if last = [] then tail_call expr isTail :: [] 
                                                                            else tail_call expr false :: last) exprs [])
       | Or' exprs -> Or' (List.fold_right (fun expr last -> if last = [] then tail_call expr isTail :: [] 
                                                                          else tail_call expr false :: last) exprs [])
       | _ -> e
   in tail_call e false;;
 
 
 let box_set e = 
   (* Helper function for box *)
   let rec counter i = 
     match i with
       | 0 -> []
       | _ -> (counter (i - 1)) @ [(i - 1)]
   in
 
   (* Add set expr' in first Seq' of body we need to box *)
   let addSet (param, pos) body =
    (match body with
      | Seq' exprs -> 
        (match exprs with
          (* Due to Gilad comment, add case of already Set' expr' => keep in same Seq' *)
          | Set' (_, Box' _) :: _ -> Seq' ([Set' (Var' (VarParam (param, pos)), Box' (VarParam (param, pos)))] @ exprs)
          | _ -> Seq' [Set' (Var' (VarParam (param, pos)), Box' (VarParam (param, pos))); body])
      | _ -> Seq' [Set' (Var' (VarParam (param, pos)), Box' (VarParam (param, pos))); body])
   in
 
   (* Replace all set occurences of param in body *)
   let rec repGet param body = 
     match body with
       (* Base case *)
       | Var' (VarParam(v, pos)) -> if param = v then BoxGet'(VarParam(v, pos)) else body
       | Var' (VarBound(v, depth, pos)) -> if param = v then BoxGet'(VarBound(v, depth, pos)) else body
       (* Replace values *)
       | Set'(var, value) -> Set'(repGet param var, repGet param value)
       | Def'(name, value) -> Def'(name, repGet param value)
       | BoxSet' (var, value) -> BoxSet' (var, repGet param value)
       (* Replace all exprs *)
       | Or' exprs -> Or'(List.map (fun expr -> repGet param expr) exprs)
       | If'(test, dit, dif) -> If'(repGet param test, repGet param dit, repGet param dif)
       | Seq' exprs -> Seq' (List.map (fun expr -> repGet param expr) exprs)
       (* Replace exprs *)
       | Applic'(op, exprs) -> Applic'(repGet param op, (List.map (fun expr -> repGet param expr) exprs))
       | ApplicTP'(op, exprs) -> ApplicTP'(repGet param op, (List.map (fun expr -> repGet param expr) exprs))
       (* Replace bodies recursively *)
       | LambdaSimple'(params, currBody) -> if (List.mem param params) then LambdaSimple' (params, currBody) 
                                                                       else LambdaSimple' (params, repGet param currBody)
       | LambdaOpt'(params, op, currBody) -> if (List.mem param (params @ [op])) then LambdaOpt' (params, op, currBody) 
                                                                                 else LambdaOpt'(params, op, repGet param currBody)
       | _ -> body
   in
 
   (* Replace all set occurences of param in body *)
   let rec repSet param body = 
     match body with
       | Set' (Var'(VarParam(v, pos)), value) -> if param = v then BoxSet'(VarParam(v, pos), repSet param value) 
                                                              else Set' (Var' (VarParam (v, pos)), repSet param value)
       | Set' (Var'(VarBound(v, depth, pos)), value) -> if param = v then BoxSet'(VarBound(v, depth, pos), repSet param value) 
                                                                     else Set' (Var' (VarBound (v, depth, pos)), repSet param value)
       | Set' (Var' v, value) -> Set' (Var' v, repSet param value)
       | BoxSet' (var, value) -> BoxSet' (var, repSet param value)
       | If' (test, dit, dif) -> If' (repSet param test, repSet param dit, repSet param dif)
       | Def' (name, value) -> Def' (name, repSet param value)
       | Seq' exprs -> Seq' (List.map (repSet param) exprs)
       | Or' exprs -> Or' (List.map (repSet param) exprs)
       | Applic'(op, exprs) -> Applic'	(repSet param op, List.map (repSet param) exprs)
       | ApplicTP'(op, exprs) -> ApplicTP' (repSet param op, List.map (repSet param) exprs)
       | LambdaSimple' (params, body) -> if (List.mem param params) then LambdaSimple' (params, body) 
                                                                    else LambdaSimple' (params, repSet param body)
       | LambdaOpt' (params, op, body) -> if (List.mem param (params @ [op])) then LambdaOpt' (params, op, body) 
                                                                              else LambdaOpt' (params, op, repSet param body)
       | _ -> body
   in
 
   (* findReads, got param and body => list of read occurences *)
   let rec findReads param body =
     (match body with
       | Var'(VarParam(v, pos)) -> if param = v then [body] else []
       | Var'(VarBound(v, depth, pos)) -> if param = v then [body] else []
       | Seq' exprs -> List.flatten (List.map (fun expr -> findReads param expr) exprs)
       | If' (test, dit, dif) -> List.flatten ([findReads param test] @ [findReads param dit] @ [findReads param dif])
       | Def'(var, expr) -> findReads param expr
       | Applic'(op, exprs) -> findReads param op @ List.flatten (List.map (fun expr -> findReads param expr) exprs)
       | ApplicTP'(op, exprs) -> findReads param op @ List.flatten (List.map (fun expr -> findReads param expr) exprs)
       | LambdaSimple' (params, currBody) -> findReads param currBody 
       | LambdaOpt' (params, opt, currBody) -> findReads param currBody
       | _ -> [])
   in
 
   (* findWrites, got param and body => list of write occurences *)
   let rec findWrites param body = 
     match body with
       | Set'(Var'(VarParam(v, pos)), value) -> if ((findReads param value) = [] && v = param) then [body] else []
       | Set'(Var'(VarBound(v, depth, pos)), value) -> if ((findReads param value) = [] && v = param) then [body] else []
       | Seq' exprs -> List.flatten (List.map (fun expr -> findWrites param expr) exprs)
       | If' (test, dit, dif) -> List.flatten ([findWrites param test] @ [findWrites param dit] @ [findWrites param dif])
       | Def'(var, expr) -> findWrites param expr
       | Applic'(op, exprs) -> findWrites param op @ List.flatten (List.map (fun expr -> findWrites param expr) exprs)
       | ApplicTP'(op, exprs) -> findWrites param op @ List.flatten (List.map (fun expr -> findWrites param expr) exprs)
       | LambdaSimple' (params, currBody) -> if findReads param currBody <> [] then []  else findWrites param currBody
       | LambdaOpt' (params, opt, currBody) -> if findReads param currBody <> [] then []  else findWrites param currBody
       | _ -> []
   in
 
   (* shouldBox, got param and body, return true if it param should be boxed *)
   let shouldBox param body = findWrites param body <> [] && findReads param body <> [] in
 
   (* Helper for box function *)
   let boxIt (param, pos) body = addSet (param, pos) (repGet param (repSet param body)) in
 
   (* Helper for box function *)
   let boxParam (param, pos) body = if (shouldBox param body) then boxIt (param, pos) body else body in
 
   (* Box params of body, return "boxed" body *)
   let boxThem params body = List.fold_right boxParam (List.combine params (counter (List.length params))) body in
 
   (* Final Parse function, got expr', return boxed expr' *)
   let rec check_box e =
     match e with
       | LambdaSimple' (args, body) -> LambdaSimple' (args, (boxThem args body))
       | LambdaOpt' (args, opt, body) -> LambdaOpt' (args, opt, (boxThem (args @ [opt]) body))
       | If' (test, dit, dif) -> If' (check_box test, check_box dit, check_box dif)
       | Set' (var, value) -> Set' (var, check_box value)
       | Def' (name, value) -> Def' (name, check_box value)
       | Seq' exprs -> Seq' (List.map check_box exprs)
       | Or' exprs -> Or' (List.map check_box exprs)
       | Applic' (op, exprs) -> Applic' (check_box op, List.map check_box exprs)
       | ApplicTP' (op, exprs) -> ApplicTP' (check_box op, List.map check_box exprs)
       | BoxSet' (var, expr) -> BoxSet' (var, check_box expr)
       | _ -> e 
   in check_box e;;
 
(* Run semantics, expr -> expr' *)
 let run_semantics expr =
   box_set
     (annotate_tail_calls
        (annotate_lexical_addresses expr));;
   
 end;; (* struct Semantics *)