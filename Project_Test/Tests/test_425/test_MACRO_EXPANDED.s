%line 1+1 ./Project_Test/Tests/test_425/test.s



%line 13+1 compiler.s

%line 22+1 compiler.s

%line 25+1 compiler.s

%line 29+1 compiler.s


%line 34+1 compiler.s




%line 41+1 compiler.s










%line 54+1 compiler.s





%line 62+1 compiler.s











%line 78+1 compiler.s











%line 96+1 compiler.s



%line 103+1 compiler.s

%line 110+1 compiler.s

%line 115+1 compiler.s


























%line 154+1 compiler.s





%line 164+1 compiler.s




%line 173+1 compiler.s

%line 177+1 compiler.s




%line 199+1 compiler.s

%line 207+1 compiler.s




%line 229+1 compiler.s

%line 238+1 compiler.s




%line 248+1 compiler.s

%line 254+1 compiler.s

%line 257+1 compiler.s

%line 260+1 compiler.s

%line 263+1 compiler.s

%line 266+1 compiler.s

[extern exit]
%line 267+0 compiler.s
[extern printf]
[extern malloc]
%line 268+1 compiler.s
[global write_sob]
%line 268+0 compiler.s
[global write_sob_if_not_void]
%line 269+1 compiler.s


write_sob_undefined:
 push rbp
 mov rbp, rsp

 mov rax, 0
 mov rdi, .undefined
 call printf

 leave
 ret

[section .data]
.undefined:
 db "#<undefined>", 0

write_sob_integer:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rsi+1]
 mov rdi, .int_format_string
 mov rax, 0
 call printf

 leave
 ret

[section .data]
.int_format_string:
 db "%ld", 0

write_sob_float:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rsi+1]
 movq xmm0, rsi
 mov rdi, .float_format_string
 mov rax, 1
 mov rsi, rsp
 and rsp, -16
 call printf
 mov rsp, rsi

 leave
 ret

[section .data]
.float_format_string:
 db "%f", 0

write_sob_char:
 push rbp
 mov rbp, rsp

 movzx rsi, byte [rsi+1]
 and rsi, 255

 cmp rsi, 0
 je .Lnul

 cmp rsi, 9
 je .Ltab

 cmp rsi, 10
 je .Lnewline

 cmp rsi, 12
 je .Lpage

 cmp rsi, 13
 je .Lreturn

 cmp rsi, 32
 je .Lspace
 jg .Lregular

 mov rdi, .special
 jmp .done

.Lnul:
 mov rdi, .nul
 jmp .done

.Ltab:
 mov rdi, .tab
 jmp .done

.Lnewline:
 mov rdi, .newline
 jmp .done

.Lpage:
 mov rdi, .page
 jmp .done

.Lreturn:
 mov rdi, .return
 jmp .done

.Lspace:
 mov rdi, .space
 jmp .done

.Lregular:
 mov rdi, .regular
 jmp .done

.done:
 mov rax, 0
 call printf

 leave
 ret

[section .data]
.space:
 db "#\space", 0
.newline:
 db "#\newline", 0
.return:
 db "#\return", 0
.tab:
 db "#\tab", 0
.page:
 db "#\page", 0
.nul:
 db "#\nul", 0
.special:
 db "#\x%02x", 0
.regular:
 db "#\%c", 0

write_sob_void:
 push rbp
 mov rbp, rsp

 mov rax, 0
 mov rdi, .void
 call printf

 leave
 ret

[section .data]
.void:
 db "#<void>", 0

write_sob_bool:
 push rbp
 mov rbp, rsp

 cmp word [rsi], word 5
 je .sobFalse

 mov rdi, .true
 jmp .continue

.sobFalse:
 mov rdi, .false

.continue:
 mov rax, 0
 call printf

 leave
 ret

[section .data]
.false:
 db "#f", 0
.true:
 db "#t", 0

write_sob_nil:
 push rbp
 mov rbp, rsp

 mov rax, 0
 mov rdi, .nil
 call printf

 leave
 ret

[section .data]
.nil:
 db "()", 0

write_sob_string:
 push rbp
 mov rbp, rsp

 push rsi

 mov rax, 0
 mov rdi, .double_quote
 call printf

 pop rsi

 mov rcx, qword [rsi+1]
 lea rax, [rsi+1+8]

