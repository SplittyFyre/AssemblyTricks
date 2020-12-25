section .data
	text db "Hello, World!", 10, 0
	text1 db "IAMMORETEXT", 10, "More!", 10, 0, "Nothere!"

section .text
	global _start
	
	extern puts
	extern putnl

_start:
	mov rax, text
	call puts
	mov rax, text1
	call puts	
	call putnl
	call putnl
	call putnl

	mov rax, 60
	mov rdi, 0
	syscall
