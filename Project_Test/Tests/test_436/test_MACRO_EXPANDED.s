%line 1+1 ./Project_Test/Tests/test_436/test.s



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
%line 5+1 ./Project_Test/Tests/test_436/test.s

[section .bss]
malloc_pointer:
 resq 1

[section .data]
const_tbl:
db 1
db 2
 db 5
%line 14+0 ./Project_Test/Tests/test_436/test.s
 db 0
%line 15+1 ./Project_Test/Tests/test_436/test.s
 db 5
%line 15+0 ./Project_Test/Tests/test_436/test.s
 db 1
%line 16+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 16+0 ./Project_Test/Tests/test_436/test.s
dq (..@39.end_str - ..@39.str)
..@39.str:
db "p"
..@39.end_str:
%line 17+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 17+0 ./Project_Test/Tests/test_436/test.s
dq (..@40.end_str - ..@40.str)
..@40.str:
db "c"
..@40.end_str:
%line 18+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 18+0 ./Project_Test/Tests/test_436/test.s
dq (..@41.end_str - ..@41.str)
..@41.str:
db "n"
..@41.end_str:
%line 19+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 19+0 ./Project_Test/Tests/test_436/test.s
dq (..@42.end_str - ..@42.str)
..@42.str:
db "z"
..@42.end_str:
%line 20+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 20+0 ./Project_Test/Tests/test_436/test.s
dq (..@43.end_str - ..@43.str)
..@43.str:
db "s"
..@43.end_str:
%line 21+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 21+0 ./Project_Test/Tests/test_436/test.s
dq (..@44.end_str - ..@44.str)
..@44.str:
db "a"
..@44.end_str:
%line 22+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 22+0 ./Project_Test/Tests/test_436/test.s
dq (..@45.end_str - ..@45.str)
..@45.str:
db "b"
..@45.end_str:
%line 23+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 23+0 ./Project_Test/Tests/test_436/test.s
dq (..@46.end_str - ..@46.str)
..@46.str:
db "y"
..@46.end_str:
%line 24+1 ./Project_Test/Tests/test_436/test.s
db 7
%line 24+0 ./Project_Test/Tests/test_436/test.s
dq (..@47.end_str - ..@47.str)
..@47.str:
db "x"
..@47.end_str:
%line 25+1 ./Project_Test/Tests/test_436/test.s



%line 32+1 ./Project_Test/Tests/test_436/test.s

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
%line 97+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_boolean
%line 98+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 0 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 99+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_float
%line 100+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 1 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 101+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_integer
%line 102+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 2 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 103+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_pair
%line 104+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 3 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 105+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_null
%line 106+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 4 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 107+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_char
%line 108+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 5 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 109+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_vector
%line 110+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 6 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 111+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_string
%line 112+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 7 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 113+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_procedure
%line 114+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 8 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 115+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_symbol
%line 116+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 9 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 117+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_length
%line 118+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 10 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 119+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_ref
%line 120+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 11 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 121+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_set
%line 122+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 12 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 123+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_string
%line 124+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 13 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 125+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_length
%line 126+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 14 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 127+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_ref
%line 128+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 15 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 129+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_set
%line 130+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 16 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 131+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_vector
%line 132+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 17 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 133+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], symbol_to_string
%line 134+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 18 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 135+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], char_to_integer
%line 136+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 19 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 137+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], integer_to_char
%line 138+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 20 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 139+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_eq
%line 140+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 21 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 141+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_add
%line 142+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 22 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 143+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_mul
%line 144+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 23 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 145+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_sub
%line 146+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 24 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 147+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_div
%line 148+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 25 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 149+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_lt
%line 150+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 26 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 151+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_equ
%line 152+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 27 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 153+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], car
%line 154+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 28 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 155+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cdr
%line 156+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 29 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 157+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_car
%line 158+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 30 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 159+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_cdr
%line 160+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 31 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 161+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cons
%line 162+1 ./Project_Test/Tests/test_436/test.s
 mov [fvar_tbl + 32 * 8], rax

