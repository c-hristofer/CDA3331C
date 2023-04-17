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

Lab3	mov.w #-7, R4; Setting initial value in R4
		clr.w R5	; Clearing Register values before use
		clr.w R6
		clr.w R7
		clr.w R8

Xcalc		mov.w R4, R5; Copies value "a" into R5
			call #ABSOL	; Absolute value of "a" in R5

Summation	mov.w R5, R6	; R5 is used as loop counter, so data is copied into R6 to be manipulated
			call #FACTO		; Factorial of R6. Stores in R6
			add.w R6, R8	; Tripples R6
			add.w R6, R8
			add.w R6, R8
			dec.w R5		; Decrement counter at end of loop
			jnz Summation
			add.w #03, R8	; Adds first loop (0)
			mov.w R8, R5	; Stores result of summation in R5

Fcalc		mov.w #7, R6	; Loop for multiplication of value in R6
			call #MULT		; Multiplies values above ^^

			add.w #25, R6	; Add 25 to numerator
			clrc
			rrc.w R6		; Divides numerator by 8
			rrc.w R6
			rrc.w R6

Loop		jmp Loop		; Infinite loop




ABSOL:	; Absolute Value subroutine
			tst R5
			jn twoscomp	; Converts R5 to absolute value if needed
			ret
twoscomp	inv R5
			inc R5		; Flips sign of value and adds 1 for 2's compliment

ABSOLend	ret			; End Absolute Value subroutine

; Calculates a! from R6 and saves it in R6
FACTO:	; Factorial Subroutine
			push.w R5		; Pushes Registers
			clr.w R6		; Clears data in R6

			mov.w R5, R6	; Places current loop value in R6
			cmp.w #0, R6
			jnz Floop		; Jump to FLOOP when counter is at 0
			mov.w #1, R6	; Changes R6 to 1 if it wasn't the last loop
			jmp FACTOend

Floop		dec.w R5	; Decrement counter
			cmp #0, R5
			jeq FACTOend; If last loop is now, jump to FACTend
			call #MULT	; Multiply values if not the last loop
			jmp Floop	; Loops until value has been calculated

FACTOend	pop.w R5
			ret	; Ends FACTO subroutine

MULT:	; Mult Subroutine
		push.w R5
		push.w R7
		push.w R8
		mov.w #8, R8		; Loop 8 times for 8 bit multiplication
		clr.w R7			; Accumulator storage
		and.w #0x00FF, R5	; Clearls upper 8 bits of R5 before beginnning multiplications

Next	rrc.w R5	; Shifts bits one at a time
		jnc Double	; Continue the loop
		add.w R6, R7; Adds Current value of R5 to Accumulator storage if carry bit

Double	add.w R6, R6	; Doubles R6 and clears carry bit
		dec.w R8		; Decrement Loop
		jnz Next		; Goes to next bit if the last loop hasn't been completed
		mov.w R7, R6	; Saves result to R6


		pop.w R8		; Pops values in R5, R7, R8
		pop.w R7
		pop.w R5

MULTend	ret


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
            
