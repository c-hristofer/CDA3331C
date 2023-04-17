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
Setup 	clr.w R4	; clear registers
		clr.w R5
		clr.w R6
		clr.w R7
		clr.w R10

		mov #14, R4 ; Setup Register values
		mov #15, R5
		mov #16, R6
		mov #10, R10

Addition	mov.w R4, R7 ; Add contents of R4, R5, R6 into R7
			add.w R5, R7
			add.w R6, R7

Subtraction	sub.w R10, R7 ; subtract content of R10 from R7

Store	mov.w R4, &0200h ; store values starting at memory address 0x0200
		mov.w R5, &0202h
		mov.w R6, &0204h
		mov.w R10, &0206h
		mov.w R7, &0208h


Mainloop jmp Mainloop ; Infinite Loop
                                            

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