user_code:

 mov rax, 6666
 push rax
 mov rax, const_tbl + 2
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, const_tbl + 4
 push rax
 push 1


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple130:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 187+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 188+1 ./Project_Test/Tests/test_436/test.s
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
%line 206+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 207+1 ./Project_Test/Tests/test_436/test.s
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
%line 221+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode130
%line 222+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont130

 Lcode130:
 push rbp
 mov rbp , rsp

 lambdaSimple131:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 229+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 230+1 ./Project_Test/Tests/test_436/test.s
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
%line 248+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 249+1 ./Project_Test/Tests/test_436/test.s
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
%line 263+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode131
%line 264+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont131

 Lcode131:
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
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont131:
 leave
 ret

 Lcont130:
 push rax
 push 1


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple128:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 390+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 391+1 ./Project_Test/Tests/test_436/test.s
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
%line 409+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 410+1 ./Project_Test/Tests/test_436/test.s
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
%line 424+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode128
%line 425+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont128

 Lcode128:
 push rbp
 mov rbp , rsp

 lambdaSimple129:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 432+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 433+1 ./Project_Test/Tests/test_436/test.s
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
%line 451+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 452+1 ./Project_Test/Tests/test_436/test.s
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
%line 466+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode129
%line 467+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont129

 Lcode129:
 push rbp
 mov rbp , rsp

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

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont129:
 leave
 ret

 Lcont128:
 push rax
 push 1


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple126:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 553+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 554+1 ./Project_Test/Tests/test_436/test.s
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
%line 572+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 573+1 ./Project_Test/Tests/test_436/test.s
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
%line 587+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode126
%line 588+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont126

 Lcode126:
 push rbp
 mov rbp , rsp

 lambdaSimple127:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 595+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 596+1 ./Project_Test/Tests/test_436/test.s
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
%line 614+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 615+1 ./Project_Test/Tests/test_436/test.s
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
%line 629+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode127
%line 630+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont127

 Lcode127:
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

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont127:
 leave
 ret

 Lcont126:
 push rax
 push 1


 lambdaSimple124:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 690+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 691+1 ./Project_Test/Tests/test_436/test.s
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
%line 709+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 710+1 ./Project_Test/Tests/test_436/test.s
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
%line 724+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode124
%line 725+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont124

 Lcode124:
 push rbp
 mov rbp , rsp

 lambdaSimple125:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 732+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 733+1 ./Project_Test/Tests/test_436/test.s
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
%line 751+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 752+1 ./Project_Test/Tests/test_436/test.s
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
%line 766+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode125
%line 767+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont125

 Lcode125:
 push rbp
 mov rbp , rsp

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

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont125:
 leave
 ret

 Lcont124:

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


 lambdaSimple115:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 858+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 859+1 ./Project_Test/Tests/test_436/test.s
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
%line 877+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 878+1 ./Project_Test/Tests/test_436/test.s
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
%line 892+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode115
%line 893+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont115

 Lcode115:
 push rbp
 mov rbp , rsp

 lambdaSimple116:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 900+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 901+1 ./Project_Test/Tests/test_436/test.s
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
%line 919+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 920+1 ./Project_Test/Tests/test_436/test.s
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
%line 934+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode116
%line 935+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont116

 Lcode116:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple122:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 945+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 946+1 ./Project_Test/Tests/test_436/test.s
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
%line 964+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 965+1 ./Project_Test/Tests/test_436/test.s
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
%line 979+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode122
%line 980+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont122

 Lcode122:
 push rbp
 mov rbp , rsp

 lambdaSimple123:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 987+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 988+1 ./Project_Test/Tests/test_436/test.s
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
%line 1006+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1007+1 ./Project_Test/Tests/test_436/test.s
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
%line 1021+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode123
%line 1022+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont123

 Lcode123:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont123:
 leave
 ret

 Lcont122:
 push rax
 push 1


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple117:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 1048+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1049+1 ./Project_Test/Tests/test_436/test.s
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
%line 1067+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1068+1 ./Project_Test/Tests/test_436/test.s
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
%line 1082+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode117
%line 1083+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont117

 Lcode117:
 push rbp
 mov rbp , rsp

 lambdaSimple118:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 1090+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1091+1 ./Project_Test/Tests/test_436/test.s
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
%line 1109+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1110+1 ./Project_Test/Tests/test_436/test.s
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
%line 1124+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode118
%line 1125+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont118

 Lcode118:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple119:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 1143+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1144+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 1162+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1163+1 ./Project_Test/Tests/test_436/test.s
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
%line 1177+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode119
%line 1178+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont119

 Lcode119:
 push rbp
 mov rbp , rsp

 lambdaSimple120:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 1185+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1186+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 1204+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1205+1 ./Project_Test/Tests/test_436/test.s
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
%line 1219+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode120
%line 1220+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont120

 Lcode120:
 push rbp
 mov rbp , rsp

 lambdaSimple121:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 1227+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1228+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 1246+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1247+1 ./Project_Test/Tests/test_436/test.s
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
%line 1261+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode121
%line 1262+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont121

 Lcode121:
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


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont121:
 leave
 ret

 Lcont120:
 leave
 ret

 Lcont119:
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 Lcont118:
 leave
 ret

 Lcont117:
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont116:
 leave
 ret

 Lcont115:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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


 lambdaSimple106:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1456+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1457+1 ./Project_Test/Tests/test_436/test.s
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
%line 1475+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1476+1 ./Project_Test/Tests/test_436/test.s
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
%line 1490+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode106
%line 1491+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont106

 Lcode106:
 push rbp
 mov rbp , rsp

 lambdaSimple107:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1498+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1499+1 ./Project_Test/Tests/test_436/test.s
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
%line 1517+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1518+1 ./Project_Test/Tests/test_436/test.s
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
%line 1532+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode107
%line 1533+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont107

 Lcode107:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple113:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 1543+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1544+1 ./Project_Test/Tests/test_436/test.s
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
%line 1562+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1563+1 ./Project_Test/Tests/test_436/test.s
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
%line 1577+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode113
%line 1578+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont113

 Lcode113:
 push rbp
 mov rbp , rsp

 lambdaSimple114:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 1585+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1586+1 ./Project_Test/Tests/test_436/test.s
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
%line 1604+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1605+1 ./Project_Test/Tests/test_436/test.s
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
%line 1619+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode114
%line 1620+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont114

 Lcode114:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont114:
 leave
 ret

 Lcont113:
 push rax
 push 1


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple108:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 1646+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1647+1 ./Project_Test/Tests/test_436/test.s
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
%line 1665+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1666+1 ./Project_Test/Tests/test_436/test.s
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
%line 1680+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode108
%line 1681+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont108

 Lcode108:
 push rbp
 mov rbp , rsp

 lambdaSimple109:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 1688+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1689+1 ./Project_Test/Tests/test_436/test.s
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
%line 1707+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1708+1 ./Project_Test/Tests/test_436/test.s
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
%line 1722+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode109
%line 1723+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont109

 Lcode109:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple110:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 1741+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1742+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 1760+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1761+1 ./Project_Test/Tests/test_436/test.s
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
%line 1775+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode110
%line 1776+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont110

 Lcode110:
 push rbp
 mov rbp , rsp

 lambdaSimple111:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 1783+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1784+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 1802+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1803+1 ./Project_Test/Tests/test_436/test.s
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
%line 1817+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode111
%line 1818+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont111

 Lcode111:
 push rbp
 mov rbp , rsp

 lambdaSimple112:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 1825+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1826+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 1844+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1845+1 ./Project_Test/Tests/test_436/test.s
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
%line 1859+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode112
%line 1860+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont112

 Lcode112:
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


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont112:
 leave
 ret

 Lcont111:
 leave
 ret

 Lcont110:
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 Lcont109:
 leave
 ret

 Lcont108:
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont107:
 leave
 ret

 Lcont106:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple104:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 2060+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2061+1 ./Project_Test/Tests/test_436/test.s
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
%line 2079+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2080+1 ./Project_Test/Tests/test_436/test.s
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
%line 2094+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode104
%line 2095+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont104

 Lcode104:
 push rbp
 mov rbp , rsp

 lambdaSimple105:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 2102+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2103+1 ./Project_Test/Tests/test_436/test.s
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
%line 2121+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2122+1 ./Project_Test/Tests/test_436/test.s
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
%line 2136+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode105
%line 2137+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont105

 Lcode105:
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
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont105:
 leave
 ret

 Lcont104:
 push rax
 push 1


 lambdaSimple70:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 2257+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2258+1 ./Project_Test/Tests/test_436/test.s
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
%line 2276+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2277+1 ./Project_Test/Tests/test_436/test.s
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
%line 2291+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode70
%line 2292+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont70

 Lcode70:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple103:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 2308+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2309+1 ./Project_Test/Tests/test_436/test.s
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
%line 2327+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2328+1 ./Project_Test/Tests/test_436/test.s
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
%line 2342+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode103
%line 2343+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont103

 Lcode103:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont103:
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple102:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 2362+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2363+1 ./Project_Test/Tests/test_436/test.s
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
%line 2381+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2382+1 ./Project_Test/Tests/test_436/test.s
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
%line 2396+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode102
%line 2397+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont102

 Lcode102:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont102:
 push rax
 push 1


 lambdaSimple99:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 2413+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2414+1 ./Project_Test/Tests/test_436/test.s
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
%line 2432+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2433+1 ./Project_Test/Tests/test_436/test.s
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
%line 2447+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode99
%line 2448+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont99

 Lcode99:
 push rbp
 mov rbp , rsp

 lambdaSimple100:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 2455+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2456+1 ./Project_Test/Tests/test_436/test.s
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
%line 2474+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2475+1 ./Project_Test/Tests/test_436/test.s
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
%line 2489+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode100
%line 2490+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont100

 Lcode100:
 push rbp
 mov rbp , rsp

 lambdaSimple101:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 2497+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2498+1 ./Project_Test/Tests/test_436/test.s
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
%line 2516+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2517+1 ./Project_Test/Tests/test_436/test.s
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
%line 2531+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode101
%line 2532+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont101

 Lcode101:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont101:
 leave
 ret

 Lcont100:
 leave
 ret

 Lcont99:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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


 mov rax, 6666
 push rax

 lambdaSimple74:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 2621+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2622+1 ./Project_Test/Tests/test_436/test.s
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
%line 2640+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2641+1 ./Project_Test/Tests/test_436/test.s
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
%line 2655+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode74
%line 2656+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont74

 Lcode74:
 push rbp
 mov rbp , rsp

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


 lambdaSimple96:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 2677+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2678+1 ./Project_Test/Tests/test_436/test.s
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
%line 2696+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2697+1 ./Project_Test/Tests/test_436/test.s
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
%line 2711+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode96
%line 2712+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont96

 Lcode96:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple97:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 2722+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2723+1 ./Project_Test/Tests/test_436/test.s
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
%line 2741+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2742+1 ./Project_Test/Tests/test_436/test.s
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
%line 2756+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode97
%line 2757+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont97

 Lcode97:
 push rbp
 mov rbp , rsp

 lambdaSimple98:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 2764+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2765+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 2783+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2784+1 ./Project_Test/Tests/test_436/test.s
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
%line 2798+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode98
%line 2799+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont98

 Lcode98:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont98:
 leave
 ret

 Lcont97:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont96:

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


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1


 lambdaSimple93:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 2861+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2862+1 ./Project_Test/Tests/test_436/test.s
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
%line 2880+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2881+1 ./Project_Test/Tests/test_436/test.s
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
%line 2895+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode93
%line 2896+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont93

 Lcode93:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple94:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 2906+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2907+1 ./Project_Test/Tests/test_436/test.s
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
%line 2925+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2926+1 ./Project_Test/Tests/test_436/test.s
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
%line 2940+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode94
%line 2941+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont94

 Lcode94:
 push rbp
 mov rbp , rsp

 lambdaSimple95:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 2948+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2949+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 2967+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2968+1 ./Project_Test/Tests/test_436/test.s
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
%line 2982+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode95
%line 2983+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont95

 Lcode95:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 leave
 ret

 Lcont95:
 leave
 ret

 Lcont94:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont93:

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


 lambdaSimple84:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 3035+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3036+1 ./Project_Test/Tests/test_436/test.s
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
%line 3054+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3055+1 ./Project_Test/Tests/test_436/test.s
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
%line 3069+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode84
%line 3070+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont84

 Lcode84:
 push rbp
 mov rbp , rsp

 lambdaSimple85:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 3077+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3078+1 ./Project_Test/Tests/test_436/test.s
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
%line 3096+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3097+1 ./Project_Test/Tests/test_436/test.s
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
%line 3111+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode85
%line 3112+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont85

 Lcode85:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple91:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 3122+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3123+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 3141+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3142+1 ./Project_Test/Tests/test_436/test.s
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
%line 3156+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode91
%line 3157+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont91

 Lcode91:
 push rbp
 mov rbp , rsp

 lambdaSimple92:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 3164+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3165+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 3183+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3184+1 ./Project_Test/Tests/test_436/test.s
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
%line 3198+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode92
%line 3199+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont92

 Lcode92:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont92:
 leave
 ret

 Lcont91:
 push rax
 push 1


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple86:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 3225+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3226+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 3244+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3245+1 ./Project_Test/Tests/test_436/test.s
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
%line 3259+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode86
%line 3260+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont86

 Lcode86:
 push rbp
 mov rbp , rsp

 lambdaSimple87:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 3267+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3268+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 3286+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3287+1 ./Project_Test/Tests/test_436/test.s
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
%line 3301+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode87
%line 3302+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont87

 Lcode87:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple88:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 3320+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3321+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 3339+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3340+1 ./Project_Test/Tests/test_436/test.s
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
%line 3354+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode88
%line 3355+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont88

 Lcode88:
 push rbp
 mov rbp , rsp

 lambdaSimple89:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 3362+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3363+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 3381+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3382+1 ./Project_Test/Tests/test_436/test.s
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
%line 3396+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode89
%line 3397+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont89

 Lcode89:
 push rbp
 mov rbp , rsp

 lambdaSimple90:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 3404+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3405+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 3423+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3424+1 ./Project_Test/Tests/test_436/test.s
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
%line 3438+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode90
%line 3439+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont90

 Lcode90:
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


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont90:
 leave
 ret

 Lcont89:
 leave
 ret

 Lcont88:
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 Lcont87:
 leave
 ret

 Lcont86:
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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

 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont85:
 leave
 ret

 Lcont84:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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


 lambdaSimple81:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 3647+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3648+1 ./Project_Test/Tests/test_436/test.s
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
%line 3666+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3667+1 ./Project_Test/Tests/test_436/test.s
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
%line 3681+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode81
%line 3682+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont81

 Lcode81:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple82:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 3692+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3693+1 ./Project_Test/Tests/test_436/test.s
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
%line 3711+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3712+1 ./Project_Test/Tests/test_436/test.s
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
%line 3726+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode82
%line 3727+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont82

 Lcode82:
 push rbp
 mov rbp , rsp

 lambdaSimple83:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 3734+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3735+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 3753+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3754+1 ./Project_Test/Tests/test_436/test.s
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
%line 3768+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode83
%line 3769+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont83

 Lcode83:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 leave
 ret

 Lcont83:
 leave
 ret

 Lcont82:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont81:

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


 lambdaSimple78:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 3821+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3822+1 ./Project_Test/Tests/test_436/test.s
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
%line 3840+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3841+1 ./Project_Test/Tests/test_436/test.s
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
%line 3855+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode78
%line 3856+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont78

 Lcode78:
 push rbp
 mov rbp , rsp

 lambdaSimple79:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 3863+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3864+1 ./Project_Test/Tests/test_436/test.s
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
%line 3882+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3883+1 ./Project_Test/Tests/test_436/test.s
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
%line 3897+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode79
%line 3898+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont79

 Lcode79:
 push rbp
 mov rbp , rsp

 lambdaSimple80:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 3905+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3906+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 3924+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3925+1 ./Project_Test/Tests/test_436/test.s
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
%line 3939+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode80
%line 3940+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont80

 Lcode80:
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


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont80:
 leave
 ret

 Lcont79:
 leave
 ret

 Lcont78:

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


 lambdaSimple75:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 4035+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4036+1 ./Project_Test/Tests/test_436/test.s
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
%line 4054+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4055+1 ./Project_Test/Tests/test_436/test.s
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
%line 4069+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode75
%line 4070+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont75

 Lcode75:
 push rbp
 mov rbp , rsp

 lambdaSimple76:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 4077+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4078+1 ./Project_Test/Tests/test_436/test.s
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
%line 4096+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4097+1 ./Project_Test/Tests/test_436/test.s
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
%line 4111+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode76
%line 4112+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont76

 Lcode76:
 push rbp
 mov rbp , rsp

 lambdaSimple77:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 4119+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4120+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 4138+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4139+1 ./Project_Test/Tests/test_436/test.s
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
%line 4153+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode77
%line 4154+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont77

 Lcode77:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont77:
 leave
 ret

 Lcont76:
 leave
 ret

 Lcont75:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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

 Lcont74:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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


 lambdaSimple71:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 4271+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4272+1 ./Project_Test/Tests/test_436/test.s
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
%line 4290+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4291+1 ./Project_Test/Tests/test_436/test.s
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
%line 4305+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode71
%line 4306+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont71

 Lcode71:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple72:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 4316+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4317+1 ./Project_Test/Tests/test_436/test.s
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
%line 4335+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4336+1 ./Project_Test/Tests/test_436/test.s
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
%line 4350+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode72
%line 4351+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont72

 Lcode72:
 push rbp
 mov rbp , rsp

 lambdaSimple73:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 4358+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4359+1 ./Project_Test/Tests/test_436/test.s
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
%line 4377+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4378+1 ./Project_Test/Tests/test_436/test.s
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
%line 4392+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode73
%line 4393+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont73

 Lcode73:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont73:
 leave
 ret

 Lcont72:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont71:

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

 Lcont70:

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


 lambdaSimple0:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 4459+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4460+1 ./Project_Test/Tests/test_436/test.s
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
%line 4478+0 ./Project_Test/Tests/test_436/test.s
 push 8*0
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4479+1 ./Project_Test/Tests/test_436/test.s
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
%line 4493+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode0
%line 4494+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont0

 Lcode0:
 push rbp
 mov rbp , rsp

 lambdaSimple1:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 4501+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4502+1 ./Project_Test/Tests/test_436/test.s
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
%line 4520+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4521+1 ./Project_Test/Tests/test_436/test.s
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
%line 4535+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode1
%line 4536+1 ./Project_Test/Tests/test_436/test.s
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
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1


 lambdaSimple44:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 4566+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4567+1 ./Project_Test/Tests/test_436/test.s
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
%line 4585+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4586+1 ./Project_Test/Tests/test_436/test.s
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
%line 4600+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode44
%line 4601+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont44

 Lcode44:
 push rbp
 mov rbp , rsp

 lambdaSimple45:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 4608+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4609+1 ./Project_Test/Tests/test_436/test.s
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
%line 4627+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4628+1 ./Project_Test/Tests/test_436/test.s
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
%line 4642+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode45
%line 4643+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont45

 Lcode45:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple46:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 4662+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4663+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 4681+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4682+1 ./Project_Test/Tests/test_436/test.s
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
%line 4696+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode46
%line 4697+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont46

 Lcode46:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple68:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 4713+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4714+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 4732+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4733+1 ./Project_Test/Tests/test_436/test.s
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
%line 4747+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode68
%line 4748+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont68

 Lcode68:
 push rbp
 mov rbp , rsp

 lambdaSimple69:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 4755+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4756+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 4774+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4775+1 ./Project_Test/Tests/test_436/test.s
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
%line 4789+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode69
%line 4790+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont69

 Lcode69:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont69:
 leave
 ret

 Lcont68:
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple66:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 4813+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4814+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 4832+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4833+1 ./Project_Test/Tests/test_436/test.s
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
%line 4847+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode66
%line 4848+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont66

 Lcode66:
 push rbp
 mov rbp , rsp

 lambdaSimple67:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 4855+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4856+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 4874+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4875+1 ./Project_Test/Tests/test_436/test.s
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
%line 4889+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode67
%line 4890+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont67

 Lcode67:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont67:
 leave
 ret

 Lcont66:
 push rax
 push 1


 lambdaSimple63:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 4910+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4911+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 4929+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4930+1 ./Project_Test/Tests/test_436/test.s
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
%line 4944+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode63
%line 4945+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont63

 Lcode63:
 push rbp
 mov rbp , rsp

 lambdaSimple64:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 4952+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4953+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 4971+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4972+1 ./Project_Test/Tests/test_436/test.s
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
%line 4986+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode64
%line 4987+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont64

 Lcode64:
 push rbp
 mov rbp , rsp

 lambdaSimple65:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 4994+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4995+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 5013+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5014+1 ./Project_Test/Tests/test_436/test.s
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
%line 5028+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode65
%line 5029+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont65

 Lcode65:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont65:
 leave
 ret

 Lcont64:
 leave
 ret

 Lcont63:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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


 mov rax, 6666
 push rax

 lambdaSimple50:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 5118+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5119+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 5137+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5138+1 ./Project_Test/Tests/test_436/test.s
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
%line 5152+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode50
%line 5153+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont50

 Lcode50:
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


 lambdaSimple60:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 5171+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5172+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 5190+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5191+1 ./Project_Test/Tests/test_436/test.s
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
%line 5205+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode60
%line 5206+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont60

 Lcode60:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple61:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 5216+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5217+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 5235+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5236+1 ./Project_Test/Tests/test_436/test.s
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
%line 5250+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode61
%line 5251+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont61

 Lcode61:
 push rbp
 mov rbp , rsp

 lambdaSimple62:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 5258+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5259+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 5277+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5278+1 ./Project_Test/Tests/test_436/test.s
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
%line 5292+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode62
%line 5293+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont62

 Lcode62:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 leave
 ret

 Lcont62:
 leave
 ret

 Lcont61:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont60:

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


 lambdaSimple57:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 5359+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5360+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 5378+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5379+1 ./Project_Test/Tests/test_436/test.s
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
%line 5393+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode57
%line 5394+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont57

 Lcode57:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple58:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 5404+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5405+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 5423+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5424+1 ./Project_Test/Tests/test_436/test.s
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
%line 5438+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode58
%line 5439+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont58

 Lcode58:
 push rbp
 mov rbp , rsp

 lambdaSimple59:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 5446+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5447+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 5465+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5466+1 ./Project_Test/Tests/test_436/test.s
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
%line 5480+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode59
%line 5481+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont59

 Lcode59:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 leave
 ret

 Lcont59:
 leave
 ret

 Lcont58:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont57:

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


 lambdaSimple54:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 5533+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5534+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 5552+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5553+1 ./Project_Test/Tests/test_436/test.s
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
%line 5567+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode54
%line 5568+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont54

 Lcode54:
 push rbp
 mov rbp , rsp

 lambdaSimple55:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 5575+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5576+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 5594+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5595+1 ./Project_Test/Tests/test_436/test.s
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
%line 5609+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode55
%line 5610+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont55

 Lcode55:
 push rbp
 mov rbp , rsp

 lambdaSimple56:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 5617+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5618+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 5636+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5637+1 ./Project_Test/Tests/test_436/test.s
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
%line 5651+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode56
%line 5652+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont56

 Lcode56:
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


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont56:
 leave
 ret

 Lcont55:
 leave
 ret

 Lcont54:

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


 lambdaSimple51:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 5747+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5748+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 5766+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5767+1 ./Project_Test/Tests/test_436/test.s
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
%line 5781+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode51
%line 5782+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont51

 Lcode51:
 push rbp
 mov rbp , rsp

 lambdaSimple52:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 5789+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5790+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 5808+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5809+1 ./Project_Test/Tests/test_436/test.s
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
%line 5823+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode52
%line 5824+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont52

 Lcode52:
 push rbp
 mov rbp , rsp

 lambdaSimple53:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 5831+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5832+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 5850+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5851+1 ./Project_Test/Tests/test_436/test.s
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
%line 5865+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode53
%line 5866+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont53

 Lcode53:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont53:
 leave
 ret

 Lcont52:
 leave
 ret

 Lcont51:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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

 Lcont50:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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


 lambdaSimple47:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 5983+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5984+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 6002+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6003+1 ./Project_Test/Tests/test_436/test.s
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
%line 6017+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode47
%line 6018+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont47

 Lcode47:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple48:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 6028+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6029+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 6047+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6048+1 ./Project_Test/Tests/test_436/test.s
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
%line 6062+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode48
%line 6063+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont48

 Lcode48:
 push rbp
 mov rbp , rsp

 lambdaSimple49:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 6070+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6071+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 6089+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6090+1 ./Project_Test/Tests/test_436/test.s
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
%line 6104+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode49
%line 6105+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont49

 Lcode49:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont49:
 leave
 ret

 Lcont48:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont47:

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

 Lcont46:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont45:
 leave
 ret

 Lcont44:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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


 lambdaSimple38:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 6217+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6218+1 ./Project_Test/Tests/test_436/test.s
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
%line 6236+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6237+1 ./Project_Test/Tests/test_436/test.s
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
%line 6251+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode38
%line 6252+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont38

 Lcode38:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple42:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 6262+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6263+1 ./Project_Test/Tests/test_436/test.s
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
%line 6281+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6282+1 ./Project_Test/Tests/test_436/test.s
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
%line 6296+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode42
%line 6297+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont42

 Lcode42:
 push rbp
 mov rbp , rsp

 lambdaSimple43:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 6304+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6305+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 6323+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6324+1 ./Project_Test/Tests/test_436/test.s
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
%line 6338+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode43
%line 6339+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont43

 Lcode43:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 leave
 ret

 Lcont43:
 leave
 ret

 Lcont42:
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple39:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 6363+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6364+1 ./Project_Test/Tests/test_436/test.s
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
%line 6382+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6383+1 ./Project_Test/Tests/test_436/test.s
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
%line 6397+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode39
%line 6398+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont39

 Lcode39:
 push rbp
 mov rbp , rsp

 lambdaSimple40:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 6405+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6406+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 6424+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6425+1 ./Project_Test/Tests/test_436/test.s
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
%line 6439+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode40
%line 6440+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont40

 Lcode40:
 push rbp
 mov rbp , rsp

 lambdaSimple41:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 6447+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6448+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 6466+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6467+1 ./Project_Test/Tests/test_436/test.s
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
%line 6481+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode41
%line 6482+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont41

 Lcode41:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont41:
 leave
 ret

 Lcont40:
 leave
 ret

 Lcont39:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont38:

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


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 lambdaSimple12:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 6571+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6572+1 ./Project_Test/Tests/test_436/test.s
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
%line 6590+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6591+1 ./Project_Test/Tests/test_436/test.s
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
%line 6605+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode12
%line 6606+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont12

 Lcode12:
 push rbp
 mov rbp , rsp

 lambdaSimple13:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 6613+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6614+1 ./Project_Test/Tests/test_436/test.s
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
%line 6632+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6633+1 ./Project_Test/Tests/test_436/test.s
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
%line 6647+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode13
%line 6648+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont13

 Lcode13:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple14:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 6667+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6668+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 6686+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6687+1 ./Project_Test/Tests/test_436/test.s
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
%line 6701+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode14
%line 6702+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont14

 Lcode14:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 lambdaSimple36:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 6718+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6719+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 6737+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6738+1 ./Project_Test/Tests/test_436/test.s
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
%line 6752+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode36
%line 6753+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont36

 Lcode36:
 push rbp
 mov rbp , rsp

 lambdaSimple37:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 6760+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6761+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 6779+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6780+1 ./Project_Test/Tests/test_436/test.s
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
%line 6794+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode37
%line 6795+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont37

 Lcode37:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont37:
 leave
 ret

 Lcont36:
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple34:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 6818+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6819+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 6837+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6838+1 ./Project_Test/Tests/test_436/test.s
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
%line 6852+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode34
%line 6853+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont34

 Lcode34:
 push rbp
 mov rbp , rsp

 lambdaSimple35:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 6860+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6861+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 6879+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6880+1 ./Project_Test/Tests/test_436/test.s
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
%line 6894+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode35
%line 6895+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont35

 Lcode35:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont35:
 leave
 ret

 Lcont34:
 push rax
 push 1


 lambdaSimple31:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 6915+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6916+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 6934+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6935+1 ./Project_Test/Tests/test_436/test.s
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
%line 6949+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode31
%line 6950+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont31

 Lcode31:
 push rbp
 mov rbp , rsp

 lambdaSimple32:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 6957+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6958+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 6976+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6977+1 ./Project_Test/Tests/test_436/test.s
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
%line 6991+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode32
%line 6992+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont32

 Lcode32:
 push rbp
 mov rbp , rsp

 lambdaSimple33:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 6999+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7000+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 7018+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7019+1 ./Project_Test/Tests/test_436/test.s
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
%line 7033+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode33
%line 7034+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont33

 Lcode33:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont33:
 leave
 ret

 Lcont32:
 leave
 ret

 Lcont31:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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


 mov rax, 6666
 push rax

 lambdaSimple18:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 7123+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7124+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 7142+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7143+1 ./Project_Test/Tests/test_436/test.s
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
%line 7157+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode18
%line 7158+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont18

 Lcode18:
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


 lambdaSimple28:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 7176+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7177+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 7195+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7196+1 ./Project_Test/Tests/test_436/test.s
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
%line 7210+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode28
%line 7211+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont28

 Lcode28:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple29:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 7221+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7222+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 7240+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7241+1 ./Project_Test/Tests/test_436/test.s
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
%line 7255+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode29
%line 7256+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont29

 Lcode29:
 push rbp
 mov rbp , rsp

 lambdaSimple30:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 7263+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7264+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 7282+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7283+1 ./Project_Test/Tests/test_436/test.s
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
%line 7297+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode30
%line 7298+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont30

 Lcode30:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 leave
 ret

 Lcont30:
 leave
 ret

 Lcont29:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont28:

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


 lambdaSimple25:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 7364+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7365+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 7383+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7384+1 ./Project_Test/Tests/test_436/test.s
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
%line 7398+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode25
%line 7399+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont25

 Lcode25:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple26:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 7409+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7410+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 7428+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7429+1 ./Project_Test/Tests/test_436/test.s
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
%line 7443+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode26
%line 7444+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont26

 Lcode26:
 push rbp
 mov rbp , rsp

 lambdaSimple27:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 7451+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7452+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 7470+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7471+1 ./Project_Test/Tests/test_436/test.s
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
%line 7485+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode27
%line 7486+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont27

 Lcode27:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 leave
 ret

 Lcont27:
 leave
 ret

 Lcont26:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont25:

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


 lambdaSimple22:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 7538+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7539+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 7557+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7558+1 ./Project_Test/Tests/test_436/test.s
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
%line 7572+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode22
%line 7573+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont22

 Lcode22:
 push rbp
 mov rbp , rsp

 lambdaSimple23:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 7580+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7581+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 7599+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7600+1 ./Project_Test/Tests/test_436/test.s
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
%line 7614+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode23
%line 7615+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont23

 Lcode23:
 push rbp
 mov rbp , rsp

 lambdaSimple24:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 7622+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7623+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 7641+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7642+1 ./Project_Test/Tests/test_436/test.s
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
%line 7656+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode24
%line 7657+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont24

 Lcode24:
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


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
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

 leave
 ret

 Lcont24:
 leave
 ret

 Lcont23:
 leave
 ret

 Lcont22:

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


 lambdaSimple19:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 7752+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7753+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 7771+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7772+1 ./Project_Test/Tests/test_436/test.s
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
%line 7786+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode19
%line 7787+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont19

 Lcode19:
 push rbp
 mov rbp , rsp

 lambdaSimple20:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 7794+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7795+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 7813+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7814+1 ./Project_Test/Tests/test_436/test.s
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
%line 7828+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode20
%line 7829+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont20

 Lcode20:
 push rbp
 mov rbp , rsp

 lambdaSimple21:
 add qword [malloc_pointer], 8 * (1 + 8)
