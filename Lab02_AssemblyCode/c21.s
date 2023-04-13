.section .data
msg:
	.string "Love UIT"
msg_len= . -msg -1

length: 
	.int (msg_len+48)
enter:
	.byte 13,10

.section .text
	.globl _start
	
_start:
	#chuyển độ dài của chuỗi msg vào edx
	movl $msg_len, %edx
	
	#chuyển địa chỉ của chuỗi cần in vào %ecx
	movl $length, %ecx
	
	#các thông số cho việc in ra màn hình eax= 4 SYS_WRITE ebx=1 STDOUT
	movl $1, %ebx
	movl $4, %eax
	int $0x80
	
	#in \n ra màn hình
	movl $2, %edx
	movl $enter, %ecx
	
	movl $1, %ebx
	movl $4, %eax
	int $0x80
	
	#kết thúc chương trình
	movl $1, %eax
	int $0x80