.loop:
 cmp rcx, 0
 je .done
 mov bl, byte [rax]
 and rbx, 0xff

 cmp rbx, 9
 je .ch_tab
 cmp rbx, 10
 je .ch_newline
 cmp rbx, 12
 je .ch_page
 cmp rbx, 13
 je .ch_return
 cmp rbx, 34
 je .ch_doublequote
 cmp rbx, 92
 je .ch_backslash
 cmp rbx, 32
 jl .ch_hex

 mov rdi, .fs_simple_char
 mov rsi, rbx
 jmp .printf

.ch_hex:
 mov rdi, .fs_hex_char
 mov rsi, rbx
 jmp .printf

.ch_tab:
 mov rdi, .fs_tab
 mov rsi, rbx
 jmp .printf

.ch_page:
 mov rdi, .fs_page
 mov rsi, rbx
 jmp .printf

.ch_return:
 mov rdi, .fs_return
 mov rsi, rbx
 jmp .printf

.ch_newline:
 mov rdi, .fs_newline
 mov rsi, rbx
 jmp .printf

.ch_doublequote:
 mov rdi, .fs_doublequote
 mov rsi, rbx
 jmp .printf

.ch_backslash:
 mov rdi, .fs_backslash
 mov rsi, rbx

.printf:
 push rax
 push rcx
 mov rax, 0
 call printf
 pop rcx
 pop rax

 dec rcx
 inc rax
 jmp .loop

.done:
 mov rax, 0
 mov rdi, .double_quote
 call printf

 leave
 ret
[section .data]
.double_quote:
 db 34, 0
.fs_simple_char:
 db "%c", 0
.fs_hex_char:
 db "\x%02x;", 0
.fs_tab:
 db "\t", 0
.fs_page:
 db "\f", 0
.fs_return:
 db "\r", 0
.fs_newline:
 db "\n", 0
.fs_doublequote:
 db 92, 34, 0
.fs_backslash:
 db 92, 92, 0

write_sob_pair:
 push rbp
 mov rbp, rsp

 push rsi

 mov rax, 0
 mov rdi, .open_paren
 call printf

 mov rsi, [rsp]

 mov rsi, qword [rsi+1]
 call write_sob

 mov rsi, [rsp]
 mov rsi, qword [rsi+1+8]
 call write_sob_pair_on_cdr

 add rsp, 1*8

 mov rdi, .close_paren
 mov rax, 0
 call printf

 leave
 ret

[section .data]
.open_paren:
 db "(", 0
.close_paren:
 db ")", 0

write_sob_pair_on_cdr:
 push rbp
 mov rbp, rsp

 mov bl, byte [rsi]
 cmp bl, 2
 je .done

 cmp bl, 10
 je .cdrIsPair

 push rsi

 mov rax, 0
 mov rdi, .dot
 call printf

 pop rsi

 call write_sob
 jmp .done

.cdrIsPair:
 mov rbx, qword [rsi+1+8]
 push rbx
 mov rsi, qword [rsi+1]
 push rsi

 mov rax, 0
 mov rdi, .space
 call printf

 pop rsi
 call write_sob

 pop rsi
 call write_sob_pair_on_cdr

 add rsp, 1*8

.done:
 leave
 ret

[section .data]
.space:
 db " ", 0
.dot:
 db " . ", 0

write_sob_vector:
 push rbp
 mov rbp, rsp

 push rsi

 mov rax, 0
 mov rdi, .fs_open_vector
 call printf

 pop rsi

 mov rcx, qword [rsi+1]
 cmp rcx, 0
 je .done
 lea rax, [rsi+1+8]

 push rcx
 push rax
 mov rsi, qword [rax]
 call write_sob
 pop rax
 pop rcx
 dec rcx
 add rax, 8

.loop:
 cmp rcx, 0
 je .done

 push rcx
 push rax
 mov rax, 0
 mov rdi, .fs_space
 call printf

 pop rax
 push rax
 mov rsi, qword [rax]
 call write_sob
 pop rax
 pop rcx
 dec rcx
 add rax, 8
 jmp .loop

.done:
 mov rax, 0
 mov rdi, .fs_close_vector
 call printf

 leave
 ret

[section .data]
.fs_open_vector:
 db "#(", 0
.fs_close_vector:
 db ")", 0
.fs_space:
 db " ", 0

write_sob_symbol:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rsi+1]

 mov rcx, qword [rsi+1]
 lea rax, [rsi+1+8]

 mov rdx, rcx

