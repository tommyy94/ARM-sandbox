#define __ICCARM__ 1
#include "C:\Program Files (x86)\IAR Systems\Embedded Workbench 8.0\arm\inc\ST\iostm32f100xB.h"


        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(1)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB
        
        
__iar_program_start
        
			
; Enable peripheral clocks
; Bit 4: Port C, Bit 3: Port B, Bit 2: Port A
GPIO_clk_ena
		ldr	R6, =RCC_APB2ENR	; R6 is pointer to register
		mov	R0, #0x001C		    ; Turn on clocks for Ports A/B/C
		str	R0, [R6]

; Port C push-pull
GPIO_init
		ldr	R6, =GPIOC_CRH
		ldr	R0, =0x44444433     ; CNF: 00, Mode: 11
		str	R0, [R6]

		mov	R2, #0x0100         ; PC8 on
    mov R3, #0x0000         ; PC8 off
		ldr	R6, =GPIOC_ODR      ; Pointer to Port C output data register
	
  
main			
		str	R2, [R6]
    nop           ; breakpoint
		str	R3, [R6]
    nop           ; breakpoint
		b	main 

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        SECTION .intvec:CODE:NOROOT(2)
        
        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     __iar_program_start

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

        PUBWEAK NMI_Handler
        PUBWEAK HardFault_Handler
        PUBWEAK MemManage_Handler
        PUBWEAK BusFault_Handler
        PUBWEAK UsageFault_Handler
        PUBWEAK SVC_Handler
        PUBWEAK DebugMon_Handler
        PUBWEAK PendSV_Handler
        PUBWEAK SysTick_Handler

        SECTION .text:CODE:REORDER:NOROOT(1)
        THUMB

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
Default_Handler
__default_handler
        CALL_GRAPH_ROOT __default_handler, "interrupt"
        NOCALL __default_handler
        B __default_handler

        END
