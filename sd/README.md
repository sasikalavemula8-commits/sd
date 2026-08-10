# Verilog Sequence Detector – 1011

A simple **Verilog HDL sequence detector** that detects the binary sequence **1011** using a **Finite State Machine (FSM)**.

## Overview

This project implements a **Mealy sequence detector**. The circuit monitors a serial binary input and generates a `detected` output whenever the sequence `1011` is received.

The design uses four FSM states:

```text
S0 → No matching bits
S1 → Detected 1
S2 → Detected 10
S3 → Detected 101
```

When the circuit is in state `S3` and receives another `1`, the complete sequence `1011` has been detected.

## Features

* Written in Verilog HDL
* Mealy FSM implementation
* Detects the sequence `1011`
* Synchronous data processing with clock
* Asynchronous reset
* Supports overlapping sequence detection
* Includes a simulation testbench

## Project Structure

```text
sequence-detector-1011/
│
├── sequence_detector.v
├── sequence_detector_tb.v
└── README.md
```

## Module Ports

| Port       | Direction | Description                       |
| ---------- | --------- | --------------------------------- |
| `clk`      | Input     | Clock signal                      |
| `reset`    | Input     | Reset signal                      |
| `data_in`  | Input     | Serial binary input               |
| `detected` | Output    | Goes HIGH when `1011` is detected |

## FSM State Diagram

```text
             1
        ┌─────────┐
        │         ▼
      ┌───┐     ┌───┐
      │ S0│────▶│ S1│
      └───┘  1  └───┘
        ▲         │
        │         │ 0
        │         ▼
        │       ┌───┐
        │       │ S2│
        │       └───┘
        │         │
        │         │ 1
        │         ▼
        │       ┌───┐
        └── 0 ─ │ S3│
                └───┘
                  │
                  │ 1 / detected = 1
                  ▼
                 S1
```

## How It Works

For the input stream:

```text
1 0 1 1
```

the FSM progresses as:

```text
S0 → S1 → S2 → S3 → S1
```

The transition from `S3` with input `1` completes the sequence:

```text
1011
```

At this point:

```text
detected = 1
```

Because this is a Mealy FSM, the detection output is generated during the transition that receives the final `1`.

## Simulation

The included testbench applies the following input sequence:

```text
1011
```

and verifies that the detector generates a HIGH output when the complete sequence is received.

### Example

```text
Input:     1 0 1 1
                     ↑
                 Detection
```

Expected result:

```text
detected = 1
```

## Tools

You can simulate this project using:

* Icarus Verilog
* Verilator
* ModelSim
* QuestaSim
* Vivado
* Intel Quartus

## Running with Icarus Verilog

Compile the design and testbench:

```bash
iverilog -o sequence_detector_tb sequence_detector.v sequence_detector_tb.v
```

Run the simulation:

```bash
vvp sequence_detector_tb
```

## Possible Improvements

This project can be extended to:

* Detect different sequences such as `1101` or `1001`
* Implement a Moore FSM
* Add overlapping/non-overlapping detection modes
* Generate waveform files for GTKWave
* Add parameterized sequence detection
