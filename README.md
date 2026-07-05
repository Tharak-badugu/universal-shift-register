# Multi-Mode Universal Shift Register (USR)

## 📌 Project Overview
This repository contains the RTL design and verification environment for a **4-bit Universal Shift Register (USR)** written in Verilog. The design supports bidirectional data shifting and parallel loading configurations controlled by a 2-bit mode selection input. It incorporates priority-based control logic alongside an asynchronous active-high reset to align with physical hardware synthesis constraints.

## ⚙️ Hardware Specifications & Modes
The design evaluates operational commands on every rising edge of the clock (`clk`) when the asynchronous reset (`rst`) is low. The hardware logic supports four distinct functional modes via the `mode[1:0]` bus:

| Mode | Operation | Description |
| :---: | :--- | :--- |
| **2'b00** | **SISO** (Serial-In, Serial-Out) | Shifts data right through `sout`, pulling new bits from `sin` when `shift` is enabled. |
| **2'b01** | **SIPO** (Serial-In, Parallel-Out) | Shifts data right, presenting the internal register state directly on the 4-bit `pout` bus. |
| **2'b10** | **PISO** (Parallel-In, Serial-Out) | Captures parallel data from `pin` when `load` is asserted; otherwise streams bits out serially when `shift` is enabled. |
| **2'b11** | **PIPO** (Parallel-In, Parallel-Out) | Latches the full 4-bit `pin` data directly to `pout` synchronously upon `load` assertion. |

### Control Priority
1. **Asynchronous Reset (`rst`):** Overrides all operations, forcing the internal registers cleanly to `4'b0000`.
2. **Parallel Load (`load`):** Takes precedence over shift signals in PISO/PIPO modes to prevent logic contention.
3. **Shift (`shift`):** Executes data-steering and bit extraction operations.

---

## 📁 Repository Structure
```text
├── rtl/
│   └── usr.v            # Core RTL hardware description
├── tb/
│   └── tb_usr.v        # Behavioral verification testbench
├── USR_wave.png        # simulation wave form
└── README.md            # Project documentation and waveform analysis
