%line 1+1 ./Project_Test/Tests/test_391/test.s



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
%line 5+1 ./Project_Test/Tests/test_391/test.s

[section .bss]
malloc_pointer:
 resq 1

[section .data]
const_tbl:
db 1
db 2
 db 5
%line 14+0 ./Project_Test/Tests/test_391/test.s
 db 0
%line 15+1 ./Project_Test/Tests/test_391/test.s
 db 5
%line 15+0 ./Project_Test/Tests/test_391/test.s
 db 1
%line 16+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 16+0 ./Project_Test/Tests/test_391/test.s
dq (..@39.end_str - ..@39.str)
..@39.str:
db "caaar"
..@39.end_str:
%line 17+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 17+0 ./Project_Test/Tests/test_391/test.s
dq (..@40.end_str - ..@40.str)
..@40.str:
db "caadr"
..@40.end_str:
%line 18+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 18+0 ./Project_Test/Tests/test_391/test.s
dq (..@41.end_str - ..@41.str)
..@41.str:
db "caar"
..@41.end_str:
%line 19+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 19+0 ./Project_Test/Tests/test_391/test.s
dq (..@42.end_str - ..@42.str)
..@42.str:
db "cdaar"
..@42.end_str:
%line 20+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 20+0 ./Project_Test/Tests/test_391/test.s
dq (..@43.end_str - ..@43.str)
..@43.str:
db "cadr"
..@43.end_str:
%line 21+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 21+0 ./Project_Test/Tests/test_391/test.s
dq (..@44.end_str - ..@44.str)
..@44.str:
db "cdadr"
..@44.end_str:
%line 22+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 22+0 ./Project_Test/Tests/test_391/test.s
dq (..@45.end_str - ..@45.str)
..@45.str:
db "cdar"
..@45.end_str:
%line 23+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 23+0 ./Project_Test/Tests/test_391/test.s
dq (..@46.end_str - ..@46.str)
..@46.str:
db "cddar"
..@46.end_str:
%line 24+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 24+0 ./Project_Test/Tests/test_391/test.s
dq (..@47.end_str - ..@47.str)
..@47.str:
db "cddr"
..@47.end_str:
%line 25+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 25+0 ./Project_Test/Tests/test_391/test.s
dq (..@48.end_str - ..@48.str)
..@48.str:
db "pair"
..@48.end_str:
%line 26+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 26+0 ./Project_Test/Tests/test_391/test.s
dq (..@49.end_str - ..@49.str)
..@49.str:
db "cdddr"
..@49.end_str:
%line 27+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 27+0 ./Project_Test/Tests/test_391/test.s
dq (..@50.end_str - ..@50.str)
..@50.str:
db "f"
..@50.end_str:
%line 28+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 28+0 ./Project_Test/Tests/test_391/test.s
dq (..@51.end_str - ..@51.str)
..@51.str:
db "null?"
..@51.end_str:
%line 29+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 29+0 ./Project_Test/Tests/test_391/test.s
 dq 1
%line 30+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 30+0 ./Project_Test/Tests/test_391/test.s
dq (..@53.end_str - ..@53.str)
..@53.str:
db "="
..@53.end_str:
%line 31+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 31+0 ./Project_Test/Tests/test_391/test.s
dq (..@54.end_str - ..@54.str)
..@54.str:
db "break"
..@54.end_str:
%line 32+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 32+0 ./Project_Test/Tests/test_391/test.s
 dq 0
%line 33+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 33+0 ./Project_Test/Tests/test_391/test.s
dq (..@56.end_str - ..@56.str)
..@56.str:
db "cdr"
..@56.end_str:
%line 34+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 34+0 ./Project_Test/Tests/test_391/test.s
dq (..@57.end_str - ..@57.str)
..@57.str:
db "car"
..@57.end_str:
%line 35+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 35+0 ./Project_Test/Tests/test_391/test.s
dq (..@58.end_str - ..@58.str)
..@58.str:
db "*"
..@58.end_str:
%line 36+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 36+0 ./Project_Test/Tests/test_391/test.s
dq (..@59.end_str - ..@59.str)
..@59.str:
db "ls"
..@59.end_str:
%line 37+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 37+0 ./Project_Test/Tests/test_391/test.s
dq (..@60.end_str - ..@60.str)
..@60.str:
db "whatever"
..@60.end_str:
%line 38+1 ./Project_Test/Tests/test_391/test.s
db 8
%line 38+0 ./Project_Test/Tests/test_391/test.s
dq (const_tbl + 266)
%line 39+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 39+0 ./Project_Test/Tests/test_391/test.s
dq (..@62.end_str - ..@62.str)
..@62.str:
db "k"
..@62.end_str:
%line 40+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 40+0 ./Project_Test/Tests/test_391/test.s
 dq 2
