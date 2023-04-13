.section .data

.section .bss
    .lcomm input, 8

.section .text
    .globl _start
_start:

    #Nhap MSSV bao gom 8 chu so	
    movl $9, %edx 
    movl $input, %ecx 
    movl $0, %ebx 
    movl $3, %eax
    int $0x80 
    
    #gan gia tri thanh ghi esi = 0 (index de xet)
    xor %esi, %esi
    #gan gia tri thanh ghi edi = 2
    movl $2, %edi

.LOOP1:
    #mot lan so sanh xet 2 chu so
    #neu index xet bang 4 (2 chu so cuoi trong mssv) thi dung vong lap
    
    cmp $4, %esi
    jge .END
    
    #neu index xet bang 2 (2 so o vi tri 3 4) thi skip khong in ra
    cmp $2, %esi
    je .SKIP
    
    #in ra 1 lan 2 chu so trong MSSV
    movl $4, %eax
    movl $1, %ebx
    leal (%ecx), %ecx
    movl $2, %edx
    int $0x80
    
.SKIP:
    #tang index cua chuoi MSSV dang xet len 1 don vi, skip dia chi cua 2 so o vi tri 3 4
    leal 2(%ecx), %ecx
    inc %esi
    jmp .LOOP1

.END:
    #exit chuong trinh
    movl $1, %eax 
    int $0x80