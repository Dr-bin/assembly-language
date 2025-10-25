; 数据段：格式字符串定义
.LC0:
        .string "%c "     ; 定义字符串常量：格式为"字符+空格"

; 主函数开始
main:
        ; 函数序言 - 建立栈帧
        push    rbp                     ; 保存旧的基址指针
        mov     rbp, rsp                ; 设置新的基址指针
        sub     rsp, 16                 ; 在栈上分配16字节空间给局部变量
        
        ; 局部变量初始化
        mov     BYTE PTR [rbp-1], 97    ; [rbp-1] = 'a' (ASCII 97)
        mov     DWORD PTR [rbp-8], 1    ; [rbp-8] = 1 (计数器，从1开始)
        
        ; 跳转到循环条件检查
        jmp     .L2

; 循环体开始
.L4:
        ; 准备打印字符：ch = ch + 1
        movzx   eax, BYTE PTR [rbp-1]   ; 零扩展加载当前字符到eax
        mov     edx, eax                ; edx = 当前字符
        add     edx, 1                  ; edx = 当前字符 + 1 (指向下一个字母)
        mov     BYTE PTR [rbp-1], dl    ; 更新ch变量为下一个字母
        
        ; 调用printf打印当前字符和空格
        movsx   eax, al                 ; 符号扩展当前字符(al中是原来的值)
        mov     esi, eax                ; esi = 要打印的字符 (printf第二个参数)
        mov     edi, OFFSET FLAT:.LC0   ; edi = 格式字符串地址 (printf第一个参数)
        mov     eax, 0                  ; eax = 0 (表示没有向量参数)
        call    printf                  ; 调用printf("%c ", ch)
        
        ; 检查是否需要换行 (每13个字符换行)
        cmp     DWORD PTR [rbp-8], 13   ; 比较计数器和13
        jne     .L3                     ; 如果计数器 != 13，跳过换行
        
        ; 执行换行
        mov     edi, 10                 ; edi = 10 ('\n'换行符的ASCII)
        call    putchar                 ; 调用putchar('\n')

; 循环继续标签
.L3:
        ; 计数器增加
        add     DWORD PTR [rbp-8], 1    ; 计数器 = 计数器 + 1

; 循环条件检查
.L2:
        cmp     DWORD PTR [rbp-8], 26   ; 比较计数器和26
        jle     .L4                     ; 如果计数器 <= 26，继续循环
        
        ; 函数返回
        mov     eax, 0                  ; 返回值 = 0
        leave                           ; 恢复栈帧 (mov rsp, rbp; pop rbp)
        ret                             ; 返回