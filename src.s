section .data
	text db "Hello, World!", 10, 0
	text1 db "IAMMORETEXT", 10, "More!", 10, 0, "Nothere!"

section .text
	global _start
	
	extern puts
	extern putnl
	extern putu
	extern puti

_start:
	mov rax, text
	call puts
	mov rax, text1
	call puts	
	call putnl
	call putnl
	call putnl

	mov rbx, -10
_for:
	mov rax, rbx
	call puti
	call putnl

	inc rbx

	cmp rbx, 10
	jle _for	

	mov rax, 60
	mov rdi, 0
	syscall
