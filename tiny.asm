BITS 64

; open /dev/null
	lea rdi, [rel devnull]
	mov rsi, 66     ; O_WRONLY | O_CREAT
	mov rdx, 420    ; S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
	mov rax, 2      ; _NR_open
	syscall

; dup2 stdout to /dev/null fd
	mov rdi, rax    ; fd from open
	mov rsi, 1      ; stdin
	mov rax, 33     ; _NR_dup2
	syscall

; write hello message
	mov rdi, 3
	lea rsi, [rel msg]
	push msg_len
	pop rdx
	mov rax, 1
	syscall

; write goodbye message
	mov rdi, 3
	lea rsi, [rel msg2]
	push msg2_len
	pop rdx
	mov rax, 1
	syscall

; exit
	mov rax, 60
	xor rdi, rdi
	syscall

; globals
section .data
	msg db "Hello, World"
	msg_len equ $ - msg
	msg2 db "Goodbye"
	msg2_len equ $ - msg2
	devnull db "/dev/null"
	devnull_len equ $ - devnull
