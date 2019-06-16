#include "peripherals.h"


#define MASK(x)         (1 << (x))
#define SIGNAL_PIN      (1u)


.syntax unified
.thumb
.balign 4
.text


/**
 * Main program.
 */
.global main
.thumb_func
main:
  bl            WDG_Disable
  bl            PORTD_Init

loop:
  /* Toggle GPIO */
  str           r2, [r3, GPIO_PTOR_OFFSET]
  bl            loop


/**
 * Disables Watchdog Timer to avoid reset loop.
 *
 * Registers: r1, r2, r3
 */
WDG_Disable:
  ldr           r3, =SIM_COPC_OFFSET        /* Load COPC offset */
  movs          r1, #0                      /* Load register value */
  ldr           r2, =SIM                    /* Load SIM base address */
  str           r1, [r2, r3]                /* Write SIM_COPC offset to SIM */
  bx            lr                          /* Return */


/**
 * Initializes PORTD and its IO pins.
 *
 * Registers: r0, r1, r2, r3
 */
PORTD_Init:
  /* Enable PORTD clock */
  ldr           r3, =SIM_SCGC5_PORTD_MASK
  ldr           r2, =SIM_SCGC_OFFSET
  ldr           r1, =SIM  
  ldr           r0, [r1, r2]                /* Write SIM_SCGC5 offset to SIM */
  orrs          r0, r3                      /* SIM->SIM_SCGC5_OFFSET |= SIM_SCGC5_PORTD_MASK */
  str           r0, [r1, r2]                /* Write SIM_SCGC5_PORTD to SIM + offset */

  /* Select multiplexer */
  ldr           r2, =PORT_PCR_MUX_MASK
  ldr           r3, =PORTD
  str           r2, [r3, PORT_PCR_OFFSET]   /* Write PORT_PCR_MUX_MASK to PORTD + offset */

  /* Set data direction */
  ldr           r3, =GPIOD                  /* Read GPIOD address */
  movs          r2, #MASK(SIGNAL_PIN)       /* Set signal pin */
  str           r2, [r3, GPIO_PDDR_OFFSET]  /* Write signal pin to GPIOD + offset */
  
  bx            lr                          /* Return */


.end
