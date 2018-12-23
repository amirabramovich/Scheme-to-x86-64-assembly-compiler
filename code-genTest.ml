(* code-genTest.ml
* Tests for code-gen.ml
* Programmer: Nitsan Soffair and Amir Abramovich, 2018
*)
    
#use "code-gen.ml";;

open Code_Gen;;
open Semantics;;
open Tag_Parser;;
open Reader;;
open PC;;

exception TestException of string;;

    (* Colors for print *)
let red = "\027[38;5;196m";;
let grn = "\027[38;5;082m";;
let yel = "\027[38;5;226m";;
let mag = "\027[38;5;201m";;
let purple = "\027[0;35m";;
let cyan = "\027[0;36m";;
let reset = "\027[0m";;

(* Print # number of test that failed *)
let printFail failed = List.map (fun (n, b) -> Printf.printf "test %s %d %s failed\n" red n reset) failed;;

(* Got list of test that failed *)
let getFailed tests = List.filter (fun (n, e) -> e = false) tests;;

(* Print summary *)
let printSum color typ nfailed nsuccess = 
    (Printf.printf "\n%s%s tests: %s \nfailed- %s%d%s\npassed- %s%d%s\n\n" color typ reset red nfailed reset grn nsuccess reset);;

(* Helper function for test, print sum *)
let testSum color typ list = 
    let sum = List.length list in
    let failed = (getFailed list) in
    let nfailed = List.length failed in
    let nsuccess = sum - nfailed in
    (printSum color typ nfailed nsuccess);;

(* Helper function for test, print test that failed *)
let testFailed list = 
    let failed = (getFailed list) in
    (printFail failed);;

let allPassed color list = 
  let failed = (getFailed list) in
  if failed = [] then (Printf.printf "%sALL TESTS PASSED\n%s" color reset);;

(* Print message *)
let print color txt = (Printf.printf "%s*************************** %s *******************************%s\n" color txt reset);;

(* tests for each func *)
let multi_annotate_lexical_addresses exprs = List.map annotate_lexical_addresses exprs;;

let scan_test x = scan_ast (multi_annotate_lexical_addresses (tag_parse_expressions (read_sexprs x)));;

let dups_test x = remove_dups (scan_test x) ;;

let expand_test x = expand_lst (dups_test x) ;;

let dups2_test x = remove_dups (expand_test x) ;;

let tbl_test x = cons_tbl (dups2_test x) ;;

(* Compare sexprs *)
let sexprs_eq slist1 slist2 = 
  let comb = List.combine slist1 slist2 in
  let res = List.map (fun (s1, s2) -> sexpr_eq s1 s2) comb in
  not (List.exists (fun e -> e = false) res);;

(* Compare 2 const, each type is (string, (int, string) ) *)
let const_eq (sl1, (n1, sr1)) (sl2, (n2, sr2)) = 
  sl1 = sl2 && n1 = n2 && sr1 = sr2;;

(* Compare list of const, i.e, table *)
let table_eq tblist1 tblist2 = 
  let comb = List.combine tblist1 tblist2 in
  let res = List.map (fun (s1, s2) -> const_eq s1 s2) comb in
  not (List.exists (fun e -> e = false) res);;

print grn "code-gen tests";;


(* Scan test *)
let s1 = sexprs_eq (scan_test "1") ([Number (Int 1)]);;
let s2 = sexprs_eq (scan_test "1 1") ([Number (Int 1); Number (Int 1)]);;
let s3 = sexprs_eq (scan_test "'(1)") ( [Pair (Number (Int 1), Nil)]);;
let s4 = sexprs_eq (scan_test "'(1 2 3 4)") ([Pair (Number (Int 1), Pair (Number (Int 2), Pair (Number (Int 3), Pair (Number (Int 4), Nil))))]);;
let s5 = sexprs_eq (scan_test "(foo 2)") ([Number (Int 2)]);;
let s6 = sexprs_eq (scan_test "(+ 1 2)") ([Number (Int 2); Number (Int 1)]);;
let s7 = sexprs_eq (scan_test "'a") ([Symbol "a"]);;
let s8 = sexprs_eq (scan_test "'(1 (2 3))") ([Pair (Number (Int 1), Pair (Pair (Number (Int 2), Pair (Number (Int 3), Nil)), Nil))]);;
let s9 = sexprs_eq (scan_test "'(1 .(2 3))") (  [Pair (Number (Int 1), Pair (Number (Int 2), Pair (Number (Int 3), Nil)))]);;
let s10 = sexprs_eq (scan_test "#( #t )") ([Vector [Bool true]]);;
let s11 = sexprs_eq (scan_test "#( 37392 )") ( [Vector [Number (Int 37392)]]);;
let s12 = sexprs_eq (scan_test "#( 37392.39382 )") ( [Vector [Number (Float 37392.39382)]]);;
let s13 = sexprs_eq (scan_test "#( #\\c 37392.39382 )") ([Vector [Char 'c'; Number (Float 37392.39382)]]);;

let scan_ast_test = [(1, s1); (2, s2); (3, s3); (4, s4); (5, s5); (6, s6); (7, s7); (8, s8); (9, s9); (10, s10); 
                     (11, s11); (12, s12); (13, s13);];;
(testSum mag "Scan ast" scan_ast_test);;
(testFailed scan_ast_test);;


(* Dup test *)
let d1 = sexprs_eq (dups_test "1") ([Number (Int 1)]);;
let d2 = sexprs_eq (dups_test "1 1") ([Number (Int 1)]);; 
let d3 = sexprs_eq (dups_test "'(1 (2 3))") (  [Pair (Number (Int 1), Pair (Pair (Number (Int 2), Pair (Number (Int 3), Nil)), Nil))]);; 
let d4 = sexprs_eq (dups_test "#( #\\c 37392.39382 )") ([Vector [Char 'c'; Number (Float 37392.39382)]]);; 

let duplic_test = [(1, d1); (2, d2); (3, d3); (4, d4)];;
(testSum cyan "Remove dups" duplic_test);;
(testFailed duplic_test);;


(* Expand test *)
let e1 = sexprs_eq (expand_test "1") ([Number (Int 1)]);;
let e2 = sexprs_eq (expand_test "1 1") ([Number (Int 1)]);; 
let e3 = sexprs_eq (expand_test "'a") ([String "a"; Symbol "a"]);;
let e4 = sexprs_eq (expand_test "'(1)") ( [Number (Int 1); Nil; Pair (Number (Int 1), Nil)]);;
let e5 = sexprs_eq (expand_test "#( #\\c 37392.39382 )") ([Number (Float 37392.39382); Char 'c'; Vector [Char 'c'; Number (Float 37392.39382)]]);; 
let e6 = sexprs_eq (expand_test "'(1 (2 3))") ([Number (Int 1);
                                                    Pair (Pair (Number (Int 2), Pair (Number (Int 3), Nil)), Nil);
                                                    Pair (Number (Int 1),
                                                    Pair (Pair (Number (Int 2), Pair (Number (Int 3), Nil)), Nil))]);; (* TODO: need to fix *)

let expand_test = [(1, e1); (2, e2); (3, e3); (4, e4); (5, e5); (6, e6);];;
(testSum purple "Expand" expand_test);;
(testFailed expand_test);;


(* Dup 2 test *)
let d_1 = sexprs_eq (dups2_test "1") ([Number (Int 1)]);;
let d_2 = sexprs_eq (dups2_test "1 1") ([Number (Int 1)]);; 
let d_3 = sexprs_eq (dups2_test "'a") ( [String "a"; Symbol "a"]);;
let d_4 = sexprs_eq (dups2_test "'(1)") ( [Number (Int 1); Nil; Pair (Number (Int 1), Nil)]);;
let d_5 = sexprs_eq (dups2_test "#( #\\c 37392.39382 )") ([Number (Float 37392.39382); Char 'c'; Vector [Char 'c'; Number (Float 37392.39382)]]);; 
let d_6 = sexprs_eq (dups2_test "'(1 (2 3))") ([Number (Int 1); Pair (Number (Int 2), Pair (Number (Int 3), Nil)); Nil;
                                                    Pair (Number (Int 1), Pair (Pair (Number (Int 2), Pair (Number (Int 3), Nil)), Nil))]);;
let d_7 = sexprs_eq (dups2_test "\"This is a string\"") ( [String "This is a string"]);;

let dup2_test = [(1, d_1); (2, d_2); (3, d_3); (4, d_4); (5, d_5); (6, d_6); (7, d_7);];; 
(testSum mag "Remove dups 2" dup2_test);;
(testFailed dup2_test);;


(* Table test *)
let t1 = table_eq (tbl_test "\"This is first string\" \"This is second string\" ") 
                  ([("Void", (0, "MAKE_VOID")); ("Nil", (1, "MAKE_NIL"));
                  ("Bool false", (2, "MAKE_BOOL(0)")); ("Bool true", (4, "MAKE_BOOL(1)"));
                  ("This is first string", (6, "test"));
                  ("This is second string", (35, "test"))]);;

let table_test = [(1, t1)];;
(testSum cyan "Table" table_test);;
(testFailed table_test);;
 

