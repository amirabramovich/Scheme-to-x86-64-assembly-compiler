%line 1+1 ./Project_Test/Tests/test_448/test.s



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
%line 5+1 ./Project_Test/Tests/test_448/test.s

[section .bss]
malloc_pointer:
 resq 1

[section .data]
const_tbl:
db 1
db 2
 db 5
%line 14+0 ./Project_Test/Tests/test_448/test.s
 db 0
%line 15+1 ./Project_Test/Tests/test_448/test.s
 db 5
%line 15+0 ./Project_Test/Tests/test_448/test.s
 db 1
%line 16+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 16+0 ./Project_Test/Tests/test_448/test.s
dq (..@39.end_str - ..@39.str)
..@39.str:
db "null?"
..@39.end_str:
%line 17+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 17+0 ./Project_Test/Tests/test_448/test.s
dq (..@40.end_str - ..@40.str)
..@40.str:
db "car"
..@40.end_str:
%line 18+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 18+0 ./Project_Test/Tests/test_448/test.s
dq (..@41.end_str - ..@41.str)
..@41.str:
db "cdr"
..@41.end_str:
%line 19+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 19+0 ./Project_Test/Tests/test_448/test.s
dq (..@42.end_str - ..@42.str)
..@42.str:
db "lst"
..@42.end_str:
%line 20+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 20+0 ./Project_Test/Tests/test_448/test.s
dq (..@43.end_str - ..@43.str)
..@43.str:
db "p"
..@43.end_str:
%line 21+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 21+0 ./Project_Test/Tests/test_448/test.s
dq (..@44.end_str - ..@44.str)
..@44.str:
db "andmap"
..@44.end_str:
%line 22+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 22+0 ./Project_Test/Tests/test_448/test.s
dq (..@45.end_str - ..@45.str)
..@45.str:
db "loop"
..@45.end_str:
%line 23+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 23+0 ./Project_Test/Tests/test_448/test.s
dq (..@46.end_str - ..@46.str)
..@46.str:
db "="
..@46.end_str:
%line 24+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 24+0 ./Project_Test/Tests/test_448/test.s
dq (..@47.end_str - ..@47.str)
..@47.str:
db "columns"
..@47.end_str:
%line 25+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 25+0 ./Project_Test/Tests/test_448/test.s
dq (..@48.end_str - ..@48.str)
..@48.str:
db "vector-set!"
..@48.end_str:
%line 26+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 26+0 ./Project_Test/Tests/test_448/test.s
dq (..@49.end_str - ..@49.str)
..@49.str:
db "+"
..@49.end_str:
%line 27+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 27+0 ./Project_Test/Tests/test_448/test.s
dq (..@50.end_str - ..@50.str)
..@50.str:
db "i"
..@50.end_str:
%line 28+1 ./Project_Test/Tests/test_448/test.s
 db 3
%line 28+0 ./Project_Test/Tests/test_448/test.s
 dq 1
%line 29+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 29+0 ./Project_Test/Tests/test_448/test.s
dq (..@52.end_str - ..@52.str)
..@52.str:
db "m"
..@52.end_str:
%line 30+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 30+0 ./Project_Test/Tests/test_448/test.s
dq (..@53.end_str - ..@53.str)
..@53.str:
db "make-vector"
..@53.end_str:
%line 31+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 31+0 ./Project_Test/Tests/test_448/test.s
dq (..@54.end_str - ..@54.str)
..@54.str:
db "rows"
..@54.end_str:
%line 32+1 ./Project_Test/Tests/test_448/test.s
 db 3
%line 32+0 ./Project_Test/Tests/test_448/test.s
 dq 0
%line 33+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 33+0 ./Project_Test/Tests/test_448/test.s
dq (..@56.end_str - ..@56.str)
..@56.str:
db "whatever"
..@56.end_str:
%line 34+1 ./Project_Test/Tests/test_448/test.s
db 8
%line 34+0 ./Project_Test/Tests/test_448/test.s
dq (const_tbl + 221)
%line 35+1 ./Project_Test/Tests/test_448/test.s
db 7
%line 35+0 ./Project_Test/Tests/test_448/test.s
dq (..@58.end_str - ..@58.str)
..@58.str:
db "make-matrix"
..@58.end_str:
%line 36+1 ./Project_Test/Tests/test_448/test.s



