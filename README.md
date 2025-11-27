# MiniRTOS - Educational Cooperative RTOS in C

![C](https://img.shields.io/badge/Language-C-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## Overview

**MiniRTOS** is a small, educational Real-Time Operating System (RTOS) implemented in C, designed to simulate task scheduling, inter-task communication, and simple peripheral interactions. It is **cooperative** (non-preemptive) but demonstrates the core concepts of multitasking, task delays, message queues, and hardware abstraction.

This project was built as a learning exercise in embedded systems, RTOS principles, and cooperative scheduling.

---

## Features

- Cooperative round-robin scheduler
- Task management with periodicity and voluntary yield
- Simple message queues for inter-task communication
- Task blocking and unblocking via queues
- Task delay mechanism (`rtos_delay`)
- Simulated ADC sensor, fans, and UART logging
- Modular and reusable code structure
- Educational comments and function-level documentation

---

## Tasks

- **task_sensor**: Simulates a 12-bit ADC reading. Sends raw data to `QUEUE_SENSOR`.
- **task_proc**: Receives raw ADC values, converts to Celsius, determines fan speeds, and forwards data to `QUEUE_PROC`.
- **task_logger**: Receives processed temperature data and prints logs via UART simulation.

All tasks use a `pc` (program counter) variable to maintain state across yields, allowing cooperative multitasking.

---

## Message Queues

- Each queue has fixed item size (`ITEM_SIZE`) and capacity (`CAPACITY`).
- Implemented as circular buffers using `uint8_t` for generic storage.
- Tasks can block on empty queues and are automatically unblocked when new data arrives.
- Example queues:
  - `QUEUE_SENSOR`: sensor → processor
  - `QUEUE_PROC`: processor → logger
  - `QUEUE_LOGGER`: (optional, centralized logging)

---

## Scheduler

- **Cooperative**, not preemptive:
  - Tasks must yield explicitly via `rtos_yield()` or `rtos_delay()`.
  - Round-robin traversal ensures fairness between READY tasks.
- Optional `rtos_delay(ms)`:
  - Sets the task's next run time.
  - Yields automatically to allow other tasks to execute.
- Design choice: cooperative scheduling simplifies state management and is easier to understand for educational purposes.

---

## Drivers Simulation

- **ADC**: Generates increasing counter values (0–4095) to simulate a 12-bit ADC.
- **Fans**: Simulated by printing the fan ID and speed percentage.
- **UART**: Logs via `fwrite` to `stdout`.
- Notes: All drivers are placeholders for real embedded hardware.

---

## Design Decisions & Tips

1. **Cooperative vs Preemptive**:  
   Cooperative simplifies debugging, avoids race conditions, and allows easy demonstration of task yielding and blocking.

2. **`uint8_t` buffers for queues**:  
   Using bytes allows generic message storage regardless of actual data type, simplifying queue design.

3. **Task `pc` and static variables**:  
   These emulate a “thread context” in a cooperative scheduler, allowing partial execution over multiple cycles.

4. **Yielding and delays**:  
   - `rtos_yield()` is used to give up CPU voluntarily.
   - `rtos_delay(ms)` lets tasks wait for a specified period without blocking the entire scheduler.

5. **Driver abstractions**:  
   - Each hardware interaction is encapsulated in a function.
   - Makes it easy to replace simulated drivers with real hardware code.

6. **Queue blocking/unblocking**:  
   - When a task tries to read from an empty queue, it is marked BLOCKED.
   - Sending a message to that queue automatically marks the task READY again.

---

## How to Compile and Run

```bash
make
./bin/minirtos
````

* Output simulates sensor readings, temperature processing, fan speeds, and UART logs.
* Tasks run with cooperative multitasking, demonstrating yields and delays.

---

## Learning Outcomes

* Understanding cooperative scheduling in RTOS.
* Implementing task delays and yields.
* Managing inter-task communication with message queues.
* Structuring embedded C code modularly for simulation and testing.
* Familiarity with ADC, UART, and actuator (fan) abstractions.

---

## License

MIT License. See `LICENSE` for details.

---

## Author

Kevin, Educational Embedded Systems Project, 2025

## Notes

* This RTOS is educational and does not include preemptive scheduling or hardware-specific drivers.
* The scheduler implementation can be extended to include time slices, preemption, or inter-task communication for further learning purposes.
