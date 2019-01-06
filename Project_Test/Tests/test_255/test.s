
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
MAKE_LITERAL_STRING "null?" ; my address is 6
MAKE_LITERAL_STRING "*" ; my address is 20
MAKE_LITERAL_STRING "car" ; my address is 30
MAKE_LITERAL_INT(3) ; my address is 42
MAKE_LITERAL_STRING "cdr" ; my address is 51
MAKE_LITERAL_STRING "numbers" ; my address is 63
MAKE_LITERAL_STRING "cons" ; my address is 79
MAKE_LITERAL_INT(1) ; my address is 92
MAKE_LITERAL_PAIR(const_tbl + 92, const_tbl + 1) ; my address is 101
MAKE_LITERAL_INT(2) ; my address is 118
MAKE_LITERAL_PAIR(const_tbl + 118, const_tbl + 1) ; my address is 127
MAKE_LITERAL_PAIR(const_tbl + 92, const_tbl + 127) ; my address is 144
MAKE_LITERAL_INT(4) ; my address is 161
MAKE_LITERAL_PAIR(const_tbl + 161, const_tbl + 1) ; my address is 170
MAKE_LITERAL_PAIR(const_tbl + 42, const_tbl + 170) ; my address is 187
MAKE_LITERAL_PAIR(const_tbl + 118, const_tbl + 187) ; my address is 204
MAKE_LITERAL_PAIR(const_tbl + 92, const_tbl + 204) ; my address is 221
MAKE_LITERAL_INT(5) ; my address is 238
MAKE_LITERAL_INT(6) ; my address is 247
MAKE_LITERAL_PAIR(const_tbl + 247, const_tbl + 1) ; my address is 256
MAKE_LITERAL_PAIR(const_tbl + 238, const_tbl + 256) ; my address is 273
MAKE_LITERAL_PAIR(const_tbl + 161, const_tbl + 273) ; my address is 290
MAKE_LITERAL_PAIR(const_tbl + 42, const_tbl + 290) ; my address is 307
MAKE_LITERAL_PAIR(const_tbl + 118, const_tbl + 307) ; my address is 324
MAKE_LITERAL_PAIR(const_tbl + 92, const_tbl + 324) ; my address is 341
MAKE_LITERAL_INT(7) ; my address is 358
MAKE_LITERAL_INT(8) ; my address is 367
MAKE_LITERAL_INT(9) ; my address is 376
MAKE_LITERAL_INT(10) ; my address is 385
MAKE_LITERAL_PAIR(const_tbl + 385, const_tbl + 1) ; my address is 394
MAKE_LITERAL_PAIR(const_tbl + 376, const_tbl + 394) ; my address is 411
MAKE_LITERAL_PAIR(const_tbl + 367, const_tbl + 411) ; my address is 428
MAKE_LITERAL_PAIR(const_tbl + 358, const_tbl + 428) ; my address is 445
MAKE_LITERAL_PAIR(const_tbl + 247, const_tbl + 445) ; my address is 462
MAKE_LITERAL_PAIR(const_tbl + 238, const_tbl + 462) ; my address is 479
MAKE_LITERAL_PAIR(const_tbl + 161, const_tbl + 479) ; my address is 496
MAKE_LITERAL_PAIR(const_tbl + 42, const_tbl + 496) ; my address is 513
MAKE_LITERAL_PAIR(const_tbl + 118, const_tbl + 513) ; my address is 530
MAKE_LITERAL_PAIR(const_tbl + 92, const_tbl + 530) ; my address is 547
MAKE_LITERAL_STRING "triple-everything" ; my address is 564
MAKE_LITERAL_INT(11) ; my address is 590
MAKE_LITERAL_INT(12) ; my address is 599
MAKE_LITERAL_INT(13) ; my address is 608
MAKE_LITERAL_INT(14) ; my address is 617
MAKE_LITERAL_INT(15) ; my address is 626
MAKE_LITERAL_INT(16) ; my address is 635
MAKE_LITERAL_INT(17) ; my address is 644
MAKE_LITERAL_INT(18) ; my address is 653
MAKE_LITERAL_INT(19) ; my address is 662
MAKE_LITERAL_INT(20) ; my address is 671
MAKE_LITERAL_INT(21) ; my address is 680
MAKE_LITERAL_INT(22) ; my address is 689
MAKE_LITERAL_INT(23) ; my address is 698
MAKE_LITERAL_INT(24) ; my address is 707
MAKE_LITERAL_INT(25) ; my address is 716
MAKE_LITERAL_INT(26) ; my address is 725
MAKE_LITERAL_INT(27) ; my address is 734
MAKE_LITERAL_INT(28) ; my address is 743
MAKE_LITERAL_INT(29) ; my address is 752
MAKE_LITERAL_INT(30) ; my address is 761
MAKE_LITERAL_INT(31) ; my address is 770
MAKE_LITERAL_INT(32) ; my address is 779
MAKE_LITERAL_INT(33) ; my address is 788
MAKE_LITERAL_INT(34) ; my address is 797
MAKE_LITERAL_INT(35) ; my address is 806
MAKE_LITERAL_INT(36) ; my address is 815
MAKE_LITERAL_INT(37) ; my address is 824
MAKE_LITERAL_INT(38) ; my address is 833
MAKE_LITERAL_INT(39) ; my address is 842
MAKE_LITERAL_INT(40) ; my address is 851
MAKE_LITERAL_PAIR(const_tbl + 851, const_tbl + 1) ; my address is 860
MAKE_LITERAL_PAIR(const_tbl + 842, const_tbl + 860) ; my address is 877
MAKE_LITERAL_PAIR(const_tbl + 833, const_tbl + 877) ; my address is 894
MAKE_LITERAL_PAIR(const_tbl + 824, const_tbl + 894) ; my address is 911
MAKE_LITERAL_PAIR(const_tbl + 815, const_tbl + 911) ; my address is 928
MAKE_LITERAL_PAIR(const_tbl + 806, const_tbl + 928) ; my address is 945
MAKE_LITERAL_PAIR(const_tbl + 797, const_tbl + 945) ; my address is 962
MAKE_LITERAL_PAIR(const_tbl + 788, const_tbl + 962) ; my address is 979
MAKE_LITERAL_PAIR(const_tbl + 779, const_tbl + 979) ; my address is 996
MAKE_LITERAL_PAIR(const_tbl + 770, const_tbl + 996) ; my address is 1013
MAKE_LITERAL_PAIR(const_tbl + 761, const_tbl + 1013) ; my address is 1030
MAKE_LITERAL_PAIR(const_tbl + 752, const_tbl + 1030) ; my address is 1047
MAKE_LITERAL_PAIR(const_tbl + 743, const_tbl + 1047) ; my address is 1064
MAKE_LITERAL_PAIR(const_tbl + 734, const_tbl + 1064) ; my address is 1081
MAKE_LITERAL_PAIR(const_tbl + 725, const_tbl + 1081) ; my address is 1098
MAKE_LITERAL_PAIR(const_tbl + 716, const_tbl + 1098) ; my address is 1115
MAKE_LITERAL_PAIR(const_tbl + 707, const_tbl + 1115) ; my address is 1132
MAKE_LITERAL_PAIR(const_tbl + 698, const_tbl + 1132) ; my address is 1149
MAKE_LITERAL_PAIR(const_tbl + 689, const_tbl + 1149) ; my address is 1166
MAKE_LITERAL_PAIR(const_tbl + 680, const_tbl + 1166) ; my address is 1183
MAKE_LITERAL_PAIR(const_tbl + 671, const_tbl + 1183) ; my address is 1200
MAKE_LITERAL_PAIR(const_tbl + 662, const_tbl + 1200) ; my address is 1217
MAKE_LITERAL_PAIR(const_tbl + 653, const_tbl + 1217) ; my address is 1234
MAKE_LITERAL_PAIR(const_tbl + 644, const_tbl + 1234) ; my address is 1251
MAKE_LITERAL_PAIR(const_tbl + 635, const_tbl + 1251) ; my address is 1268
MAKE_LITERAL_PAIR(const_tbl + 626, const_tbl + 1268) ; my address is 1285
MAKE_LITERAL_PAIR(const_tbl + 617, const_tbl + 1285) ; my address is 1302
MAKE_LITERAL_PAIR(const_tbl + 608, const_tbl + 1302) ; my address is 1319
MAKE_LITERAL_PAIR(const_tbl + 599, const_tbl + 1319) ; my address is 1336
MAKE_LITERAL_PAIR(const_tbl + 590, const_tbl + 1336) ; my address is 1353
MAKE_LITERAL_PAIR(const_tbl + 385, const_tbl + 1353) ; my address is 1370
MAKE_LITERAL_PAIR(const_tbl + 376, const_tbl + 1370) ; my address is 1387
MAKE_LITERAL_PAIR(const_tbl + 367, const_tbl + 1387) ; my address is 1404
MAKE_LITERAL_PAIR(const_tbl + 358, const_tbl + 1404) ; my address is 1421
MAKE_LITERAL_PAIR(const_tbl + 247, const_tbl + 1421) ; my address is 1438
MAKE_LITERAL_PAIR(const_tbl + 238, const_tbl + 1438) ; my address is 1455
MAKE_LITERAL_PAIR(const_tbl + 161, const_tbl + 1455) ; my address is 1472
MAKE_LITERAL_PAIR(const_tbl + 42, const_tbl + 1472) ; my address is 1489
MAKE_LITERAL_PAIR(const_tbl + 118, const_tbl + 1489) ; my address is 1506
MAKE_LITERAL_PAIR(const_tbl + 92, const_tbl + 1506) ; my address is 1523

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
dq T_UNDEFINED ; i'm triple-everything, my address is 33

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

	lambdaSimple0:
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
		MAKE_CLOSURE(rax, r10, Lcode0)
		jmp Lcont0

	Lcode0:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
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
	je Lelse1
	mov rax, const_tbl + 1 ; Const 
	jmp LexitIf1
	Lelse1:

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
	mov rax, qword [fvar_tbl + 29 * WORD_SIZE] ; VarFree 
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

	push rax ; push arg 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
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
	mov rax, const_tbl + 42 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
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

	LexitIf1:
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont0:
	mov qword [fvar_tbl + 33 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 1 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
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

    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 101 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
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

    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 144 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
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

    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 221 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
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

    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 341 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
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

    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 547 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
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

    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 1523 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
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