%line 43+1 ./Project_Test/Tests/test_448/test.s

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
%line 110+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_boolean
%line 111+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 0 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 112+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_float
%line 113+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 1 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 114+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_integer
%line 115+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 2 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 116+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_pair
%line 117+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 3 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 118+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_null
%line 119+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 4 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 120+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_char
%line 121+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 5 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 122+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_vector
%line 123+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 6 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 124+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_string
%line 125+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 7 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 126+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_procedure
%line 127+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 8 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 128+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_symbol
%line 129+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 9 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 130+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_length
%line 131+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 10 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 132+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_ref
%line 133+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 11 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 134+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_set
%line 135+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 12 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 136+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_string
%line 137+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 13 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 138+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_length
%line 139+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 14 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 140+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_ref
%line 141+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 15 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 142+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_set
%line 143+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 16 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 144+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_vector
%line 145+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 17 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 146+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], symbol_to_string
%line 147+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 18 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 148+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], char_to_integer
%line 149+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 19 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 150+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], integer_to_char
%line 151+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 20 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 152+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_eq
%line 153+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 21 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 154+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_add
%line 155+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 22 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 156+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_mul
%line 157+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 23 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 158+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_sub
%line 159+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 24 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 160+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_div
%line 161+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 25 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 162+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_lt
%line 163+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 26 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 164+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_equ
%line 165+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 27 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 166+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], car
%line 167+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 28 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 168+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cdr
%line 169+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 29 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 170+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_car
%line 171+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 30 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 172+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_cdr
%line 173+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 31 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 174+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cons
%line 175+1 ./Project_Test/Tests/test_448/test.s
 mov [fvar_tbl + 32 * 8], rax