.loop:
 cmp rcx, 0
 je .done
 mov bl, byte [rax]
 and rbx, 0xff

 cmp rcx, rdx
 jne .ch_simple
 cmp rbx, '+'
 je .ch_hex
 cmp rbx, '-'
 je .ch_hex
 cmp rbx, 'A'
 jl .ch_hex

.ch_simple:
 mov rdi, .fs_simple_char
 mov rsi, rbx
 jmp .printf

.ch_hex:
 mov rdi, .fs_hex_char
 mov rsi, rbx

.printf:
 push rax
 push rcx
 mov rax, 0
 call printf
 pop rcx
 pop rax

 dec rcx
 inc rax
 jmp .loop

.done:
 leave
 ret

[section .data]
.fs_simple_char:
 db "%c", 0
.fs_hex_char:
 db "\x%02x;", 0

write_sob_closure:
 push rbp
 mov rbp, rsp

 mov rdx, qword [rsi+1+8]
 mov rsi, qword [rsi+1]

 mov rdi, .closure
 mov rax, 0
 call printf

 leave
 ret
[section .data]
.closure:
 db "#<closure [env:%p, code:%p]>", 0

[section .text]
write_sob:
 mov rbx, 0
 mov bl, byte [rsi]
 jmp qword [.jmp_table + rbx * 8]

[section .data]
.jmp_table:
 dq write_sob_undefined, write_sob_void, write_sob_nil
 dq write_sob_integer, write_sob_float, write_sob_bool
 dq write_sob_char, write_sob_string, write_sob_symbol
 dq write_sob_closure, write_sob_pair, write_sob_vector

[section .text]
write_sob_if_not_void:
 mov rsi, rax
 mov bl, byte [rsi]
 cmp bl, 1
 je .continue

 call write_sob

 mov rax, 0
 mov rdi, .newline
 call printf

.continue:
 ret
[section .data]
.newline:
 db 10, 0
%line 5+1 ./Project_Test/Tests/test_425/test.s

[section .bss]
malloc_pointer:
 resq 1

[section .data]
const_tbl:
db 1
db 2
 db 5
%line 14+0 ./Project_Test/Tests/test_425/test.s
 db 0
%line 15+1 ./Project_Test/Tests/test_425/test.s
 db 5
%line 15+0 ./Project_Test/Tests/test_425/test.s
 db 1
%line 16+1 ./Project_Test/Tests/test_425/test.s
db 7
%line 16+0 ./Project_Test/Tests/test_425/test.s
dq (..@39.end_str - ..@39.str)
..@39.str:
db "apply"
..@39.end_str:
%line 17+1 ./Project_Test/Tests/test_425/test.s
db 7
%line 17+0 ./Project_Test/Tests/test_425/test.s
dq (..@40.end_str - ..@40.str)
..@40.str:
db "x"
..@40.end_str:
%line 18+1 ./Project_Test/Tests/test_425/test.s
 db 10
%line 18+0 ./Project_Test/Tests/test_425/test.s
 dq const_tbl + 1
 dq const_tbl + 1
%line 19+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 19+0 ./Project_Test/Tests/test_425/test.s
 dq 1
%line 20+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 20+0 ./Project_Test/Tests/test_425/test.s
 dq 2
%line 21+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 21+0 ./Project_Test/Tests/test_425/test.s
 dq 3
%line 22+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 22+0 ./Project_Test/Tests/test_425/test.s
 dq 4
%line 23+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 23+0 ./Project_Test/Tests/test_425/test.s
 dq 5
%line 24+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 24+0 ./Project_Test/Tests/test_425/test.s
 dq 6
%line 25+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 25+0 ./Project_Test/Tests/test_425/test.s
 dq 7
%line 26+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 26+0 ./Project_Test/Tests/test_425/test.s
 dq 8
%line 27+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 27+0 ./Project_Test/Tests/test_425/test.s
 dq 9
%line 28+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 28+0 ./Project_Test/Tests/test_425/test.s
 dq 10
%line 29+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 29+0 ./Project_Test/Tests/test_425/test.s
 dq 11
%line 30+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 30+0 ./Project_Test/Tests/test_425/test.s
 dq 12
%line 31+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 31+0 ./Project_Test/Tests/test_425/test.s
 dq 13
%line 32+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 32+0 ./Project_Test/Tests/test_425/test.s
 dq 14
%line 33+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 33+0 ./Project_Test/Tests/test_425/test.s
 dq 15
%line 34+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 34+0 ./Project_Test/Tests/test_425/test.s
 dq 16
