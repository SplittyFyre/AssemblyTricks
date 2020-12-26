section .data
	newline db 10

section .bss
	numbuf resb 32

section .text
	global strlen
	global puts	
	global putnl
	global puti
	global putu

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


; rax contains value
puti:
	; set r8 to end of buffer
	mov r8, numbuf
	add r8, 31

	xor rcx, rcx	; rcx length of string
	mov r9, 10	; don't know why can't div by literal

	mov r10b, 0
	test rax, rax	; is negative?
	jns puti_loop
	mov r10b, 1
	neg rax
puti_loop:
	dec r8
	inc rcx

	xor rdx, rdx
	div r9
	add rdx, 48
	mov [r8], dl
	
	test rax, rax	; continue loop until zero
	jnz puti_loop

	test r10b, r10b
	jz puti_syscall
	
	dec r8
	inc rcx
	mov byte [r8], '-'	

puti_syscall:
	mov rax, 1
	mov rdi, 1
	mov rsi, r8
	mov rdx, rcx
	syscall
	ret


putu:
        ; set r8 to end of buffer
        mov r8, numbuf
        add r8, 31

        xor rcx, rcx    ; rcx length of string
        mov r9, 10      ; don't know why can't div by literal

putu_loop:
        dec r8
        inc rcx

        xor rdx, rdx
        div r9
        add rdx, 48
        mov [r8], dl

        test rax, rax   ; continue loop until zero
        jnz putu_loop

        mov rax, 1
        mov rdi, 1
        mov rsi, r8
        mov rdx, rcx
        syscall
        ret