user_code:

 lambdaSimple0:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 180+0 ./Project_Test/Tests/test_448/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 181+1 ./Project_Test/Tests/test_448/test.s
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
%line 199+0 ./Project_Test/Tests/test_448/test.s
 push 8*0
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 200+1 ./Project_Test/Tests/test_448/test.s
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
%line 214+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode0
%line 215+1 ./Project_Test/Tests/test_448/test.s
 jmp Lcont0

 Lcode0:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
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
 jne LexitOr1


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
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

 cmp rax, const_tbl + 2
 je Lelse2

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
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

 jmp LexitIf2
 Lelse2:
 mov rax, const_tbl + 2
 LexitIf2:
 cmp rax, const_tbl + 2
 jne LexitOr1
 LexitOr1:
 leave
 ret

 Lcont0:
 mov qword [fvar_tbl + 34 * 8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 lambdaSimple3:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 342+0 ./Project_Test/Tests/test_448/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 343+1 ./Project_Test/Tests/test_448/test.s
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
 add qword [malloc_pointer], 8*2
%line 361+0 ./Project_Test/Tests/test_448/test.s
 push 8*2
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 362+1 ./Project_Test/Tests/test_448/test.s
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
%line 376+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode3
%line 377+1 ./Project_Test/Tests/test_448/test.s
 jmp Lcont3

 Lcode3:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, const_tbl + 238
 push rax
 push 1


 lambdaSimple4:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 391+0 ./Project_Test/Tests/test_448/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 392+1 ./Project_Test/Tests/test_448/test.s
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
%line 410+0 ./Project_Test/Tests/test_448/test.s
 push 8*2
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 411+1 ./Project_Test/Tests/test_448/test.s
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
%line 425+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode4
%line 426+1 ./Project_Test/Tests/test_448/test.s
 jmp Lcont4

 Lcode4:
 push rbp
 mov rbp , rsp
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


 lambdaSimple5:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 438+0 ./Project_Test/Tests/test_448/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 439+1 ./Project_Test/Tests/test_448/test.s
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
%line 457+0 ./Project_Test/Tests/test_448/test.s
 push 8*1
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 458+1 ./Project_Test/Tests/test_448/test.s
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
%line 472+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode5
%line 473+1 ./Project_Test/Tests/test_448/test.s
 jmp Lcont5

 Lcode5:
 push rbp
 mov rbp , rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 push rax
 mov rax, qword [rbp+(4+1)*8]
 mov r15, 7777
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
 je Lelse6
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 jmp LexitIf6
 Lelse6:

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 push rax
 push 1

 mov rax, qword [fvar_tbl + 17 * 8]

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
 mov rax, qword [rbp+(4+1)*8]
 mov r15, 7777
 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
 push rax
 push 3

 mov rax, qword [fvar_tbl + 16 * 8]

 mov rbx, [rax + 1]
 push rbx
 mov rbx, [rax + 1 + 8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx



 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, const_tbl + 160
 push rax
 mov rax, qword [rbp+(4+1)*8]
 mov r15, 7777
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

 push rax
 mov rax, qword [rbp+(4+0)*8]
 mov r15, 7777
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

 LexitIf6:
 leave
 ret

 Lcont5:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0


 mov rax, 6666
 push rax
 mov rax, const_tbl + 212
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 push 1

 mov rax, qword [fvar_tbl + 17 * 8]

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

 Lcont4:

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
 mov qword [fvar_tbl + 33 * 8], rax
 mov rax, const_tbl + 0
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
%line 864+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 865+1 ./Project_Test/Tests/test_448/test.s

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
%line 881+0 ./Project_Test/Tests/test_448/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 882+1 ./Project_Test/Tests/test_448/test.s

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
%line 916+0 ./Project_Test/Tests/test_448/test.s
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
..@155.str_loop:
 jz ..@155.str_loop_end
 dec rcx
 mov byte [rax+rcx], dil
 jmp ..@155.str_loop
..@155.str_loop_end:
 pop rcx
 sub rax, 8+1
%line 917+1 ./Project_Test/Tests/test_448/test.s

 leave
 ret

vector_length:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 add qword [malloc_pointer], 1+8
%line 927+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 928+1 ./Project_Test/Tests/test_448/test.s

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
%line 976+0 ./Project_Test/Tests/test_448/test.s
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
..@165.vec_loop:
 jz ..@165.vec_loop_end
 dec rcx
 mov qword [rax+rcx*8], rdi
 jmp ..@165.vec_loop
..@165.vec_loop_end:
 sub rax, 8+1
 pop rcx
%line 977+1 ./Project_Test/Tests/test_448/test.s

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
%line 996+0 ./Project_Test/Tests/test_448/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], dil
%line 997+1 ./Project_Test/Tests/test_448/test.s
 push rax
 add qword [malloc_pointer], 1+8
%line 998+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rcx
%line 999+1 ./Project_Test/Tests/test_448/test.s
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
%line 1034+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1035+1 ./Project_Test/Tests/test_448/test.s

 leave
 ret

integer_to_char:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 and rsi, 255
 add qword [malloc_pointer], 1+1
%line 1047+0 ./Project_Test/Tests/test_448/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 1048+1 ./Project_Test/Tests/test_448/test.s

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
%line 1139+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1140+1 ./Project_Test/Tests/test_448/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1144+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1145+1 ./Project_Test/Tests/test_448/test.s

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
%line 1219+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1220+1 ./Project_Test/Tests/test_448/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1224+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1225+1 ./Project_Test/Tests/test_448/test.s

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
%line 1299+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1300+1 ./Project_Test/Tests/test_448/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1304+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1305+1 ./Project_Test/Tests/test_448/test.s

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
%line 1379+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1380+1 ./Project_Test/Tests/test_448/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1384+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1385+1 ./Project_Test/Tests/test_448/test.s

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
%line 1459+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1460+1 ./Project_Test/Tests/test_448/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1464+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1465+1 ./Project_Test/Tests/test_448/test.s

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
%line 1551+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 1552+1 ./Project_Test/Tests/test_448/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 1556+0 ./Project_Test/Tests/test_448/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 1557+1 ./Project_Test/Tests/test_448/test.s

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
%line 1641+0 ./Project_Test/Tests/test_448/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 1642+1 ./Project_Test/Tests/test_448/test.s

 jmp .return

.return:
 leave
 ret
