%line 1+1 ./Project_Test/Tests/test_3/test.s



%line 13+1 compiler.s

%line 22+1 compiler.s

%line 25+1 compiler.s

%line 29+1 compiler.s


%line 34+1 compiler.s




%line 41+1 compiler.s










%line 54+1 compiler.s





%line 62+1 compiler.s











%line 78+1 compiler.s




%line 89+1 compiler.s




%line 97+1 compiler.s


%line 105+1 compiler.s

%line 110+1 compiler.s




%line 132+1 compiler.s





%line 142+1 compiler.s





%line 152+1 compiler.s


%line 157+1 compiler.s





%line 180+1 compiler.s

%line 189+1 compiler.s





%line 212+1 compiler.s

%line 221+1 compiler.s




%line 231+1 compiler.s

%line 237+1 compiler.s

%line 240+1 compiler.s

%line 243+1 compiler.s

%line 246+1 compiler.s

%line 249+1 compiler.s

[extern exit]
%line 250+0 compiler.s
[extern printf]
[extern malloc]
%line 251+1 compiler.s
[global write_sob]
%line 251+0 compiler.s
[global write_sob_if_not_void]
%line 252+1 compiler.s


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

 cmp rbx, 32
 jg .ch_simple

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
%line 5+1 ./Project_Test/Tests/test_3/test.s

[section .bss]
malloc_pointer:
 resq 1

[section .data]
const_tbl:
db 1
db 2
 db 5
%line 14+0 ./Project_Test/Tests/test_3/test.s
 db 0
%line 15+1 ./Project_Test/Tests/test_3/test.s
 db 5
%line 15+0 ./Project_Test/Tests/test_3/test.s
 db 1
%line 16+1 ./Project_Test/Tests/test_3/test.s
 db 6
%line 16+0 ./Project_Test/Tests/test_3/test.s
 db 0
%line 17+1 ./Project_Test/Tests/test_3/test.s
db 7
%line 17+0 ./Project_Test/Tests/test_3/test.s
dq 57
db 116
db 104
db 105
db 115
db 32
db 115
db 104
db 111
db 117
db 108
db 100
db 32
db 98
db 101
db 32
db 97
db 110
db 32
db 101
db 114
db 114
db 111
db 114
db 44
db 32
db 98
db 117
db 116
db 32
db 121
db 111
db 117
db 32
db 100
db 111
db 110
db 39
db 116
db 32
db 115
db 117
db 112
db 112
db 111
db 114
db 116
db 32
db 101
db 120
db 99
db 101
db 112
db 116
db 105
db 111
db 110
db 115
%line 18+1 ./Project_Test/Tests/test_3/test.s
 db 3
%line 18+0 ./Project_Test/Tests/test_3/test.s
 dq 0
%line 19+1 ./Project_Test/Tests/test_3/test.s
 db 3
%line 19+0 ./Project_Test/Tests/test_3/test.s
 dq 1
%line 20+1 ./Project_Test/Tests/test_3/test.s
db 7
%line 20+0 ./Project_Test/Tests/test_3/test.s
dq 8
db 119
db 104
db 97
db 116
db 101
db 118
db 101
db 114
%line 21+1 ./Project_Test/Tests/test_3/test.s
db 8
%line 21+0 ./Project_Test/Tests/test_3/test.s
dq (const_tbl + 92)
%line 22+1 ./Project_Test/Tests/test_3/test.s



%line 29+1 ./Project_Test/Tests/test_3/test.s

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

[global main]
[section .text]
main:
 push rbp
 mov rbp, rsp


 mov rdi, 1024*1024*4*1024
 call malloc
 mov [malloc_pointer], rax






 push 0
 push qword const_tbl + 1
 push qword 0
 push rsp

 jmp code_fragment

code_fragment:





 add qword [malloc_pointer], 1+8*2
%line 108+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_boolean
%line 109+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 0 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 110+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_float
%line 111+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 1 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 112+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_integer
%line 113+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 2 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 114+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_pair
%line 115+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 3 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 116+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_null
%line 117+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 4 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 118+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_char
%line 119+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 5 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 120+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_vector
%line 121+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 6 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 122+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_string
%line 123+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 7 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 124+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_procedure
%line 125+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 8 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 126+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_symbol
%line 127+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 9 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 128+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_length
%line 129+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 10 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 130+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_ref
%line 131+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 11 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 132+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], string_set
%line 133+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 12 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 134+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_string
%line 135+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 13 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 136+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_length
%line 137+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 14 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 138+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_ref
%line 139+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 15 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 140+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], vector_set
%line 141+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 16 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 142+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], make_vector
%line 143+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 17 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 144+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], symbol_to_string
%line 145+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 18 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 146+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], char_to_integer
%line 147+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 19 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 148+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], integer_to_char
%line 149+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 20 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 150+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], is_eq
%line 151+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 21 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 152+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_add
%line 153+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 22 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 154+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_mul
%line 155+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 23 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 156+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_sub
%line 157+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 24 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 158+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_div
%line 159+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 25 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 160+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_lt
%line 161+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 26 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 162+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], bin_equ
%line 163+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 27 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 164+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], car
%line 165+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 28 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 166+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cdr
%line 167+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 29 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 168+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_car
%line 169+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 30 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 170+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], set_cdr
%line 171+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 31 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 172+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], cons
%line 173+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 32 * 8], rax
 add qword [malloc_pointer], 1+8*2
%line 174+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], const_tbl + 1
 mov qword [rax+1+8], apply
