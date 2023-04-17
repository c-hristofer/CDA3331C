;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
;Memory allocation of Arrays must be done before the RESET and Stop WDT

ARY1	.set	0x0200			;Memory allocation  ARY1

ARY1S	.set	0x0210			;Memory allocation  ARY1S

ARY2	.set	0x0220			;Memory allocation ARY2

ARY2S	.set	0x0230			;Memory allocation  ARY2S





		clr	R4						;clearing all register being use is a good programming practice

		clr	R5

		clr	R6

		clr R7

		clr R8

		clr R9

		clr R10





SORT1	mov.w	#ARY1, R4		;initialize R4 as a pointer to array1

		mov.w	#ARY1S, R6		;initialize R4 as a pointer to array1 sorted

		call 	#ArraySetup1	;then call subroutine ArraySetup1

		call	#COPY			;Copy elements from ARY1 to ARY1S space

		call	#SORT			;Sort elements in ARAY1





SORT2	mov.w	#ARY2, R4		;initialize R4 as a pointer to array2

		mov.w	#ARY2S, R6		;initialize R4 as a pointer to array2 sorted

		call	#ArraySetup2		;then call subroutine ArraySetup2

		call	#COPY			;Copy elements from ARY2 to ARY2S space

		call	#SORT				;Sort elements in ARAY2





Mainloop   jmp  Mainloop		;Infinite Loop





ArraySetup1
		mov.b	#10, 0(R4)			; Array element initialization Subroutine. First start with the number of elements

		mov.b	#45, 1(R4)			; Fill in the 10 elements.

		mov.b	#-23, 2(R4)

		mov.b	#-78, 3(R4)

		mov.b	#32, 4(R4)

		mov.b	#89, 5(R4)

		mov.b	#-19, 6(R4)

		mov.b	#-99, 7(R4)

		mov.b	#73, 8(R4)

		mov.b	#-18, 9(R4)

		mov.b	#56, 10(R4)

		ret





ArraySetup2     				; Similar to ArraySetup1 subroutine
		mov.b	#10, 0(R4)			; Array element initialization Subroutine. First start with the number of elements

		mov.b	#22, 1(R4)			; Fill in the 10 elements.

		mov.b	#45, 2(R4)

		mov.b	#21, 3(R4)

		mov.b	#-39, 4(R4)

		mov.b	#-63, 5(R4)

		mov.b	#69, 6(R4)

		mov.b	#72, 7(R4)

		mov.b	#41, 8(R4)

		mov.b	#28, 9(R4)

		mov.b	#-28, 10(R4)

		ret





COPY	mov.b 0(R4), R10	;save n in R10

		inc.b R10			; increment for total size of array

		mov.w R4,R5			; copy R4 to R5 to preserve data in R4

		mov.w R6, R7 		; copy R6 to R7 to preserve data in R6

LP		mov.b @R5+, 0(R7) 	; copy n to R7

		inc.w R7

		dec R10				; decrement counter

		jnz LP				; loop until values are copied

		ret


SORT	mov.b @R6, R8		; move value in R6 to R8. R8 is number of elements in array

LOOP1	mov.w R8, R9		; R9 is amount of loops left

		dec R8				; decrement R8 for size - 1. first location is n

		jz DONE				; if R8 = 0, End program

		mov.w R6, R7		; copy R6 to R7 to preserve data in R6

		inc R7				; increment R7

LOOP2	dec R9				; If R9 = 0,

		jz LOOP1

		mov.b @R7+, R10

		cmp.b R10, 0(R7);

		jge LOOP2

		mov.b @R7, -1(R7); places current value stored in R7 in previous location

		mov.b R10, 0(R7) ;

		jmp LOOP2

DONE	ret

                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
