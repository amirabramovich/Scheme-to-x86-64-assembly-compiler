%line 1+1 ./Project_Test/Tests/test_426/test.s



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
%line 5+1 ./Project_Test/Tests/test_426/test.s

[section .bss]
malloc_pointer:
 resq 1

[section .data]
const_tbl:
db 1
db 2
 db 5
%line 14+0 ./Project_Test/Tests/test_426/test.s
 db 0
%line 15+1 ./Project_Test/Tests/test_426/test.s
 db 5
%line 15+0 ./Project_Test/Tests/test_426/test.s
 db 1
%line 16+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 16+0 ./Project_Test/Tests/test_426/test.s
dq (..@39.end_str - ..@39.str)
..@39.str:
db "a"
..@39.end_str:
%line 17+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 17+0 ./Project_Test/Tests/test_426/test.s
dq (..@40.end_str - ..@40.str)
..@40.str:
db "b"
..@40.end_str:
%line 18+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 18+0 ./Project_Test/Tests/test_426/test.s
dq (..@41.end_str - ..@41.str)
..@41.str:
db "c"
..@41.end_str:
%line 19+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 19+0 ./Project_Test/Tests/test_426/test.s
dq (..@42.end_str - ..@42.str)
..@42.str:
db "esadsad"
..@42.end_str:
%line 20+1 ./Project_Test/Tests/test_426/test.s
 db 3
%line 20+0 ./Project_Test/Tests/test_426/test.s
 dq 3
%line 21+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 21+0 ./Project_Test/Tests/test_426/test.s
dq (..@44.end_str - ..@44.str)
..@44.str:
db "d"
..@44.end_str:
%line 22+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 22+0 ./Project_Test/Tests/test_426/test.s
dq (..@45.end_str - ..@45.str)
..@45.str:
db "fsfdsaf3dfss"
..@45.end_str:
%line 23+1 ./Project_Test/Tests/test_426/test.s
 db 3
%line 23+0 ./Project_Test/Tests/test_426/test.s
 dq 10
%line 24+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 24+0 ./Project_Test/Tests/test_426/test.s
dq (..@47.end_str - ..@47.str)
..@47.str:
db "e"
..@47.end_str:
%line 25+1 ./Project_Test/Tests/test_426/test.s
 db 3
%line 25+0 ./Project_Test/Tests/test_426/test.s
 dq 0
