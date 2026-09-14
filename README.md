# Synchronous FIFO.v

This project implements a **Synchronous FIFO (First-In First-Out) memory buffer in Verilog**. A FIFO is a data structure where the **first data written into the buffer is the first data to be read out**.

## 📌 Overview
A **Synchronous FIFO** operates with a **single clock for both read and write operations**. It is widely used in **digital systems and FPGA designs** to temporarily store and transfer data between modules operating at the same clock frequency.

## ⚙️ Features
- Single clock for both read and write operations
- FIFO-based data ordering (First-In First-Out)
- Read and write pointer management
- Full and Empty flag generation
- Efficient data buffering between modules

## 🏗️ Architecture
The Synchronous FIFO consists of the following components:

- **Memory Array** → Stores the incoming data.
- **Write Pointer** → Points to the location where the next data will be written.
- **Read Pointer** → Points to the location from which data will be read.
- **Control Logic** → Generates **Full** and **Empty** flags to prevent overflow or underflow.

### Operation
- **Write Operation** → Data is written into the FIFO when the write enable signal is active.
- **Read Operation** → Data is read from the FIFO when the read enable signal is active.
- The write pointer increments after every write, and the read pointer increments after every read.

## Output 
### Waveform 
<img width="939" height="243" alt="image" src="https://github.com/user-attachments/assets/819588d0-870b-48d9-96d2-02d19b753d86" />

### Simulation Terminal
<img width="429" height="182" alt="image" src="https://github.com/user-attachments/assets/9929cf86-af75-448c-b975-fdc2f916f9ff" />

