# FIFO Memory Design Using Verilog

## 📌 Project Overview

This project implements a **FIFO (First In, First Out) Memory** using Verilog HDL.

A FIFO memory stores data in the order it is written and reads the data in the same order. The first data written into the FIFO is the first data read from it.

This project demonstrates FIFO memory architecture, read/write control, pointers, status flags, and RTL simulation.

---

## 🎯 Objectives

* Design a FIFO memory using Verilog HDL
* Implement read and write operations
* Maintain read and write pointers
* Generate `FULL` and `EMPTY` flags
* Verify FIFO operation using a testbench
* Demonstrate First-In-First-Out data handling

---

## 🏗️ FIFO Architecture

```text
                    +----------------+
                    |   Write Logic  |
                    +-------+--------+
                            |
                            ▼
                      +-----------+
Data In ─────────────►|   FIFO    |
                      |  Memory   |
                      +-----------+
                            |
                            ▼
                      +-----------+
                      | Read Logic|
                      +-----+-----+
                            |
                            ▼
                        Data Out
```

The FIFO contains:

* Memory array
* Write pointer
* Read pointer
* Counter
* Full flag
* Empty flag

---

## ⚙️ Specifications

| Parameter       |        Value |
| --------------- | -----------: |
| Data Width      |       8 bits |
| FIFO Depth      |  8 locations |
| Memory Capacity |      64 bits |
| Clock           | Single clock |
| Reset           |  Active-high |
| Data Format     |       Binary |

---

## 🔌 Module Interface

| Signal     | Direction | Width | Description       |
| ---------- | --------- | ----: | ----------------- |
| `clk`      | Input     |     1 | System clock      |
| `reset`    | Input     |     1 | Reset signal      |
| `wr_en`    | Input     |     1 | Write enable      |
| `rd_en`    | Input     |     1 | Read enable       |
| `data_in`  | Input     |     8 | Input data        |
| `data_out` | Output    |     8 | Output data       |
| `full`     | Output    |     1 | FIFO full status  |
| `empty`    | Output    |     1 | FIFO empty status |

---

## 🔄 Working Principle

### 1. Reset

When `reset` is HIGH:

```text
Read Pointer  = 0
Write Pointer = 0
Count         = 0
```

The FIFO becomes empty:

```text
empty = 1
full  = 0
```

### 2. Write Operation

When:

```text
wr_en = 1
empty/full conditions are valid
```

data is written into the memory at the location indicated by the write pointer.

Example:

```text
10 → 20 → 30 → 40
```

### 3. Read Operation

When:

```text
rd_en = 1
empty = 0
```

data is read from the location indicated by the read pointer.

The data is returned in the same order:

```text
10 → 20 → 30 → 40
```

---

## 🔢 FIFO Data Flow

```text
WRITE SIDE                       READ SIDE

   10 ──────┐
   20 ──────┤
   30 ──────┤      FIFO       ┌──────► 10
   40 ──────┤    MEMORY       ├──────► 20
            └───────────────►  ├──────► 30
                               └──────► 40
```

This is the **First In, First Out** principle.

---

## 🚦 FULL and EMPTY Flags

### Empty

The `empty` flag becomes HIGH when there is no data in the FIFO.

```text
empty = 1
```

A read operation is not allowed when the FIFO is empty.

### Full

The `full` flag becomes HIGH when all memory locations are occupied.

```text
full = 1
```

A write operation is not allowed when the FIFO is full.

---

## 🧪 Testbench

The testbench performs the following operations:

```text
1. Apply reset
2. Write 10
3. Write 20
4. Write 30
5. Write 40
6. Read 10
7. Read 20
8. Read 30
9. Read 40
10. Verify EMPTY flag
```

---

## ✅ Expected Output

```text
WRITE | Data = 10
WRITE | Data = 20
WRITE | Data = 30
WRITE | Data = 40

READ  | Data = 10
READ  | Data = 20
READ  | Data = 30
READ  | Data = 40

FIFO EMPTY
```

### Expected Data Sequence

```text
Input Data:

10 → 20 → 30 → 40

Output Data:

10 → 20 → 30 → 40
```

---

## 📊 Expected FIFO Status

| Operation | Data | FULL | EMPTY |
| --------- | ---: | ---: | ----: |
| Reset     |    — |    0 |     1 |
| Write     |   10 |    0 |     0 |
| Write     |   20 |    0 |     0 |
| Write     |   30 |    0 |     0 |
| Write     |   40 |    0 |     0 |
| Read      |   10 |    0 |     0 |
| Read      |   20 |    0 |     0 |
| Read      |   30 |    0 |     0 |
| Read      |   40 |    0 |     1 |

---

## 📁 Project Structure

```text
FIFO-Memory-Design/
│
├── fifo_memory.v
├── fifo_memory_tb.v
└── README.md
```

### Files Description

**`fifo_memory.v`**

Contains the RTL implementation of the FIFO memory.

**`fifo_memory_tb.v`**

Contains the Verilog testbench for functional verification.

**`README.md`**

Project documentation.

---

## 💻 Simulation

### Using Icarus Verilog

Compile:

```bash
iverilog -o fifo_sim fifo_memory.v fifo_memory_tb.v
```

Run:

```bash
vvp fifo_sim
```

---

## 🛠️ Supported Tools

This project can be simulated using:

* Icarus Verilog
* Verilator
* ModelSim
* QuestaSim
* Xilinx Vivado
* Intel Quartus
* EDA Playground

---

## 🚀 Applications

FIFO memory is commonly used in:

* Data buffering
* UART communication
* SPI communication
* Processor systems
* Digital signal processing
* Network interfaces
* Embedded systems
* FPGA designs
* ASIC designs
* Communication systems

---

## 🔮 Future Enhancements

The design can be extended with:

* Parameterized FIFO width and depth
* Almost-full flag
* Almost-empty flag
* Asynchronous FIFO
* Dual-clock FIFO
* Gray-code pointers
* FPGA Block RAM implementation
* AXI-Stream interface
* Error detection
* Overflow and underflow detection

---

## 📚 Learning Outcomes

This project demonstrates:

* Verilog HDL
* RTL design
* Memory arrays
* Sequential logic
* Read/write pointers
* Counters
* FIFO architecture
* Status flag generation
* Testbench development
* Digital system verification

---

## 👩‍💻 Author

**FIFO Memory Design Using Verilog HDL**

## 📜 License

This project is intended for educational and academic purposes.
