
;;; All the macros and the scheme-object printing procedure
;;; are defined in compiler.s
%include "compiler.s"

section .bss
malloc_pointer:
    resq 1

section .data
const_tbl:
MAKE_VOID ; my address is 0
MAKE_NIL ; my address is 1
MAKE_BOOL(0) ; my address is 2
MAKE_BOOL(1) ; my address is 4
MAKE_LITERAL_STRING "boolean?" ; my address is 6
MAKE_LITERAL_STRING "b" ; my address is 23
MAKE_LITERAL_SYMBOL(const_tbl + 23) ; my address is 33
MAKE_LITERAL_STRING "a" ; my address is 42
MAKE_LITERAL_SYMBOL(const_tbl + 42) ; my address is 52
MAKE_LITERAL_STRING "c" ; my address is 61
MAKE_LITERAL_SYMBOL(const_tbl + 61) ; my address is 71
MAKE_LITERAL_PAIR(const_tbl + 71, const_tbl + 1) ; my address is 80
MAKE_LITERAL_PAIR(const_tbl + 33, const_tbl + 80) ; my address is 97
MAKE_LITERAL_PAIR(const_tbl + 52, const_tbl + 97) ; my address is 114
MAKE_LITERAL_STRING "cons" ; my address is 131
MAKE_LITERAL_STRING "car" ; my address is 144
MAKE_LITERAL_STRING "integer?" ; my address is 156
MAKE_LITERAL_STRING "char?" ; my address is 173
MAKE_LITERAL_CHAR('a') ; my address is 187
MAKE_LITERAL_STRING "null?" ; my address is 189
MAKE_LITERAL_STRING "symbol?" ; my address is 203
MAKE_LITERAL_STRING "lambda" ; my address is 219
MAKE_LITERAL_SYMBOL(const_tbl + 219) ; my address is 234
MAKE_LITERAL_STRING "vector?" ; my address is 243
MAKE_LITERAL_STRING "string?" ; my address is 259
MAKE_LITERAL_INT(1234) ; my address is 275
MAKE_LITERAL_PAIR(const_tbl + 52, const_tbl + 33) ; my address is 284
MAKE_LITERAL_STRING "pair?" ; my address is 301
MAKE_LITERAL_STRING "zero?" ; my address is 315
MAKE_LITERAL_STRING "not" ; my address is 329
MAKE_LITERAL_STRING "string-ref" ; my address is 341
MAKE_LITERAL_STRING "abc" ; my address is 360
MAKE_LITERAL_INT(97) ; my address is 372
MAKE_LITERAL_STRING "string-length" ; my address is 381
MAKE_LITERAL_STRING "make-vector" ; my address is 403
MAKE_LITERAL_STRING "vector-length" ; my address is 423
MAKE_LITERAL_STRING "n" ; my address is 445
MAKE_LITERAL_INT(10000) ; my address is 455
MAKE_LITERAL_STRING "vector-ref" ; my address is 464
MAKE_LITERAL_STRING "v" ; my address is 483
MAKE_LITERAL_STRING "char->integer" ; my address is 493
MAKE_LITERAL_CHAR('A') ; my address is 515
MAKE_LITERAL_INT(65) ; my address is 517
MAKE_LITERAL_INT(0) ; my address is 526
MAKE_LITERAL_CHAR('h') ; my address is 535
MAKE_LITERAL_STRING "string-set!" ; my address is 537
MAKE_LITERAL_CHAR(' ') ; my address is 557
MAKE_LITERAL_STRING "eq?" ; my address is 559
MAKE_LITERAL_STRING "ab" ; my address is 571
MAKE_LITERAL_SYMBOL(const_tbl + 571) ; my address is 582
MAKE_LITERAL_STRING "string" ; my address is 591
MAKE_LITERAL_STRING "make-string" ; my address is 606
MAKE_LITERAL_INT(7) ; my address is 626
MAKE_LITERAL_STRING "*" ; my address is 635
MAKE_LITERAL_STRING "+" ; my address is 645
MAKE_LITERAL_INT(234) ; my address is 655
MAKE_LITERAL_STRING "=" ; my address is 664
MAKE_LITERAL_STRING "-" ; my address is 674
MAKE_LITERAL_INT(6) ; my address is 684
MAKE_LITERAL_STRING "<" ; my address is 693
MAKE_LITERAL_STRING ">" ; my address is 703
MAKE_LITERAL_INT(5) ; my address is 713
MAKE_LITERAL_INT(4) ; my address is 722
MAKE_LITERAL_INT(3) ; my address is 731
MAKE_LITERAL_INT(2) ; my address is 740
MAKE_LITERAL_INT(1) ; my address is 749
MAKE_LITERAL_VECTOR const_tbl + 52, const_tbl + 33, const_tbl + 71 ; my address is 758
MAKE_LITERAL_VECTOR const_tbl + 52, const_tbl + 4, const_tbl + 1 ; my address is 791
MAKE_LITERAL_VECTOR const_tbl + 749, const_tbl + 740, const_tbl + 731 ; my address is 824

