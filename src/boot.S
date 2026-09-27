.section ".text.boot"
.global _start

_start:
    mrs x0, mpidr_el1
    and x0, x0, #0xff
    cbnz x0, halt

    ldr x0, =stack_top
    mov sp, x0

    ldr x0, =__bss_start
    ldr x1, =__bss_end

clear_bss:
    cmp x0, x1
    b.hs enter_kernel
    str xzr, [x0], #8
    b clear_bss

enter_kernel:
    bl pebble_main

halt:
    wfe
    b halt

.section ".bss"
.align 12
stack_bottom:
    .skip 65536
stack_top:
