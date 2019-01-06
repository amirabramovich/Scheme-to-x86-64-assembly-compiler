%line 1+1 ./Project_Test/Tests/test_254/test.s



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
%line 5+1 ./Project_Test/Tests/test_254/test.s

[section .bss]
malloc_pointer:
 resq 1

[section .data]
const_tbl:
db 1
db 2
 db 5
%line 14+0 ./Project_Test/Tests/test_254/test.s
 db 0
%line 15+1 ./Project_Test/Tests/test_254/test.s
 db 5
%line 15+0 ./Project_Test/Tests/test_254/test.s
 db 1
%line 16+1 ./Project_Test/Tests/test_254/test.s
db 7
%line 16+0 ./Project_Test/Tests/test_254/test.s
dq (..@39.end_str - ..@39.str)
..@39.str:
db "null?"
..@39.end_str:
%line 17+1 ./Project_Test/Tests/test_254/test.s
db 7
%line 17+0 ./Project_Test/Tests/test_254/test.s
dq (..@40.end_str - ..@40.str)
..@40.str:
db "car"
..@40.end_str:
%line 18+1 ./Project_Test/Tests/test_254/test.s
db 7
%line 18+0 ./Project_Test/Tests/test_254/test.s
dq (..@41.end_str - ..@41.str)
..@41.str:
db "cdr"
..@41.end_str:
%line 19+1 ./Project_Test/Tests/test_254/test.s
db 7
%line 19+0 ./Project_Test/Tests/test_254/test.s
dq (..@42.end_str - ..@42.str)
..@42.str:
db "ls"
..@42.end_str:
%line 20+1 ./Project_Test/Tests/test_254/test.s
db 7
%line 20+0 ./Project_Test/Tests/test_254/test.s
dq (..@43.end_str - ..@43.str)
..@43.str:
db "+"
..@43.end_str:
%line 21+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 21+0 ./Project_Test/Tests/test_254/test.s
 dq 0
%line 22+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 22+0 ./Project_Test/Tests/test_254/test.s
 dq 1
%line 23+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 23+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 74
 dq const_tbl + 1
%line 24+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 24+0 ./Project_Test/Tests/test_254/test.s
 dq 2
%line 25+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 25+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 100
 dq const_tbl + 1
%line 26+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 26+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 74
 dq const_tbl + 109
%line 27+1 ./Project_Test/Tests/test_254/test.s
db 7
%line 27+0 ./Project_Test/Tests/test_254/test.s
dq (..@50.end_str - ..@50.str)
..@50.str:
db "sum"
..@50.end_str:
%line 28+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 28+0 ./Project_Test/Tests/test_254/test.s
 dq 3
%line 29+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 29+0 ./Project_Test/Tests/test_254/test.s
 dq 4
%line 30+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 30+0 ./Project_Test/Tests/test_254/test.s
 dq 5
%line 31+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 31+0 ./Project_Test/Tests/test_254/test.s
 dq 6
%line 32+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 32+0 ./Project_Test/Tests/test_254/test.s
 dq 7
%line 33+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 33+0 ./Project_Test/Tests/test_254/test.s
 dq 8
%line 34+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 34+0 ./Project_Test/Tests/test_254/test.s
 dq 9
%line 35+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 35+0 ./Project_Test/Tests/test_254/test.s
 dq 10
%line 36+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 36+0 ./Project_Test/Tests/test_254/test.s
 dq 11
%line 37+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 37+0 ./Project_Test/Tests/test_254/test.s
 dq 12
%line 38+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 38+0 ./Project_Test/Tests/test_254/test.s
 dq 13
%line 39+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 39+0 ./Project_Test/Tests/test_254/test.s
 dq 14
%line 40+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 40+0 ./Project_Test/Tests/test_254/test.s
 dq 15
%line 41+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 41+0 ./Project_Test/Tests/test_254/test.s
 dq 16
%line 42+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 42+0 ./Project_Test/Tests/test_254/test.s
 dq 17
%line 43+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 43+0 ./Project_Test/Tests/test_254/test.s
 dq 18
%line 44+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 44+0 ./Project_Test/Tests/test_254/test.s
 dq 19
%line 45+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 45+0 ./Project_Test/Tests/test_254/test.s
 dq 20
%line 46+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 46+0 ./Project_Test/Tests/test_254/test.s
 dq 21
%line 47+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 47+0 ./Project_Test/Tests/test_254/test.s
 dq 22
%line 48+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 48+0 ./Project_Test/Tests/test_254/test.s
 dq 23
%line 49+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 49+0 ./Project_Test/Tests/test_254/test.s
 dq 24
%line 50+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 50+0 ./Project_Test/Tests/test_254/test.s
 dq 25
%line 51+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 51+0 ./Project_Test/Tests/test_254/test.s
 dq 26
