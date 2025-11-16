#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H

// Config tick type width - set to 32 bits for 24 bit sys tick timer
#define configTICK_TYPE_WIDTH_IN_BITS               TICK_TYPE_WIDTH_32_BITS
// Interrupt priority - Lower numbers represent higher priorities.
#define configMAX_SYSCALL_INTERRUPT_PRIORITY        1
// Stack size for minimal tasks set to 256 bytes
#define configMINIMAL_STACK_SIZE                    0x100
// Max priorities set to 5 - lower is better as each priority level consumes RAM
#define configMAX_PRIORITIES                        5
// Use preemption to enable high priority task switching
#define configUSE_PREEMPTION                        1
// Idle hook not used
#define configUSE_IDLE_HOOK                         0
// Tick hook not used
#define configUSE_TICK_HOOK                         0
// Heap size set to 4 KB -
#define configTOTAL_HEAP_SIZE                       ((size_t)(4 * 1024))
// CPU clock speed set to 8 MHz
#define configCPU_CLOCK_HZ                          ((unsigned long)8000000)
// Tick rate set to 1000 Hz
#define configTICK_RATE_HZ                          ((TickType_t)10)

#endif /* FREERTOS_CONFIG_H */
