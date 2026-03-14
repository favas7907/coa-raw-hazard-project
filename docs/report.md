# Project Report — Pipeline RAW Hazard Demonstration

## 1. Problem Statement
Demonstrate RAW (Read After Write) data hazards in a RISC-V
5-stage pipeline and show both hardware and software solutions.

## 2. Hazard Types Demonstrated

### ALU → ALU RAW Hazard
add x3, x1, x2    # writes x3
add x4, x3, x1    # immediately reads x3 → RAW hazard

### Load-Use RAW Hazard
lw  x6, 0(x12)    # loads x6
add x7, x6, x5    # immediately reads x6 → load-use hazard

## 3. Solutions

### Software — Manual NOP Stalls
- Insert 2 NOPs after each hazardous instruction
- Creates pipeline bubbles manually
- Increases CPI significantly

### Hardware — Forwarding
- Processor detects hazard automatically
- Forwards result from EX/MEM stage to ALU input
- No extra instructions needed

## 4. Performance Comparison
| Configuration             | CPI   | Notes                          |
|---------------------------|-------|--------------------------------|
| w/o Forwarding + NOPs     | > 1.5 | NOP bubbles inflate cycle count|
| With Forwarding (no NOPs) | ~1.0  | Hardware resolves hazards      |

## 5. Observations
(Fill after running all 3 experiments in Ripes)
- Cycles with NOPs :
- Cycles with FWD  :
- CPI with NOPs    :
- CPI with FWD     :

## 6. Conclusion
(Write after completing experiments)
