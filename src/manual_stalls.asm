# ============================================================
# manual_stalls.asm
# BTech CS - Computer Organization and Architecture
# Project: Pipeline RAW Hazard Demonstration
#
# Purpose  : Resolves RAW hazards using manual NOP stalls
# Processor: RISC-V 5-Stage WITHOUT Forwarding or Hazard Detection
#
# Rule: Insert 2 NOPs after every instruction whose result
#       is needed by the following instruction
# ============================================================

.data
    A:  .word 5
    B:  .word 7
    C:  .word 12

.text
main:
    # ---- Load base addresses ----
    la   x10, A
    la   x11, B
    la   x12, C

    # ---- Load values (2 NOPs after each lw) ----
    lw   x1, 0(x10)        # x1 = A = 5
    nop                    # stall 1
    nop                    # stall 2
    lw   x2, 0(x11)        # x2 = B = 7
    nop                    # stall 1
    nop                    # stall 2

    # ---- ALU -> ALU RAW Hazard Chain (2 NOPs between each) ----
    add  x3, x1, x2        # x3 = 12   [WRITES x3]
    nop                    # stall 1
    nop                    # stall 2
    add  x4, x3, x1        # x4 = 17   [reads x3 - now safe]
    nop                    # stall 1
    nop                    # stall 2
    add  x5, x4, x3        # x5 = 29   [reads x4 - now safe]

    # ---- Load-Use RAW Hazard (2 NOPs after lw) ----
    lw   x6, 0(x12)        # x6 = 12
    nop                    # stall 1
    nop                    # stall 2
    add  x7, x6, x5        # x7 = 41   [reads x6 - now safe]

    # ---- Loop with manual stalls ----
    li   x9, 10            # loop counter
    li   x8, 0             # accumulator

loop:
    add  x8, x8, x3        # x8 += 12
    nop
    nop
    add  x8, x8, x4        # x8 += 17   [reads x8 - now safe]
    nop
    nop
    addi x9, x9, -1        # x9--
    nop
    nop
    bnez x9, loop

end:
    nop                    # <<< SET BREAKPOINT HERE in Ripes