%line 35+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 35+0 ./Project_Test/Tests/test_425/test.s
 dq 17
%line 36+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 36+0 ./Project_Test/Tests/test_425/test.s
 dq 18
%line 37+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 37+0 ./Project_Test/Tests/test_425/test.s
 dq 19
%line 38+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 38+0 ./Project_Test/Tests/test_425/test.s
 dq 20
%line 39+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 39+0 ./Project_Test/Tests/test_425/test.s
 dq 21
%line 40+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 40+0 ./Project_Test/Tests/test_425/test.s
 dq 22
%line 41+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 41+0 ./Project_Test/Tests/test_425/test.s
 dq 23
%line 42+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 42+0 ./Project_Test/Tests/test_425/test.s
 dq 24
%line 43+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 43+0 ./Project_Test/Tests/test_425/test.s
 dq 25
%line 44+1 ./Project_Test/Tests/test_425/test.s
 db 3
%line 44+0 ./Project_Test/Tests/test_425/test.s
 dq 26
%line 45+1 ./Project_Test/Tests/test_425/test.s
db 7
%line 45+0 ./Project_Test/Tests/test_425/test.s
dq (..@68.end_str - ..@68.str)
..@68.str:
db "cons"
..@68.end_str:
%line 46+1 ./Project_Test/Tests/test_425/test.s
db 7
%line 46+0 ./Project_Test/Tests/test_425/test.s
dq (..@69.end_str - ..@69.str)
..@69.str:
db "map"
..@69.end_str:
%line 47+1 ./Project_Test/Tests/test_425/test.s



%line 54+1 ./Project_Test/Tests/test_425/test.s

fvar_tbl:
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0
dq 0

[global main]
[section .text]
main:
 push rbp
 mov rbp, rsp


 mov rdi, 1024*500*1024
 call malloc
 mov [malloc_pointer], rax






 push 0
 push qword const_tbl + 1
 push qword 0
 push rsp

 jmp code_fragment

code_fragment:





 add qword [malloc_pointer], 1+8*2
%line 121+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_boolean
%line 122+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 0 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 123+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_float
%line 124+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 1 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 125+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_integer
%line 126+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 2 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 127+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_pair
%line 128+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 3 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 129+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_null
%line 130+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 4 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 131+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_char
%line 132+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 5 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 133+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_vector
%line 134+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 6 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 135+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_string
%line 136+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 7 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 137+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_procedure
%line 138+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 8 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 139+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_symbol
%line 140+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 9 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 141+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_length
%line 142+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 10 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 143+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_ref
%line 144+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 11 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 145+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_set
%line 146+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 12 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 147+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_string
%line 148+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 13 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 149+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_length
%line 150+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 14 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 151+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_ref
%line 152+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 15 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 153+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_set
%line 154+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 16 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 155+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_vector
%line 156+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 17 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 157+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], symbol_to_string
%line 158+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 18 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 159+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], char_to_integer
%line 160+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 19 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 161+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], integer_to_char
%line 162+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 20 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 163+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_eq
%line 164+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 21 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 165+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_add
%line 166+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 22 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 167+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_mul
%line 168+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 23 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 169+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_sub
%line 170+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 24 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 171+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_div
%line 172+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 25 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 173+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_lt
%line 174+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 26 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 175+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_equ
%line 176+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 27 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 177+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], car
%line 178+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 28 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 179+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cdr
%line 180+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 29 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 181+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_car
%line 182+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 30 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 183+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_cdr
%line 184+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 31 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 185+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cons
%line 186+1 ./Project_Test/Tests/test_425/test.s
 mov [fvar_tbl + 32 * 8], rax

user_code:

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 push 0


 lambdaSimple1:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 199+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 200+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 0
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 218+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 219+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 233+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode1
%line 234+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont1

 Lcode1:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, const_tbl + 1
 push rax

 lambdaSimple27:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 321+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 322+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 340+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 341+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 355+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode27
%line 356+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont27

 Lcode27:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 272
 leave
 ret

 Lcont27:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple26:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 384+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 385+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 403+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 404+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 418+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode26
%line 419+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont26

 Lcode26:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 263
 leave
 ret

 Lcont26:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple25:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 447+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 448+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 466+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 467+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 481+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode25
%line 482+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont25

 Lcode25:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 254
 leave
 ret

 Lcont25:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple24:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 510+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 511+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 529+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 530+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 544+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode24