%line 175+1 ./Project_Test/Tests/test_3/test.s
 mov [fvar_tbl + 33 * 8], rax

user_code:

 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+32*8]
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 4
 push 4

lambdaSimple1:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 193+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 194+1 ./Project_Test/Tests/test_3/test.s
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
%line 212+0 ./Project_Test/Tests/test_3/test.s
 push 8*0
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 213+1 ./Project_Test/Tests/test_3/test.s
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
%line 227+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode1
%line 228+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont1

Lcode1:
 push rbp
 mov rbp, rsp


lambdaOpt2:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 1)
%line 237+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 238+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 256+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 257+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 271+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode2
%line 272+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont2

Lcode2:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 294+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 295+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rax, const_tbl+1
 push rax
 mov rcx, 2
 push 2

 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple4:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 328+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 329+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 347+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 348+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 362+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode4
%line 363+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont4

Lcode4:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 369+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 370+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple5:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 377+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 378+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 396+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 397+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 411+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode5
%line 412+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont5

Lcode5:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse6
 mov rax, qword [rbp+(4+0)*8]
 jmp LexitIf6

Lelse6:
 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1

 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple8:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 458+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 459+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 477+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 478+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 492+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode8
%line 493+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont8

Lcode8:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 499+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 500+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple9:
 add qword [malloc_pointer], 8 * (1 + 5)
%line 507+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 5)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 508+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 526+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 527+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 541+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode9
%line 542+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont9

Lcode9:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*4]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse10
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*4]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*4]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 628+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 629+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf10

Lelse10:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*4]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*4]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*4]
 mov rax, qword [rax+8*3]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 709+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 710+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf10:
 leave
 ret

Lcont9:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 leave
 ret

Lcont8:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 746+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 747+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf6:
 leave
 ret

Lcont5:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 leave
 ret

Lcont4:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 783+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 784+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave

 ret

Lcont2:
 leave
 ret

Lcont1:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+46*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+27*8]
 push rax
 mov rcx, 1
 push 1

lambdaSimple19:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 819+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 820+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 838+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 839+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 853+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode19
%line 854+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont19

Lcode19:
 push rbp
 mov rbp, rsp

lambdaSimple20:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 861+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 862+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 880+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 881+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 895+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode20
%line 896+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont20

Lcode20:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+74
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 917+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 918+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont20:
 leave
 ret

Lcont19:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+45*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void



lambdaOpt21:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 0)
%line 947+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 948+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 966+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 967+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 981+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode21
%line 982+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont21

Lcode21:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 1004+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 1005+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax


 mov rax, qword [rbp+(4+0)*8]
 leave

 ret

Lcont21:
 mov qword [fvar_tbl+44*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+3*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 3
 push 3

lambdaSimple23:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1044+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1045+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 1063+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1064+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 1078+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode23
%line 1079+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont23

Lcode23:
 push rbp
 mov rbp, rsp

lambdaSimple24:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1086+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1087+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 1105+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1106+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 1120+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode24
%line 1121+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont24

Lcode24:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 jne LexitOr25


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse27
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 1
 push 1
 mov rax, qword [fvar_tbl+43*8]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 1202+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 1203+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf27

Lelse27:
 mov rax, const_tbl+2


LexitIf27:
 cmp rax, const_tbl + 2
 jne LexitOr25

 LexitOr25:
 leave
 ret

Lcont24:
 leave
 ret

Lcont23:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+43*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+22*8]
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+3*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 4
 push 4

lambdaSimple31:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1254+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1255+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 1273+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1274+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 1288+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode31
%line 1289+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont31

Lcode31:
 push rbp
 mov rbp, rsp

lambdaSimple32:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1296+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1297+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 1315+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1316+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 1330+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode32
%line 1331+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont32

Lcode32:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 2
 push 2

lambdaSimple33:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 1346+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1347+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 1365+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1366+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 1380+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode33
%line 1381+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont33

Lcode33:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+1)*8]
 add qword [malloc_pointer], 8
%line 1387+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 1388+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+1)*8], rax
 mov rax, const_tbl + 0

 mov rax, const_tbl+74
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple34:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 1399+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1400+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 1418+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1419+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 1433+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode34
%line 1434+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont34

Lcode34:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse35
 mov rax, qword [rbp+(4+1)*8]
 jmp LexitIf35

Lelse35:

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse36
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, const_tbl+83
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 1544+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 1545+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf36

Lelse36:
 mov rax, const_tbl+8


LexitIf36:


LexitIf35:
 leave
 ret

Lcont34:
 push rax
 mov rax, qword [rbp+(4+1)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, 6666
 push rax
 mov rax, const_tbl+74
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp+(4+1)*8]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 1584+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 1585+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont33:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 1597+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 1598+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont32:
 leave
 ret

Lcont31:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+42*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+42*8]
 push rax
 mov rax, qword [fvar_tbl+27*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+13*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 5
 push 5

lambdaSimple42:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1640+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1641+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*4
%line 1659+0 ./Project_Test/Tests/test_3/test.s
 push 8*4
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1660+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 4
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
%line 1674+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode42
%line 1675+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont42

Lcode42:
 push rbp
 mov rbp, rsp


lambdaOpt43:
 mov rsi, 1
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1684+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1685+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 1703+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1704+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 1718+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode43
%line 1719+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont43

Lcode43:
 push rbp
 mov rbp , rsp



 mov r13, 1
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 1741+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 1742+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse44
 mov rax, 6666
 push rax
 mov rax, const_tbl+6
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 1796+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 1797+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf44

Lelse44:

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, const_tbl+83
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse45
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 1881+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 1882+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf45

Lelse45:
 mov rax, const_tbl+8


LexitIf45:


LexitIf44:
 leave

 ret

Lcont43:
 leave
 ret

Lcont42:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+13*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+17*8]
 push rax
 mov rax, qword [fvar_tbl+42*8]
 push rax
 mov rcx, 4
 push 4