%line 7836+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 8)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7837+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 8
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
%line 7855+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7856+1 ./Project_Test/Tests/test_436/test.s
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
%line 7870+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode21
%line 7871+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont21

 Lcode21:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont21:
 leave
 ret

 Lcont20:
 leave
 ret

 Lcont19:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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

 Lcont18:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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


 lambdaSimple15:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 7988+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7989+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 8007+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8008+1 ./Project_Test/Tests/test_436/test.s
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
%line 8022+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode15
%line 8023+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont15

 Lcode15:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple16:
 add qword [malloc_pointer], 8 * (1 + 6)
%line 8033+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 6)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8034+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 6
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
%line 8052+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8053+1 ./Project_Test/Tests/test_436/test.s
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
%line 8067+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode16
%line 8068+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont16

 Lcode16:
 push rbp
 mov rbp , rsp

 lambdaSimple17:
 add qword [malloc_pointer], 8 * (1 + 7)
%line 8075+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 7)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8076+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 7
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
%line 8094+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8095+1 ./Project_Test/Tests/test_436/test.s
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
%line 8109+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode17
%line 8110+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont17

 Lcode17:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont17:
 leave
 ret

 Lcont16:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 leave
 ret

 Lcont15:

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

 Lcont14:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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

 Lcont13:
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


 lambdaSimple6:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 8222+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8223+1 ./Project_Test/Tests/test_436/test.s
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
%line 8241+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8242+1 ./Project_Test/Tests/test_436/test.s
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
%line 8256+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode6
%line 8257+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont6

 Lcode6:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple10:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 8267+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8268+1 ./Project_Test/Tests/test_436/test.s
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
%line 8286+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8287+1 ./Project_Test/Tests/test_436/test.s
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
%line 8301+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode10
%line 8302+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont10

 Lcode10:
 push rbp
 mov rbp , rsp

 lambdaSimple11:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 8309+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8310+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 8328+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8329+1 ./Project_Test/Tests/test_436/test.s
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
%line 8343+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode11
%line 8344+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont11

 Lcode11:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 leave
 ret

 Lcont11:
 leave
 ret

 Lcont10:
 push rax
 push 1


 mov rax, 6666
 push rax

 lambdaSimple7:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 8368+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8369+1 ./Project_Test/Tests/test_436/test.s
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
%line 8387+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8388+1 ./Project_Test/Tests/test_436/test.s
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
%line 8402+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode7
%line 8403+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont7

 Lcode7:
 push rbp
 mov rbp , rsp

 lambdaSimple8:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 8410+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8411+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 8429+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8430+1 ./Project_Test/Tests/test_436/test.s
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
%line 8444+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode8
%line 8445+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont8

 Lcode8:
 push rbp
 mov rbp , rsp

 lambdaSimple9:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 8452+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8453+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 8471+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8472+1 ./Project_Test/Tests/test_436/test.s
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
%line 8486+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode9
%line 8487+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont9

 Lcode9:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont9:
 leave
 ret

 Lcont8:
 leave
 ret

 Lcont7:
 push rax
 push 1

 mov rax, qword [rbp+(4+0)*8]
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


 lambdaSimple2:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 8553+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8554+1 ./Project_Test/Tests/test_436/test.s
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
%line 8572+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8573+1 ./Project_Test/Tests/test_436/test.s
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
%line 8587+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode2
%line 8588+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont2

 Lcode2:
 push rbp
 mov rbp , rsp

 lambdaSimple3:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 8595+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8596+1 ./Project_Test/Tests/test_436/test.s
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
%line 8614+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8615+1 ./Project_Test/Tests/test_436/test.s
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
%line 8629+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode3
%line 8630+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont3

 Lcode3:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax

 lambdaSimple4:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 8640+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8641+1 ./Project_Test/Tests/test_436/test.s
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
 add qword [malloc_pointer], 8*1
