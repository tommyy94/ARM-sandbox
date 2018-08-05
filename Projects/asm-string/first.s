; Directives
    PRESERVE8
    THUMB       
 
; Vector Table Mapped to Address 0 at Reset
    AREA    RESET, DATA, READONLY
    EXPORT  __Vectors
 
__Vectors 
    DCD     0x20001000     ; stack pointer value when stack is empty
    DCD     Reset_Handler  ; reset vector
  
    ALIGN
    	  
          
string
    DCB	    "Very nice summer", 0	
 
    AREA    MYCODE, CODE, READONLY
 
    ENTRY
    EXPORT Reset_Handler
 
           
; Subroutimes
printString
    LDR     R0, =string         ; Load the address of string into the register R0 
    MOV	    R1, #0  	        ; Initialize the counter counting the length of string

loopCount
    LDRB	R2, [R0], #1        ; 1oad the character from the address R0 contains
    CBZ	    R2, countDone       ; If it is zero, we are done, length in R1
    ADD	    R1, #1;             ; increment the counter for length
    B	    loopCount   
    
countDone
    BX      LR
    
    
Reset_Handler
 
; Main program
Start 
    BL      printString

	
    B       countDone
    ALIGN
    
    B       Start
    END