lambdaSimple51:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 1933+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1934+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 1952+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1953+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 1967+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode51
%line 1968+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont51

Lcode51:
 push rbp
 mov rbp, rsp


lambdaOpt52:
 mov rsi, 1
 add qword [malloc_pointer], 8 * (1 + 1)
%line 1977+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 1978+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 1996+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 1997+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2011+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode52
%line 2012+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont52

Lcode52:
 push rbp
 mov rbp , rsp



 mov r13, 1
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 2034+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 2035+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse53
 mov rax, 6666
 push rax
 mov rax, const_tbl+74
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 2089+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 2090+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf53

Lelse53:

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, const_tbl+83
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [fvar_tbl+27*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse54
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 2172+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 2173+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf54

Lelse54:
 mov rax, const_tbl+8


LexitIf54:


LexitIf53:
 leave

 ret

Lcont52:
 leave
 ret

Lcont51:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+17*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+21*8]
 push rax
 mov rcx, 1
 push 1

lambdaSimple60:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 2218+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2219+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2237+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2238+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2252+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode60
%line 2253+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont60

Lcode60:
 push rbp
 mov rbp, rsp

lambdaSimple61:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 2260+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2261+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2279+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2280+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2294+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode61
%line 2295+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont61

Lcode61:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, const_tbl+4
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse62
 mov rax, const_tbl+2
 jmp LexitIf62

Lelse62:
 mov rax, const_tbl+4


LexitIf62:
 leave
 ret

Lcont61:
 leave
 ret

Lcont60:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+41*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+2*8]
 push rax
 mov rax, qword [fvar_tbl+1*8]
 push rax
 mov rcx, 2
 push 2

lambdaSimple65:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 2365+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2366+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2384+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2385+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2399+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode65
%line 2400+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont65

Lcode65:
 push rbp
 mov rbp, rsp

lambdaSimple66:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 2407+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2408+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2426+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2427+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2441+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode66
%line 2442+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont66

Lcode66:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 jne LexitOr67

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 2484+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 2485+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 cmp rax, const_tbl + 2
 jne LexitOr67

 LexitOr67:
 leave
 ret

Lcont66:
 leave
 ret

Lcont65:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+40*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+33*8]
 push rax
 mov rax, qword [fvar_tbl+32*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 5
 push 5

lambdaSimple70:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 2531+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2532+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2550+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2551+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2565+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode70
%line 2566+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont70

Lcode70:
 push rbp
 mov rbp, rsp


lambdaOpt71:
 mov rsi, 2
 add qword [malloc_pointer], 8 * (1 + 1)
%line 2575+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2576+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2594+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2595+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2609+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode71
%line 2610+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont71

Lcode71:
 push rbp
 mov rbp , rsp



 mov r13, 2
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 2632+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 2633+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+2)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse72
 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1

lambdaSimple84:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 2679+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2680+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2698+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2699+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2713+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode84
%line 2714+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont84

Lcode84:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple85:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 2727+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2728+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2746+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2747+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2761+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode85
%line 2762+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont85

Lcode85:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 2768+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 2769+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple86:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 2776+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 2777+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 2795+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 2796+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 2810+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode86
%line 2811+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont86

Lcode86:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse87
 mov rax, const_tbl+1
 jmp LexitIf87

Lelse87:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 2935+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 2936+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf87:
 leave
 ret

Lcont86:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 2966+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 2967+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont85:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 2979+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 2980+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont84:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 2992+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 2993+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf72

Lelse72:
 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+2)*8]
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 2
 push 2

lambdaSimple73:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 3009+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3010+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 3028+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3029+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 3043+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode73
%line 3044+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont73

Lcode73:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple74:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 3057+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3058+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 3076+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3077+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 3091+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode74
%line 3092+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont74

Lcode74:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 3098+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 3099+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple75:
 add qword [malloc_pointer], 8 * (1 + 4)
%line 3106+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 4)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3107+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 3125+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3126+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 3140+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode75
%line 3141+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont75

Lcode75:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse76
 mov rax, const_tbl+1
 jmp LexitIf76

Lelse76:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*4]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [fvar_tbl+39*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*3]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [fvar_tbl+39*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 3
 push 3
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*3]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 3315+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 3316+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf76:
 leave
 ret

Lcont75:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 3350+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 3351+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont74:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 3363+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 3364+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont73:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 3376+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 3377+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf72:
 leave

 ret

Lcont71:
 leave
 ret

Lcont70:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+39*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+22*8]
 push rax
 mov rax, qword [fvar_tbl+42*8]
 push rax
 mov rax, qword [fvar_tbl+17*8]
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+3*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 7
 push 7

lambdaSimple95:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 3427+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3428+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*5
%line 3446+0 ./Project_Test/Tests/test_3/test.s
 push 8*5
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3447+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 5
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
%line 3461+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode95
%line 3462+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont95

Lcode95:
 push rbp
 mov rbp, rsp

lambdaSimple96:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 3469+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3470+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 3488+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3489+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 3503+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode96
%line 3504+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont96