;;; These macro definitions are required for the primitive
;;; definitions in the epilogue to work properly
%define SOB_VOID_ADDRESS const_tbl + 0
%define SOB_NIL_ADDRESS const_tbl + 1
%define SOB_FALSE_ADDRESS const_tbl + 2
%define SOB_TRUE_ADDRESS const_tbl + 4

fvar_tbl:
dq T_UNDEFINED ; i'm boolean?, my address is 0
dq T_UNDEFINED ; i'm float?, my address is 1
dq T_UNDEFINED ; i'm integer?, my address is 2
dq T_UNDEFINED ; i'm pair?, my address is 3
dq T_UNDEFINED ; i'm null?, my address is 4
dq T_UNDEFINED ; i'm char?, my address is 5
dq T_UNDEFINED ; i'm vector?, my address is 6
dq T_UNDEFINED ; i'm string?, my address is 7
dq T_UNDEFINED ; i'm procedure?, my address is 8
dq T_UNDEFINED ; i'm symbol?, my address is 9
dq T_UNDEFINED ; i'm string-length, my address is 10
dq T_UNDEFINED ; i'm string-ref, my address is 11
dq T_UNDEFINED ; i'm string-set!, my address is 12
dq T_UNDEFINED ; i'm make-string, my address is 13
dq T_UNDEFINED ; i'm vector-length, my address is 14
dq T_UNDEFINED ; i'm vector-ref, my address is 15
dq T_UNDEFINED ; i'm vector-set!, my address is 16
dq T_UNDEFINED ; i'm make-vector, my address is 17
dq T_UNDEFINED ; i'm symbol->string, my address is 18
dq T_UNDEFINED ; i'm char->integer, my address is 19
dq T_UNDEFINED ; i'm integer->char, my address is 20
dq T_UNDEFINED ; i'm eq?, my address is 21
dq T_UNDEFINED ; i'm +, my address is 22
dq T_UNDEFINED ; i'm *, my address is 23
dq T_UNDEFINED ; i'm -, my address is 24
dq T_UNDEFINED ; i'm /, my address is 25
dq T_UNDEFINED ; i'm <, my address is 26
dq T_UNDEFINED ; i'm =, my address is 27
dq T_UNDEFINED ; i'm car, my address is 28
dq T_UNDEFINED ; i'm cdr, my address is 29
dq T_UNDEFINED ; i'm set-car!, my address is 30
dq T_UNDEFINED ; i'm set-cdr!, my address is 31
dq T_UNDEFINED ; i'm cons, my address is 32
dq T_UNDEFINED ; i'm >, my address is 33
dq T_UNDEFINED ; i'm not, my address is 34
dq T_UNDEFINED ; i'm zero?, my address is 35

