# UART Controller Design and Verification

## Overview

This project implements a UART (Universal Asynchronous Receiver Transmitter) Controller in Verilog HDL. The design consists of a baud rate generator, UART transmitter, UART receiver, and a top-level integration module. Functional verification was performed using ModelSim through loopback communication testing.

---

## Features

* Baud Rate Generator
* UART Transmitter (TX)
* UART Receiver (RX)
* FSM-Based Design
* Loopback Verification
* ModelSim Simulation

---

## RTL Architecture

### Baud Generator

Generates periodic baud tick pulses used for UART data transmission and reception.

### UART Transmitter (TX)

The transmitter serializes 8-bit parallel data and sends it through a UART frame consisting of:

* 1 Start Bit
* 8 Data Bits
* 1 Stop Bit

FSM States:

* IDLE
* START
* DATA
* STOP

### UART Receiver (RX)

The receiver reconstructs serial data into an 8-bit parallel word and indicates successful reception using `rx_done`.

FSM States:

* IDLE
* DATA
* STOP

### Top Module

The top-level module integrates:

* Baud Generator
* UART TX
* UART RX

A loopback connection is used where TX output is directly connected to RX input for verification.

---

## Verification

Functional verification was performed using ModelSim.

### Test Cases

| Transmitted Data | Received Data | Result |
| ---------------- | ------------- | ------ |
| 0xA5             | 0xA5          | PASS   |
| 0x55             | 0x55          | PASS   |
| 0x3C             | 0x3C          | PASS   |

### Verification Results

Successful UART loopback communication was verified for all test patterns.

Observed outputs:

```text
TX_DATA = A5  -> RX_DATA = A5
TX_DATA = 55  -> RX_DATA = 55
TX_DATA = 3C  -> RX_DATA = 3C
```

The receiver correctly reconstructed the transmitted data and asserted `rx_done` after frame reception.

---


## Tools Used

* Verilog HDL
* ModelSim Intel FPGA Edition

---

## Structure

```text
UART_Controller_Verilog
│
├── RTL
│   ├── baud_gen.v
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── uart_top.v
│
├── TB
│   └── uart_tb.v
│
├── Waveforms
│   └── uart_loopback_waveform.png
│
└── README.md
```

---

## Author

Snigdha Roy Chowdhury