%line 8659+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8660+1 ./Project_Test/Tests/test_436/test.s
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
%line 8674+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode4
%line 8675+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont4

 Lcode4:
 push rbp
 mov rbp , rsp

 lambdaSimple5:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 8682+0 ./Project_Test/Tests/test_436/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8683+1 ./Project_Test/Tests/test_436/test.s
 mov r11, r10
 mov r12, 0
 mov r13, 1
 mov r15, qword[rbp + 16]

 .copy_env:
 cmp r12, 5
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
%line 8701+0 ./Project_Test/Tests/test_436/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8702+1 ./Project_Test/Tests/test_436/test.s
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
%line 8716+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode5
%line 8717+1 ./Project_Test/Tests/test_436/test.s
 jmp Lcont5

 Lcode5:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 leave
 ret

 Lcont5:
 leave
 ret

 Lcont4:
 push rax
 push 1


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 1

 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
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
 leave
 ret

 Lcont2:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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
 leave
 ret

 Lcont0:

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


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
%line 9042+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9043+1 ./Project_Test/Tests/test_436/test.s

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
%line 9059+0 ./Project_Test/Tests/test_436/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 9060+1 ./Project_Test/Tests/test_436/test.s

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
%line 9094+0 ./Project_Test/Tests/test_436/test.s
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
..@656.str_loop:
 jz ..@656.str_loop_end
 dec rcx
 mov byte [rax+rcx], dil
 jmp ..@656.str_loop