global main
section .text
main:
    push rbp 
    mov rbp, rsp

    ;; set up the heap
    mov rdi, MB(500) ;; TODO: changed from GB(4)
    call malloc
    mov [malloc_pointer], rax

    ;; Set up the dummy activation frame
    ;; The dummy return address is T_UNDEFINED
    ;; (which a is a macro for 0) so that returning
    ;; from the top level (which SHOULD NOT HAPPEN
    ;; AND IS A BUG) will cause a segfault.
    push 0
    push qword SOB_NIL_ADDRESS
    push qword T_UNDEFINED
    push rsp

    jmp code_fragment

code_fragment:
    ;; Set up the primitive stdlib fvars:
    ;; Since the primtive procedures are defined in assembly,
    ;; they are not generated by scheme (define ...) expressions.
    ;; This is where we emulate the missing (define ...) expressions
    ;; for all the primitive procedures.
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_boolean)
    mov [fvar_tbl + 0 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_float)
    mov [fvar_tbl + 1 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_integer)
    mov [fvar_tbl + 2 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_pair)
    mov [fvar_tbl + 3 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_null)
    mov [fvar_tbl + 4 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_char)
    mov [fvar_tbl + 5 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_vector)
    mov [fvar_tbl + 6 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_string)
    mov [fvar_tbl + 7 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_procedure)
    mov [fvar_tbl + 8 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_symbol)
    mov [fvar_tbl + 9 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, string_length)
    mov [fvar_tbl + 10 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, string_ref)
    mov [fvar_tbl + 11 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, string_set)
    mov [fvar_tbl + 12 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, make_string)
    mov [fvar_tbl + 13 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, vector_length)
    mov [fvar_tbl + 14 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, vector_ref)
    mov [fvar_tbl + 15 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, vector_set)
    mov [fvar_tbl + 16 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, make_vector)
    mov [fvar_tbl + 17 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, symbol_to_string)
    mov [fvar_tbl + 18 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, char_to_integer)
    mov [fvar_tbl + 19 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, integer_to_char)
    mov [fvar_tbl + 20 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, is_eq)
    mov [fvar_tbl + 21 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_add)
    mov [fvar_tbl + 22 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_mul)
    mov [fvar_tbl + 23 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_sub)
    mov [fvar_tbl + 24 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_div)
    mov [fvar_tbl + 25 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_lt)
    mov [fvar_tbl + 26 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, bin_equ)
    mov [fvar_tbl + 27 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, car)
    mov [fvar_tbl + 28 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, cdr)
    mov [fvar_tbl + 29 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, set_car)
    mov [fvar_tbl + 30 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, set_cdr)
    mov [fvar_tbl + 31 * WORD_SIZE], rax
    MAKE_CLOSURE(rax, SOB_NIL_ADDRESS, cons)
    mov [fvar_tbl + 32 * WORD_SIZE], rax
    