%line 26+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 26+0 ./Project_Test/Tests/test_426/test.s
dq (..@49.end_str - ..@49.str)
..@49.str:
db "f"
..@49.end_str:
%line 27+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 27+0 ./Project_Test/Tests/test_426/test.s
dq (..@50.end_str - ..@50.str)
..@50.str:
db "dsfdsh"
..@50.end_str:
%line 28+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 28+0 ./Project_Test/Tests/test_426/test.s
dq (..@51.end_str - ..@51.str)
..@51.str:
db "g"
..@51.end_str:
%line 29+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 29+0 ./Project_Test/Tests/test_426/test.s
dq (..@52.end_str - ..@52.str)
..@52.str:
db "idfdsfds"
..@52.end_str:
%line 30+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 30+0 ./Project_Test/Tests/test_426/test.s
dq (..@53.end_str - ..@53.str)
..@53.str:
db "h"
..@53.end_str:
%line 31+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 31+0 ./Project_Test/Tests/test_426/test.s
dq (..@54.end_str - ..@54.str)
..@54.str:
db "jdsfdsf"
..@54.end_str:
%line 32+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 32+0 ./Project_Test/Tests/test_426/test.s
dq (..@55.end_str - ..@55.str)
..@55.str:
db "i"
..@55.end_str:
%line 33+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 33+0 ./Project_Test/Tests/test_426/test.s
dq (..@56.end_str - ..@56.str)
..@56.str:
db "kdsfdsf"
..@56.end_str:
%line 34+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 34+0 ./Project_Test/Tests/test_426/test.s
dq (..@57.end_str - ..@57.str)
..@57.str:
db "j"
..@57.end_str:
%line 35+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 35+0 ./Project_Test/Tests/test_426/test.s
dq (..@58.end_str - ..@58.str)
..@58.str:
db "lds"
..@58.end_str:
%line 36+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 36+0 ./Project_Test/Tests/test_426/test.s
dq (..@59.end_str - ..@59.str)
..@59.str:
db "k"
..@59.end_str:
%line 37+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 37+0 ./Project_Test/Tests/test_426/test.s
dq (..@60.end_str - ..@60.str)
..@60.str:
db "mdsff"
..@60.end_str:
%line 38+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 38+0 ./Project_Test/Tests/test_426/test.s
dq (..@61.end_str - ..@61.str)
..@61.str:
db "l"
..@61.end_str:
%line 39+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 39+0 ./Project_Test/Tests/test_426/test.s
dq (..@62.end_str - ..@62.str)
..@62.str:
db "nd"
..@62.end_str:
%line 40+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 40+0 ./Project_Test/Tests/test_426/test.s
dq (..@63.end_str - ..@63.str)
..@63.str:
db "m"
..@63.end_str:
%line 41+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 41+0 ./Project_Test/Tests/test_426/test.s
dq (..@64.end_str - ..@64.str)
..@64.str:
db ""
..@64.end_str:
%line 42+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 42+0 ./Project_Test/Tests/test_426/test.s
dq (..@65.end_str - ..@65.str)
..@65.str:
db "n"
..@65.end_str:
%line 43+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 43+0 ./Project_Test/Tests/test_426/test.s
dq (..@66.end_str - ..@66.str)
..@66.str:
db "pdsfdsf"
..@66.end_str:
%line 44+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 44+0 ./Project_Test/Tests/test_426/test.s
dq (..@67.end_str - ..@67.str)
..@67.str:
db "o"
..@67.end_str:
%line 45+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 45+0 ./Project_Test/Tests/test_426/test.s
dq (..@68.end_str - ..@68.str)
..@68.str:
db "q34324dsfdsfdsf35r"
..@68.end_str:
%line 46+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 46+0 ./Project_Test/Tests/test_426/test.s
dq (..@69.end_str - ..@69.str)
..@69.str:
db "p"
..@69.end_str:
%line 47+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 47+0 ./Project_Test/Tests/test_426/test.s
dq (..@70.end_str - ..@70.str)
..@70.str:
db "rdfsfdsf3rfdsfdsf"
..@70.end_str:
%line 48+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 48+0 ./Project_Test/Tests/test_426/test.s
dq (..@71.end_str - ..@71.str)
..@71.str:
db "q"
..@71.end_str:
%line 49+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 49+0 ./Project_Test/Tests/test_426/test.s
dq (..@72.end_str - ..@72.str)
..@72.str:
db "sfddsfr4fdfdsfdsgfdgfdh"
..@72.end_str:
%line 50+1 ./Project_Test/Tests/test_426/test.s
 db 3
%line 50+0 ./Project_Test/Tests/test_426/test.s
 dq 14
%line 51+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 51+0 ./Project_Test/Tests/test_426/test.s
dq (..@74.end_str - ..@74.str)
..@74.str:
db "r"
..@74.end_str:
%line 52+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 52+0 ./Project_Test/Tests/test_426/test.s
dq (..@75.end_str - ..@75.str)
..@75.str:
db "tdfsdsf34sfddsf"
..@75.end_str:
%line 53+1 ./Project_Test/Tests/test_426/test.s
 db 3
%line 53+0 ./Project_Test/Tests/test_426/test.s
 dq 11
%line 54+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 54+0 ./Project_Test/Tests/test_426/test.s
dq (..@77.end_str - ..@77.str)
..@77.str:
db "s"
..@77.end_str:
%line 55+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 55+0 ./Project_Test/Tests/test_426/test.s
dq (..@78.end_str - ..@78.str)
..@78.str:
db "uffdsfds43sfdfds"
..@78.end_str:
%line 56+1 ./Project_Test/Tests/test_426/test.s
 db 3
%line 56+0 ./Project_Test/Tests/test_426/test.s
 dq 8
%line 57+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 57+0 ./Project_Test/Tests/test_426/test.s
dq (..@80.end_str - ..@80.str)
..@80.str:
db "t"
..@80.end_str:
%line 58+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 58+0 ./Project_Test/Tests/test_426/test.s
dq (..@81.end_str - ..@81.str)
..@81.str:
db "vdsfdsfdsf4dsfsdf"
..@81.end_str:
%line 59+1 ./Project_Test/Tests/test_426/test.s
 db 3
%line 59+0 ./Project_Test/Tests/test_426/test.s
 dq 9