%line 545+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont24

 Lcode24:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 245
 leave
 ret

 Lcont24:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple23:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 573+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 574+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 592+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 593+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 607+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode23
%line 608+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont23

 Lcode23:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 236
 leave
 ret

 Lcont23:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple22:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 636+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 637+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 655+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 656+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 670+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode22
%line 671+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont22

 Lcode22:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 227
 leave
 ret

 Lcont22:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple21:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 699+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 700+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 718+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 719+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 733+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode21
%line 734+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont21

 Lcode21:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 218
 leave
 ret

 Lcont21:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple20:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 762+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 763+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 781+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 782+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 796+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode20
%line 797+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont20

 Lcode20:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 209
 leave
 ret

 Lcont20:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple19:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 825+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 826+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 844+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 845+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 859+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode19
%line 860+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont19

 Lcode19:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 200
 leave
 ret

 Lcont19:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple18:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 888+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 889+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 907+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 908+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 922+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode18
%line 923+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont18

 Lcode18:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 191
 leave
 ret

 Lcont18:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple17:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 951+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 952+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 970+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 971+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 985+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode17
%line 986+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont17

 Lcode17:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 182
 leave
 ret

 Lcont17:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple16:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1014+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1015+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1033+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1034+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1048+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode16
%line 1049+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont16

 Lcode16:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 173
 leave
 ret

 Lcont16:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple15:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1077+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1078+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1096+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1097+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1111+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode15
%line 1112+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont15

 Lcode15:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 164
 leave
 ret

 Lcont15:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple14:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1140+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1141+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1159+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1160+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1174+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode14
%line 1175+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont14

 Lcode14:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 155
 leave
 ret

 Lcont14:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple13:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1203+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1204+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1222+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1223+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1237+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode13
%line 1238+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont13

 Lcode13:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 146
 leave
 ret

 Lcont13:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple12:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1266+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1267+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1285+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1286+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1300+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode12
%line 1301+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont12

 Lcode12:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 137
 leave
 ret

 Lcont12:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple11:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1329+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1330+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1348+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1349+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1363+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode11
%line 1364+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont11

 Lcode11:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 128
 leave
 ret

 Lcont11:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple10:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1392+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1393+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1411+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1412+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1426+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode10
%line 1427+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont10

 Lcode10:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 119
 leave
 ret

 Lcont10:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple9:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1455+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1456+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1474+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1475+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1489+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode9
%line 1490+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont9

 Lcode9:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 110
 leave
 ret

 Lcont9:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple8:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1518+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1519+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1537+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1538+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1552+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode8
%line 1553+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont8

 Lcode8:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 101
 leave
 ret

 Lcont8:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple7:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1581+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1582+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1600+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1601+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1615+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode7
%line 1616+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont7

 Lcode7:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 92
 leave
 ret

 Lcont7:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple6:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1644+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1645+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1663+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1664+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1678+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode6
%line 1679+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont6

 Lcode6:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 83
 leave
 ret

 Lcont6:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple5:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1707+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1708+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1726+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1727+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1741+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode5
%line 1742+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont5

 Lcode5:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 74
 leave
 ret

 Lcont5:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple4:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1770+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1771+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1789+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1790+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1804+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode4
%line 1805+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont4

 Lcode4:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 65
 leave
 ret

 Lcont4:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple3:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1833+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1834+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*1
%line 1852+0 ./Project_Test/Tests/test_425/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1853+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 1
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1867+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode3
%line 1868+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont3

 Lcode3:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 56
 leave
 ret

 Lcont3:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple2:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1896+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1897+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 1
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*0
%line 1915+0 ./Project_Test/Tests/test_425/test.s
 push 8*0
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1916+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 0
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 1930+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode2
%line 1931+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont2

 Lcode2:
 push rbp
 mov rbp , rsp
 mov rax, const_tbl + 47
 leave
 ret

 Lcont2:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 32 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 leave
 ret

 Lcont1:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 lambdaSimple0:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1974+0 ./Project_Test/Tests/test_425/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1975+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 0
 je .done_copy_env
 mov r14, qword[r15 + 8 * r12]
 mov [r11 + 8 * r13], r14
 inc r12
 inc r13
 jmp .copy_env

 .done_copy_env:
 mov r12, 0
 mov r15, rbp
 add r15, 32
 add qword [malloc_pointer], 8*0
