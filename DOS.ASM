;:ts=8
;
; C function call header
;

dataseg	segment para public 'data'
	public	tick_
tick_	dw	0
extrn	whoami_:word
extrn	prbuf_:word
extrn	_Corg_:word
extrn	_Cend_:word
dataseg	ends

codeseg	SEGMENT	para PUBLIC 'code'
	PUBLIC dmain_,dmaout_,COFF_,beep_,out_,peekb_,pokeb_
	PUBLIC getch_, no_char_,wsetmem_,clock_
	PUBLIC getds_
	EXTRN	quit_:NEAR
	ASSUME	CS:codeseg, DS:dataseg
	
;
;  DOS interface routines
;
;  Author:	Jon Lane
;  Date:	February 25, 1983
;

;----------------------------------------------------------------------;
;
;	Do low level stuff so that window can be swapped to disk
;
;  Author:	Jon Lane
;  Date:	February 28, 1983
;
;-------------------------------------------------------------------------
;
;	scrdma(string,length,ds,offset) -- dma a string to the screen
;
;-------------------------------------------------------------------------	

dmaout_	PROC	NEAR
	PUSH	BP		;Save BP on stack to conform to call
	MOV	BP,SP		;Set BP to allow subsequent calls
	push	di
	push	si
	pushf

	CLD
	MOV	AX,[BP + 8]	;Set string move destination to
	MOV	BX,ES		;save the extra segment reg
	MOV	ES,AX		;point to the screen
	MOV	DI,[BP + 10]	;Set the offset into the screen
	MOV	SI,[BP + 4]	;Set the source for the string move
	MOV	CX,[BP + 6]	;Set xfer count to 64 words
	REP	MOVSW		;Blast this out to the screen

	MOV	AH,CL
	MOV	ES,BX		;restor the ES

	popf
	pop	si
	pop	di
	POP	BP		;reset BP for caller's environment
	RET			;return to caller
dmaout_	ENDP

dmain_	PROC	NEAR
	PUSH	BP		;Save BP on stack to conform to call
	MOV	BP,SP		;Set BP to allow subsequent calls
	push	di
	push	si
	pushf

	MOV	AX,DS		;Set ES to point to the current DS
	MOV	BX,ES		; save ES
	MOV	ES,AX		;

	CLD
	MOV	AX,[BP + 8]	;Set string move destination to
	MOV	DS,AX		;point to the screen
	MOV	SI,[BP + 10]	;Set the offset into the screen
	MOV	DI,[BP + 4]	;Set the source for the string move
	MOV	CX,[BP + 6]	;Set xfer count
	REP	MOVSW		;Blast this out to the screen

	MOV	AX,ES		;Restore Current DS
	MOV	ES,BX		;Restore ES ???
	MOV	DS,AX		;

	MOV	AH,CL

	popf
	pop	si
	pop	di
	POP	BP		;reset BP for caller's environment
	RET			;return to caller
dmain_	ENDP

wsetmem_	proc	near
	push	bp
	mov	bp,sp
	push	di
	push	si
	pushf

	push	ds
	pop	es
	
	mov	di,[bp + 4]
	mov	cx,[bp + 6]
	mov	ax,[bp + 8]
	cld
	repz	stosw

	popf
	pop	si
	pop	di
	pop	bp
	ret
wsetmem_	endp

beep_	proc	near
	push	bp		;Save BP on stack to conform to call
	mov	bp,sp		;Set BP to allow subsequent calls

	mov	bx,300		;count of speaker cycles
	in	al,61h		;input control info from keyboard/speaker port
	push	ax		;save it on the stack
cycle:	and	al,0fch		;speaker off pulse (mask out bit 0 and 1)
	out	61h,al		;send command to speaker port
	mov	cx,50		;time for tone half-cycle
l1:	loop	l1		;kill time
	or	al,2		;speaker on pulse (bit 1 on)
	out	61h,al		;send command to speaker port
	mov	cx,50		;time for tone half-cycle
l2:	loop	l2		;kill time
	dec	bx		;count down of speaker cycles
	jnz	cycle		;continue cycling speaker
	pop	ax		;restore speaker/keyboard port value
	out	61h,al		;send port value out

	pop	bp		;reset BP for caller's environment
	ret			;return to caller
beep_	endp

;------------------------------------------------------------------;
; COFF, vectors CTRL-BREAK interrupts to a small assembly language ;
; function which calls QUIT					   ;
;------------------------------------------------------------------;

ctrlbreak:
	push	ax		; AX will be destroyed by call
	call	quit_
	pop	ax		; Restore proper value of ax
	iret

clock_	proc	near
	cli
	push	ds
	push	ax

	; use our data segment
	mov	ax,dataseg
	mov	ds,ax
	inc	tick_		; Tick the old clock

	pop	ax
	pop	ds
	iret			; return from interrupt
clock_	endp


COFF_	proc	near
	mov	dx,offset ctrlbreak	; DX has address of handler
	push	ds			; Save value of DS
	push	ds			; Save value of DS
	push	cs			; Move Value of CS
	pop	ds			; into DS
	mov	ax,2523h		; Set CTRL-BREAK function call
	int	21h
	pop	ds			; Restore DS
	pop	es
	ret
COFF_	endp

getch_	proc	near
	mov	ah,0
	int	16h
	cmp	al,0
	jnz	clrscan
	mov	al,ah
	or	al,80h
clrscan:
	mov	ah,0
	ret
getch_	endp

no_char_	proc	near
	mov	ah,1
	int	16h
	mov	ax,0
	jnz	n1
	inc	ax
n1:
	ret
no_char_	endp

out_	proc	near
	mov	bx,sp
	mov	dx,2[bx]
	mov	al,4[bx]
	out	dx,al
	ret
out_	endp

pokeb_	proc near
	mov	bx,sp
	push	ds
	mov	al,6[bx]
	lds	bx,dword ptr 2[bx]
	mov	[bx],al
	pop	ds
	ret
pokeb_	endp

peekb_	proc	near
	mov	bx,sp
	push	ds
	lds	bx,dword ptr 2[bx]
	mov	al,[bx]
	mov	ah,0
	pop	ds
	ret
peekb_	endp

getds_	proc	near
	push	ds
	pop	ax
	ret
getds_	endp

codeseg	ends
	end