user_code:

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 4 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 0 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse0

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 2 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 0 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse1

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 275 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 0 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse2

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 52 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 0 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse3

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 33 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 9 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse4

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 52 ; Const 
	push rax ; push arg 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 114 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 28 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse5

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 749 ; Const 
	push rax ; push arg 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 740 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 749 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 32 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 28 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse6

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 275 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 2 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse7

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 187 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 5 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse8

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 1 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 4 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse9

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 360 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 7 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse10

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 234 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 9 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse11

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 824 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 6 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse12

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 275 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 6 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse13

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 758 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 7 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse14

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 275 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 7 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse15

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 791 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 14 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 731 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse16

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 284 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 3 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse17

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 1 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 3 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse18

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 526 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 35 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse19

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 655 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 35 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse20

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 526 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 360 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 11 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 19 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 372 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse21

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 455 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 

	lambdaSimple37:
	MALLOC r10, 8 * (1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; j
	mov r15, qword[rbp + 16] ; lexical env

	.copy_env:
		cmp r12, 0 ; |env|
		je .done_copy_env
		mov r14, qword[r15 + 8 * r12] ; r14 = Env[i]
		mov [r11 + 8 * r13], r14 ; ExtEnv[j] = r14
		inc r12 ; inc counter of loop
		inc r13 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, 1 ; 1 arguments
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode37)
		jmp Lcont37

	Lcode37:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 13 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 10 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont37:
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse22

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 455 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 

	lambdaSimple36:
	MALLOC r10, 8 * (1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; j
	mov r15, qword[rbp + 16] ; lexical env

	.copy_env:
		cmp r12, 0 ; |env|
		je .done_copy_env
		mov r14, qword[r15 + 8 * r12] ; r14 = Env[i]
		mov [r11 + 8 * r13], r14 ; ExtEnv[j] = r14
		inc r12 ; inc counter of loop
		inc r13 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, 1 ; 1 arguments
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode36)
		jmp Lcont36

	Lcode36:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 17 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 14 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont36:
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse23

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 758 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 

	lambdaSimple35:
	MALLOC r10, 8 * (1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; j
	mov r15, qword[rbp + 16] ; lexical env

	.copy_env:
		cmp r12, 0 ; |env|
		je .done_copy_env
		mov r14, qword[r15 + 8 * r12] ; r14 = Env[i]
		mov [r11 + 8 * r13], r14 ; ExtEnv[j] = r14
		inc r12 ; inc counter of loop
		inc r13 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, 1 ; 1 arguments
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode35)
		jmp Lcont35

	Lcode35:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 740 ; Const 
	push rax ; push arg 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 15 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 71 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont35:
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse24

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 515 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 19 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 517 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse25

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 740 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 13 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 

	lambdaSimple34:
	MALLOC r10, 8 * (1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; j
	mov r15, qword[rbp + 16] ; lexical env

	.copy_env:
		cmp r12, 0 ; |env|
		je .done_copy_env
		mov r14, qword[r15 + 8 * r12] ; r14 = Env[i]
		mov [r11 + 8 * r13], r14 ; ExtEnv[j] = r14
		inc r12 ; inc counter of loop
		inc r13 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, 0 ; 0 arguments
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode34)
		jmp Lcont34

	Lcode34:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 535 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 526 ; Const 
	push rax ; push arg 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 3 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 12 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 



	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 557 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 749 ; Const 
	push rax ; push arg 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 3 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 12 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 



	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	mov rax, const_tbl + 582 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont34:
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse26

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 722 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 626 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 731 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse27

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 731 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 740 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 749 ; Const 
	push rax ; push arg 
	push 3 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 23 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 684 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse28

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 655 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 23 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 655 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse29

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 731 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 740 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 749 ; Const 
	push rax ; push arg 
	push 3 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 684 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse30

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 655 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 655 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse31

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 740 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 731 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 684 ; Const 
	push rax ; push arg 
	push 3 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 24 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	push rax ; push arg 
	mov rax, const_tbl + 749 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 27 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse32

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 713 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 722 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 731 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 740 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 749 ; Const 
	push rax ; push arg 
	push 5 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 26 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse33

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 749 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 740 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 731 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 722 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 713 ; Const 
	push rax ; push arg 
	push 5 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 33 * WORD_SIZE] ; VarFree 
	; finish parse op 
 	mov rbx, [rax + TYPE_SIZE] ; closure's env to rbx 
	push rbx ; push env (args) to stack (rsp stack pointer) 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code to rbx 
	call rbx ; call code (of closure) 
	add rsp, 8*1 ; pop env (args) 
	pop rbx ; pop number args 
	inc rbx ; add magic as param (in counter) for pop 
	shl rbx, 3 ; rbx = rbx * 8 (calc size args) 
	add rsp, rbx ; pop args 

	jmp LexitIf33
	Lelse33:
	mov rax, const_tbl + 2 ; Const 
	LexitIf33:
	jmp LexitIf32
	Lelse32:
	mov rax, const_tbl + 2 ; Const 
	LexitIf32:
	jmp LexitIf31
	Lelse31:
	mov rax, const_tbl + 2 ; Const 
	LexitIf31:
	jmp LexitIf30
	Lelse30:
	mov rax, const_tbl + 2 ; Const 
	LexitIf30:
	jmp LexitIf29
	Lelse29:
	mov rax, const_tbl + 2 ; Const 
	LexitIf29:
	jmp LexitIf28
	Lelse28:
	mov rax, const_tbl + 2 ; Const 
	LexitIf28:
	jmp LexitIf27
	Lelse27:
	mov rax, const_tbl + 2 ; Const 
	LexitIf27:
	jmp LexitIf26
	Lelse26:
	mov rax, const_tbl + 2 ; Const 
	LexitIf26:
	jmp LexitIf25
	Lelse25:
	mov rax, const_tbl + 2 ; Const 
	LexitIf25:
	jmp LexitIf24
	Lelse24:
	mov rax, const_tbl + 2 ; Const 
	LexitIf24:
	jmp LexitIf23
	Lelse23:
	mov rax, const_tbl + 2 ; Const 
	LexitIf23:
	jmp LexitIf22
	Lelse22:
	mov rax, const_tbl + 2 ; Const 
	LexitIf22:
	jmp LexitIf21
	Lelse21:
	mov rax, const_tbl + 2 ; Const 
	LexitIf21:
	jmp LexitIf20
	Lelse20:
	mov rax, const_tbl + 2 ; Const 
	LexitIf20:
	jmp LexitIf19
	Lelse19:
	mov rax, const_tbl + 2 ; Const 
	LexitIf19:
	jmp LexitIf18
	Lelse18:
	mov rax, const_tbl + 2 ; Const 
	LexitIf18:
	jmp LexitIf17
	Lelse17:
	mov rax, const_tbl + 2 ; Const 
	LexitIf17:
	jmp LexitIf16
	Lelse16:
	mov rax, const_tbl + 2 ; Const 
	LexitIf16:
	jmp LexitIf15
	Lelse15:
	mov rax, const_tbl + 2 ; Const 
	LexitIf15:
	jmp LexitIf14
	Lelse14:
	mov rax, const_tbl + 2 ; Const 
	LexitIf14:
	jmp LexitIf13
	Lelse13:
	mov rax, const_tbl + 2 ; Const 
	LexitIf13:
	jmp LexitIf12
	Lelse12:
	mov rax, const_tbl + 2 ; Const 
	LexitIf12:
	jmp LexitIf11
	Lelse11:
	mov rax, const_tbl + 2 ; Const 
	LexitIf11:
	jmp LexitIf10
	Lelse10:
	mov rax, const_tbl + 2 ; Const 
	LexitIf10:
	jmp LexitIf9
	Lelse9:
	mov rax, const_tbl + 2 ; Const 
	LexitIf9:
	jmp LexitIf8
	Lelse8:
	mov rax, const_tbl + 2 ; Const 
	LexitIf8:
	jmp LexitIf7
	Lelse7:
	mov rax, const_tbl + 2 ; Const 
	LexitIf7:
	jmp LexitIf6
	Lelse6:
	mov rax, const_tbl + 2 ; Const 
	LexitIf6:
	jmp LexitIf5
	Lelse5:
	mov rax, const_tbl + 2 ; Const 
	LexitIf5:
	jmp LexitIf4
	Lelse4:
	mov rax, const_tbl + 2 ; Const 
	LexitIf4:
	jmp LexitIf3
	Lelse3:
	mov rax, const_tbl + 2 ; Const 
	LexitIf3:
	jmp LexitIf2
	Lelse2:
	mov rax, const_tbl + 2 ; Const 
	LexitIf2:
	jmp LexitIf1
	Lelse1:
	mov rax, const_tbl + 2 ; Const 
	LexitIf1:
	jmp LexitIf0
	Lelse0:
	mov rax, const_tbl + 2 ; Const 
	LexitIf0:
    call write_sob_if_not_void
	add rsp, 4*8 
	pop rbp 
	ret 


