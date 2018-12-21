  (* tag-parser.ml
  * A compiler from Scheme to CISC
  *
  * Programmer: Mayer Goldberg, 2018
  *)

  #use "reader.ml";;

  type constant =
    | Sexpr of sexpr
    | Void

  type expr =
    | Const of constant
    | Var of string
    | If of expr * expr * expr
    | Seq of expr list
    | Set of expr * expr
    | Def of expr * expr
    | Or of expr list
    | LambdaSimple of string list * expr
    | LambdaOpt of string list * string * expr
    | Applic of expr * (expr list);;

  let rec expr_eq e1 e2 =
    match e1, e2 with
    | Const Void, Const Void -> true
    | Const(Sexpr s1), Const(Sexpr s2) -> sexpr_eq s1 s2
    | Var(v1), Var(v2) -> String.equal v1 v2
    | If(t1, th1, el1), If(t2, th2, el2) -> (expr_eq t1 t2) && (expr_eq th1 th2) && (expr_eq el1 el2)
    | (Seq(l1), Seq(l2) | Or(l1), Or(l2)) -> List.for_all2 expr_eq l1 l2
    | (Set(var1, val1), Set(var2, val2) | Def(var1, val1), Def(var2, val2)) -> (expr_eq var1 var2) && (expr_eq val1 val2)
    | LambdaSimple(vars1, body1), LambdaSimple(vars2, body2) -> (List.for_all2 String.equal vars1 vars2) && (expr_eq body1 body2)
    | LambdaOpt(vars1, var1, body1), LambdaOpt(vars2, var2, body2) -> (String.equal var1 var2) &&
                                                                      (List.for_all2 String.equal vars1 vars2) && (expr_eq body1 body2)
    | Applic(e1, args1), Applic(e2, args2) -> (expr_eq e1 e2) && (List.for_all2 expr_eq args1 args2)
    | _ -> false;;
    
                        
  exception X_syntax_error;;

  module type TAG_PARSER = sig
    val tag_parse_expression : sexpr -> expr
    val tag_parse_expressions : sexpr list -> expr list
  end;; (* signature TAG_PARSER *)

  module Tag_Parser : TAG_PARSER = struct

  let reserved_word_list =
    ["and"; "begin"; "cond"; "define"; "else"; "if"; "lambda"; "let"; "let*";
    "letrec"; "or"; "quasiquote"; "quote"; "set!"; "unquote"; "unquote-splicing"];;  

  (* work on the tag parser starts here *)
  open PC;;

  (* Returns true if var is reserved *)
  let isReserved var =
    ormap (fun word -> var = word) reserved_word_list;;

  (* Returns true if list is improper *)
  let rec isImproper = function
    | Nil -> false
    | Pair (car, Nil) -> false
    | Pair (car, ((Pair(_, _)) as cdr)) -> isImproper cdr
    | Pair (car, cdr) -> true
    | _ -> raise X_syntax_error;;

  (* Recieves pairs and flattens them to list *)
  let rec flatPair = function
    | Nil -> []
    | Pair(a, Nil) -> [a]
    | Pair(a, Pair(b, c)) -> a :: (flatPair(Pair(b, c)))
    | Pair(a, b) -> [a; b]
    | _ -> raise X_syntax_error;;

  (* Recieves list and combine elements to pairs *)
  let rec revFlat = function
    | [] -> Nil
    | a :: b -> Pair (a, revFlat b);;

  (* Helper function which splits the args in let expr *)
  let splitArgs pair =
    let rec split pair (ls, rs) =
      match pair with
      | Nil -> revFlat (List.rev (flatPair ls)), revFlat (List.rev (flatPair rs))
      | Pair (Pair (left, Pair (right, Nil)), cdr) -> split cdr (Pair (left, ls), Pair (right, rs))
      | _ -> raise X_syntax_error in split pair (Nil, Nil);;
  

  (* Main function, Sexpr -> Expr *)
  let tag_parse_expression sexpr = 
    let rec _parse sexpr =

      (* Validate & Check functions *)
      (* Validate last elem is Nil *)
      let rec checkLast recPair origPair = 
        (match recPair with
          | Pair (_, Nil) -> origPair
          | Pair (_, pair) -> checkLast pair origPair
          | Nil -> origPair
          | _ -> raise X_syntax_error)
      in

      (* Check name, for Define *)
      let checkName name = 
        (match name with
          | Bool _ | Number _ | Char _ | String _ -> raise X_syntax_error
          | _ -> name)
      in

      (* Validate that body is not Nil *)
      let checkBody body = 
        (match body with
          | Nil -> raise X_syntax_error 
          | _ -> body)
      in

      (* Validate that set name is not Lambda and not Const *)
      let checkSet exprName = 
        (match exprName with
          | Const (_) | LambdaSimple (_) | LambdaOpt (_) -> raise X_syntax_error
          | _ -> exprName)
      in

      (* Check list is Unique, List -> true if Unique *)
      let checkUniq _list =
        let _map = (List.map (fun (x) -> List.map (fun (y) -> x = y) _list) _list) in
        let map_ = (List.map (fun (x) -> (List.filter (fun (y) -> y = true) x)) _map) in
        let _map_ = (List.filter (fun (x) -> (List.length x) > 1) map_) in
        (List.length _map_ < 1)
      in


      (* Helper functions for Parse *)
      (* Helper for parse Applic *)
      let applicSexps pair =
        let pair = checkLast pair pair in 
        let flatten = flatPair pair in
        let exprList = List.map _parse flatten in exprList
      in

      (* Helper for parse Lambda, Symbol -> String *)
      let symToStr (sym) = 
        match sym with
          | Symbol s -> s
          | _ -> raise X_syntax_error
      in

      (* Helper for parse Lambda, Convert args to strings *)
      let prepArgs arglist = 
        let flatten = flatPair arglist in
        let _uniq = checkUniq flatten in
        (match _uniq with
          | false -> raise X_syntax_error
          | true -> List.map symToStr flatten)
      in

      (* Helper for Let Rec *)
      let rec whatever = function
        | [] -> Nil
        | a :: b -> Pair (Pair(a, Pair (Pair (Symbol "quote", Pair (Symbol "whatever", Nil)), Nil)), whatever b)
      in
    
      (* Helper for Let Rec *)      
      let add_whatevers params =
        whatever (flatPair params) 
      in

      (* Helper for Let Rec *)
      let rec set_params = function
        | [] -> []
        | Pair (param, sexpr) :: b -> Pair (Symbol "set!", Pair (param, sexpr)) :: set_params b
        | _ -> raise X_syntax_error 
      in

      
      (* Macro expansions *)
      (* Expansion of Quasiquote expressions *)
      let rec expandQQ qq =
        match qq with
          (* case 1 *)
          | Pair(Symbol("unquote"), Pair(qq, Nil)) -> qq 
          (* case 2 *)
          | Pair(Symbol("unquote-splicing"), Pair(qq, Nil)) -> raise X_syntax_error
          (* case 3 *)
          | Nil | Symbol _ -> Pair(Symbol("quote"), Pair(qq, Nil))
          (* case 4 *)
          | Vector(sexprs) ->
            let sexprs = List.map expandQQ sexprs in
            let sexprs = revFlat sexprs in
            Pair(Symbol("vector"), sexprs)
          (* case 5 *)
          | Pair(a, b) ->
            (match (a, b) with
              (* case 5.1 *)
              | (Pair(Symbol("unquote-splicing"), Pair(a, Nil)), b) -> Pair(Symbol("append"), Pair(a, Pair(expandQQ b, Nil)))
              (* case 5.2 *)
              | (a, Pair(Symbol("unquote-splicing"), Pair(b, Nil))) -> Pair((Symbol("cons")), (Pair(expandQQ a, (Pair(b, Nil)))))
              (* case 5.3 *)
              | (a, b) -> Pair((Symbol("cons")), (Pair(expandQQ a, (Pair(expandQQ b, Nil))))))
          (* else - nothing special *)
          | e -> e
      in
      
      (* Expansion of And expressions *)
      let parseAnd sexprs = 
        (match sexprs with
          | Nil -> Const (Sexpr (Bool true))
          | Pair (sexpr, Nil) -> _parse sexpr
          | Pair (sexpr, rest) -> If ((_parse sexpr) ,_parse (Pair ((Symbol "and"), rest)), Const (Sexpr (Bool false)))
          | _ -> raise X_syntax_error)
      in


      (* Parse functions *)
      (* Parse Or expression *)
      let parseOr sexprs =
        (match sexprs with
          | Nil -> Const (Sexpr (Bool false))
          | Vector vec -> 
            let exprs = List.map _parse vec in
            Or (exprs)
          | Pair (sexpr, Nil) -> _parse sexpr
          | Pair (_sexpr, _sexprs) ->
            let pair = (Pair(_sexpr, _sexprs)) in
            let checkTail = checkLast pair pair in 
            let tail = flatPair checkTail in
            let exprs = List.map _parse tail in
            Or (exprs)
          | _ -> raise X_syntax_error) 
      in

      (* Parse simple Define expression *)
      let _parseDefine name sexpr = 
        let _name = checkName name in
        Def (_parse _name, _parse sexpr) (* define var *)
      in

      (* Parse Define expresison *)
      let parseDefine name args sexpr =
        let _name = checkName name in
        let _sexpr = checkLast sexpr sexpr in 
        _parse (Pair (Symbol "define", Pair (name, Pair (Pair (Symbol "lambda", Pair (args, _sexpr)), Nil))))
      in

      (* Parse Begin expression *)
      let parseBegin sexprs =
        let sexprs = List.map _parse (flatPair sexprs) in
          (match sexprs with
            | [] -> Const Void
            | [sexpr] -> sexpr
            | _ -> Seq sexprs)
      in

      (* Parse Cond expression *)
      let parseCond sexpr =
        (match sexpr with
          (* 0. empty cond *)
          | Nil -> Const Void
          | other ->
            let rec cond_rec = function
              (* 0.1. else cond with single expr *)
              | Pair (Pair (Symbol "else", Pair (dif, Nil)), Nil) -> dif 
              (* 0.2. else cond with multiple expr *)
              | Pair (Pair (Symbol "else", rest), Nil) -> Pair (Symbol "begin", rest) 
              (* 0.3. '=>' single cond without args *)
              | Pair (Pair (func, Pair(Symbol "=>", Pair(body, Nil))), Nil) -> 
                (Pair (Symbol "let", Pair (Pair (Pair (Symbol "value", Pair (func, Nil)), Pair (Pair (Symbol "f",
                Pair (Pair (Symbol "lambda", Pair (Nil, Pair (body, Nil))), Nil)), Nil)), Pair (Pair (Symbol "if", Pair (Symbol "value",
                Pair (Pair (Pair (Symbol "f", Nil), Pair (Symbol "value", Nil)), Nil))), Nil))))
              (* 0.4. '=>' single cond with args *)
              | Pair (Pair (Pair (func, args), Pair (Symbol "=>", body)), Nil) -> 
                (Pair (Symbol "let", Pair (Pair (Pair (Symbol "value", Pair (Pair (func, args), Nil)), Pair (Pair (Symbol "f",
                Pair (Pair (Symbol "lambda", Pair (Nil, body)), Nil)), Nil)), Pair (Pair (Symbol "if", Pair (Symbol "value",
                Pair (Pair (Pair (Symbol "f", Nil), Pair (Symbol "value", Nil)), Nil))), Nil))))
              (* 0.5. '=>' cond without args with multiple conds *)
              | Pair (Pair (func, Pair(Symbol "=>", Pair(body, Nil))), rest) ->
                (Pair (Symbol "let", Pair (Pair (Pair (Symbol "value", Pair (func, Nil)), Pair (Pair (Symbol "f",
                Pair (Pair (Symbol "lambda", Pair (Nil, Pair (body, Nil))), Nil)), Pair (Pair (Symbol "rest", Pair (Pair(Symbol "lambda", Pair(Nil, Pair(cond_rec rest, Nil))), Nil)), Nil))),
                Pair(Pair(Symbol "if",Pair(Symbol "value",Pair(Pair(Pair(Symbol "f",Nil),Pair(Symbol "value",Nil)),Pair(Pair(Symbol "rest",Nil),Nil)))),Nil))))
              (* 0.6. '=>' cond with args with multiple conds *)
              | Pair (Pair (Pair (func, args),Pair (Symbol "=>", body)), rest) ->
                (Pair (Symbol "let", Pair (Pair (Pair (Symbol "value", Pair (Pair (func, args), Nil)), Pair (Pair (Symbol "f",
                  Pair (Pair (Symbol "lambda", Pair (Nil, body)), Nil)), Pair (Pair (Symbol "rest", Pair (Pair(Symbol "lambda", 
                    Pair(Nil, Pair(cond_rec rest, Nil))), Nil)), Nil))), Pair(Pair(Symbol "if", Pair(Symbol "value", Pair(Pair(Pair(Symbol "f", Nil), 
                      Pair(Symbol "value", Nil)), Pair(Pair(Symbol "rest", Nil), Nil)))), Nil))))
              (* 1. single rib with single expr: *)
                (* 1.1 without else *)
              | Pair (Pair (first, Nil), Nil) -> Pair (Symbol "if", Pair (first, Pair (first, Nil)))
                (* 1.2 with else with single expr *)
              | Pair (Pair (first, Nil), Pair (Pair (Symbol "else", Pair (dif, Nil)), Nil)) ->
                  Pair (Symbol "if", Pair (first, Pair (first, Pair (dif, Nil))))
                (* 1.3 with else with multiple exprs *)
              | Pair (Pair (first, Nil), Pair (Pair (Symbol "else", rest), Nil)) ->
                  Pair (Symbol "if", Pair (first, Pair (first, Pair (Pair (Symbol "begin", rest), Nil))))
              (* 2. single rib with multiple exprs: *)
                (* 2.1 without else *)
              | Pair (Pair (first, body), Nil) -> Pair (Symbol "if", Pair (first, Pair (Pair (Symbol "begin", body), Nil)))
                (* 2.2 with else with single expr *)
              | Pair (Pair (first, body), Pair (Pair (Symbol "else", Pair(dif, Nil)), Nil)) -> 
                  Pair (Symbol "if", Pair (first, Pair (Pair (Symbol "begin", body), Pair (dif, Nil))))
                (* 2.3 with else with multiple exprs *)                                
              | Pair (Pair (first, body), Pair (Pair (Symbol "else", rest), Nil)) ->
                  Pair (Symbol "if", Pair (first, Pair (Pair (Symbol "begin", body), Pair (Pair (Symbol "begin", rest), Nil))))
              (* 3. multiple ribs while first with single expr *)
              | Pair (Pair (first, Nil), rest) -> Pair (Symbol "if", Pair (first, Pair (first, Pair (cond_rec rest, Nil))))
              (* 4. multiple ribs while first with multiple exprs *)
              | Pair (Pair (first, body), rest) -> Pair (Symbol "if", Pair (first, Pair (Pair (Symbol "begin", body), Pair (cond_rec rest, Nil))))
              | _ -> raise X_syntax_error in _parse (cond_rec other)) 
      in

      (* Parse Lambda expresison, body is expr *)
      let lambdaHelper args body = 
        (match args with
          | Nil -> LambdaSimple ([], body)
          | Symbol s -> LambdaOpt ([], s, body)
          | Pair (_, _) ->
            let improper = isImproper args in
            let args = prepArgs args in
              (match (improper, List.rev args) with
                | (true, larg :: args) -> LambdaOpt (List.rev args, larg, body)
                | _ -> LambdaSimple (args, body))
          | _ -> raise X_syntax_error)
      in

      (* Parse Lambda expresison *)
      let parseLambda args body = 
        let body = checkBody body in 
        let body = List.map _parse (flatPair body) in
        let body = match body with
                    | a :: [] -> a
                    | a :: b -> Seq body
                    | _ -> Const Void in
        lambdaHelper args body 
      in

      (* Parse Let expresison *)
      let parseLet args body =
        let (par, arg) = splitArgs args in
        _parse (Pair (Pair (Symbol "lambda", Pair (par, body)), arg))
      in

      (* Parse Let Star expresison *)
      let parseLetS args body =
        (match args with
          | Nil | Pair(_, Nil) -> parseLet args body
          | Pair(arg, rest) -> 
            _parse (Pair (Symbol "let", Pair(Pair (arg, Nil), Pair(Pair (Symbol "let*", Pair(rest, body)), Nil))))
          | _ -> raise X_syntax_error)
      in 

      (* Parse Set expression *)
      let parseSet set_name set_val = 
        let name = checkName set_name in
        let exprName = _parse name in
        if (checkSet exprName) = exprName then
          let exprVal = _parse set_val in
          Set (exprName, (exprVal))
        else raise X_syntax_error
      in

      (* Parse Let Rec expresison *)
      let parseLetR args body = 
        let (params, arg) = splitArgs args in 
        let first = add_whatevers params in
        let second = revFlat (set_params (flatPair args)) in
        let combined = (flatPair second) @ (flatPair body) in
        let comb = revFlat combined in
        let finish = Pair (Symbol "let", Pair (first, comb)) in
        _parse finish
      in

      (* Parse all Sexprs *)
      match sexpr with
        | Bool _ | Number _ | Char _ | String _ | Vector _ -> Const (Sexpr sexpr)
        | Symbol s -> if isReserved s then raise X_syntax_error else Var s
        | Pair (Symbol "if", Pair(test, Pair(dit, Nil))) -> If (_parse test, _parse dit, Const Void) (* without else *)
        | Pair (Symbol "if", Pair(test, Pair(dit, Pair (dif, Nil)))) -> If (_parse test, _parse dit, _parse dif) (* with else *)
        | Pair (Symbol "quote", (Pair(sexpr, Nil))) -> Const (Sexpr sexpr)
        | Pair (Symbol "quasiquote", Pair(sexpr, Nil)) -> _parse (expandQQ sexpr)
        | Pair (Symbol "unquote", Pair(sexpr, Nil)) -> _parse (expandQQ sexpr)
        | Pair (Symbol "set!", Pair(set_name, Pair(set_val, Nil))) -> parseSet set_name set_val
        | Pair (Symbol "define", Pair(Pair(name, args), expr)) -> parseDefine name args expr
        | Pair (Symbol "define", Pair(name, Pair(sexpr, Nil))) -> _parseDefine name sexpr
        | Pair (Symbol "lambda", Pair(args, body)) -> parseLambda args body
        | Pair (Symbol "and", sexpr) -> parseAnd sexpr
        | Pair (Symbol "cond", sexpr) -> parseCond sexpr
        | Pair (Symbol "or", sexpr) -> parseOr sexpr
        | Pair (Symbol "begin", sexpr) -> parseBegin sexpr
        | Pair (Symbol "let", Pair(args, body)) -> parseLet args body
        | Pair (Symbol "let*", Pair(args, body)) -> parseLetS args body
        | Pair (Symbol "letrec", Pair(args, body)) -> parseLetR args body
        | Pair (symVar, Pair(const, Nil)) -> Applic (_parse symVar, [_parse const])
        | Pair (symVar, pair) -> Applic (_parse symVar, applicSexps pair)
        | _ -> raise X_syntax_error
    in _parse sexpr;;
 
  (* Parse expressions *)
  let tag_parse_expressions sexpr = List.map tag_parse_expression sexpr;;
 
   
 end;; (* struct Tag_Parser *)