..@656.str_loop_end:
 pop rcx
 sub rax, 8+1
%line 9095+1 ./Project_Test/Tests/test_436/test.s

 leave
 ret

vector_length:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 add qword [malloc_pointer], 1+8
%line 9105+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9106+1 ./Project_Test/Tests/test_436/test.s

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
%line 9154+0 ./Project_Test/Tests/test_436/test.s
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
..@666.vec_loop:
 jz ..@666.vec_loop_end
 dec rcx
 mov qword [rax+rcx*8], rdi
 jmp ..@666.vec_loop
..@666.vec_loop_end:
 sub rax, 8+1
 pop rcx
%line 9155+1 ./Project_Test/Tests/test_436/test.s

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
%line 9174+0 ./Project_Test/Tests/test_436/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], dil
%line 9175+1 ./Project_Test/Tests/test_436/test.s
 push rax
 add qword [malloc_pointer], 1+8
%line 9176+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rcx
%line 9177+1 ./Project_Test/Tests/test_436/test.s
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
%line 9212+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9213+1 ./Project_Test/Tests/test_436/test.s

 leave
 ret

integer_to_char:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 and rsi, 255
 add qword [malloc_pointer], 1+1
%line 9225+0 ./Project_Test/Tests/test_436/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 9226+1 ./Project_Test/Tests/test_436/test.s

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
%line 9317+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9318+1 ./Project_Test/Tests/test_436/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9322+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9323+1 ./Project_Test/Tests/test_436/test.s

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
%line 9397+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9398+1 ./Project_Test/Tests/test_436/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9402+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9403+1 ./Project_Test/Tests/test_436/test.s

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
%line 9477+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9478+1 ./Project_Test/Tests/test_436/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9482+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9483+1 ./Project_Test/Tests/test_436/test.s

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
%line 9557+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9558+1 ./Project_Test/Tests/test_436/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9562+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9563+1 ./Project_Test/Tests/test_436/test.s

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
%line 9637+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9638+1 ./Project_Test/Tests/test_436/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9642+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9643+1 ./Project_Test/Tests/test_436/test.s

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
%line 9729+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9730+1 ./Project_Test/Tests/test_436/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9734+0 ./Project_Test/Tests/test_436/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9735+1 ./Project_Test/Tests/test_436/test.s

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
%line 9819+0 ./Project_Test/Tests/test_436/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 9820+1 ./Project_Test/Tests/test_436/test.s

 jmp .return

.return:
 leave
 ret