is_boolean:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_BOOL
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_float:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_FLOAT
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_integer:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_INTEGER
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_pair:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_PAIR
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_null:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_NIL
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_char:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_CHAR
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_vector:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_VECTOR
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_string:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_STRING
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_procedure:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_CLOSURE
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

is_symbol:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    mov sil, byte [rsi]

    cmp sil, T_SYMBOL
    jne .wrong_type
    mov rax, SOB_TRUE_ADDRESS
    jmp .return

.wrong_type:
    mov rax, SOB_FALSE_ADDRESS
.return:
    leave
    ret

string_length:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    STRING_LENGTH rsi, rsi
    MAKE_INT(rax, rsi)

    leave
    ret

string_ref:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) 
    STRING_ELEMENTS rsi, rsi
    mov rdi, PVAR(1)
    INT_VAL rdi, rdi
    shl rdi, 0
    add rsi, rdi

    mov sil, byte [rsi]
    MAKE_CHAR(rax, sil)

    leave
    ret

string_set:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) 
    STRING_ELEMENTS rsi, rsi
    mov rdi, PVAR(1)
    INT_VAL rdi, rdi
    shl rdi, 0
    add rsi, rdi

    mov rax, PVAR(2)
    CHAR_VAL rax, rax
    mov byte [rsi], al
    mov rax, SOB_VOID_ADDRESS

    leave
    ret