%line 60+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 60+0 ./Project_Test/Tests/test_426/test.s
dq (..@83.end_str - ..@83.str)
..@83.str:
db "u"
..@83.end_str:
%line 61+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 61+0 ./Project_Test/Tests/test_426/test.s
dq (..@84.end_str - ..@84.str)
..@84.str:
db "string-ref"
..@84.end_str:
%line 62+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 62+0 ./Project_Test/Tests/test_426/test.s
dq (..@85.end_str - ..@85.str)
..@85.str:
db "wdsfdsfdsf3fsd"
..@85.end_str:
%line 63+1 ./Project_Test/Tests/test_426/test.s
 db 3
%line 63+0 ./Project_Test/Tests/test_426/test.s
 dq 6
%line 64+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 64+0 ./Project_Test/Tests/test_426/test.s
dq (..@87.end_str - ..@87.str)
..@87.str:
db "v"
..@87.end_str:
%line 65+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 65+0 ./Project_Test/Tests/test_426/test.s
dq (..@88.end_str - ..@88.str)
..@88.str:
db "xff"
..@88.end_str:
%line 66+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 66+0 ./Project_Test/Tests/test_426/test.s
dq (..@89.end_str - ..@89.str)
..@89.str:
db "w"
..@89.end_str:
%line 67+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 67+0 ./Project_Test/Tests/test_426/test.s
dq (..@90.end_str - ..@90.str)
..@90.str:
db "dfsy"
..@90.end_str:
%line 68+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 68+0 ./Project_Test/Tests/test_426/test.s
dq (..@91.end_str - ..@91.str)
..@91.str:
db "x"
..@91.end_str:
%line 69+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 69+0 ./Project_Test/Tests/test_426/test.s
dq (..@92.end_str - ..@92.str)
..@92.str:
db "zdfs"
..@92.end_str:
%line 70+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 70+0 ./Project_Test/Tests/test_426/test.s
dq (..@93.end_str - ..@93.str)
..@93.str:
db "y"
..@93.end_str:
%line 71+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 71+0 ./Project_Test/Tests/test_426/test.s
dq (..@94.end_str - ..@94.str)
..@94.str:
db "string-length"
..@94.end_str:
%line 72+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 72+0 ./Project_Test/Tests/test_426/test.s
dq (..@95.end_str - ..@95.str)
..@95.str:
db "asdfds"
..@95.end_str:
%line 73+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 73+0 ./Project_Test/Tests/test_426/test.s
dq (..@96.end_str - ..@96.str)
..@96.str:
db "eq?"
..@96.end_str:
%line 74+1 ./Project_Test/Tests/test_426/test.s
db 8
%line 74+0 ./Project_Test/Tests/test_426/test.s
dq (const_tbl + 6)
%line 75+1 ./Project_Test/Tests/test_426/test.s
db 7
%line 75+0 ./Project_Test/Tests/test_426/test.s
dq (..@98.end_str - ..@98.str)
..@98.str:
db "z"
..@98.end_str:
%line 76+1 ./Project_Test/Tests/test_426/test.s



%line 83+1 ./Project_Test/Tests/test_426/test.s

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
%line 174+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_boolean
%line 175+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 0 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 176+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_float
%line 177+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 1 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 178+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_integer
%line 179+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 2 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 180+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_pair
%line 181+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 3 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 182+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_null
%line 183+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 4 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 184+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_char
%line 185+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 5 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 186+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_vector
%line 187+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 6 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 188+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_string
%line 189+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 7 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 190+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_procedure
%line 191+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 8 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 192+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_symbol
%line 193+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 9 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 194+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_length
%line 195+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 10 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 196+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_ref
%line 197+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 11 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 198+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_set
%line 199+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 12 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 200+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_string
%line 201+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 13 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 202+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_length
%line 203+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 14 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 204+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_ref
%line 205+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 15 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 206+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_set
%line 207+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 16 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 208+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_vector
%line 209+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 17 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 210+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], symbol_to_string
%line 211+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 18 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 212+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], char_to_integer
%line 213+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 19 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 214+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], integer_to_char
%line 215+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 20 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 216+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_eq
%line 217+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 21 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 218+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_add
%line 219+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 22 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 220+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_mul
%line 221+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 23 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 222+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_sub
%line 223+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 24 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 224+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_div
%line 225+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 25 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 226+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_lt
%line 227+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 26 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 228+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_equ
%line 229+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 27 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 230+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], car
%line 231+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 28 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 232+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cdr
%line 233+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 29 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 234+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_car
%line 235+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 30 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 236+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_cdr
%line 237+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 31 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 238+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cons
%line 239+1 ./Project_Test/Tests/test_426/test.s
 mov [fvar_tbl + 32 * 8], rax

