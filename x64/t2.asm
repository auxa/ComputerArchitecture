option casemap:none             ; case sensitive
 
extern  printf:near             ; printf

.code

;_int64 g =256
public g
g	QWORD 256
;i = rcx, j = rdx
public p
p:	lea rax, [rcx + rdx]
	shl rax, 2
	dec rax
	ret

;no entry/exit code

;parameter i = rcx
public q
q:	sub rsp, 32
	mov rdx, rcx
	neg rdx
	mov rcx, [g]
	call p
	add rsp, 32
	ret


;n = rax
public f
f:	cmp rcx, 0
	jle	L2
	mov rbx, rcx
	dec rcx
	push rcx
	call f
	pop rbx
	add rbx, 1
	imul rax, rbx
	jmp L3
L2: mov rax, 1
L3: ret 

;parameters a = rcx, b= rdx, c= r8, d= r9, e= [rsp+96]

fxp5	 db		 "a= %IA64d b =IA64d c =%IA64d d= %IA64d e= IA64d sum =%IA64d",  0AH, 00H

public xp5

xp5: sub rsp, 56			 ; 7 params on the shadow space
	 lea rax, [rcx+rdx]
	 add rax, r8
	 add rax, r9
	 mov r10, [rsp + 96]
	 add rax, r10
	 mov [rsp+48], rax
	 mov [rsp+40], r10
	 mov [rsp+32], r9
	 mov r9, r8
	 mov r8, rdx
	 mov rdx, rcx
	 lea rcx, fxp5
	 call printf
	 mov rax, rdx
	 add rsp, 32
	 ret

	 end
