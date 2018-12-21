
(* reader.ml
 * A compiler from Scheme to x86/64
 *
 * Programmer: Mayer Goldberg, 2018
 *)

 #use "pc.ml";;

 exception X_not_yet_implemented;;
 exception X_this_should_not_happen;;
   
 type number =
   | Int of int
   | Float of float;;
   
 type sexpr =
   | Bool of bool
   | Nil
   | Number of number
   | Char of char
   | String of string
   | Symbol of string
   | Pair of sexpr * sexpr
   | Vector of sexpr list;;
 
   let rec sexpr_eq s1 s2 =
     match s1, s2 with
     | Bool(b1), Bool(b2) -> b1 = b2
     | Nil, Nil -> true
     | Number(Float f1), Number(Float f2) -> abs_float(f1 -. f2) < 0.001
     | Number(Int n1), Number(Int n2) -> n1 = n2
     | Char(c1), Char(c2) -> c1 = c2
     | String(s1), String(s2) -> s1 = s2
     | Symbol(s1), Symbol(s2) -> s1 = s2
     | Pair(car1, cdr1), Pair(car2, cdr2) -> (sexpr_eq car1 car2) && (sexpr_eq cdr1 cdr2)
     | Vector(l1), Vector(l2) -> List.for_all2 sexpr_eq l1 l2
     | _ -> false;;
   
 module Reader: sig
   val read_sexpr : string -> sexpr
   val read_sexprs : string -> sexpr list
 end
 = struct
 
 let normalize_scheme_symbol str =
   let s = string_to_list str in
   if (andmap
   (fun ch -> (ch = (lowercase_ascii ch)))
   s) then str
   else Printf.sprintf "|%s|" str;;
 
 open PC;;

(* TODO: 
    .1. Fix test 11 Peleg
    .2. Make code shorter & simpler
*)
 