user_code:

 mov rax, 6666
 push rax
 mov rax, const_tbl + 16
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 58 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 26
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 57 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 61
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 56 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 52
 push rax
 mov rax, const_tbl + 36
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 55 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 92
 push rax
 mov rax, const_tbl + 71
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 54 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 111
 push rax
 mov rax, const_tbl + 145
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 53 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 130
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 52 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 155
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 51 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 182
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 50 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 208
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 49 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 234
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 48 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 256
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 47 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 280
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 46 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 301
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 45 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 320
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 44 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 644
 push rax
 mov rax, const_tbl + 346
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 43 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 538
 push rax
 mov rax, const_tbl + 383
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 42 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 451
 push rax
 mov rax, const_tbl + 419
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 41 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 494
 push rax
 mov rax, const_tbl + 470
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 40 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 538
 push rax
 mov rax, const_tbl + 513
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 39 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 583
 push rax
 mov rax, const_tbl + 557
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 38 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 644
 push rax
 mov rax, const_tbl + 621
 push rax
 push 2

 mov rax, qword [fvar_tbl + 11 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 37 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 663
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 36 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 685
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 35 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 708
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 34 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, const_tbl + 753
 push rax
 push 1

 mov rax, qword [fvar_tbl + 10 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl + 33 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl + 33 * 8]
 push rax
 mov rax, const_tbl + 780
 push rax
 push 2

 mov rax, qword [fvar_tbl + 21 * 8]

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
%line 1073+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1074+1 ./Project_Test/Tests/test_426/test.s

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
%line 1090+0 ./Project_Test/Tests/test_426/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 1091+1 ./Project_Test/Tests/test_426/test.s

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
%line 1125+0 ./Project_Test/Tests/test_426/test.s
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
..@179.str_loop:
 jz ..@179.str_loop_end
 dec rcx
 mov byte [rax+rcx], dil
 jmp ..@179.str_loop
..@179.str_loop_end:
 pop rcx
 sub rax, 8+1
%line 1126+1 ./Project_Test/Tests/test_426/test.s

 leave
 ret

vector_length:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 add qword [malloc_pointer], 1+8
%line 1136+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1137+1 ./Project_Test/Tests/test_426/test.s

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
%line 1185+0 ./Project_Test/Tests/test_426/test.s
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
..@189.vec_loop:
 jz ..@189.vec_loop_end
 dec rcx
 mov qword [rax+rcx*8], rdi
 jmp ..@189.vec_loop
..@189.vec_loop_end:
 sub rax, 8+1
 pop rcx
%line 1186+1 ./Project_Test/Tests/test_426/test.s

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
%line 1205+0 ./Project_Test/Tests/test_426/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], dil
%line 1206+1 ./Project_Test/Tests/test_426/test.s
 push rax
 add qword [malloc_pointer], 1+8
%line 1207+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rcx
%line 1208+1 ./Project_Test/Tests/test_426/test.s
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
%line 1243+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1244+1 ./Project_Test/Tests/test_426/test.s

 leave
 ret

integer_to_char:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 and rsi, 255
 add qword [malloc_pointer], 1+1
%line 1256+0 ./Project_Test/Tests/test_426/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 1257+1 ./Project_Test/Tests/test_426/test.s

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
%line 1348+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1349+1 ./Project_Test/Tests/test_426/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1353+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1354+1 ./Project_Test/Tests/test_426/test.s

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
%line 1428+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1429+1 ./Project_Test/Tests/test_426/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1433+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1434+1 ./Project_Test/Tests/test_426/test.s

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
%line 1508+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1509+1 ./Project_Test/Tests/test_426/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1513+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1514+1 ./Project_Test/Tests/test_426/test.s

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
%line 1588+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1589+1 ./Project_Test/Tests/test_426/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1593+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1594+1 ./Project_Test/Tests/test_426/test.s

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
%line 1668+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1669+1 ./Project_Test/Tests/test_426/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1673+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1674+1 ./Project_Test/Tests/test_426/test.s

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
%line 1760+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1761+1 ./Project_Test/Tests/test_426/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1765+0 ./Project_Test/Tests/test_426/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1766+1 ./Project_Test/Tests/test_426/test.s

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
%line 1850+0 ./Project_Test/Tests/test_426/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 1851+1 ./Project_Test/Tests/test_426/test.s

 jmp .return

.return:
 leave
 ret
