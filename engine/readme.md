# [neomura/atmega328p-cartridge](../readme.md)/Engine

This engine is written in [AVRA assembler](https://github.com/Ro5bert/avra).

## Flow

The reset vector starts by running through setup routines for the engine and game.

It then enters the main loop, with the the engine's interrupt interacting with hardware and advancing global state which the main loop tracks to raise events.

## Registers

The ATMega328P has enough general-purpose registers that with the limited cycles available frequently used information is best kept in a register rather than repeatedly storing to (costing 2 cycles) and loading from (costing 2 cycles) SRAM.  Additionally, if registers used by the main loop and interrupts overlap as little as possible, the push (2 cycles) and pop (2 cycles) normally required to prevent corruption of main loop state from interrupts can be avoided as well.  In practice, few game logic or driver operations require more than 4 general purpose registers.

Some registers have special purposes:

- `r0` and `r1` receive the result of the instructions `fmul`, `fmuls`, `fmulsu`, `mul`, `muls` and `mulsu`.
- `r26`/`r27`, `r28`/`r29` and `r30`/`r31` are labelled `X`, `Y` and `Z` respectively and are used for indirect load, store and jump.

If these are used, they are considered to belong to the main loop, and any interrupts must back them up (using `push`) beforehand and restore them (using `pop`) before `reti` (alongside `SREG`).

`r0` through `r15` are not directly usable with the instructions `cpi`, `fmul`, `fmuls`, `fmulsu`, `muls`, `mulsu`, `cbr`, `ldi`, `lds`, `ori`, `sbci`, `sbr`, `ser`, `sts`, `subi`, `andi` or `cbr`.  Consequently, if a use is found which is not made impossible or awkward through this limitation, these registers should be prioritized to leave the more flexible r16-r31 available for other operations.

The resulting mapping is as follows:

| Register | Name                           | Description                                                                                                                                              |
| -------- | ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `r0`     | N/A                            | Output for some instructions.                                                                                                                            |
| `r1`     | N/A                            | Output for some instructions.                                                                                                                            |
| `r2`     | `pad_0`                        | State of pad 0 (set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right; all cleared when pad disconnected). |
| `r3`     | `pad_1`                        | State of pad 1 (set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right; all cleared when pad disconnected). |
| `r4`     | `pad_2`                        | State of pad 2 (set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right; all cleared when pad disconnected). |
| `r5`     | `pad_3`                        | State of pad 3 (set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right; all cleared when pad disconnected). |
| `r6`     | `main_loop_previous_video_row` | Used by the main loop for state tracking.                                                                                                                |
| `r7`     | `zero`                         | Always contains zero.                                                                                                                                    |
| `r8`     | `game_general_purpose_low_a`   | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                 |
| `r9`     | `game_general_purpose_low_b`   | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                 |
| `r10`    | `game_general_purpose_low_c`   | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                 |
| `r11`    | `game_general_purpose_low_d`   | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                 |
| `r12`    | `game_general_purpose_low_e`   | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                 |
| `r13`    | `game_general_purpose_low_f`   | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                 |
| `r14`    | `game_general_purpose_low_g`   | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                 |
| `r15`    | `game_general_purpose_low_h`   | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                 |
| `r16`    | `video_next_row`               | The row which the interrupt will be outputting next.  Will remain 0 for longer than other values, in which `game_tick` is executed by the main loop.     |
| `r17`    | `interrupt_state`              | Used by the interrupt to track progress through the current frame.                                                                                       |
| `r18`    | `interrupt_flags`              | Flags used internally by by the interrupt.                                                                                                               |
| `r19`    | `game_general_purpose_high_a`  | Available for general purpose usage.                                                                                                                     |
| `r20`    | `game_general_purpose_high_b`  | Available for general purpose usage.                                                                                                                     |
| `r21`    | `game_general_purpose_high_c`  | Available for general purpose usage.                                                                                                                     |
| `r22`    | `game_general_purpose_high_d`  | Available for general purpose usage.                                                                                                                     |
| `r23`    | `game_general_purpose_high_e`  | Available for general purpose usage.                                                                                                                     |
| `r24`    | `game_general_purpose_high_f`  | Available for general purpose usage.                                                                                                                     |
| `r25`    | `game_general_purpose_high_g`  | Available for general purpose usage.                                                                                                                     |
| `r26`    | N/A                            | `X` (low).                                                                                                                                               |
| `r27`    | N/A                            | `X` (high).                                                                                                                                              |
| `r28`    | N/A                            | `Y` (low).                                                                                                                                               |
| `r29`    | N/A                            | `Y` (high).                                                                                                                                              |
| `r30`    | N/A                            | `Z` (low).                                                                                                                                               |
| `r31`    | N/A                            | `Z` (high).                                                                                                                                              |

## Creating a game

Use AVRA to compile the engine's [main file](./engine/main.asm).

This directory and your game's source directory must be added as include paths.

Define exactly one of the following to select a video standard:

- `NTSC`
- `PAL_60`

An example command line is as follows, assuming that the current working directory is the game's source directory:

`avra -o game.hex submodules/neomura/atmega328p-cartridge/engine/engine/main.asm --includedir submodules/neomura/atmega328p-cartridge/engine --define NTSC`

This expects a number of files to exist:

### [`game/declarations/index.asm`](../example/game/declarations/index.asm)

Use this file to declare any constants, SRAM or register mappings which will be used in other files.  You will need to include the globals of any [drivers](./engine/drivers/readme.md) you use.

### [`game/implementation/setup.asm`](../example/game/implementation/setup.asm)

Use this file to configure any SRAM or registers prior to the game starting.  `r31` should be safe to use here.

### [`game/implementation/frame.asm`](../example/game/implementation/frame.asm)

This file is executed once per frame, by the main loop.  It is executed before the first execution of `game/row.asm` during a frame.  This is the only time that pad state registers should be read from.

### [`game/implementation/row.asm`](../example/game/implementation/row.asm)

This file is executed once per pixel row, by the main loop.  It should be used to communicate prepare the next line's framebuffer.

### [`game/implementation/sample.asm`](../example/game/implementation/sample.asm)

This file is executed by the interrupt once per audio sample, at approximately 15750Hz.  `r28`, `r29`, `r30` and `r31` can be freely clobbered; any other registers must be `push`ed before use and `pop`ped before exit if they are used anywhere else in the program.