(* Sexpr *)
let _sexpr = 
  let rec rec_sexpr () =
    let _sexpr = (delayed rec_sexpr) in
 
    (* Helper functions *)
    (* Number *)
    (* Sign helper function *)
    let _sign = 
      let plus = char '+' in
      let positive = pack plus (fun _ -> 1) in 
      let minus = char '-' in
      let negative = pack minus (fun _ -> -1) in 
      let signs = disj positive negative in
      let sign = maybe signs in
      let final = pack sign (function
                              | None -> 1
                              | (Some mult) -> mult) in final
      in
 
    (* Digits helper functions *)
    (* Natural 0 to 9 digits *)
    let digit_0_to_9 =
      let digit = range '0' '9' in
      let num = pack digit (fun ch -> (int_of_char ch) - (int_of_char '0')) in num
    in
    
    (* Float 0 to 9 difits *)
    let float_digit_0_to_9 =
      let digit = range '0' '9' in
      let num = pack digit (fun ch -> float_of_int (int_of_char ch) -. float_of_int (int_of_char '0')) in num
    in
    
    (* Natural a to f "digits" *)
    let digit_a_to_f = 
      let digit = range 'a' 'f' in
      let num = pack digit (fun ch -> (int_of_char ch) - (int_of_char 'a') + 10) in num
    in
    
    (* Float a to f "digits" *)
    let float_digit_a_to_f = 
      let digit = range 'a' 'f' in
      let num = pack digit (fun ch -> float_of_int (int_of_char ch) -. float_of_int (int_of_char 'a') +. 10.0) in num
    in

    (* Natural A to F "digits" *)
    let digit_A_to_F = 
      let digit = range 'A' 'F' in
      let num = pack digit (fun ch -> (int_of_char ch) - (int_of_char 'A') + 10) in num
    in 

    (* Float A to F "digits" *)
    let float_digit_A_to_F = 
      let digit = range 'A' 'F' in
      let num = pack digit (fun ch -> float_of_int (int_of_char ch) -. float_of_int(int_of_char 'A') +. 10.0) in num
    in
    
    (* Natural digits 0 to F *)
    let digit_0_to_F = disj_list [digit_0_to_9; digit_a_to_f; digit_A_to_F] in
    (* Float ditis 0 to F *)
    let float_digit_0_to_F = disj_list [float_digit_0_to_9; float_digit_a_to_f; float_digit_A_to_F] in

    (* Natural number *)
    let _natural =
      let digit = digit_0_to_9 in
      let digits = plus digit in
      let number = pack digits (fun s -> (List.fold_left (fun a b -> 10 * a + b) 0 s)) in number
    in
 
    (* Hex natural number *)
    let _hex_natural =
      let digit = digit_0_to_F in
      let digits = plus digit in
      let number = pack digits (fun s -> (List.fold_left (fun a b -> 16 * a + b) 0 s)) in number
    in
 
    (* Hex float number *)
    let hex_float =
      let digit = float_digit_0_to_F in
      let digits = plus digit in
      let number = pack digits (fun s -> (List.fold_left (fun a b -> 16.0 *. a +. b)0.0 s)) in number
    in
 
    (* Return integer *)
    let make_int sign nat =
      let signed_nat = caten sign nat in
      let final = pack signed_nat (fun (mult, n) -> mult * n) in final
    in
 
    (* Return integer from hex num *)
    let _hex = 
      let sign = _sign in
      let prefix = caten (word_ci "#x") sign in
      let sign = pack prefix (fun (_, sign) -> sign) in
      let nat = _hex_natural in
      make_int sign nat
    in
       
    (* Return integer from natural num *)
    let _integer = 
      let sign = _sign in
      let nat = _natural in
      make_int sign nat
    in
 
    (* Float number *)
    let _float = 
      let sign = _sign in
      let natural = _natural in
      let left = caten sign natural in
      let dot = char '.' in
      let ldot = caten left dot in
      let frac = 
        let digit = float_digit_0_to_9 in
        let digits = plus digit in
        let final = pack digits (fun s -> (List.fold_right (fun a b -> a +. b /. 10.0) s 0.0 ) /. 10.0) in final
      in
      let full = caten ldot frac in
      let num = pack full (fun (((sign, left), _), right) -> (float_of_int sign) *. (float_of_int left +. right)) in num
    in
 
    (* Hex float number *)
    let _hexfloat = 
      let prefix = caten (word_ci "#x") _sign in
      let left = caten prefix hex_float in
      let dot = char '.' in
      let ldot = caten left dot in
      let frac = 
        let digit = float_digit_0_to_F in
        let digits = plus digit in
        let final = pack digits (fun s -> (List.fold_right (fun a b -> a +. b /. 16.0) s 0.0) /. 16.0) in final in
      let full = caten ldot frac in
      let num = pack full (fun ((((_, sign), left), _), right) -> (float_of_int sign) *. (left +. right)) in num
    in
 
    (* Helper for scientific *)
    let rec exp = (fun (x) -> if (x = 0.0) then 1.0
                              else if (x > 0.0) then 10.0 *. (exp (x -. 1.0))
                              else (exp (x +. 1.0) /. 10.0))
    in
 
    (* Scientific number *)
    let scientific = 
      let left_int = caten _integer (word_ci "e") in
      let left_float = caten _float (word_ci "e") in
      let pack_float = (pack left_float (fun (num, _) -> num)) in
      let pack_int = (pack left_int (fun (num, _) -> (float_of_int num))) in
      let left = (disj pack_int pack_float) in
      let right = (caten (pack left (fun (num) -> num)) _integer) in
      let final = (pack right (fun (num, expo) -> num *. (exp (float_of_int expo)))) in final
    in

    (* Helper function for symbol *)
    let lowercase_string str =
      let char_list = string_to_list str in
      let s = List.map (fun ch -> (lowercase_ascii ch)) char_list in s
    in

    (* Comment *)
    let comment =
      let start = (char ';') in
      let eol = char '\n' in
      let eoi = pack nt_end_of_input (fun _ -> '\n') in
      let _end = disj eol eoi in
      let comm = diff nt_any _end in
      let full = caten start (caten (star comm) _end) in full
    in
  
    (* Comment sexpr *)
    let comment_sexpr =
      let start = word "#;" in 
      let full = caten start (caten (star nt_whitespace) _sexpr) in full
    in

    (* Skip on comments & spaces *)
    let skip =
      let f = (fun _ -> ()) in
      let space = pack nt_whitespace f in
      let comm = pack comment f in
      let comm_sexpr = pack comment_sexpr f in 
      let skips = disj_list [space; comm; comm_sexpr] in
      let skip_ = pack (star skips) f in skip_
    in

    (* Skip on "skip" strs, save sexp *)
    let make_spaced nt = 
      let space = caten (caten skip nt) skip in
      let keep = pack space (fun ((_, e), _) -> e) in keep
    in 
    
    (* Left & right parens *)
    let lparen = make_spaced (word "(") in
    let rparen = make_spaced (word ")") in
    let lparen_ = make_spaced (word "[") in
    let rparen_ = make_spaced (word "]") in

    (* Pair *)
    let lst = caten (caten lparen (star (make_spaced _sexpr))) rparen in
    let lst_ = caten (caten lparen_ (star (make_spaced _sexpr))) rparen_ in
    let pairs = disj_list [lst_; lst;] in
    let pair = pack pairs (fun ((_, e), _) -> e) in
   

    (* Sexpr parsers *)
    (* Sexpr boolean *)
    let _boolean =
      let _true = pack (word_ci "#t") (fun _ -> Bool true) in
      let _false = pack (word_ci "#f") (fun _ -> Bool false) in
      let bools = disj _true _false in bools
    in

    (* Sexper number *)
    let _number = disj_list [
                    pack scientific (fun (num) -> Number (Float num)) ;
                    pack _float (fun (num) -> Number (Float num));
                    pack _hexfloat (fun (num) -> Number (Float num));
                    pack _hex (fun (num) -> Number (Int num));
                    pack _integer (fun (num) -> Number (Int num));]
    in
 
    (* Sexpr char *)
    let _char =
      let prefix = caten (char '#') (char '\\') in
      let _visible_char = const (fun ch -> 32 < Char.code ch) in
      let _space = pack (word_ci "space") (fun _ -> Char.chr 32) in
      let _tab = pack (word_ci "tab") (fun _ -> Char.chr 9) in
      let _newline = pack (word_ci "newline") (fun _ -> Char.chr 10) in
      let _page = pack (word_ci "page") (fun _ -> Char.chr 12) in
      let _return = pack (word_ci "return") (fun _ -> Char.chr 13) in
      let _null = pack (word_ci "nul") (fun _ -> Char.chr 0) in

      let hexa = caten (word_ci "x") _hex_natural in
      let _hex_char = pack hexa (fun (_, c) -> Char.chr c) in
    
      let chars = disj_list [_null; _space; _tab; _newline; _page; _return; _hex_char; _visible_char] in
      let full = caten prefix chars in
      let final = pack full (fun (_, c) -> Char c) in final
    in
 
    (* Sexpr symbol *)
    let symbols = one_of_ci "0123456789abcdefghijklmnopqrstuvwxyz!$^*-_=+<>?/:" in
    let syms = plus symbols in
    let symbol = pack syms (fun (chlist) -> lowercase_string (list_to_string chlist)) in
    let _sym = pack symbol (fun (sym) -> Symbol (list_to_string sym)) in
    let fixed_sym = caten _number _sym in
    let fixed = diff _number fixed_sym in
    let _symbol = disj fixed _sym in

    (* Sexpr string *)
    let backslash = pack (word_ci "\\\\") (fun _ -> Char.chr 92) in
    let double_quote = pack (word_ci "\\\"") (fun _ -> Char.chr 34) in
    let tab = pack (word_ci "\\t") (fun _ -> Char.chr 9) in
    let newline = pack (word_ci "\\n") (fun _ -> Char.chr 10) in
    let page = pack (word_ci "\\f") (fun _ -> Char.chr 12) in
    let return = pack (word_ci "\\r") (fun _ -> Char.chr 13) in
    
    let pre = caten (word_ci "\\x") _hex_natural in
    let full = caten pre (word ";") in 
    let hexa = pack full (fun ((_, c), _) -> Char.chr c) in

    let meta = disj_list [backslash; double_quote; tab; newline; page; return; hexa] in

    let quote = char '\"' in
    let dif = diff nt_any (one_of "\\\"") in
    let str = disj dif meta in
    let strs = star str in
    let full = caten quote (caten strs quote) in
    let _string = pack full (fun (_, (str, _)) -> String (list_to_string str)) in
     
    (* Sexpr nil *)
    let nil = caten lparen (caten skip rparen) in
    let nil_ = caten lparen_ (caten skip rparen_) in
    let nils = disj_list [nil; nil_; ] in
    let _nil = pack nils (fun _ -> Nil) in

    (* Sexpr pairs *)
    (* Proper list *)
    let proper_list = pack pair (fun (s) -> List.fold_right (fun a b -> Pair (a, b)) s Nil) in
 
    (* Improper list *)
    let dot =  make_spaced (char '.') in
    let first = caten (plus (make_spaced _sexpr)) dot in
    let first_ = pack first (fun (e, _) -> e) in
    let both = caten first_ _sexpr in
    let lst = pack both (fun (a, b) -> List.fold_right (fun a b -> Pair (a, b)) a b) in
    let full = caten (caten lparen lst) rparen in
    let full_ = caten (caten lparen_ lst) rparen_ in
    let pairs = disj_list [full; full_;] in
    let imp_list = pack pairs (fun ((_, s), _) -> s) in

    let _pair = disj_list [proper_list; imp_list] in
 
    (* Sexpr vector *)
    let vector = 
      let prefix = disj (word "#(") (word "#[") in
      let sexprs = make_spaced _sexpr in
      let lst = caten prefix (star sexprs) in
      let vector = caten lst rparen in
      let parsed = pack vector (fun (((_), slist), _) -> slist) in parsed
    in
 
    let _vector = pack vector (fun (s) -> Vector s) in (* 11.12 Change: merge 2 paren kinds *)

    (* Sexpr quotes *)
    let quote = caten (char '\'') _sexpr in
    let _quote = pack quote (fun (_, q) -> Pair (Symbol "quote", Pair (q, Nil))) in

    let qquote = caten (char '`') _sexpr in
    let _qquote = pack qquote (fun (_, q) -> Pair (Symbol "quasiquote", Pair (q, Nil))) in

    let usquote = caten (word ",@") _sexpr in
    let _usquote = pack usquote (fun (_, q) -> Pair (Symbol "unquote-splicing", Pair (q, Nil))) in

    let unquote = caten (char ',') _sexpr in
    let _unquote = pack unquote (fun (_, q) -> Pair(Symbol "unquote", Pair(q, Nil))) in

    let _quotes = disj_list[_quote; _qquote; _usquote; _unquote] in

    (* Sexpr *)
    (disj_list[
      make_spaced _boolean;
      make_spaced _char;
      make_spaced _symbol;
      make_spaced _number;
      make_spaced _string;
      make_spaced _nil;
      make_spaced _pair;
      make_spaced _vector;
      make_spaced _quotes;
    ]) in
     rec_sexpr();;


  (* Three dots *)
  (* Helper for ThreeDots *)
  let rec add_parens num =
    if num <= 0 then [' ']
    else ')' :: (add_parens (num - 1));;
 
  (* Auto close of ThreeDots *)
  let rec remove_dots list num = 
    match list with
      | [] -> []
      (* got open paren *)
      | '(' :: cdr | '[' :: cdr -> '(' :: (remove_dots cdr (num + 1)) (* 11.12 Change: merge 2 same matches input *)
      | ')' :: cdr | ']' :: cdr -> ')' :: (remove_dots cdr (num - 1))
      (* Close with ... *)
      | car :: '.' :: '.' :: ['.'] -> [car] @ (add_parens num)
      (* Start with ... and str *)
      | '.' :: '.' :: '.' :: cdr -> (add_parens num) @ (remove_dots cdr 0)
      (* Dots in string *)
      | '\"' :: '.' :: '.' :: '.' :: '\"' :: cdr -> '\"' :: '.' :: '.' :: '.' :: '\"' :: (remove_dots cdr 0)
      (* Dots in comment *)
      | ';' :: '.' :: '.' :: '.' :: cdr -> ';' :: '.' :: '.' :: '.' :: cdr
      | car :: ';' :: '.' :: '.' :: '.' :: cdr -> ';' :: '.' :: '.' :: '.' :: add_parens num @ remove_dots (car :: cdr) num
      (* Regular case *)
      | car :: cdr -> car :: (remove_dots cdr num);;

  (* Auto close of ThreeDots *)
  let remove_dots list = remove_dots list 0;;
     
  
  (* Readers *)
  (* Read sexpr *)
  let read_sexpr string = 
    match (_sexpr (remove_dots (string_to_list string))) with
      | (e, []) -> e
      | _ -> raise X_no_match;;
  
  (* Read sexprs *)
  let read_sexprs string = 
    match (star _sexpr (remove_dots (string_to_list string))) with
      | (e, []) -> e
      | _ -> raise X_no_match;;
   
 end;; (* struct Reader *)