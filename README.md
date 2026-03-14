# COA Project — Pipeline RAW Hazard Demonstration
**BTech Computer Science | Computer Organization and Architecture**

## Overview
Demonstrates RAW (Read After Write) data hazards in a RISC-V
5-stage pipeline using the Ripes simulator, along with both
hardware (forwarding) and software (NOP stalls) solutions.

## Project Structure
coa-raw-hazard-project/
├── src/
│   ├── raw_hazards.asm       # Use with forwarding processor
│   └── manual_stalls.asm     # Use without forwarding
├── docs/
│   └── report.md
├── screenshots/
├── .gitignore
└── README.md

## How to Run in Ripes
1. Download Ripes: https://github.com/mortbopet/Ripes/releases
2. Open Ripes → Editor tab → paste .asm file contents
3. Select processor → Reset → set breakpoint at end: nop → Run

## Processor Selection
| Experiment          | Processor                  | File                |
|---------------------|----------------------------|---------------------|
| Show RAW bugs       | 5-Stage w/o Forwarding     | raw_hazards.asm     |
| Software fix (NOPs) | 5-Stage w/o Forwarding     | manual_stalls.asm   |
| Hardware fix        | 5-Stage with Forwarding    | raw_hazards.asm     |

## Expected Register Values
| Register | Value | Calculation     |
|----------|-------|-----------------|
| x1       | 5     | A               |
| x2       | 7     | B               |
| x3       | 12    | A + B           |
| x4       | 17    | x3 + x1         |
| x5       | 29    | x4 + x3         |
| x6       | 12    | C               |
| x7       | 41    | x6 + x5         |
| x8       | 290   | 10 × (x3 + x4)  |
| x9       | 0     | loop done       |

## Team Members
- Name 1 — Roll No.
- Name 2 — Roll No.

## References
- Ripes: https://github.com/mortbopet/Ripes
- Patterson & Hennessy — Computer Organization and Design (RISC-V Edition)
