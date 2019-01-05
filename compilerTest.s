
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
MAKE_LITERAL_STRING "*** compiler tests ***" ; my address is 6
MAKE_LITERAL_FLOAT(2.2) ; my address is 37
MAKE_LITERAL_STRING "c" ; my address is 46
MAKE_LITERAL_SYMBOL(const_tbl + 46) ; my address is 56
MAKE_LITERAL_STRING "" ; my address is 65
MAKE_LITERAL_STRING "str" ; my address is 74
MAKE_LITERAL_INT(1) ; my address is 86
MAKE_LITERAL_INT(2) ; my address is 95
MAKE_LITERAL_PAIR(const_tbl + 95, const_tbl + 1) ; my address is 104
MAKE_LITERAL_PAIR(const_tbl + 86, const_tbl + 104) ; my address is 121
MAKE_LITERAL_INT(3) ; my address is 138
MAKE_LITERAL_INT(4) ; my address is 147
MAKE_LITERAL_PAIR(const_tbl + 147, const_tbl + 1) ; my address is 156
MAKE_LITERAL_PAIR(const_tbl + 138, const_tbl + 156) ; my address is 173
MAKE_LITERAL_PAIR(const_tbl + 95, const_tbl + 173) ; my address is 190
MAKE_LITERAL_PAIR(const_tbl + 86, const_tbl + 190) ; my address is 207
MAKE_LITERAL_STRING "Const" ; my address is 224
MAKE_LITERAL_STRING "If" ; my address is 238
MAKE_LITERAL_STRING "Or" ; my address is 249
MAKE_LITERAL_STRING "And" ; my address is 260
MAKE_LITERAL_STRING "Seq" ; my address is 272
MAKE_LITERAL_STRING "Define" ; my address is 284
MAKE_LITERAL_STRING "set-car!" ; my address is 299
MAKE_LITERAL_STRING "set-cdr!" ; my address is 316
MAKE_LITERAL_STRING "Set" ; my address is 333
MAKE_LITERAL_STRING "eq?" ; my address is 345
MAKE_LITERAL_STRING "Lambda" ; my address is 357
MAKE_LITERAL_STRING "func" ; my address is 372
MAKE_LITERAL_INT(7) ; my address is 385
MAKE_LITERAL_STRING "a" ; my address is 394
MAKE_LITERAL_STRING "b" ; my address is 404
MAKE_LITERAL_INT(5) ; my address is 414
MAKE_LITERAL_INT(6) ; my address is 423
MAKE_LITERAL_STRING "LambdaOpt" ; my address is 432
MAKE_LITERAL_STRING "*" ; my address is 450
MAKE_LITERAL_STRING "z" ; my address is 460
MAKE_LITERAL_STRING "done!" ; my address is 470
MAKE_LITERAL_INT(0) ; my address is 484
MAKE_LITERAL_STRING "cons" ; my address is 493
MAKE_LITERAL_STRING "+" ; my address is 506
MAKE_LITERAL_STRING "y" ; my address is 516
MAKE_LITERAL_STRING "Applic" ; my address is 526
MAKE_LITERAL_STRING "x" ; my address is 541
MAKE_LITERAL_STRING "Box" ; my address is 551
MAKE_LITERAL_STRING "----------------------" ; my address is 563
MAKE_LITERAL_STRING "*** End of tests ***" ; my address is 594

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
dq T_UNDEFINED ; i'm func, my address is 33
dq T_UNDEFINED ; i'm y, my address is 34
dq T_UNDEFINED ; i'm x, my address is 35