make_string:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    mov rdi, PVAR(1)
    CHAR_VAL rdi, rdi
    and rdi, 255

    MAKE_STRING rax, rsi, dil

    leave
    ret

vector_length:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
    VECTOR_LENGTH rsi, rsi
    MAKE_INT(rax, rsi)

    leave
    ret

vector_ref:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) 
    VECTOR_ELEMENTS rsi, rsi
    mov rdi, PVAR(1)
    INT_VAL rdi, rdi
    shl rdi, 3
    add rsi, rdi

    mov rax, [rsi]

    leave
    ret

vector_set:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) 
    VECTOR_ELEMENTS rsi, rsi
    mov rdi, PVAR(1)
    INT_VAL rdi, rdi
    shl rdi, 3
    add rsi, rdi

    mov rdi, PVAR(2)
    mov [rsi], rdi
    mov rax, SOB_VOID_ADDRESS

    leave
    ret

make_vector:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    mov rdi, PVAR(1)
    

    MAKE_VECTOR rax, rsi, rdi

    leave
    ret

symbol_to_string:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    SYMBOL_VAL rsi, rsi
    
    STRING_LENGTH rcx, rsi
    STRING_ELEMENTS rdi, rsi

    push rcx
    push rdi

    mov dil, byte [rdi]
    MAKE_CHAR(rax, dil)
    push rax
    MAKE_INT(rax, rcx)
    push rax
    push 2
    push SOB_NIL_ADDRESS
    call make_string
    add rsp, 4*8

    STRING_ELEMENTS rsi, rax

    pop rdi
    pop rcx

.loop:
    cmp rcx, 0
    je .end
    lea r8, [rdi+rcx]
    lea r9, [rsi+rcx]

    mov bl, byte [r8]
    mov byte [r9], bl
    
    dec rcx
    jmp .loop ;; due to Yitav comment on facebook
.end:

    leave
    ret

char_to_integer:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    CHAR_VAL rsi, rsi
    and rsi, 255
    MAKE_INT(rax, rsi)

    leave
    ret

integer_to_char:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    and rsi, 255
    MAKE_CHAR(rax, sil)

    leave
    ret

is_eq:
    push rbp
    mov rbp, rsp

    
    mov rsi, PVAR(0)
    mov rdi, PVAR(1)
    cmp rsi, rdi
    je .true
    mov rax, SOB_FALSE_ADDRESS
    jmp .return

.true:
    mov rax, SOB_TRUE_ADDRESS

.return:
    leave
    ret

