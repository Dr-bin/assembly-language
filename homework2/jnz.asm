data segment
    newline db 0dh, 0ah, '$'
data ends

code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    
    mov bl, 'a'
    mov cx, 26
    mov dh, 0
    
print_loop:
    ; 打印字符
    mov dl, bl
    mov ah, 02h
    int 21h
    
    ; 打印空格
    mov dl, ' '
    mov ah, 02h
    int 21h
    
    inc bl
    inc dh
    
    ; 检查是否需要换行
    cmp dh, 13
    jne skip_newline    ; 条件跳转：不等于时跳转
    
    ; 执行换行
    mov dx, offset newline
    mov ah, 09h
    int 21h
    mov dh, 0
    
skip_newline:
    ; 用条件跳转替代loop指令
    dec cx              ; CX减1
    jnz print_loop      ; 条件跳转：结果非零时跳转
    
    ; 程序结束
    mov ah, 4ch
    int 21h
    
code ends
end start