
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
MAKE_LITERAL_STRING "caaar" ; my address is 6
MAKE_LITERAL_STRING "caadr" ; my address is 20
MAKE_LITERAL_STRING "caar" ; my address is 34
MAKE_LITERAL_STRING "cdaar" ; my address is 47
MAKE_LITERAL_STRING "cadr" ; my address is 61
MAKE_LITERAL_STRING "cdadr" ; my address is 74
MAKE_LITERAL_STRING "cdar" ; my address is 88
MAKE_LITERAL_STRING "cddar" ; my address is 101
MAKE_LITERAL_STRING "cddr" ; my address is 115
MAKE_LITERAL_STRING "pair" ; my address is 128
MAKE_LITERAL_STRING "cdddr" ; my address is 141
MAKE_LITERAL_STRING "f" ; my address is 155
MAKE_LITERAL_STRING "null?" ; my address is 165
MAKE_LITERAL_INT(1) ; my address is 179
MAKE_LITERAL_STRING "=" ; my address is 188
MAKE_LITERAL_STRING "break" ; my address is 198
MAKE_LITERAL_INT(0) ; my address is 212
MAKE_LITERAL_STRING "cdr" ; my address is 221
MAKE_LITERAL_STRING "car" ; my address is 233
MAKE_LITERAL_STRING "*" ; my address is 245
MAKE_LITERAL_STRING "ls" ; my address is 255
MAKE_LITERAL_STRING "whatever" ; my address is 266
MAKE_LITERAL_SYMBOL(const_tbl + 266) ; my address is 283
MAKE_LITERAL_STRING "k" ; my address is 292
MAKE_LITERAL_INT(2) ; my address is 302
MAKE_LITERAL_INT(3) ; my address is 311
MAKE_LITERAL_INT(4) ; my address is 320
MAKE_LITERAL_INT(5) ; my address is 329
MAKE_LITERAL_PAIR(const_tbl + 329, const_tbl + 1) ; my address is 338
MAKE_LITERAL_PAIR(const_tbl + 320, const_tbl + 338) ; my address is 355
MAKE_LITERAL_PAIR(const_tbl + 311, const_tbl + 355) ; my address is 372
MAKE_LITERAL_PAIR(const_tbl + 302, const_tbl + 372) ; my address is 389
MAKE_LITERAL_PAIR(const_tbl + 179, const_tbl + 389) ; my address is 406
MAKE_LITERAL_INT(7) ; my address is 423
MAKE_LITERAL_INT(8) ; my address is 432
MAKE_LITERAL_INT(9) ; my address is 441
MAKE_LITERAL_PAIR(const_tbl + 441, const_tbl + 338) ; my address is 450
MAKE_LITERAL_PAIR(const_tbl + 179, const_tbl + 450) ; my address is 467
MAKE_LITERAL_PAIR(const_tbl + 212, const_tbl + 467) ; my address is 484
MAKE_LITERAL_PAIR(const_tbl + 432, const_tbl + 484) ; my address is 501
MAKE_LITERAL_PAIR(const_tbl + 311, const_tbl + 501) ; my address is 518
MAKE_LITERAL_PAIR(const_tbl + 423, const_tbl + 518) ; my address is 535
MAKE_LITERAL_STRING "product$" ; my address is 552
MAKE_LITERAL_STRING "x" ; my address is 569
MAKE_LITERAL_INT(912) ; my address is 579
MAKE_LITERAL_PAIR(const_tbl + 579, const_tbl + 338) ; my address is 588
MAKE_LITERAL_PAIR(const_tbl + 179, const_tbl + 588) ; my address is 605
MAKE_LITERAL_PAIR(const_tbl + 179, const_tbl + 605) ; my address is 622
MAKE_LITERAL_PAIR(const_tbl + 432, const_tbl + 622) ; my address is 639
MAKE_LITERAL_PAIR(const_tbl + 311, const_tbl + 639) ; my address is 656
MAKE_LITERAL_PAIR(const_tbl + 423, const_tbl + 656) ; my address is 673

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
dq T_UNDEFINED ; i'm product$, my address is 33
dq T_UNDEFINED ; i'm cdddr, my address is 34
dq T_UNDEFINED ; i'm cddar, my address is 35
dq T_UNDEFINED ; i'm cdadr, my address is 36
dq T_UNDEFINED ; i'm cdaar, my address is 37
dq T_UNDEFINED ; i'm caadr, my address is 38
dq T_UNDEFINED ; i'm caaar, my address is 39
dq T_UNDEFINED ; i'm cdar, my address is 40
dq T_UNDEFINED ; i'm cddr, my address is 41
dq T_UNDEFINED ; i'm cadr, my address is 42
dq T_UNDEFINED ; i'm caar, my address is 43

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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont0:
	mov qword [fvar_tbl + 43 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple1:
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
		MAKE_CLOSURE(rax, r10, Lcode1)
		jmp Lcont1

	Lcode1:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont1:
	mov qword [fvar_tbl + 42 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple2:
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
		MAKE_CLOSURE(rax, r10, Lcode2)
		jmp Lcont2

	Lcode2:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont2:
	mov qword [fvar_tbl + 41 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple3:
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
		MAKE_CLOSURE(rax, r10, Lcode3)
		jmp Lcont3

	Lcode3:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont3:
	mov qword [fvar_tbl + 40 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple4:
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
		MAKE_CLOSURE(rax, r10, Lcode4)
		jmp Lcont4

	Lcode4:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 43 * WORD_SIZE] ; VarFree 
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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont4:
	mov qword [fvar_tbl + 39 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple5:
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
		MAKE_CLOSURE(rax, r10, Lcode5)
		jmp Lcont5

	Lcode5:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont5:
	mov qword [fvar_tbl + 38 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple6:
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
		MAKE_CLOSURE(rax, r10, Lcode6)
		jmp Lcont6

	Lcode6:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 43 * WORD_SIZE] ; VarFree 
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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont6:
	mov qword [fvar_tbl + 37 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple7:
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
		MAKE_CLOSURE(rax, r10, Lcode7)
		jmp Lcont7

	Lcode7:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 42 * WORD_SIZE] ; VarFree 
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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont7:
	mov qword [fvar_tbl + 36 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple8:
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
		MAKE_CLOSURE(rax, r10, Lcode8)
		jmp Lcont8

	Lcode8:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 40 * WORD_SIZE] ; VarFree 
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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont8:
	mov qword [fvar_tbl + 35 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple9:
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
		MAKE_CLOSURE(rax, r10, Lcode9)
		jmp Lcont9

	Lcode9:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [fvar_tbl + 41 * WORD_SIZE] ; VarFree 
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

	leave ; done parsing lambdaSimple body above 
	ret

	Lcont9:
	mov qword [fvar_tbl + 34 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	lambdaSimple10:
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
		MAKE_CLOSURE(rax, r10, Lcode10)
		jmp Lcont10

	Lcode10:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(1) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 

	lambdaSimple11:
	MALLOC r10, 8 * (1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; j
	mov r15, qword[rbp + 16] ; lexical env

	.copy_env:
		cmp r12, 1 ; |env|
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
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, 2 ; 2 arguments
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode11)
		jmp Lcont11

	Lcode11:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 283 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 

	lambdaSimple12:
	MALLOC r10, 8 * (1 + 2) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; j
	mov r15, qword[rbp + 16] ; lexical env

	.copy_env:
		cmp r12, 2 ; |env|
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
		MAKE_CLOSURE(rax, r10, Lcode12)
		jmp Lcont12

	Lcode12:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	mov qword PVAR(0), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS


	lambdaSimple13:
	MALLOC r10, 8 * (1 + 3) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; j
	mov r15, qword[rbp + 16] ; lexical env

	.copy_env:
		cmp r12, 3 ; |env|
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
		MAKE_CLOSURE(rax, r10, Lcode13)
		jmp Lcont13

	Lcode13:
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
	je Lelse14

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 179 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, PVAR(1) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
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

	jmp LexitIf14
	Lelse14:

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 212 ; Const 
	push rax ; push arg 

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
	je Lelse15

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, const_tbl + 212 ; Const 
	push rax ; push arg 
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [rbp + 16] ; Var' or Box' of VarBound 
	mov rax, BVAR(1)
	mov rax, BVAR(0)
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

	jmp LexitIf15
	Lelse15:

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	lambdaSimple16:
	MALLOC r10, 8 * (1 + 4) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; j
	mov r15, qword[rbp + 16] ; lexical env

	.copy_env:
		cmp r12, 4 ; |env|
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
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, 2 ; 2 arguments
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode16)
		jmp Lcont16

	Lcode16:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	push rax ; push arg 

	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, qword [rbp + 16] ; Var' or Box' of VarBound 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
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
	push 1 ; push number args 
	; start parse op 
	mov rax, qword [rbp + 16] ; Var' or Box' of VarBound 
	mov rax, BVAR(0)
	mov rax, BVAR(1)
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

	Lcont16:
	push rax ; push arg 

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
	push 2 ; push number args 
	; start parse op 
	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
	mov rax, qword [rax]
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

	LexitIf15:
	LexitIf14:
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont13:
	push rax ; VarParam, BoxSet' 
	mov rax, PVAR(0)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 
	mov rax, qword [rbp + 16] ; Var' or Box' of VarBound 
	mov rax, BVAR(1)
	mov rax, BVAR(1)
	push rax ; push arg 
	mov rax, qword [rbp + 16] ; Var' or Box' of VarBound 
	mov rax, BVAR(1)
	mov rax, BVAR(0)
	push rax ; push arg 
	push 2 ; push number args 
	; start parse op 
	mov rax, PVAR(0) ; VarParam, BoxGet' 
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

	Lcont12:
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

	Lcont11:
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

	Lcont10:
	mov qword [fvar_tbl + 33 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, MAGIC ; Applic 
	push rax ; push magic to stack 

	lambdaSimple17:
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
		MAKE_CLOSURE(rax, r10, Lcode17)
		jmp Lcont17

	Lcode17:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont17:
	push rax ; push arg 
	mov rax, const_tbl + 406 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
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

	lambdaSimple18:
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
		MAKE_CLOSURE(rax, r10, Lcode18)
		jmp Lcont18

	Lcode18:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont18:
	push rax ; push arg 
	mov rax, const_tbl + 535 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
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

	lambdaSimple19:
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
		MAKE_CLOSURE(rax, r10, Lcode19)
		jmp Lcont19

	Lcode19:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov r15, IS_PARAM ; for sign in ApplicTP, that this arg is param 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont19:
	push rax ; push arg 
	mov rax, const_tbl + 673 ; Const 
	push rax ; push arg 
	push 2 ; push number args 
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
