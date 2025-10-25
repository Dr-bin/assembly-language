data segment
    newline db 0dh, 0ah, '$'  ; 定义换行符(回车+换行)
data ends

code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax          ; 设置数据段寄存器
    
    mov bl, 'a'         ; BL寄存器存储当前要打印的字母
    mov cx, 26          ; CX是循环计数器，总共26个字母
    mov dh, 0           ; DH是行计数器，记录当前行已打印的字符数
    
print_loop:
    ; 打印当前字符
    mov dl, bl          ; 将字符从BL移到DL（DOS功能要求）
    mov ah, 02h         ; DOS功能号02h - 显示字符
    int 21h             ; 调用DOS中断
    
    ; 打印空格
    mov dl, ' '
    mov ah, 02h         
    int 21h             ; 调用DOS中断
    
    inc bl              ; BL加1，指向下一个字母
    inc dh              ; 行计数器加1
    
    ; 检查是否需要换行（每行13个字符）
    cmp dh, 13          ; 比较DH是否等于13
    jne no_newline      ; 如果不等于13，跳过换行
    
    ; 换行处理
    mov dx, offset newline ; DX指向换行符字符串
    mov ah, 09h         ; DOS功能号09h - 显示字符串
    int 21h
    mov dh, 0           ; 重置行计数器为0
    
no_newline:
    loop print_loop     ; CX减1，如果CX≠0则跳转到print_loop
    
    ; 程序结束
    mov ah, 4ch         ; DOS功能号4Ch - 程序退出
    int 21h
    
code ends
end start