%line 52+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 52+0 ./Project_Test/Tests/test_254/test.s
 dq 27
%line 53+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 53+0 ./Project_Test/Tests/test_254/test.s
 dq 28
%line 54+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 54+0 ./Project_Test/Tests/test_254/test.s
 dq 29
%line 55+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 55+0 ./Project_Test/Tests/test_254/test.s
 dq 30
%line 56+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 56+0 ./Project_Test/Tests/test_254/test.s
 dq 31
%line 57+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 57+0 ./Project_Test/Tests/test_254/test.s
 dq 32
%line 58+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 58+0 ./Project_Test/Tests/test_254/test.s
 dq 33
%line 59+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 59+0 ./Project_Test/Tests/test_254/test.s
 dq 34
%line 60+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 60+0 ./Project_Test/Tests/test_254/test.s
 dq 35
%line 61+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 61+0 ./Project_Test/Tests/test_254/test.s
 dq 36
%line 62+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 62+0 ./Project_Test/Tests/test_254/test.s
 dq 37
%line 63+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 63+0 ./Project_Test/Tests/test_254/test.s
 dq 38
%line 64+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 64+0 ./Project_Test/Tests/test_254/test.s
 dq 39
%line 65+1 ./Project_Test/Tests/test_254/test.s
 db 3
%line 65+0 ./Project_Test/Tests/test_254/test.s
 dq 40
%line 66+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 66+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 488
 dq const_tbl + 1
%line 67+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 67+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 479
 dq const_tbl + 497
%line 68+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 68+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 470
 dq const_tbl + 514
%line 69+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 69+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 461
 dq const_tbl + 531
%line 70+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 70+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 452
 dq const_tbl + 548
%line 71+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 71+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 443
 dq const_tbl + 565
%line 72+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 72+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 434
 dq const_tbl + 582
%line 73+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 73+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 425
 dq const_tbl + 599
%line 74+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 74+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 416
 dq const_tbl + 616
%line 75+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 75+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 407
 dq const_tbl + 633
%line 76+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 76+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 398
 dq const_tbl + 650
%line 77+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 77+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 389
 dq const_tbl + 667
%line 78+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 78+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 380
 dq const_tbl + 684
%line 79+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 79+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 371
 dq const_tbl + 701
%line 80+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 80+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 362
 dq const_tbl + 718
%line 81+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 81+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 353
 dq const_tbl + 735
%line 82+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 82+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 344
 dq const_tbl + 752
%line 83+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 83+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 335
 dq const_tbl + 769
%line 84+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 84+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 326
 dq const_tbl + 786
%line 85+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 85+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 317
 dq const_tbl + 803
%line 86+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 86+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 308
 dq const_tbl + 820
%line 87+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 87+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 299
 dq const_tbl + 837
%line 88+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 88+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 290
 dq const_tbl + 854
%line 89+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 89+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 281
 dq const_tbl + 871
%line 90+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 90+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 272
 dq const_tbl + 888
%line 91+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 91+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 263
 dq const_tbl + 905
%line 92+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 92+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 254
 dq const_tbl + 922
%line 93+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 93+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 245
 dq const_tbl + 939
%line 94+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 94+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 236
 dq const_tbl + 956
%line 95+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 95+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 227
 dq const_tbl + 973
%line 96+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 96+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 218
 dq const_tbl + 990
%line 97+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 97+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 209
 dq const_tbl + 1007
%line 98+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 98+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 200
 dq const_tbl + 1024
%line 99+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 99+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 191
 dq const_tbl + 1041
%line 100+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 100+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 182
 dq const_tbl + 1058
%line 101+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 101+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 173
 dq const_tbl + 1075
%line 102+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 102+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 164
 dq const_tbl + 1092
%line 103+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 103+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 155
 dq const_tbl + 1109
%line 104+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 104+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 100
 dq const_tbl + 1126
%line 105+1 ./Project_Test/Tests/test_254/test.s
 db 10
%line 105+0 ./Project_Test/Tests/test_254/test.s
 dq const_tbl + 74
 dq const_tbl + 1143
%line 106+1 ./Project_Test/Tests/test_254/test.s



