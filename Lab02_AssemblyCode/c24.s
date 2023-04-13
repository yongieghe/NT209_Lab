.section .data
output1:
	.string "Enter a year: "
	
output2:
	.string "\nCan be in Ho Chi Minh Communist Youth Union"
op2 = .-output2
output3:
	.string "\nCan't be in Ho Chi Minh Communist Youth Union"
op3 = .-output3	
output4:
	.string "\nYour age is:"
op4 = .-output4
	
.section .bss
	.lcomm year, 4
	.lcomm age, 4
	.lcomm output, 4
	.lcomm number_str, 2
	
.section .text
	.globl _start
_start:

	# In ra cau "Enter a year: "
	movl $13, %edx 
	movl $output1, %ecx 
	movl $1, %ebx 
	movl $4, %eax 
	int $0x80 
	
	# Nhap nam sinh 
	movl $3,%eax
	movl $0,%ebx
	movl $year,%ecx
	movl $4, %edx
	int $0x80
	
	# Khoi tao va lay gia tri cua so nguyen, tuc la nam sinh vao
	movl $0,%eax 
	movl $year,%ebx      
loop:
    	cmpb $0,(%ebx)    # Kiem tra da duyet het so chua
    	je endloop
    	imull $10,%eax 	     
    	movzbl (%ebx), %ecx    # lay ky tu thu 1 trong chuoi 
    	subb $'0',%cl          # Chuyen ky tu vua lay sang so nguyen
    	addl %ecx,%eax         # Them so nguyen vua lay vao tong so nguyen
    	incl %ebx              # Tang index
    	jmp loop	
	
endloop: 
        movl %eax,output	  	# Gia tri cua so nguyen

	# Tuoi = nam hien tai (2023) - năm sinh
	movl $2023,%eax      
	subl output,%eax    
	movl %eax,age      
	
	
	# Xuat ket qua "Your age is: "
	movl $4,%eax
	movl $1,%ebx
	movl $output4,%ecx    
	movl $op4,%edx
	int $0x80
	xor %edx, %edx	      # Xoa bo nho co san
	
	# Xuat tuoi 
	movl (age), %eax
	movl $10, %ebx
	div %ebx
	addl $'0, %edx
	addl $'0, %eax
	movl $number_str, %ebx
	movl %eax, (%ebx)
	movl %edx, 1(%ebx)

	movl $4, %eax
	movl $1, %ebx
	movl $number_str, %ecx
	movl $2, %edx
	int $0x80
	
	
	# Kiem tra do tuoi trong Doan
	cmpl $30, age #neu tuoi > 30 thi in ra khong thuoc tuoi doan 
	jg .No
	cmpl $16, age #neu tuoi doan <16 thi in ra khong thuoc tuoi doan
	jl .No
	movl $output2, %ecx #tu 16 - 30 thi in ra thuoc tuoi doan
	movl $op2, %edx 
	movl $1, %ebx 
	movl $4, %eax 
	int $0x80 
	jmp .Yes
.No:
	movl $output3, %ecx 
	movl $op3, %edx 
	movl $1, %ebx 
	movl $4, %eax 
	int $0x80 
.Yes:

	movl $1, %eax
	int $0x80