Lcode96:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple97:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 3517+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3518+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 3536+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3537+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 3551+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode97
%line 3552+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont97

Lcode97:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 3558+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 3559+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple98:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 3566+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3567+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 3585+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3586+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 3600+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode98
%line 3601+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont98

Lcode98:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse99
 mov rax, qword [rbp+(4+1)*8]
 jmp LexitIf99

Lelse99:

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse100
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+2)*8]
 push rax
 mov rax, const_tbl+83
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*6]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+2)*8]
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 3
 push 3
 mov rax, qword [fvar_tbl+16*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx


 mov rax, qword [rbp+(4+1)*8]
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 3
 push 3
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 3755+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*8]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 3756+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf100

Lelse100:
 mov rax, const_tbl+8


LexitIf100:


LexitIf99:
 leave
 ret

Lcont98:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, 6666
 push rax
 mov rax, const_tbl+74
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*5]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 3
 push 3
 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 3837+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*8]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 3838+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont97:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 3850+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 3851+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont96:
 leave
 ret

Lcont95:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+38*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+24*8]
 push rax
 mov rax, qword [fvar_tbl+14*8]
 push rax
 mov rax, qword [fvar_tbl+32*8]
 push rax
 mov rax, qword [fvar_tbl+15*8]
 push rax
 mov rax, qword [fvar_tbl+26*8]
 push rax
 mov rcx, 5
 push 5

lambdaSimple110:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 3893+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3894+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 3912+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3913+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 3927+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode110
%line 3928+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont110

Lcode110:
 push rbp
 mov rbp, rsp

lambdaSimple111:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 3935+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3936+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 3954+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 3955+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 3969+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode111
%line 3970+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont111

Lcode111:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple112:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 3983+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 3984+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4002+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4003+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4017+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode112
%line 4018+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont112

Lcode112:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 4024+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 4025+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple113:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 4032+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4033+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4051+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4052+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4066+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode113
%line 4067+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont113

Lcode113:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, const_tbl+74
 push rax
 mov rax, qword [rbp+(4+2)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse114
 mov rax, qword [rbp+(4+1)*8]
 jmp LexitIf114

Lelse114:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, const_tbl+83
 push rax
 mov rax, qword [rbp+(4+2)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+2)*8]
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 3
 push 3
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 4182+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*8]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 4183+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf114:
 leave
 ret

Lcont113:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, const_tbl+83
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, const_tbl+1
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 3
 push 3
 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 4259+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*8]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 4260+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont112:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 4272+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 4273+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont111:
 leave
 ret

Lcont110:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+37*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+38*8]
 push rax
 mov rcx, 1
 push 1

lambdaSimple122:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 4307+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4308+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4326+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4327+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4341+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode122
%line 4342+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont122

Lcode122:
 push rbp
 mov rbp, rsp


lambdaOpt123:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 1)
%line 4351+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4352+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4370+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4371+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4385+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode123
%line 4386+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont123

Lcode123:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 4408+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 4409+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 4439+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 4440+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave

 ret

Lcont123:
 leave
 ret

Lcont122:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+36*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+33*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+22*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 5
 push 5

lambdaSimple125:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 4483+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4484+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4502+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4503+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4517+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode125
%line 4518+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont125

Lcode125:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple126:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 4531+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4532+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4550+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4551+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4565+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode126
%line 4566+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont126

Lcode126:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 4572+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 4573+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0



lambdaOpt127:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 2)
%line 4582+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4583+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4601+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4602+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4616+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode127
%line 4617+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont127

Lcode127:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 4639+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 4640+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse128
 mov rax, const_tbl+74
 jmp LexitIf128

Lelse128:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 4760+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 4761+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf128:
 leave

 ret

Lcont127:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 leave
 ret

Lcont126:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 4788+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 4789+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont125:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+22*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+33*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+23*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 5
 push 5

lambdaSimple134:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 4827+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4828+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4846+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4847+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4861+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode134
%line 4862+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont134

Lcode134:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple135:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 4875+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4876+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4894+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4895+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4909+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode135
%line 4910+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont135

Lcode135:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 4916+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 4917+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0



lambdaOpt136:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 2)
%line 4926+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 4927+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 4945+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 4946+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 4960+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode136
%line 4961+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont136

Lcode136:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 4983+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 4984+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse137
 mov rax, const_tbl+83
 jmp LexitIf137

Lelse137:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 5104+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 5105+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf137:
 leave

 ret

Lcont136:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0

 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 leave
 ret

Lcont135:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 5132+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 5133+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont134:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+23*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+42*8]
 push rax
 mov rax, qword [fvar_tbl+33*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+22*8]
 push rax
 mov rax, qword [fvar_tbl+24*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 7
 push 7

lambdaSimple143:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 5175+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5176+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 5194+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5195+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 5209+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode143
%line 5210+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont143

Lcode143:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple144:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 5223+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5224+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 5242+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5243+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 5257+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode144
%line 5258+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont144

Lcode144:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 5264+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 5265+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0



lambdaOpt145:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 2)
%line 5274+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5275+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 5293+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5294+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 5308+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode145
%line 5309+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont145

Lcode145:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 5331+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 5332+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse146
 mov rax, const_tbl+74
 jmp LexitIf146

Lelse146:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*6]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 5452+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 5453+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf146:
 leave

 ret

Lcont145:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0