%line 41+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 41+0 ./Project_Test/Tests/test_391/test.s
 dq 3
%line 42+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 42+0 ./Project_Test/Tests/test_391/test.s
 dq 4
%line 43+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 43+0 ./Project_Test/Tests/test_391/test.s
 dq 5
%line 44+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 44+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 329
 dq const_tbl + 1
%line 45+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 45+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 320
 dq const_tbl + 338
%line 46+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 46+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 311
 dq const_tbl + 355
%line 47+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 47+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 302
 dq const_tbl + 372
%line 48+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 48+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 179
 dq const_tbl + 389
%line 49+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 49+0 ./Project_Test/Tests/test_391/test.s
 dq 7
%line 50+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 50+0 ./Project_Test/Tests/test_391/test.s
 dq 8
%line 51+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 51+0 ./Project_Test/Tests/test_391/test.s
 dq 9
%line 52+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 52+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 441
 dq const_tbl + 338
%line 53+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 53+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 179
 dq const_tbl + 450
%line 54+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 54+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 212
 dq const_tbl + 467
%line 55+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 55+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 432
 dq const_tbl + 484
%line 56+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 56+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 311
 dq const_tbl + 501
%line 57+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 57+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 423
 dq const_tbl + 518
%line 58+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 58+0 ./Project_Test/Tests/test_391/test.s
dq (..@81.end_str - ..@81.str)
..@81.str:
db "product$"
..@81.end_str:
%line 59+1 ./Project_Test/Tests/test_391/test.s
db 7
%line 59+0 ./Project_Test/Tests/test_391/test.s
dq (..@82.end_str - ..@82.str)
..@82.str:
db "x"
..@82.end_str:
%line 60+1 ./Project_Test/Tests/test_391/test.s
 db 3
%line 60+0 ./Project_Test/Tests/test_391/test.s
 dq 912
%line 61+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 61+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 579
 dq const_tbl + 338
%line 62+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 62+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 179
 dq const_tbl + 588
%line 63+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 63+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 179
 dq const_tbl + 605
%line 64+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 64+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 432
 dq const_tbl + 622
%line 65+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 65+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 311
 dq const_tbl + 639
%line 66+1 ./Project_Test/Tests/test_391/test.s
 db 10
%line 66+0 ./Project_Test/Tests/test_391/test.s
 dq const_tbl + 423
 dq const_tbl + 656
%line 67+1 ./Project_Test/Tests/test_391/test.s



%line 74+1 ./Project_Test/Tests/test_391/test.s

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
%line 150+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_boolean
%line 151+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 0 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 152+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_float
%line 153+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 1 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 154+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_integer
%line 155+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 2 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 156+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_pair
%line 157+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 3 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 158+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_null
%line 159+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 4 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 160+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_char
%line 161+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 5 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 162+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_vector
%line 163+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 6 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 164+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_string
%line 165+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 7 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 166+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_procedure
%line 167+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 8 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 168+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_symbol
%line 169+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 9 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 170+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_length
%line 171+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 10 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 172+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_ref
%line 173+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 11 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 174+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_set
%line 175+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 12 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 176+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_string
%line 177+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 13 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 178+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_length
%line 179+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 14 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 180+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_ref
%line 181+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 15 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 182+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_set
%line 183+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 16 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 184+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_vector
%line 185+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 17 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 186+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], symbol_to_string
%line 187+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 18 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 188+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], char_to_integer
%line 189+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 19 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 190+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], integer_to_char
%line 191+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 20 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 192+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_eq
%line 193+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 21 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 194+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_add
%line 195+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 22 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 196+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_mul
%line 197+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 23 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 198+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_sub
%line 199+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 24 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 200+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_div
%line 201+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 25 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 202+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_lt
%line 203+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 26 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 204+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_equ
%line 205+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 27 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 206+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], car
%line 207+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 28 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 208+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cdr
%line 209+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 29 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 210+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_car
%line 211+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 30 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 212+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_cdr
%line 213+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 31 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 214+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cons
%line 215+1 ./Project_Test/Tests/test_391/test.s
 mov [fvar_tbl + 32 * 8], rax