%line 113+1 ./Project_Test/Tests/test_254/test.s

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
%line 179+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_boolean
%line 180+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 0 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 181+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_float
%line 182+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 1 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 183+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_integer
%line 184+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 2 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 185+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_pair
%line 186+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 3 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 187+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_null
%line 188+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 4 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 189+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_char
%line 190+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 5 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 191+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_vector
%line 192+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 6 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 193+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_string
%line 194+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 7 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 195+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_procedure
%line 196+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 8 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 197+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_symbol
%line 198+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 9 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 199+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_length
%line 200+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 10 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 201+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_ref
%line 202+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 11 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 203+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_set
%line 204+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 12 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 205+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_string
%line 206+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 13 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 207+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_length
%line 208+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 14 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 209+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_ref
%line 210+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 15 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 211+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_set
%line 212+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 16 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 213+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_vector
%line 214+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 17 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 215+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], symbol_to_string
%line 216+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 18 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 217+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], char_to_integer
%line 218+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 19 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 219+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], integer_to_char
%line 220+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 20 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 221+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_eq
%line 222+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 21 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 223+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_add
%line 224+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 22 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 225+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_mul
%line 226+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 23 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 227+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_sub
%line 228+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 24 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 229+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_div
%line 230+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 25 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 231+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_lt
%line 232+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 26 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 233+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_equ
%line 234+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 27 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 235+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], car
%line 236+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 28 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 237+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cdr
%line 238+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 29 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 239+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_car
%line 240+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 30 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 241+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_cdr
%line 242+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 31 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 243+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cons
%line 244+1 ./Project_Test/Tests/test_254/test.s
 mov [fvar_tbl + 32 * 8], rax

user_code:

 lambdaSimple0:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 249+0 ./Project_Test/Tests/test_254/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 250+1 ./Project_Test/Tests/test_254/test.s
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
%line 268+0 ./Project_Test/Tests/test_254/test.s
 push 8*0
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 269+1 ./Project_Test/Tests/test_254/test.s
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
%line 283+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode0
%line 284+1 ./Project_Test/Tests/test_254/test.s
 jmp Lcont0

 Lcode0:
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
 je Lelse1
 mov rax, const_tbl + 65
 jmp LexitIf1
 Lelse1:

 mov rax, 6666
 push rax

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

 mov rax, qword [fvar_tbl + 22 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 LexitIf1:
 leave
 ret

 Lcont0:
 mov qword [fvar_tbl + 33 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 1
 push rax
 push 1

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
 mov rax, const_tbl + 83
 push rax
 push 1

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
 mov rax, const_tbl + 126
 push rax
 push 1

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
 mov rax, const_tbl + 1160
 push rax
 push 1

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
%line 674+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 675+1 ./Project_Test/Tests/test_254/test.s

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
%line 691+0 ./Project_Test/Tests/test_254/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 692+1 ./Project_Test/Tests/test_254/test.s

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
%line 726+0 ./Project_Test/Tests/test_254/test.s
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
..@213.str_loop:
 jz ..@213.str_loop_end
 dec rcx
 mov byte [rax+rcx], dil
 jmp ..@213.str_loop
..@213.str_loop_end:
 pop rcx
 sub rax, 8+1
%line 727+1 ./Project_Test/Tests/test_254/test.s

 leave
 ret

vector_length:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 add qword [malloc_pointer], 1+8
%line 737+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 738+1 ./Project_Test/Tests/test_254/test.s

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
%line 786+0 ./Project_Test/Tests/test_254/test.s
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
..@223.vec_loop:
 jz ..@223.vec_loop_end
 dec rcx
 mov qword [rax+rcx*8], rdi
 jmp ..@223.vec_loop
..@223.vec_loop_end:
 sub rax, 8+1
 pop rcx
%line 787+1 ./Project_Test/Tests/test_254/test.s

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
%line 806+0 ./Project_Test/Tests/test_254/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], dil
%line 807+1 ./Project_Test/Tests/test_254/test.s
 push rax
 add qword [malloc_pointer], 1+8
%line 808+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rcx
%line 809+1 ./Project_Test/Tests/test_254/test.s
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
%line 844+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 845+1 ./Project_Test/Tests/test_254/test.s

 leave
 ret

integer_to_char:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 and rsi, 255
 add qword [malloc_pointer], 1+1
%line 857+0 ./Project_Test/Tests/test_254/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 858+1 ./Project_Test/Tests/test_254/test.s

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
%line 949+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 950+1 ./Project_Test/Tests/test_254/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 954+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 955+1 ./Project_Test/Tests/test_254/test.s

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
%line 1029+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1030+1 ./Project_Test/Tests/test_254/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1034+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1035+1 ./Project_Test/Tests/test_254/test.s

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
%line 1109+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1110+1 ./Project_Test/Tests/test_254/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1114+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1115+1 ./Project_Test/Tests/test_254/test.s

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
%line 1189+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1190+1 ./Project_Test/Tests/test_254/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1194+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1195+1 ./Project_Test/Tests/test_254/test.s

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
%line 1269+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1270+1 ./Project_Test/Tests/test_254/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1274+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1275+1 ./Project_Test/Tests/test_254/test.s

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
%line 1361+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1362+1 ./Project_Test/Tests/test_254/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1366+0 ./Project_Test/Tests/test_254/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1367+1 ./Project_Test/Tests/test_254/test.s

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
%line 1451+0 ./Project_Test/Tests/test_254/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 1452+1 ./Project_Test/Tests/test_254/test.s

 jmp .return

.return:
 leave
 ret
