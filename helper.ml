(* 
author: Nadav Brama
*)

(* TODO:
    .1. Delete later, before submission. 
*)

#use "reader.ml";;
#use "semantic-analyser.ml";;
#use "semantic-analyser.ml";;

open Reader;;
open Tag_Parser;;
open Semantics;;

exception X_decompile_error;;
let () = Printexc.record_backtrace true;


module type COMPILER_HELPER = sig
  val string_of_sexpr : sexpr -> string
  val strings_of_sexprs : sexpr list -> string list
  val sexpr_of_expr : expr -> sexpr
  val sexprs_of_exprs : expr list -> sexpr list
  val expr'_of_string : string -> expr'
end;; (* signature COMPILER_HELPER *)


module Compiler_helper : COMPILER_HELPER = struct


let rec propPairs_to_list pairs = match pairs with
  | Nil ->[]
  | Pair(a, b) -> a :: (propPairs_to_list b)
  | _ -> raise X_decompile_error;;

let rec imPairs_to_list pairs = match pairs with
  | Nil -> raise X_decompile_error
  | Pair(a, b) -> a :: (imPairs_to_list b)
  | _ -> [pairs];;

let list_to_pairs ls = 
        List.fold_right
        (fun a b -> Pair(a , b))
        ls
        Nil;;

let rec string_of_sexpr sexpr = 
    match sexpr with
    | Nil -> "()"
    | Symbol s -> s
    | Bool a -> if a then "#t" else "#f"
    | Number(Int n) -> Printf.sprintf "%d" n
    | Number (Float f) -> Printf.sprintf "%f" f
    | Char c ->  String.escaped(Printf.sprintf "%c" c)
    | String s -> "\"" ^ (String.escaped s) ^ "\""
    | Pair(a,b) -> "(" ^ (string_of_pair sexpr) ^ ")"
    | Vector v -> "#(" ^ String.concat " " (List.map string_of_sexpr v) ^")"

and string_of_pair sexpr = 
    try
    let list = propPairs_to_list sexpr in 
    let stringList = List.map string_of_sexpr list in 
    String.concat " " stringList
    with X_decompile_error ->
    let list = imPairs_to_list sexpr in 
    let stringList = List.map string_of_sexpr list in
    let last =List.hd (List.rev stringList) in
    let withoutLast = List.rev (List.tl (List.rev stringList)) in 
    (String.concat " " withoutLast) ^ " . " ^ last;;

let strings_of_sexprs sexprs = List.map string_of_sexpr sexprs;;

let rec sexpr_of_expr expr = match expr with
    | Const (Sexpr (Number(a)))-> Number(a)
    | Const (Sexpr (Bool a) ) -> Bool a
    | Const (Sexpr (Char a)) -> Char a
    | Const (Sexpr (String  a))-> String a
    | Const (Sexpr sexpr) -> Pair(Symbol "quote" , Pair(sexpr,Nil))
    | Var v -> Symbol(v)
    | If(test,dit,Const Void) -> Pair((sexpr_of_expr test), Pair(sexpr_of_expr dit,Nil)) 
    | If(test,dit,dif) -> Pair(Symbol "if" ,Pair((sexpr_of_expr test), Pair(sexpr_of_expr dit,Pair(sexpr_of_expr dif,Nil))) )
    | Seq list -> Pair(Symbol "begin", list_to_pairs (List.map sexpr_of_expr list))
    | Const Void -> Pair(Symbol "begin", Nil)
    | Set(expr1, expr2) -> Pair(Symbol "set!",Pair(sexpr_of_expr expr1, Pair(sexpr_of_expr expr2,Nil)))
    | Def(expr1 , expr2) -> Pair(Symbol "define",Pair(sexpr_of_expr expr1, Pair(sexpr_of_expr expr2, Nil)))
    | Or list -> Pair(Symbol "or", list_to_pairs (List.map sexpr_of_expr list))
    | LambdaSimple(args, body)-> 
             let args = List.map (fun a -> Symbol a) args in 
             let args = list_to_pairs args in
             let body = sexpr_of_expr body in 
             let body  = match body with
                 | Pair(a,b) -> Pair(body, Nil)
                 | _ -> Pair(body ,Nil) in 
             Pair(Symbol "lambda", Pair (args , body))
    | LambdaOpt(arglist, argOpt, body) -> 
         let rec create_arglist list _end = match list with
            | [] -> Symbol(_end)
            | _ -> Pair( Symbol(List.hd list), (create_arglist (List.tl list) _end))   
              in    
        let arglist = create_arglist arglist argOpt in
         let body = sexpr_of_expr body in 
         let body  = match body with
             | Pair(a,b) -> body
             | _ -> Pair(body ,Nil) in 
         Pair(Symbol "lambda", Pair(arglist, body))
    | Applic(expr, exprs) -> 
    let sexprs = List.map sexpr_of_expr exprs in 
    let sexprs = list_to_pairs sexprs in 
    Pair (sexpr_of_expr expr, sexprs );;

let sexprs_of_exprs sexprs = List.map sexpr_of_expr sexprs;;

(* Helper function, string -> expr' *)
let expr'_of_string string = run_semantics (tag_parse_expression (read_sexpr string));;


end;;