%line 1993+0 ./Project_Test/Tests/test_425/test.s
 push 8*0
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1994+1 ./Project_Test/Tests/test_425/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 0
 je .done_copy_params
 mov r9, [r15]
 mov [r14], r9
 add r14, 8
 add r15, 8
 inc r12
 jmp .copy_params

 .done_copy_params:
 mov [r10], r11
 add qword [malloc_pointer], 1+8*2
%line 2008+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode0
%line 2009+1 ./Project_Test/Tests/test_425/test.s
 jmp Lcont0

 Lcode0:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, const_tbl + 30
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 2

 mov rax, qword [fvar_tbl + 34 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 leave
 ret

 Lcont0:
 push rax
 push 2

 mov rax, qword [fvar_tbl + 33 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 call write_sob_if_not_void
 add rsp, 4*8
 pop rbp
 ret


is_boolean:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 5
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_float:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 4
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_integer:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 3
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_pair:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 10
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_null:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 2
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_char:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 6
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_vector:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 11
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_string:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 7
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_procedure:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 9
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

is_symbol:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov sil, byte [rsi]

 cmp sil, 8
 jne .wrong_type
 mov rax, const_tbl + 4
 jmp .return

.wrong_type:
 mov rax, const_tbl + 2
.return:
 leave
 ret

string_length:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 add qword [malloc_pointer], 1+8
%line 2247+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2248+1 ./Project_Test/Tests/test_425/test.s

 leave
 ret

string_ref:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 lea rsi, [rsi+1+8]
 mov rdi, qword [rbp+(4+1)*8]
 mov rdi, qword [rdi+1]
 shl rdi, 0
 add rsi, rdi

 mov sil, byte [rsi]
 add qword [malloc_pointer], 1+1
%line 2264+0 ./Project_Test/Tests/test_425/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 2265+1 ./Project_Test/Tests/test_425/test.s

 leave
 ret

string_set:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 lea rsi, [rsi+1+8]
 mov rdi, qword [rbp+(4+1)*8]
 mov rdi, qword [rdi+1]
 shl rdi, 0
 add rsi, rdi

 mov rax, qword [rbp+(4+2)*8]
 movzx rax, byte [rax+1]
 mov byte [rsi], al
 mov rax, const_tbl + 0

 leave
 ret

make_string:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 mov rdi, qword [rbp+(4+1)*8]
 movzx rdi, byte [rdi+1]
 and rdi, 255

 lea rax, [rsi+8+1]
%line 2299+0 ./Project_Test/Tests/test_425/test.s
 add qword [malloc_pointer], rax
 push rax
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 7
 mov qword [rax+1], rsi
 push rcx
 add rax,8+1
 mov rcx, rsi
 cmp rcx, 0
..@262.str_loop:
 jz ..@262.str_loop_end
 dec rcx
 mov byte [rax+rcx], dil
 jmp ..@262.str_loop
..@262.str_loop_end:
 pop rcx
 sub rax, 8+1
%line 2300+1 ./Project_Test/Tests/test_425/test.s

 leave
 ret

vector_length:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 add qword [malloc_pointer], 1+8
%line 2310+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2311+1 ./Project_Test/Tests/test_425/test.s

 leave
 ret

vector_ref:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 lea rsi, [rsi+1+8]
 mov rdi, qword [rbp+(4+1)*8]
 mov rdi, qword [rdi+1]
 shl rdi, 3
 add rsi, rdi

 mov rax, [rsi]

 leave
 ret

vector_set:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 lea rsi, [rsi+1+8]
 mov rdi, qword [rbp+(4+1)*8]
 mov rdi, qword [rdi+1]
 shl rdi, 3
 add rsi, rdi

 mov rdi, qword [rbp+(4+2)*8]
 mov [rsi], rdi
 mov rax, const_tbl + 0

 leave
 ret

make_vector:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 mov rdi, qword [rbp+(4+1)*8]


 lea rax, [rsi*8+8+1]
%line 2359+0 ./Project_Test/Tests/test_425/test.s
 add qword [malloc_pointer], rax
 push rax
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 11
 mov qword [rax+1], rsi
 push rcx
 add rax, 8+1
 mov rcx, rsi
 cmp rcx, 0
..@272.vec_loop:
 jz ..@272.vec_loop_end
 dec rcx
 mov qword [rax+rcx*8], rdi
 jmp ..@272.vec_loop
..@272.vec_loop_end:
 sub rax, 8+1
 pop rcx
%line 2360+1 ./Project_Test/Tests/test_425/test.s

 leave
 ret

symbol_to_string:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]

 mov rcx, qword [rsi+1]
 lea rdi, [rsi+1+8]

 push rcx
 push rdi

 mov dil, byte [rdi]
 add qword [malloc_pointer], 1+1
%line 2379+0 ./Project_Test/Tests/test_425/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], dil
%line 2380+1 ./Project_Test/Tests/test_425/test.s
 push rax
 add qword [malloc_pointer], 1+8
