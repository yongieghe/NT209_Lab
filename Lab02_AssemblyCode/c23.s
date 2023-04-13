.section .data

.section .bss
    .lcomm input1, 2
    .lcomm input2, 2
    .lcomm input3, 2
    .lcomm input4, 2
    .lcomm input5, 2	
    .lcomm count,1
.section .text
    .globl _start
_start:
    # Thêm các số vào từng biến input
    movl $3, %edx 
    movl $input1, %ecx 
    movl $0, %ebx 
    movl $3, %eax
    int $0x80 
    
    movl $3, %edx 
    movl $input2, %ecx 
    movl $0, %ebx 
    movl $3, %eax
    int $0x80 
    
    movl $3, %edx
    movl $input3, %ecx 
    movl $0, %ebx 
    movl $3, %eax
    int $0x80 
    
    movl $3, %edx
    movl $input4, %ecx 
    movl $0, %ebx 
    movl $3, %eax
    int $0x80 
    
    movl $3, %edx
    movl $input5, %ecx 
    movl $0, %ebx 
    movl $3, %eax
    int $0x80 
    
    # Đặt thanh ghi đếm về giá trị 0
    xor %edi, %edi

    
    movl $input1, %esi      # Truyền giá trị input1 vào thanh ghi esi
    movb (%esi), %bl        # Lấy giá trị byte tại địa chỉ được lưu trữ tại thanh ghi esi và di chuyển giá trị đó vào thanh ghi bl
    sub $48, %bl            # Trừ thanh ghi bl đi 48 để chuyển đổi ký tự số thành giá trị số nguyên tương ứng
    cmp $5, %bl             # So sánh giá trị của thanh ghi bl với 5
    jge .DONE               # Nếu lớn hơn hoặc bằng thì sẽ nhảy đến nhãn .DONE, nếu không thỏa thì sẽ thực hiện các lệnh tiếp theo
    
    movb 1(%esi), %bl       # Lấy giá trị byte tại địa chỉ được lưu trữ tại thanh ghi esi+1 và di chuyển giá trị đó vào thanh ghi bl
    sub $48, %bl            # Trừ thanh ghi bl đi 48 để chuyển đổi ký tự số thành giá trị số nguyên tương ứng
    cmp $0, %bl             # So sánh giá trị của thanh ghi bl với 0
    jne .COUNT1             # Nếu không bằng thì sẽ nhảy đến nhãn để đếm biến tiếp theo, nếu không thì thực hiện các lệnh tiếp theo
    
    .DONE:
    incl %edi               # Tăng giá trị thanh ghi edi(biến đếm) lên 1

 #tương tự với các input còn lại   
.COUNT1: 
    movl $input2, %esi
    movb (%esi), %bl
    sub $48, %bl
    cmp $5, %bl
    jge .DONE1

    movb 1(%esi), %bl
    sub $48, %bl
    cmp $0, %bl
    jne .COUNT2
    
    .DONE1:
    incl %edi

       
.COUNT2: 

    movl $input3, %esi
    movb (%esi), %bl
    sub $48, %bl
    cmp $5, %bl
    jge .DONE2

    movb 1(%esi), %bl
    sub $48, %bl
    cmp $0, %bl
    jne .COUNT3
    
    .DONE2:
    incl %edi


.COUNT3: 
    
    movl $input4, %esi
    movb (%esi), %bl
    sub $48, %bl
    cmp $5, %bl
    jge .DONE3

    movb 1(%esi), %bl
    sub $48, %bl
    cmp $0, %bl
    jne .COUNT4
    
    .DONE3:
    incl %edi


.COUNT4: 
        
    movl $input5, %esi
    movb (%esi), %bl
    sub $48, %bl
    cmp $5, %bl
    jge .DONE4

    movb 1(%esi), %bl
    sub $48, %bl
    cmp $0, %bl
    jne .END
    
    .DONE4:
    incl %edi

.END:
    addl $48, %edi
    movl %edi, (count)
    movl $count, %ecx
    movl $1, %edx
    movl $1, %ebx
    movl $4, %eax
    int $0x80
    
    movl $1, %eax 
    int $0x80
    