lambdaOpt151:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 2)
%line 5473+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5474+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 5492+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5493+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 5507+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode151
%line 5508+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont151

Lcode151:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 5530+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 5531+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse152
 mov rax, const_tbl+8
 jmp LexitIf152

Lelse152:

 mov rax, 6666
 push rax
 mov rax, const_tbl+83
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*5]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [fvar_tbl+27*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse153
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, const_tbl+74
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 5649+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 5650+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf153

Lelse153:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*6]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 5734+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 5735+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf153:


LexitIf152:
 leave

 ret

Lcont151:
 leave
 ret

Lcont144:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 5758+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 5759+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont143:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+24*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+42*8]
 push rax
 mov rax, qword [fvar_tbl+33*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+23*8]
 push rax
 mov rax, qword [fvar_tbl+25*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 7
 push 7

lambdaSimple162:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 5801+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5802+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 5820+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5821+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 5835+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode162
%line 5836+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont162

Lcode162:
 push rbp
 mov rbp, rsp


lambdaOpt163:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 1)
%line 5845+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 5846+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 5864+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 5865+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 5879+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode163
%line 5880+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont163

Lcode163:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 5902+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 5903+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse164
 mov rax, const_tbl+8
 jmp LexitIf164

Lelse164:

 mov rax, 6666
 push rax
 mov rax, const_tbl+83
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*5]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [fvar_tbl+27*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse165
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, const_tbl+83
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 6021+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 6022+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf165

Lelse165:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*6]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*2]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 6105+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 6106+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf165:


LexitIf164:
 leave

 ret

Lcont163:
 leave
 ret

Lcont162:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+25*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+27*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 4
 push 4

lambdaSimple174:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 6153+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6154+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 6172+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6173+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 6187+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode174
%line 6188+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont174

Lcode174:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple175:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 6201+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6202+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 6220+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6221+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 6235+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode175
%line 6236+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont175

Lcode175:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 6242+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 6243+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple176:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 6250+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6251+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 6269+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6270+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 6284+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode176
%line 6285+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont176

Lcode176:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse177
 mov rax, const_tbl+4
 jmp LexitIf177

Lelse177:

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse178
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 6414+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 6415+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf178

Lelse178:
 mov rax, const_tbl+2


LexitIf178:


LexitIf177:
 leave
 ret

Lcont176:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0



lambdaOpt184:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 2)
%line 6441+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6442+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 6460+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6461+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 6475+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode184
%line 6476+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont184

Lcode184:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 6498+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 6499+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse185
 mov rax, const_tbl+8
 jmp LexitIf185

Lelse185:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 6596+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 6597+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf185:
 leave

 ret

Lcont184:
 leave
 ret

Lcont175:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 6617+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 6618+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont174:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+27*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+26*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 4
 push 4

lambdaSimple190:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 6654+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6655+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 6673+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6674+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 6688+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode190
%line 6689+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont190

Lcode190:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple191:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 6702+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6703+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 6721+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6722+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 6736+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode191
%line 6737+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont191

Lcode191:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 6743+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 6744+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple192:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 6751+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6752+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 6770+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6771+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 6785+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode192
%line 6786+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont192

Lcode192:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse193
 mov rax, const_tbl+4
 jmp LexitIf193

Lelse193:

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse194
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 6915+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 6916+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf194

Lelse194:
 mov rax, const_tbl+2


LexitIf194:


LexitIf193:
 leave
 ret

Lcont192:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0



lambdaOpt200:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 2)
%line 6942+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 6943+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 6961+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 6962+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 6976+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode200
%line 6977+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont200

Lcode200:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 6999+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 7000+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse201
 mov rax, const_tbl+8
 jmp LexitIf201

Lelse201:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 7097+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 7098+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf201:
 leave

 ret

Lcont200:
 leave
 ret

Lcont191:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 7118+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 7119+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont190:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+26*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+41*8]
 push rax
 mov rax, qword [fvar_tbl+27*8]
 push rax
 mov rax, qword [fvar_tbl+26*8]
 push rax
 mov rax, qword [fvar_tbl+4*8]
 push rax
 mov rcx, 6
 push 6

lambdaSimple206:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 7159+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7160+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 7178+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7179+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 7193+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode206
%line 7194+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont206

Lcode206:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple207:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 7207+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7208+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 7226+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7227+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 7241+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode207
%line 7242+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont207

Lcode207:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 7248+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 7249+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple208:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 7256+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7257+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 7275+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7276+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 7290+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode208
%line 7291+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont208

Lcode208:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse209
 mov rax, const_tbl+4
 jmp LexitIf209

Lelse209:

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 jne LexitOr214


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 jne LexitOr214

 LexitOr214:
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse210
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*5]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 7487+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 7488+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf210

Lelse210:
 mov rax, const_tbl+2


LexitIf210:


LexitIf209:
 leave
 ret

Lcont208:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0



lambdaOpt220:
 mov rsi, 0
 add qword [malloc_pointer], 8 * (1 + 2)
%line 7514+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7515+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 7533+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7534+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 7548+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode220
%line 7549+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont220

Lcode220:
 push rbp
 mov rbp , rsp



 mov r13, 0
 mov r15, r13
 mov r9, const_tbl+1

.get_opt_args:
 mov r8, qword [rbp+(4+r15)*8]
 cmp r8, 6666
 je .create_opt_list
 add r15, 1
 jmp .get_opt_args

.create_opt_list:
 add r15, -1
 mov r8, qword [rbp+(4+r15)*8]
 add qword [malloc_pointer], 1+8*2