bin_add:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    addsd xmm0, xmm1

    pop r8
    cmp r8, 0
    je .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    leave
    ret

bin_mul:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    mulsd xmm0, xmm1

    pop r8
    cmp r8, 0
    je .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    leave
    ret

bin_sub:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    subsd xmm0, xmm1

    pop r8
    cmp r8, 0
    je .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    leave
    ret

bin_div:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    divsd xmm0, xmm1

    pop r8
    cmp r8, 0
    je .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    leave
    ret

bin_lt:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    cmpltsd xmm0, xmm1

    pop r8
    cmp r8, 0
    je .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    INT_VAL rsi, rax
    cmp rsi, 0
    je .return_false
    mov rax, SOB_TRUE_ADDRESS
    jmp .final_return

.return_false:
    mov rax, SOB_FALSE_ADDRESS

.final_return:


    leave
    ret

bin_equ:
    push rbp
    mov rbp, rsp

    mov r8, 0

    mov rsi, PVAR(0)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .test_next
    or r8, 1

.test_next:

    mov rsi, PVAR(1)
    push rsi
    push 1
    push SOB_NIL_ADDRESS
    call is_float
    add rsp, 3*WORD_SIZE 


    cmp rax, SOB_TRUE_ADDRESS
    je .load_numbers
    or r8, 2

.load_numbers:
    push r8

    shr r8, 1
    jc .first_arg_int
    mov rsi, PVAR(0)
    FLOAT_VAL rsi, rsi 
    movq xmm0, rsi
    jmp .load_next_float

.first_arg_int:
    mov rsi, PVAR(0)
    INT_VAL rsi, rsi
    cvtsi2sd xmm0, rsi

.load_next_float:
    shr r8, 1
    jc .second_arg_int
    mov rsi, PVAR(1)
    FLOAT_VAL rsi, rsi
    movq xmm1, rsi
    jmp .perform_float_op

.second_arg_int:
    mov rsi, PVAR(1)
    INT_VAL rsi, rsi
    cvtsi2sd xmm1, rsi

.perform_float_op:
    cmpeqsd xmm0, xmm1

    pop r8
    cmp r8, 0
    je .return_float

    cvttsd2si rsi, xmm0
    MAKE_INT(rax, rsi)
    jmp .return

.return_float:
    movq rsi, xmm0
    MAKE_FLOAT(rax, rsi)

.return:

    INT_VAL rsi, rax
    cmp rsi, 0
    je .return_false
    mov rax, SOB_TRUE_ADDRESS
    jmp .final_return

.return_false:
    mov rax, SOB_FALSE_ADDRESS

.final_return:


    leave
    ret


 
car:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0) ;; rsi got pair
	CAR rax, rsi ;; rax got car
    jmp .return

.return:
    leave
    ret

cdr:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(0)
	CDR rax, rsi
    jmp .return

.return:
    leave
    ret
    
set_car:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(1) ;; rsi contains new car
    mov r8, PVAR(0) ;; qword of pair
    add r8, 1 ;; r8 is car loc
    mov [r8], rsi
    mov r9, qword [r8] ;; r9 is car val

    mov rax, SOB_VOID_ADDRESS
    jmp .return

.return:
    leave
    ret

set_cdr:
    push rbp
    mov rbp, rsp

    mov rsi, PVAR(1) ;; rsi contains new car
    mov r8, PVAR(0) ;; qword of pair
    add r8, 9 ;; r8 is cdr loc
    mov [r8], rsi
    mov r9, qword [r8] ;; r9 is car val

    mov rax, SOB_VOID_ADDRESS
    jmp .return

.return:
    leave
    ret

cons:
    push rbp
    mov rbp, rsp

    mov r8, PVAR(0) ;; car
    mov r9, PVAR(1) ;; cdr
    MAKE_PAIR (rax, r8, r9) ;; put pair into rax, r8 is car, r9 is cdr

    jmp .return

.return:
    leave
    ret    
