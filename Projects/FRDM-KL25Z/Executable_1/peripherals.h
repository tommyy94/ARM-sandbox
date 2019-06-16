/* Peripheral SIM base address */
#define SIM                       (0x40047000u)
#define SIM_SCGC_OFFSET           (0x1038u)
#define SIM_SCGC5_PORTD_MASK      (0X1000u)
#define SIM_COPC_OFFSET           (0x1100u)

/* Peripheral PCR Bit Fields */
#define PORT_PCR_MUX_MASK         (0x100u)
#define PORT_PCR_OFFSET           (0x04u)

/* Peripheral Port Base Addresses */
#define PORTD                     (0x4004C000u)

/* Peripheral GPIO Base Addresses */
#define GPIOD                     (0x400FF0C0u)
#define GPIO_PDDR_OFFSET          (0x14u)
#define GPIO_PTOR_OFFSET          (0x0Cu)
