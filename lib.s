section .data
	newline db 10
	BUFLEN equ 4
	
	ibi dq BUFLEN
	obi dq 0

section .bss
	inbuf  resb BUFLEN
	outbuf resb BUFLEN
	numbuf resb 32

section .text
	global flushout
	global putchar
	global puts	
	global putnl
	global puti
	global putu

	global getchar
	global scanu

flushout:
	cmp qword [obi], 0
	je flushout_end
	push rcx
	mov rax, 1
	mov rdi, 1
	mov rsi, outbuf
	mov rdx, qword [obi]
	syscall
	pop rcx
	mov qword [obi], 0
flushout_end:
	ret

; print char/byte in %al, consumes rdx
putchar:
	mov rdx, outbuf
	add rdx, qword [obi]
	mov byte [rdx], al
	inc qword [obi]
	cmp qword [obi], BUFLEN
	jl putchar_end
	call flushout
putchar_end:
	ret


; print null-terminated string in [rax]
puts:
	mov rcx, rax
puts_loop:
	cmp byte [rcx], 0
	je puts_end
	mov al, [rcx]
	call putchar
	inc rcx
	jmp puts_loop
puts_end:
	ret


putnl:
	mov al, 10
	call putchar	
	ret


; rax contains value
puti:
	; set r8 to end of buffer
	mov r8, numbuf + 31
	
	mov byte [r8], 0	; \0 terminator

	mov r9, 10		; don't know why can't div by literal

	mov r10b, 0
	test rax, rax		; is negative?
	jns puti_loop
	mov r10b, 1
	neg rax
puti_loop:
	dec r8

	xor rdx, rdx
	div r9
	add rdx, 48
	mov [r8], dl
	
	test rax, rax	; continue loop until zero
	jnz puti_loop

	test r10b, r10b
	jz puti_end
	
	dec r8
	mov byte [r8], '-'	

puti_end:
	mov rax, r8
	call puts
	ret



; rax contains value
putu:
	; set r8 to end of buffer
	mov r8, numbuf + 31
	
	mov byte [r8], 0	; \0 terminator

	mov r9, 10		; don't know why can't div by literal
putu_loop:
	dec r8

	xor rdx, rdx
	div r9
	add rdx, 48
	mov [r8], dl
	
	test rax, rax	; continue loop until zero
	jnz putu_loop
putu_end:
	mov rax, r8
	call puts
	ret





; puts char into cl
getchar:
	cmp qword [ibi], BUFLEN
	jl getchar_end

; fill input buffer:
	mov qword [ibi], 0
	
	push rax
	xor rax, rax
	xor rdi, rdi
	mov rsi, inbuf
	mov rdx, BUFLEN
	syscall
	mov rdx, rax
	pop rax

	cmp rdx, BUFLEN
	je getchar_end

	mov byte [inbuf + rdx], 0

getchar_end:
	mov rdx, [ibi]
	xor rcx, rcx
	mov cl, [inbuf + rdx]	
	inc qword [ibi]
	ret



; scans unsigned value into rax
scanu:
	xor rax, rax
	mov r8, 10
scanu_strip:
	call getchar
	cmp cl, '0'
	jl scanu_strip
scanu_loop:
	mul r8
	sub cl, '0'
	add rax, rcx
	call getchar
	cmp cl, '0'
	jge scanu_loop
	dec qword [ibi]
	ret




