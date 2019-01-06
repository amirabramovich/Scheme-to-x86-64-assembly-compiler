
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
MAKE_LITERAL_STRING "a" ; my address is 6
MAKE_LITERAL_STRING "b" ; my address is 16
MAKE_LITERAL_STRING "c" ; my address is 26
MAKE_LITERAL_STRING "esadsad" ; my address is 36
MAKE_LITERAL_INT(3) ; my address is 52
MAKE_LITERAL_STRING "d" ; my address is 61
MAKE_LITERAL_STRING "fsfdsaf3dfss" ; my address is 71
MAKE_LITERAL_INT(10) ; my address is 92
MAKE_LITERAL_STRING "e" ; my address is 101
MAKE_LITERAL_INT(0) ; my address is 111
MAKE_LITERAL_STRING "f" ; my address is 120
MAKE_LITERAL_STRING "dsfdsh" ; my address is 130
MAKE_LITERAL_STRING "g" ; my address is 145
MAKE_LITERAL_STRING "idfdsfds" ; my address is 155
MAKE_LITERAL_STRING "h" ; my address is 172
MAKE_LITERAL_STRING "jdsfdsf" ; my address is 182
MAKE_LITERAL_STRING "i" ; my address is 198
MAKE_LITERAL_STRING "kdsfdsf" ; my address is 208
MAKE_LITERAL_STRING "j" ; my address is 224
MAKE_LITERAL_STRING "lds" ; my address is 234
MAKE_LITERAL_STRING "k" ; my address is 246
MAKE_LITERAL_STRING "mdsff" ; my address is 256
MAKE_LITERAL_STRING "l" ; my address is 270
MAKE_LITERAL_STRING "nd" ; my address is 280
MAKE_LITERAL_STRING "m" ; my address is 291
MAKE_LITERAL_STRING "" ; my address is 301
MAKE_LITERAL_STRING "n" ; my address is 310
MAKE_LITERAL_STRING "pdsfdsf" ; my address is 320
MAKE_LITERAL_STRING "o" ; my address is 336
MAKE_LITERAL_STRING "q34324dsfdsfdsf35r" ; my address is 346
MAKE_LITERAL_STRING "p" ; my address is 373
MAKE_LITERAL_STRING "rdfsfdsf3rfdsfdsf" ; my address is 383
MAKE_LITERAL_STRING "q" ; my address is 409
MAKE_LITERAL_STRING "sfddsfr4fdfdsfdsgfdgfdh" ; my address is 419
MAKE_LITERAL_INT(14) ; my address is 451
MAKE_LITERAL_STRING "r" ; my address is 460
MAKE_LITERAL_STRING "tdfsdsf34sfddsf" ; my address is 470
MAKE_LITERAL_INT(11) ; my address is 494
MAKE_LITERAL_STRING "s" ; my address is 503
MAKE_LITERAL_STRING "uffdsfds43sfdfds" ; my address is 513
MAKE_LITERAL_INT(8) ; my address is 538
MAKE_LITERAL_STRING "t" ; my address is 547
MAKE_LITERAL_STRING "vdsfdsfdsf4dsfsdf" ; my address is 557
MAKE_LITERAL_INT(9) ; my address is 583
MAKE_LITERAL_STRING "u" ; my address is 592
MAKE_LITERAL_STRING "string-ref" ; my address is 602
MAKE_LITERAL_STRING "wdsfdsfdsf3fsd" ; my address is 621
MAKE_LITERAL_INT(6) ; my address is 644
MAKE_LITERAL_STRING "v" ; my address is 653
MAKE_LITERAL_STRING "xff" ; my address is 663
MAKE_LITERAL_STRING "w" ; my address is 675
MAKE_LITERAL_STRING "dfsy" ; my address is 685
MAKE_LITERAL_STRING "x" ; my address is 698
MAKE_LITERAL_STRING "zdfs" ; my address is 708
MAKE_LITERAL_STRING "y" ; my address is 721
MAKE_LITERAL_STRING "string-length" ; my address is 731
MAKE_LITERAL_STRING "asdfds" ; my address is 753
MAKE_LITERAL_STRING "eq?" ; my address is 768
MAKE_LITERAL_SYMBOL(const_tbl + 6) ; my address is 780
MAKE_LITERAL_STRING "z" ; my address is 789

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
dq T_UNDEFINED ; i'm z, my address is 33
dq T_UNDEFINED ; i'm y, my address is 34
dq T_UNDEFINED ; i'm x, my address is 35
dq T_UNDEFINED ; i'm w, my address is 36
dq T_UNDEFINED ; i'm v, my address is 37
dq T_UNDEFINED ; i'm u, my address is 38
dq T_UNDEFINED ; i'm t, my address is 39
dq T_UNDEFINED ; i'm s, my address is 40
dq T_UNDEFINED ; i'm r, my address is 41
dq T_UNDEFINED ; i'm q, my address is 42
dq T_UNDEFINED ; i'm p, my address is 43
dq T_UNDEFINED ; i'm o, my address is 44
dq T_UNDEFINED ; i'm n, my address is 45
dq T_UNDEFINED ; i'm m, my address is 46
dq T_UNDEFINED ; i'm l, my address is 47
dq T_UNDEFINED ; i'm k, my address is 48
dq T_UNDEFINED ; i'm j, my address is 49
dq T_UNDEFINED ; i'm i, my address is 50
dq T_UNDEFINED ; i'm h, my address is 51
dq T_UNDEFINED ; i'm g, my address is 52
dq T_UNDEFINED ; i'm f, my address is 53
dq T_UNDEFINED ; i'm e, my address is 54
dq T_UNDEFINED ; i'm d, my address is 55
dq T_UNDEFINED ; i'm c, my address is 56
dq T_UNDEFINED ; i'm b, my address is 57
dq T_UNDEFINED ; i'm a, my address is 58

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
	mov rax, const_tbl + 16 ; Const 
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

	mov qword [fvar_tbl + 58 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 26 ; Const 
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

	mov qword [fvar_tbl + 57 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 61 ; Const 
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

	mov qword [fvar_tbl + 56 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 52 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 36 ; Const 
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

	mov qword [fvar_tbl + 55 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 92 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 71 ; Const 
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

	mov qword [fvar_tbl + 54 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 111 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 145 ; Const 
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

	mov qword [fvar_tbl + 53 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 130 ; Const 
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

	mov qword [fvar_tbl + 52 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 155 ; Const 
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

	mov qword [fvar_tbl + 51 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 182 ; Const 
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

	mov qword [fvar_tbl + 50 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 208 ; Const 
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

	mov qword [fvar_tbl + 49 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 234 ; Const 
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

	mov qword [fvar_tbl + 48 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 256 ; Const 
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

	mov qword [fvar_tbl + 47 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 280 ; Const 
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

	mov qword [fvar_tbl + 46 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 301 ; Const 
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

	mov qword [fvar_tbl + 45 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 320 ; Const 
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

	mov qword [fvar_tbl + 44 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 644 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 346 ; Const 
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

	mov qword [fvar_tbl + 43 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 538 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 383 ; Const 
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

	mov qword [fvar_tbl + 42 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 451 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 419 ; Const 
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

	mov qword [fvar_tbl + 41 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 494 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 470 ; Const 
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

	mov qword [fvar_tbl + 40 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 538 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 513 ; Const 
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

	mov qword [fvar_tbl + 39 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 583 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 557 ; Const 
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

	mov qword [fvar_tbl + 38 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 644 ; Const 
	push rax ; push arg 
	mov rax, const_tbl + 621 ; Const 
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

	mov qword [fvar_tbl + 37 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 663 ; Const 
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

	mov qword [fvar_tbl + 36 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 685 ; Const 
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

	mov qword [fvar_tbl + 35 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 708 ; Const 
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

	mov qword [fvar_tbl + 34 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 753 ; Const 
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

	mov qword [fvar_tbl + 33 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, qword [fvar_tbl + 33 * WORD_SIZE] ; VarFree 
	push rax ; push arg 
	mov rax, const_tbl + 780 ; Const 
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
