section .text
	global _start
	
	extern getchar
	extern flushout
	extern putchar
	extern puts
	extern putnl
	extern putu
	extern puti
	extern scanu

_start:

	mov rax, 123456
	call putu
	call putnl

	mov rax, 42069
	call putu
	call putnl
	call flushout

	mov rax, 60
	mov rdi, 0
	syscall