%line 7571+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 7572+1 ./Project_Test/Tests/test_3/test.s
 cmp r15, r13
 jl .done_create_opt_list
 mov r9, rax
 jmp .create_opt_list
 cmp r15, r13
 jne .create_opt_list

 .done_create_opt_list:
 mov rax, r9
 mov r10, rbp
 shl r13, 3
 add r10, r13
 add r10, 8 * 4
 mov [r10], rax



 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse221
 mov rax, const_tbl+8
 jmp LexitIf221

Lelse221:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*5]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 7669+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 7670+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf221:
 leave

 ret

Lcont220:
 leave
 ret

Lcont207:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 7690+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 7691+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont206:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+35*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void


 mov rax, 6666
 push rax
 mov rax, qword [fvar_tbl+24*8]
 push rax
 mov rax, qword [fvar_tbl+19*8]
 push rax
 mov rax, qword [fvar_tbl+29*8]
 push rax
 mov rax, qword [fvar_tbl+28*8]
 push rax
 mov rax, qword [fvar_tbl+21*8]
 push rax
 mov rax, qword [fvar_tbl+6*8]
 push rax
 mov rax, qword [fvar_tbl+7*8]
 push rax
 mov rax, qword [fvar_tbl+5*8]
 push rax
 mov rax, qword [fvar_tbl+3*8]
 push rax
 mov rax, qword [fvar_tbl+1*8]
 push rax
 mov rax, qword [fvar_tbl+2*8]
 push rax
 mov rax, qword [fvar_tbl+14*8]
 push rax
 mov rax, qword [fvar_tbl+15*8]
 push rax
 mov rax, qword [fvar_tbl+11*8]
 push rax
 mov rax, qword [fvar_tbl+10*8]
 push rax
 mov rax, qword [fvar_tbl+41*8]
 push rax
 mov rax, qword [fvar_tbl+27*8]
 push rax
 mov rax, qword [fvar_tbl+26*8]
 push rax
 mov rcx, 18
 push 18

lambdaSimple226:
 add qword [malloc_pointer], 8 * (1 + 0)
%line 7755+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 0)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7756+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*7
%line 7774+0 ./Project_Test/Tests/test_3/test.s
 push 8*7
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7775+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 7
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
%line 7789+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode226
%line 7790+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont226

Lcode226:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax

lambdaSimple268:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 7799+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7800+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*18
%line 7818+0 ./Project_Test/Tests/test_3/test.s
 push 8*18
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7819+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 18
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
%line 7833+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode268
%line 7834+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont268

Lcode268:
 push rbp
 mov rbp, rsp
 mov rax, 6666
 push rax
 mov rax, const_tbl+109
 push rax
 mov rcx, 1
 push 1

lambdaSimple269:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 7847+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7848+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*18
%line 7866+0 ./Project_Test/Tests/test_3/test.s
 push 8*18
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7867+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 18
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
%line 7881+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode269
%line 7882+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont269

Lcode269:
 push rbp
 mov rbp, rsp
 mov rax, qword [rbp+(4+0)*8]
 add qword [malloc_pointer], 8
%line 7888+0 ./Project_Test/Tests/test_3/test.s
 push 8
 mov rbx, qword [malloc_pointer]
 sub rbx, [rsp]
 add rsp, 8
%line 7889+1 ./Project_Test/Tests/test_3/test.s
 mov [rbx], rax
 mov rax, rbx
 mov qword qword [rbp+(4+0)*8], rax
 mov rax, const_tbl + 0


lambdaSimple270:
 add qword [malloc_pointer], 8 * (1 + 3)
%line 7896+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 3)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 7897+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*18
%line 7915+0 ./Project_Test/Tests/test_3/test.s
 push 8*18
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 7916+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 18
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
%line 7930+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode270
%line 7931+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont270

Lcode270:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, const_tbl+74
 push rax
 mov rax, qword [rbp+(4+3)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse271
 mov rax, const_tbl+4
 jmp LexitIf271

Lelse271:

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+3)*8]
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp+(4+2)*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+3)*8]
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp+(4+2)*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [fvar_tbl+34*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse272
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, const_tbl+83
 push rax
 mov rax, qword [rbp+(4+3)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*2]
 mov rax, qword [rax+8*17]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp+(4+2)*8]
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 4
 push 4
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 8066+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*8]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*9]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 8067+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 jmp LexitIf272

Lelse272:
 mov rax, const_tbl+2


LexitIf272:


LexitIf271:
 leave
 ret

Lcont270:
 push rax
 mov rax, qword [rbp+(4+0)*8]
 pop qword [rax]
 mov rax, const_tbl + 0


 mov rax, 6666
 push rax

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*2]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse278
 mov rax, const_tbl+2
 jmp LexitIf278

Lelse278:
 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, const_tbl+83
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*3]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*17]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*2]
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*1]
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 push rax
 mov rcx, 4
 push 4
 mov rax, qword [rbp+(4+0)*8]
 mov rax, qword [rax]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 8245+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*8]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*9]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 8246+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10



LexitIf278:
 leave
 ret

Lcont269:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 8261+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 8262+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont268:
 push rax
 mov rcx, 1
 push 1

lambdaSimple227:
 add qword [malloc_pointer], 8 * (1 + 1)
%line 8274+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 1)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8275+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*18
%line 8293+0 ./Project_Test/Tests/test_3/test.s
 push 8*18
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8294+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 18
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
%line 8308+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode227
%line 8309+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont227

