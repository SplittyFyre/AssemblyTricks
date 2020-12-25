section .data
	newline db 10

section .text
	global strlen
	global puts	
	global putnl

; takes in string in rax
; returns nullbyte address in rax, length in rcx
strlen:
	xor rcx, rcx	; rcx stores length of string, set to 0
strlen_loop:
	cmp byte [rax], 0	; check if nullbyte
	je strlen_ret
	inc rax
	inc rcx
	jmp strlen_loop
strlen_ret:
	ret

; print null-terminated string
puts:
	mov rsi, rax
	call strlen	

	mov rax, 1
	mov rdi, 1
	; rsi set at start
	mov rdx, rcx
	syscall
	ret


putnl:
	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall
	ret
