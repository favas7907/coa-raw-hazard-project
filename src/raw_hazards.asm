# ============================================================
# raw_hazards.asm
# BTech CS - Computer Organization and Architecture
# Project: Pipeline RAW Hazard Demonstration
#
# Purpose  : Demonstrates RAW (Read After Write) hazards
# Processor: RISC-V 5-Stage WITH Forwarding + Hazard Detection
# ============================================================

.data
    A:  .word 5        # First operand
    B:  .word 7        # Second operand
    C:  .word 12       # Third operand (for load-use hazard)

.text
main:
    # ---- Load base addresses ----
    la   x10, A            # x10 = address of A
    la   x11, B            # x11 = address of B
    la   x12, C            # x12 = address of C

    # ---- Load values from memory ----
    lw   x1, 0(x10)        # x1 = A = 5
    lw   x2, 0(x11)        # x2 = B = 7

    # ---- ALU -> ALU RAW Hazard Chain ----
    add  x3, x1, x2        # x3 = 12   [WRITES x3]
    add  x4, x3, x1        # x4 = 17   [RAW: reads x3 immediately]
    add  x5, x4, x3        # x5 = 29   [RAW: reads x4 immediately]

    # ---- Load-Use RAW Hazard ----
    lw   x6, 0(x12)        # x6 = 12   [LOADS x6]
    add  x7, x6, x5        # x7 = 41   [RAW load-use: reads x6 immediately]

    # ---- Loop with RAW Hazards ----
    li   x9, 10            # x9 = loop counter = 10
    li   x8, 0             # x8 = accumulator = 0

loop:
    add  x8, x8, x3        # x8 += 12   [RAW: x8 written then read]
    add  x8, x8, x4        # x8 += 17   [RAW: x8 written then read]
    addi x9, x9, -1        # x9--
    bnez x9, loop          # if x9 != 0, loop again

end:
    nop                    # <<< SET BREAKPOINT HERE in Ripes