Lcode227:
 push rbp
 mov rbp, rsp

lambdaSimple228:
 add qword [malloc_pointer], 8 * (1 + 2)
%line 8316+0 ./Project_Test/Tests/test_3/test.s
 push 8 * (1 + 2)
 mov r10, qword [malloc_pointer]
 sub r10, [rsp]
 add rsp, 8
%line 8317+1 ./Project_Test/Tests/test_3/test.s
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
 add qword [malloc_pointer], 8*18
%line 8335+0 ./Project_Test/Tests/test_3/test.s
 push 8*18
 mov r14, qword [malloc_pointer]
 sub r14, [rsp]
 add rsp, 8
%line 8336+1 ./Project_Test/Tests/test_3/test.s
 mov r11, r14

.copy_params:
 cmp r12, 18
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
%line 8350+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 9
 mov qword [rax+1], r10
 mov qword [rax+1+8], Lcode228
%line 8351+1 ./Project_Test/Tests/test_3/test.s
 jmp Lcont228

Lcode228:
 push rbp
 mov rbp, rsp

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*7]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse230

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*7]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse231

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 jmp LexitIf231

Lelse231:
 mov rax, const_tbl+2


LexitIf231:
 jmp LexitIf230

Lelse230:
 mov rax, const_tbl+2


LexitIf230:
 cmp rax, const_tbl + 2
 jne LexitOr229


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse235

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse236

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 jmp LexitIf236

Lelse236:
 mov rax, const_tbl+2


LexitIf236:
 jmp LexitIf235

Lelse235:
 mov rax, const_tbl+2


LexitIf235:
 cmp rax, const_tbl + 2
 jne LexitOr229


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*9]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse240

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*9]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse241

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*14]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*14]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [fvar_tbl+34*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse242

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*15]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*15]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [fvar_tbl+34*8]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 jmp LexitIf242

Lelse242:
 mov rax, const_tbl+2


LexitIf242:
 jmp LexitIf241

Lelse241:
 mov rax, const_tbl+2


LexitIf241:
 jmp LexitIf240

Lelse240:
 mov rax, const_tbl+2


LexitIf240:
 cmp rax, const_tbl + 2
 jne LexitOr229


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*10]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse251

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*10]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse252

 mov rax, 6666
 push rax

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*16]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
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
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*16]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*1]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 jmp LexitIf252

Lelse252:
 mov rax, const_tbl+2


LexitIf252:
 jmp LexitIf251

Lelse251:
 mov rax, const_tbl+2


LexitIf251:
 cmp rax, const_tbl + 2
 jne LexitOr229


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*11]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse258

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*11]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse259

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*3]
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*4]
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 4
 push 4
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 jmp LexitIf259

Lelse259:
 mov rax, const_tbl+2


LexitIf259:
 jmp LexitIf258

Lelse258:
 mov rax, const_tbl+2


LexitIf258:
 cmp rax, const_tbl + 2
 jne LexitOr229


 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*12]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse263

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rcx, 1
 push 1
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*12]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 cmp rax, const_tbl + 2
 je Lelse264

 mov rax, 6666
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*6]
 push rax
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*5]
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 4
 push 4
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*0]
 mov rax, qword [rax+8*0]
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 jmp LexitIf264

Lelse264:
 mov rax, const_tbl+2


LexitIf264:
 jmp LexitIf263

Lelse263:
 mov rax, const_tbl+2


LexitIf263:
 cmp rax, const_tbl + 2
 jne LexitOr229

 mov rax, 6666
 push rax
 mov rax, qword [rbp+(4+1)*8]
 push rax
 mov rax, qword [rbp+(4+0)*8]
 push rax
 mov rcx, 2
 push 2
 mov rax, qword [rbp + 16]
 mov rax, qword [rax+8*1]
 mov rax, qword [rax+8*13]
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 9027+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*7]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 9028+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 cmp rax, const_tbl + 2
 jne LexitOr229

 LexitOr229:
 leave
 ret

Lcont228:
 leave
 ret

Lcont227:
 mov r9, [rax+1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 push rax
%line 9048+0 ./Project_Test/Tests/test_3/test.s
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 dec rax
 mov r8, [rbp-8*1]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*2]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*3]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*4]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*5]
 mov [rbp+8*rax], r8
 dec rax
 mov r8, [rbp-8*6]
 mov [rbp+8*rax], r8
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8
%line 9049+1 ./Project_Test/Tests/test_3/test.s
 mov rbp, r15
 jmp r10

 leave
 ret

Lcont226:
 mov rbx, [rax+1]
 push rbx
 mov rbx, [rax+1+8]
 call rbx
 add rsp, 8*1
 pop rbx
 inc rbx
 shl rbx, 3
 add rsp, rbx

 mov qword [fvar_tbl+34*8], rax
 mov rax, const_tbl + 0
 call write_sob_if_not_void

 mov rax, const_tbl+4
 call write_sob_if_not_void

 mov rax, const_tbl+2
 call write_sob_if_not_void
 add rsp, 4*8
 pop rbp
 ret


apply:
 push rbp
 mov rbp, rsp

 mov rcx, 2

.get_list:
 mov r14, qword [rbp+(4+rcx)*8]
 cmp r14, 6666
 je .got_list
 inc rcx
 jmp .get_list

 dec rcx

.got_list:
 dec rcx
 mov r14, qword [rbp+(4+rcx)*8]
 mov r11, r14
 mov rdx, 1
 push 6666

