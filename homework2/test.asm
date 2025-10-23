code segment
assume cs:code
start:
    mov bl, 'a'        ; 当前字母
    mov cx, 26         ; 总字母数
    mov dh, 0          ; 行计数器
    
main_loop:
    ; 打印字符
    mov dl, bl
    mov ah, 02h
    int 21h
    
    inc bl             ; 下一个字母
    inc dh             ; 行计数器+1
    
    ; 检查是否最后一个字符
    cmp cx, 1
    je program_end
    
    ; 检查是否需要换行
    cmp dh, 13
    jne print_space
    
    ; 换行
    mov dl, 0dh        ; 回车
    mov ah, 02h
    int 21h
    mov dl, 0ah        ; 换行
    mov ah, 02h
    int 21h
    mov dh, 0          ; 重置行计数器
    jmp continue
    
print_space:
    ; 打印空格
    mov dl, ' '
    mov ah, 02h
    int 21h
    
continue:
    loop main_loop
    
program_end:
    mov ah, 4ch
    int 21h
code ends
end start