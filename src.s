section .data
	text db "Hello, World!", 10, 0
	text1 db "IAMMORETEXT", 10, "More!", 10, 0, "Nothere!"

section .text
	global _start
	
	extern flushout
	extern putchar
	extern puts
	extern putnl
	extern putu
	extern puti

_start:
	mov al, 'P'
	call putchar
	mov al, 'E'
	call putchar
	mov al, 'G'
	call putchar
	call putnl

	mov rax, text
	call puts
	mov rax, text1
	call puts

	mov rax, -133742069
	call puti
	call putnl

	mov rax, -1
	call putu
	call putnl

	call flushout

	mov rax, 60
	mov rdi, 0
	syscall