global main
section .text
main:
    push rbp 
    mov rbp, rsp

    ;; set up the heap
    mov rdi, MB(100) ;; TODO: changed from GB(4)
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
	mov rax, const_tbl + 6 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 224 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 37 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 37 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 56 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 56 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 74 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 65 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 121 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 121 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 207 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 207 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 238 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 4 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 4 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse0
	mov rax, const_tbl + 4 ; Const 
	jmp LexitIf0
	Lelse0:
	mov rax, const_tbl + 2 ; Const 
	LexitIf0:
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 2 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse1
	mov rax, const_tbl + 484 ; Const 
	jmp LexitIf1
	Lelse1:
	mov rax, const_tbl + 86 ; Const 
	LexitIf1:
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 484 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 2 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse2
	mov rax, const_tbl + 86 ; Const 
	jmp LexitIf2
	Lelse2:
	mov rax, const_tbl + 2 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse3
	mov rax, const_tbl + 86 ; Const 

	mov rax, const_tbl + 95 ; Const 
	jmp LexitIf3
	Lelse3:
	mov rax, const_tbl + 4 ; Const 

	mov rax, const_tbl + 86 ; Const 

	mov rax, const_tbl + 484 ; Const 
	LexitIf3:
	LexitIf2:
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 249 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 2 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 2 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; Or 
	jne LexitOr4

	mov rax, const_tbl + 2 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; Or 
	jne LexitOr4
	LexitOr4:
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; Or 
	jne LexitOr5

	mov rax, const_tbl + 484 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; Or 
	jne LexitOr5

	mov rax, const_tbl + 95 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; Or 
	jne LexitOr5
	LexitOr5:
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 260 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 86 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse6
	mov rax, const_tbl + 95 ; Const 
	cmp rax, SOB_FALSE_ADDRESS ; If 
	je Lelse7
	mov rax, const_tbl + 138 ; Const 
	jmp LexitIf7
	Lelse7:
	mov rax, const_tbl + 2 ; Const 
	LexitIf7:
	jmp LexitIf6
	Lelse6:
	mov rax, const_tbl + 2 ; Const 
	LexitIf6:
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 272 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple8:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 147 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 138 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 23 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont8:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 284 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 32 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	mov qword [fvar_tbl + 34 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void

	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	mov qword [fvar_tbl + 35 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void

	mov rax, qword [fvar_tbl + 35 * WORD_SIZE] ; VarFree 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 333 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 484 ; Const 
	push rax ; Applic 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 30 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 31 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, qword [fvar_tbl + 34 * WORD_SIZE] ; VarFree 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple9:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	mov rax, 6666 ; begin applic 
	push rax 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple11:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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
	mov rax, const_tbl + 95 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont11:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple10:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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
	mov rax, const_tbl + 95 ; Const 
	mov rbx, qword [rbp + 16] ; VarBound, Set 
	mov rbx, BVARX(0)
	mov BVARX(0), rax
	mov rax, SOB_VOID_ADDRESS

	mov rax, const_tbl + 147 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont10:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont9:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple12:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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
	mov rax, const_tbl + 138 ; Const 
	mov qword PVAR(0), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS

	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont12:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple13:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple14:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode14)
		jmp Lcont14

	Lcode14:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 95 ; Const 
	mov rbx, qword [rbp + 16] ; VarBound, Set 
	mov rbx, BVARX(0)
	mov BVARX(0), rax
	mov rax, SOB_VOID_ADDRESS

	mov rax, qword [rbp + 16] ; Var' or Box' of VarBound 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont14:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont13:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 357 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple15:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode15)
		jmp Lcont15

	Lcode15:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont15:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 21 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple16:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	push rax ; Applic 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont16:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 

	lambdaSimple17:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 2 ; 2 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, PVAR(1) ; Var' or Box' of VarParam 
	push rax ; Applic 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont17:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple18:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple19:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont19:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont18:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple20:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode20)
		jmp Lcont20

	Lcode20:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple21:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode21)
		jmp Lcont21

	Lcode21:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont21:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont20:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple22:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode22)
		jmp Lcont22

	Lcode22:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple24:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode24)
		jmp Lcont24

	Lcode24:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 95 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont24:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple23:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode23)
		jmp Lcont23

	Lcode23:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont23:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont22:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple25:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode25)
		jmp Lcont25

	Lcode25:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple26:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode26)
		jmp Lcont26

	Lcode26:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple27:
	MALLOC r10, 8 * ( 1 + 2) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 2 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode27)
		jmp Lcont27

	Lcode27:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 147 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 138 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont27:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont26:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont25:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 432 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple28:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 2 ; 2 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode28)
		jmp Lcont28

	Lcode28:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 86 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont28:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	lambdaSimple29:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode29)
		jmp Lcont29

	Lcode29:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont29:
	mov qword [fvar_tbl + 33 * WORD_SIZE], rax; Define 
	mov rax, SOB_VOID_ADDRESS
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 33 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 

	lambdaSimple30:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode30)
		jmp Lcont30

	Lcode30:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, PVAR(1) ; Var' or Box' of VarParam 
	push rax ; Applic 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont30:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 147 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 

	lambdaSimple31:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 2 ; 2 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode31)
		jmp Lcont31

	Lcode31:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont31:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 414 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple32:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 2 ; 2 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode32)
		jmp Lcont32

	Lcode32:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont32:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 

	lambdaSimple33:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode33)
		jmp Lcont33

	Lcode33:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	lambdaSimple34:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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
	mov rax, qword [rbp + 16] ; Var' or Box' of VarBound 
	mov rax, BVAR(0)
	mov rax, BVAR(2)
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont34:


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple35:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple36:
	MALLOC r10, 8 * ( 1 + 2) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 2 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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
	mov rax, const_tbl + 423 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont36:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont35:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont33:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 138 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 3 ; parsing of operator below 

	lambdaSimple37:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
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

	lambdaSimple38:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode38)
		jmp Lcont38

	Lcode38:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, qword [rbp + 16] ; Var' or Box' of VarBound 
	mov rax, BVAR(0)
	mov rax, BVAR(2)
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont38:


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple39:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode39)
		jmp Lcont39

	Lcode39:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple40:
	MALLOC r10, 8 * ( 1 + 2) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 2 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode40)
		jmp Lcont40

	Lcode40:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 385 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont40:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont39:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont37:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 138 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 414 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 

	lambdaSimple41:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode41)
		jmp Lcont41

	Lcode41:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov qword PVAR(0), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS

	mov rax, PVAR(1) ; Var' or Box' of VarParam 
	mov qword PVAR(1), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS

	mov rax, PVAR(2) ; Var' or Box' of VarParam 
	mov qword PVAR(2), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS


	lambdaSimple42:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode42)
		jmp Lcont42

	Lcode42:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
	mov rax, qword [rax]
	push rax ; Applic 
	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
	mov rax, qword [rax]
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; VarBound, BoxSet' 
	mov rax, qword [rbp +16]
	mov rax, BVARX(0)
	mov rax, BVARX(0)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS

	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(2)
	mov rax, qword [rax]
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont42:


	lambdaSimple43:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode43)
		jmp Lcont43

	Lcode43:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	lambdaSimple44:
	MALLOC r10, 8 * ( 1 + 2) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 2 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode44)
		jmp Lcont44

	Lcode44:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 414 ; Const 
	push rax ; VarBound, BoxSet' 
	mov rax, qword [rbp +16]
	mov rax, BVARX(1)
	mov rax, BVARX(2)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont44:
	push rax ; VarBound, BoxSet' 
	mov rax, qword [rbp +16]
	mov rax, BVARX(0)
	mov rax, BVARX(1)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont43:


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, PVAR(1) ; VarParam, BoxGet' 
	push rax ; Applic 
	mov rax, PVAR(0) ; VarParam, BoxGet' 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont41:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 147 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 138 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 423 ; Const 
	push rax ; Applic 
	push 3 ; parsing of operator below 

	lambdaSimple45:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode45)
		jmp Lcont45

	Lcode45:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov qword PVAR(0), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS

	mov rax, PVAR(1) ; Var' or Box' of VarParam 
	mov qword PVAR(1), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS

	mov rax, PVAR(2) ; Var' or Box' of VarParam 
	mov qword PVAR(2), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS


	lambdaSimple46:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode46)
		jmp Lcont46

	Lcode46:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
	mov rax, qword [rax]
	push rax ; Applic 
	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
	mov rax, qword [rax]
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; VarBound, BoxSet' 
	mov rax, qword [rbp +16]
	mov rax, BVARX(0)
	mov rax, BVARX(0)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS

	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(2)
	mov rax, qword [rax]
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont46:


	lambdaSimple47:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode47)
		jmp Lcont47

	Lcode47:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	lambdaSimple48:
	MALLOC r10, 8 * ( 1 + 2) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 2 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 3 ; 3 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*3 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode48)
		jmp Lcont48

	Lcode48:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 414 ; Const 
	push rax ; VarBound, BoxSet' 
	mov rax, qword [rbp +16]
	mov rax, BVARX(1)
	mov rax, BVARX(2)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont48:
	push rax ; VarBound, BoxSet' 
	mov rax, qword [rbp +16]
	mov rax, BVARX(0)
	mov rax, BVARX(1)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont47:


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, PVAR(1) ; VarParam, BoxGet' 
	push rax ; Applic 
	mov rax, PVAR(0) ; VarParam, BoxGet' 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont45:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 526 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple49:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode49)
		jmp Lcont49

	Lcode49:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple51:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode51)
		jmp Lcont51

	Lcode51:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 86 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont51:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 

	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple50:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode50)
		jmp Lcont50

	Lcode50:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 95 ; Const 
	mov rbx, qword [rbp + 16] ; VarBound, Set 
	mov rbx, BVARX(0)
	mov BVARX(0), rax
	mov rax, SOB_VOID_ADDRESS

	mov rax, const_tbl + 484 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont50:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont49:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 

	lambdaSimple53:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 2 ; 2 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode53)
		jmp Lcont53

	Lcode53:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, PVAR(1) ; Var' or Box' of VarParam 
	push rax ; Applic 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont53:
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple52:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode52)
		jmp Lcont52

	Lcode52:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 23 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont52:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple54:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 0 ; 0 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*0 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode54)
		jmp Lcont54

	Lcode54:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont54:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 484 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 

	lambdaSimple55:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 2 ; 2 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode55)
		jmp Lcont55

	Lcode55:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 86 ; Const 

	mov rax, const_tbl + 95 ; Const 


	lambdaSimple56:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 2 ; 2 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode56)
		jmp Lcont56

	Lcode56:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 470 ; Const 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont56:
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont55:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 138 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 32 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 32 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 95 ; Const 
	push rax ; Applic 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 2 ; parsing of operator below 

	lambdaSimple57:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 2 ; 2 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*2 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode57)
		jmp Lcont57

	Lcode57:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 

	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, PVAR(1) ; Var' or Box' of VarParam 
	push rax ; Applic 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	push rax ; Applic 
	push 2 ; parsing of operator below 
	mov rax, qword [fvar_tbl + 22 * WORD_SIZE] ; VarFree 
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont57:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 551 ; Const 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple58:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode58)
		jmp Lcont58

	Lcode58:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov qword PVAR(0), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS


	lambdaSimple59:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode59)
		jmp Lcont59

	Lcode59:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, const_tbl + 95 ; Const 
	push rax ; VarBound, BoxSet' 
	mov rax, qword [rbp +16]
	mov rax, BVARX(0)
	mov rax, BVARX(0)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont59:

	mov rax, PVAR(0) ; VarParam, BoxGet' 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont58:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple60:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode60)
		jmp Lcont60

	Lcode60:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov qword PVAR(0), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS

	mov rax, const_tbl + 138 ; Const 
	push rax ; VarParam, BoxSet' 
	mov rax, PVAR(0)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple61:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode61)
		jmp Lcont61

	Lcode61:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
	mov rax, qword [rax]
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont61:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont60:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void


	mov rax, 6666 ; begin applic 
	push rax 
	mov rax, const_tbl + 86 ; Const 
	push rax ; Applic 
	push 1 ; parsing of operator below 

	lambdaSimple62:
	MALLOC r10, 8 * ( 1 + 0) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 0 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode62)
		jmp Lcont62

	Lcode62:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, PVAR(0) ; Var' or Box' of VarParam 
	mov qword PVAR(0), rax ; VarParam, Set 
	mov rax, SOB_VOID_ADDRESS

	mov rax, const_tbl + 147 ; Const 
	push rax ; VarParam, BoxSet' 
	mov rax, PVAR(0)
	pop qword [rax]
	mov rax, SOB_VOID_ADDRESS


	mov rax, 6666 ; begin applic 
	push rax 
	push 0 ; parsing of operator below 

	lambdaSimple63:
	MALLOC r10, 8 * ( 1 + 1) ; Allocate ExtEnv
	mov r11, r10 ; copy of ExtEnv address
	mov r12, 0 ; i
	mov r13, 1 ; |env|
	mov r15, rbp ; copy of rbp

	.copy_env:
		cmp r12, r13
		je .done_copy_env
		add r11, 8
		mov r14, qword[r15 + 16] ; r14 = Env[i]
		mov [r11], r14 ; ExtEnv[j] = r14
		mov r15, qword[r15] ; jmp to next env
		inc r12 ; inc counter of loop
		jmp .copy_env ; back to loop

	.done_copy_env:
		mov r12, 0 ; i
		mov r13, 1 ; 1 arguments
		mov r15, rbp ; r15 = rbp
		add r15, 32 ; r15 = address of first arg
		MALLOC r14, 8*1 ; allocate ExtEnv[0]
		mov r11, r14 ; copy of ExtEnv[0] 

	.copy_params:
		cmp r12, r13
		je .done_copy_params
		mov r9, [r15] ; r9 = Param(i)
		mov [r14], r9 ; ExtEnv [0][i] = r9
		add r14, 8
		add r15, 8
		inc r12
		jmp .copy_params

	.done_copy_params:
		mov [r10], r11
		MAKE_CLOSURE(rax, r10, Lcode63)
		jmp Lcont63

	Lcode63:
	push rbp
	mov rbp , rsp ; parse of lambdaSimple body below: 
	mov rax, qword [rbp + 16] ; VarBound, BoxGet' 
	mov rax, BVAR(0)
	mov rax, BVAR(0)
	mov rax, qword [rax]
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont63:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
	leave ; done parsing lambdaSimple body above 
	ret

	Lcont62:
	mov rbx, [rax + TYPE_SIZE] ; closure's env 
	push rbx ; push env 
	mov rbx, [rax + TYPE_SIZE + WORD_SIZE] ; clousre's code 
	call rbx ; call code 
	add rsp, 8*1 ; pop env 
	pop rbx ; pop arg count 
	inc rbx 
	shl rbx, 3 ; rbx = rbx * 8 
	add rsp, rbx ; pop args 
    call write_sob_if_not_void

	mov rax, const_tbl + 563 ; Const 
    call write_sob_if_not_void

	mov rax, const_tbl + 594 ; Const 
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
    ; jmp .loop ;; due to Yitav comment on facebook
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
