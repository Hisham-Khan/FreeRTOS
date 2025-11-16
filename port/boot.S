    .section .vectors
vector_table:
    .word __stack           // Initial Stack Pointer
    .word reset_handler     // Reset Handler
    .zero 400               // Reserved space for other vectors

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    b main                  // Branch to main function
    b .                     // Infinite loop after main returns