.push_list:
 cmp r11, const_tbl+1
 je .non_empty
 mov r10, qword [r14+1]
 mov r11, qword [r14+1+8]
 push r10
 mov r14, r11
 inc rdx
 jmp .push_list


.non_empty:
 mov r10, rsp
 mov r11, rbp
 add r11, -16

.reverse:
 cmp r10, r11
 jg .finish
 mov r12, qword[r10]
 mov r13, qword[r11]
 mov qword[r10], r13
 mov qword[r11], r12
 add r10, 8
 add r11, -8
 jmp .reverse

.finish:
 dec rcx
 add rdx, rcx
 dec rdx

 cmp rcx, 0
 jle .prep_call

.push_args:
 mov rax, qword [rbp+(4+rcx)*8]
 push rax
 cmp rcx, 1
 je .prep_call
 dec rcx
 jmp .push_args

.prep_call:
 push rdx
 mov rax, qword [rbp+(4+0)*8]
 mov r9, [rax + 1]
 push r9
 mov r10, [rax+1+8]
 push qword [rbp + 8]
 mov r15, qword[rbp]
 add rdx, 5


 push rax
 mov r9, qword [rbp+3*8]
 mov rax, r9
 add rax, 5
 mov r11, 1

.shift:
 dec rax
 mov r12, r11
 shl r12, 3
 mov r13, rbp
 sub r13, r12
 mov r8, qword[r13]
 mov [rbp + 8 * rax], r8
 cmp r11, rdx
 je .end_shift
 inc r11
 jmp .shift

.end_shift:
 pop rax
 mov r8, r9
 add r8, 5
 shl r8, 3
 add rsp, r8

 mov rbp, r15
 jmp r10

.return:
 leave
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
%line 9376+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9377+1 ./Project_Test/Tests/test_3/test.s

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
%line 9393+0 ./Project_Test/Tests/test_3/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 9394+1 ./Project_Test/Tests/test_3/test.s

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
%line 9428+0 ./Project_Test/Tests/test_3/test.s
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
..@508.str_loop:
 jz ..@508.str_loop_end
 dec rcx
 mov byte [rax+rcx], dil
 jmp ..@508.str_loop
..@508.str_loop_end:
 pop rcx
 sub rax, 8+1
%line 9429+1 ./Project_Test/Tests/test_3/test.s

 leave
 ret

vector_length:
 push rbp
 mov rbp, rsp

 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 add qword [malloc_pointer], 1+8
%line 9439+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9440+1 ./Project_Test/Tests/test_3/test.s

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
%line 9488+0 ./Project_Test/Tests/test_3/test.s
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
..@518.vec_loop:
 jz ..@518.vec_loop_end
 dec rcx
 mov qword [rax+rcx*8], rdi
 jmp ..@518.vec_loop
..@518.vec_loop_end:
 sub rax, 8+1
 pop rcx
%line 9489+1 ./Project_Test/Tests/test_3/test.s

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
%line 9508+0 ./Project_Test/Tests/test_3/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], dil
%line 9509+1 ./Project_Test/Tests/test_3/test.s
 push rax
 add qword [malloc_pointer], 1+8
%line 9510+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rcx
%line 9511+1 ./Project_Test/Tests/test_3/test.s
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
%line 9545+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9546+1 ./Project_Test/Tests/test_3/test.s

 leave
 ret

integer_to_char:
 push rbp
 mov rbp, rsp


 mov rsi, qword [rbp+(4+0)*8]
 mov rsi, qword [rsi+1]
 and rsi, 255
 add qword [malloc_pointer], 1+1
%line 9558+0 ./Project_Test/Tests/test_3/test.s
 push 1+1
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 6
 mov byte [rax+1], sil
%line 9559+1 ./Project_Test/Tests/test_3/test.s

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
 cmp r8, 3
 jne .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9650+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9651+1 ./Project_Test/Tests/test_3/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9655+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9656+1 ./Project_Test/Tests/test_3/test.s

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
 cmp r8, 3
 jne .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9730+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9731+1 ./Project_Test/Tests/test_3/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9735+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9736+1 ./Project_Test/Tests/test_3/test.s

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
 cmp r8, 3
 jne .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9810+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9811+1 ./Project_Test/Tests/test_3/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9815+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9816+1 ./Project_Test/Tests/test_3/test.s

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
 cmp r8, 3
 jne .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9890+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9891+1 ./Project_Test/Tests/test_3/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9895+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9896+1 ./Project_Test/Tests/test_3/test.s

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
 cmp r8, 3
 jne .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9970+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 9971+1 ./Project_Test/Tests/test_3/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 9975+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 9976+1 ./Project_Test/Tests/test_3/test.s

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
 cmp r8, 3
 jne .return_float

 cvttsd2si rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 10062+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 3
 mov qword [rax+1], rsi
%line 10063+1 ./Project_Test/Tests/test_3/test.s
 jmp .return

.return_float:
 movq rsi, xmm0
 add qword [malloc_pointer], 1+8
%line 10067+0 ./Project_Test/Tests/test_3/test.s
 push 1+8
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 4
 mov qword [rax+1], rsi
%line 10068+1 ./Project_Test/Tests/test_3/test.s

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
%line 10152+0 ./Project_Test/Tests/test_3/test.s
 push 1+8*2
 mov rax, qword [malloc_pointer]
 sub rax, [rsp]
 add rsp, 8
 mov byte [rax], 10
 mov qword [rax+1], r8
 mov qword [rax+1+8], r9
%line 10153+1 ./Project_Test/Tests/test_3/test.s

 jmp .return

.return:
 leave
 ret