%line 2381+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rcx
%line 2382+1 ./Project_Test/Tests/test_425/test.s
 push rax
 push 2
 push const_tbl + 1
 call make_string
 add rsp, 4*8

 lea rsi, [rax+1+8]

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
 jmp .loop
.end:

 leave
 ret

char_to_integer:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 movzx rsi, byte [rsi+1]
 and rsi, 255
 add qword [malloc_pointer], 1+8
%line 2417+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2418+1 ./Project_Test/Tests/test_425/test.s

 leave
 ret

integer_to_char:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 and rsi, 255
 add qword [malloc_pointer], 1+1
%line 2430+0 ./Project_Test/Tests/test_425/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 2431+1 ./Project_Test/Tests/test_425/test.s

 leave
 ret

is_eq:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rdi, qword [rbp+(4+1)*8]
 cmp rsi, rdi
 je .true
 mov rax, const_tbl + 2
 jmp .return

.true:
 mov rax, const_tbl + 4

.return:
 leave
 ret

bin_add:
 push rbp
 mov rbp, rsp

 mov r8, 0

 mov rsi, qword [rbp+(4+0)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .test_next
 or r8, 1

.test_next:

 mov rsi, qword [rbp+(4+1)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .load_numbers
 or r8, 2

.load_numbers:
 push r8

 shr r8, 1
 jc .first_arg_int
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 movq xmm0, rsi
 jmp .load_next_float

.first_arg_int:
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm0, rsi

.load_next_float:
 shr r8, 1
 jc .second_arg_int
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 movq xmm1, rsi
 jmp .perform_float_op

.second_arg_int:
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm1, rsi

.perform_float_op:
 addsd xmm0, xmm1

 pop r8
 cmp r8, 0
 je .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2522+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2523+1 ./Project_Test/Tests/test_425/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2527+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2528+1 ./Project_Test/Tests/test_425/test.s

.return:

 leave
 ret

bin_mul:
 push rbp
 mov rbp, rsp

 mov r8, 0

 mov rsi, qword [rbp+(4+0)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .test_next
 or r8, 1

.test_next:

 mov rsi, qword [rbp+(4+1)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .load_numbers
 or r8, 2

.load_numbers:
 push r8

 shr r8, 1
 jc .first_arg_int
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 movq xmm0, rsi
 jmp .load_next_float

.first_arg_int:
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm0, rsi

.load_next_float:
 shr r8, 1
 jc .second_arg_int
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 movq xmm1, rsi
 jmp .perform_float_op

.second_arg_int:
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm1, rsi

.perform_float_op:
 mulsd xmm0, xmm1

 pop r8
 cmp r8, 0
 je .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2602+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2603+1 ./Project_Test/Tests/test_425/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2607+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2608+1 ./Project_Test/Tests/test_425/test.s

.return:

 leave
 ret

bin_sub:
 push rbp
 mov rbp, rsp

 mov r8, 0

 mov rsi, qword [rbp+(4+0)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .test_next
 or r8, 1

.test_next:

 mov rsi, qword [rbp+(4+1)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .load_numbers
 or r8, 2

.load_numbers:
 push r8

 shr r8, 1
 jc .first_arg_int
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 movq xmm0, rsi
 jmp .load_next_float

.first_arg_int:
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm0, rsi

.load_next_float:
 shr r8, 1
 jc .second_arg_int
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 movq xmm1, rsi
 jmp .perform_float_op

.second_arg_int:
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm1, rsi

.perform_float_op:
 subsd xmm0, xmm1

 pop r8
 cmp r8, 0
 je .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2682+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2683+1 ./Project_Test/Tests/test_425/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2687+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2688+1 ./Project_Test/Tests/test_425/test.s

.return:

 leave
 ret

bin_div:
 push rbp
 mov rbp, rsp

 mov r8, 0

 mov rsi, qword [rbp+(4+0)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .test_next
 or r8, 1

.test_next:

 mov rsi, qword [rbp+(4+1)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .load_numbers
 or r8, 2

.load_numbers:
 push r8

 shr r8, 1
 jc .first_arg_int
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 movq xmm0, rsi
 jmp .load_next_float

.first_arg_int:
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm0, rsi

.load_next_float:
 shr r8, 1
 jc .second_arg_int
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 movq xmm1, rsi
 jmp .perform_float_op

.second_arg_int:
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm1, rsi

.perform_float_op:
 divsd xmm0, xmm1

 pop r8
 cmp r8, 0
 je .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2762+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2763+1 ./Project_Test/Tests/test_425/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2767+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2768+1 ./Project_Test/Tests/test_425/test.s

.return:

 leave
 ret

bin_lt:
 push rbp
 mov rbp, rsp

 mov r8, 0

 mov rsi, qword [rbp+(4+0)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .test_next
 or r8, 1

.test_next:

 mov rsi, qword [rbp+(4+1)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .load_numbers
 or r8, 2

.load_numbers:
 push r8

 shr r8, 1
 jc .first_arg_int
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 movq xmm0, rsi
 jmp .load_next_float

.first_arg_int:
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm0, rsi

.load_next_float:
 shr r8, 1
 jc .second_arg_int
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 movq xmm1, rsi
 jmp .perform_float_op

.second_arg_int:
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm1, rsi

.perform_float_op:
 cmpltsd xmm0, xmm1

 pop r8
 cmp r8, 0
 je .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2842+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2843+1 ./Project_Test/Tests/test_425/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2847+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2848+1 ./Project_Test/Tests/test_425/test.s

.return:

 mov rsi, qword [rax+1]
 cmp rsi, 0
 je .return_false
 mov rax, const_tbl + 4
 jmp .final_return

.return_false:
 mov rax, const_tbl + 2

.final_return:


 leave
 ret

bin_equ:
 push rbp
 mov rbp, rsp

 mov r8, 0

 mov rsi, qword [rbp+(4+0)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .test_next
 or r8, 1

.test_next:

 mov rsi, qword [rbp+(4+1)*8]
 push rsi
 push 1
 push const_tbl + 1
 call is_float
 add rsp, 3*8


 cmp rax, const_tbl + 4
 je .load_numbers
 or r8, 2

.load_numbers:
 push r8

 shr r8, 1
 jc .first_arg_int
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 movq xmm0, rsi
 jmp .load_next_float

.first_arg_int:
 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm0, rsi

.load_next_float:
 shr r8, 1
 jc .second_arg_int
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 movq xmm1, rsi
 jmp .perform_float_op

.second_arg_int:
 mov rsi, qword [rbp+(4+1)*8]
 mov rsi, qword [rsi+1]
 cvtsi2sd xmm1, rsi

.perform_float_op:
 cmpeqsd xmm0, xmm1

 pop r8
 cmp r8, 0
 je .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2934+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2935+1 ./Project_Test/Tests/test_425/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2939+0 ./Project_Test/Tests/test_425/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2940+1 ./Project_Test/Tests/test_425/test.s

.return:

 mov rsi, qword [rax+1]
 cmp rsi, 0
 je .return_false
 mov rax, const_tbl + 4
 jmp .final_return

.return_false:
 mov rax, const_tbl + 2

.final_return:


 leave
 ret



car:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rax, qword [rsi+1]
 jmp .return

.return:
 leave
 ret

cdr:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rax, qword [rsi+1+8]
 jmp .return

.return:
 leave
 ret

set_car:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+1)*8]
 mov r8, qword [rbp+(4+0)*8]
 add r8, 1
 mov [r8], rsi
 mov r9, qword [r8]

 mov rax, const_tbl + 0
 jmp .return

.return:
 leave
 ret

set_cdr:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+1)*8]
 mov r8, qword [rbp+(4+0)*8]
 add r8, 9
 mov [r8], rsi
 mov r9, qword [r8]

 mov rax, const_tbl + 0
 jmp .return

.return:
 leave
 ret

cons:
 push rbp
 mov rbp, rsp

 mov r8, qword [rbp+(4+0)*8]
 mov r9, qword [rbp+(4+1)*8]
 add qword [malloc_pointer], 1+8*2
%line 3024+0 ./Project_Test/Tests/test_425/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 3025+1 ./Project_Test/Tests/test_425/test.s

 jmp .return

.return:
 leave
 ret
