    .section .vectors
vector_table:
    .word 0xABCD            // Initial Stack Pointer
    .word reset_handler     // Reset Handler
    .zero 400               // Reserved space for other vectors

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    // bl main                // Branch to main function
    mov r1, #1
    mov r2, #2
    add r3, r1, r2
    bl .                    // Infinite loop after main returns