user_code:

 lambdaSimple0:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 220+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 221+1 ./Project_Test/Tests/test_391/test.s
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
%line 239+0 ./Project_Test/Tests/test_391/test.s
 push 8*0
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 240+1 ./Project_Test/Tests/test_391/test.s
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
%line 254+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode0
%line 255+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont0

 Lcode0:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 28 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 28 * 8]

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
 mov qword [fvar_tbl + 43 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple1:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 308+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 309+1 ./Project_Test/Tests/test_391/test.s
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
%line 327+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 328+1 ./Project_Test/Tests/test_391/test.s
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
%line 342+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode1
%line 343+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont1

 Lcode1:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 28 * 8]

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
 mov qword [fvar_tbl + 42 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple2:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 396+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 397+1 ./Project_Test/Tests/test_391/test.s
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
%line 415+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 416+1 ./Project_Test/Tests/test_391/test.s
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
%line 430+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode2
%line 431+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont2

 Lcode2:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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

 Lcont2:
 mov qword [fvar_tbl + 41 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple3:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 484+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 485+1 ./Project_Test/Tests/test_391/test.s
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
%line 503+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 504+1 ./Project_Test/Tests/test_391/test.s
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
%line 518+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode3
%line 519+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont3

 Lcode3:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 28 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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

 Lcont3:
 mov qword [fvar_tbl + 40 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple4:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 572+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 573+1 ./Project_Test/Tests/test_391/test.s
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
%line 591+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 592+1 ./Project_Test/Tests/test_391/test.s
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
%line 606+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode4
%line 607+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont4

 Lcode4:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 43 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 28 * 8]

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

 Lcont4:
 mov qword [fvar_tbl + 39 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple5:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 660+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 661+1 ./Project_Test/Tests/test_391/test.s
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
%line 679+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 680+1 ./Project_Test/Tests/test_391/test.s
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
%line 694+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode5
%line 695+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont5

 Lcode5:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 28 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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

 Lcont5:
 mov qword [fvar_tbl + 38 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple6:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 748+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 749+1 ./Project_Test/Tests/test_391/test.s
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
%line 767+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 768+1 ./Project_Test/Tests/test_391/test.s
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
%line 782+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode6
%line 783+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont6

 Lcode6:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 43 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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

 Lcont6:
 mov qword [fvar_tbl + 37 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple7:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 836+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 837+1 ./Project_Test/Tests/test_391/test.s
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
%line 855+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 856+1 ./Project_Test/Tests/test_391/test.s
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
%line 870+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode7
%line 871+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont7

 Lcode7:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 42 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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

 Lcont7:
 mov qword [fvar_tbl + 36 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple8:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 924+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 925+1 ./Project_Test/Tests/test_391/test.s
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
%line 943+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 944+1 ./Project_Test/Tests/test_391/test.s
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
%line 958+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode8
%line 959+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont8

 Lcode8:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 40 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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

 Lcont8:
 mov qword [fvar_tbl + 35 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple9:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1012+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1013+1 ./Project_Test/Tests/test_391/test.s
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
%line 1031+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1032+1 ./Project_Test/Tests/test_391/test.s
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
%line 1046+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode9
%line 1047+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont9

 Lcode9:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 41 * 8]

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
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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

 Lcont9:
 mov qword [fvar_tbl + 34 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple10:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1100+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1101+1 ./Project_Test/Tests/test_391/test.s
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
%line 1119+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1120+1 ./Project_Test/Tests/test_391/test.s
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
%line 1134+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode10
%line 1135+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont10

 Lcode10:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 mov r15, 7777
 push rax
 push 1


 lambdaSimple11:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1150+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1151+1 ./Project_Test/Tests/test_391/test.s
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
 add qword [malloc_pointer], 8*2
%line 1169+0 ./Project_Test/Tests/test_391/test.s
 push 8*2
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1170+1 ./Project_Test/Tests/test_391/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 2
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
%line 1184+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode11
%line 1185+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont11

 Lcode11:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, const_tbl + 283
 push rax
 push 1


 lambdaSimple12:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 1199+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1200+1 ./Project_Test/Tests/test_391/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 2
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
%line 1218+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1219+1 ./Project_Test/Tests/test_391/test.s
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
%line 1233+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode12
%line 1234+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont12

 Lcode12:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


 lambdaSimple13:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 1246+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1247+1 ./Project_Test/Tests/test_391/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 3
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
%line 1265+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1266+1 ./Project_Test/Tests/test_391/test.s
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
%line 1280+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode13
%line 1281+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont13

 Lcode13:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 4 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse14

 mov rax, 6666
 push rax
 mov rax, const_tbl + 179
 push rax
 push 1

 mov rax, qword [rbp+(4+1)*8]
 mov r15, 7777

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 jmp LexitIf14
 Lelse14:

 mov rax, 6666
 push rax
 mov rax, const_tbl + 212
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 28 * 8]

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
 push 2

 mov rax, qword [fvar_tbl + 27 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse15

 mov rax, 6666
 push rax
 mov rax, const_tbl + 212
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 jmp LexitIf15
 Lelse15:

 mov rax, 6666
 push rax

 lambdaSimple16:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 1400+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1401+1 ./Project_Test/Tests/test_391/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 4
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
 add qword [malloc_pointer], 8*2
%line 1419+0 ./Project_Test/Tests/test_391/test.s
 push 8*2
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1420+1 ./Project_Test/Tests/test_391/test.s
 mov r11, r14

 .copy_params:
 cmp r12, 2
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
%line 1434+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode16
%line 1435+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont16

 Lcode16:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1

 mov rax, qword [fvar_tbl + 28 * 8]

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
 push 2

 mov rax, qword [fvar_tbl + 23 * 8]

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
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]

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

 Lcont16:
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [fvar_tbl + 29 * 8]

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
 push 2

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 LexitIf15:
 LexitIf14:
 leave
 ret

 Lcont13:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 push rax
 push 2

 mov rax, qword [rbp+(4+0)*8]

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

 Lcont12:

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

 Lcont11:

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

 Lcont10:
 mov qword [fvar_tbl + 33 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax

 lambdaSimple17:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1624+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1625+1 ./Project_Test/Tests/test_391/test.s
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
%line 1643+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1644+1 ./Project_Test/Tests/test_391/test.s
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
%line 1658+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode17
%line 1659+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont17

 Lcode17:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont17:
 push rax
 mov rax, const_tbl + 406
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


 mov rax, 6666
 push rax

 lambdaSimple18:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1694+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1695+1 ./Project_Test/Tests/test_391/test.s
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
%line 1713+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1714+1 ./Project_Test/Tests/test_391/test.s
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
%line 1728+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode18
%line 1729+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont18

 Lcode18:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont18:
 push rax
 mov rax, const_tbl + 535
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


 mov rax, 6666
 push rax

 lambdaSimple19:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1764+0 ./Project_Test/Tests/test_391/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1765+1 ./Project_Test/Tests/test_391/test.s
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
%line 1783+0 ./Project_Test/Tests/test_391/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1784+1 ./Project_Test/Tests/test_391/test.s
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
%line 1798+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode19
%line 1799+1 ./Project_Test/Tests/test_391/test.s
 jmp Lcont19

 Lcode19:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont19:
 push rax
 mov rax, const_tbl + 673
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
%line 2019+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2020+1 ./Project_Test/Tests/test_391/test.s

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
%line 2036+0 ./Project_Test/Tests/test_391/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 2037+1 ./Project_Test/Tests/test_391/test.s

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
%line 2071+0 ./Project_Test/Tests/test_391/test.s
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
..@242.str_loop:
 jz ..@242.str_loop_end
 dec rcx
 mov byte [rax+rcx], dil
 jmp ..@242.str_loop
..@242.str_loop_end:
 pop rcx
 sub rax, 8+1
%line 2072+1 ./Project_Test/Tests/test_391/test.s

 leave
 ret

vector_length:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 add qword [malloc_pointer], 1+8
%line 2082+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2083+1 ./Project_Test/Tests/test_391/test.s

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
%line 2131+0 ./Project_Test/Tests/test_391/test.s
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
..@252.vec_loop:
 jz ..@252.vec_loop_end
 dec rcx
 mov qword [rax+rcx*8], rdi
 jmp ..@252.vec_loop
..@252.vec_loop_end:
 sub rax, 8+1
 pop rcx
%line 2132+1 ./Project_Test/Tests/test_391/test.s

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
%line 2151+0 ./Project_Test/Tests/test_391/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], dil
%line 2152+1 ./Project_Test/Tests/test_391/test.s
 push rax
 add qword [malloc_pointer], 1+8
%line 2153+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rcx
%line 2154+1 ./Project_Test/Tests/test_391/test.s
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
%line 2189+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2190+1 ./Project_Test/Tests/test_391/test.s

 leave
 ret

integer_to_char:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 and rsi, 255
 add qword [malloc_pointer], 1+1
%line 2202+0 ./Project_Test/Tests/test_391/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 2203+1 ./Project_Test/Tests/test_391/test.s

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
%line 2294+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2295+1 ./Project_Test/Tests/test_391/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2299+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2300+1 ./Project_Test/Tests/test_391/test.s

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
%line 2374+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2375+1 ./Project_Test/Tests/test_391/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2379+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2380+1 ./Project_Test/Tests/test_391/test.s

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
%line 2454+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2455+1 ./Project_Test/Tests/test_391/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2459+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2460+1 ./Project_Test/Tests/test_391/test.s

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
%line 2534+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2535+1 ./Project_Test/Tests/test_391/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2539+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2540+1 ./Project_Test/Tests/test_391/test.s

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
%line 2614+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2615+1 ./Project_Test/Tests/test_391/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2619+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2620+1 ./Project_Test/Tests/test_391/test.s

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
%line 2706+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 2707+1 ./Project_Test/Tests/test_391/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 2711+0 ./Project_Test/Tests/test_391/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 2712+1 ./Project_Test/Tests/test_391/test.s

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
%line 2796+0 ./Project_Test/Tests/test_391/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 2797+1 ./Project_Test/Tests/test_391/test.s

 jmp .return

.return:
 leave
 ret
