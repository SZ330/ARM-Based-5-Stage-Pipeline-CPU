# ARM-Based 5-Stage Pipelined CPU

## Overview
This repository contains an **ARM-based 5-stage pipelined CPU** implemented in **SystemVerilog** for EE 469.  
The design follows a classic 5-stage pipeline and focuses on **data forwarding** to resolve data hazards.

---
## Pipeline Stages
The processor implements the following pipeline stages:

1. **IF — Instruction Fetch**
2. **ID — Instruction Decode / Register Fetch**
3. **EX — Execute**
4. **MEM — Memory Access**
5. **WB — Write Back**

---

## Features
- ARM-based instruction set
- 5-stage pipelined datapath
- Data forwarding (EX/MEM and MEM/WB paths)
- Accelerated branching

---

## Project Context & Attribution
This project was completed as part of: **EE 469 – Computer Architecture I**

Instructor: **Professor Scott Hauck**, **University of Washington**

This repository is shared for **educational and portfolio purposes only**.

---

## Academic Integrity Notice
If you are currently enrolled in EE 469 or a similar course:

**Do not copy or submit this code as your own work.**  
Doing so may violate academic integrity policies.

---
