# [neomura/atmega328p-cartridge](../readme.md)/Engine

This engine is written in [AVRA assembler](https://github.com/Ro5bert/avra).

## Flow

The reset vector starts by running through setup routines for drivers and the game.

It then enters the main loop, with the TV standard driver having configured an interrupt to interact with hardware and advance global state which the main loop tracks to raise events.

## Registers

The ATMega328P has enough general-purpose registers that with the limited cycles available frequently used information is best kept in a register rather than repeatedly storing to (costing 2 cycles) and loading from (costing 2 cycles) SRAM.  Additionally, if registers used by the main loop and interrupts overlap as little as possible, the push (2 cycles) and pop (2 cycles) normally required to prevent corruption of main loop state from interrupts can be avoided as well.  In practice, few game logic or driver operations require more than 4 general purpose registers.

Some registers have special purposes, so are used as little as possible:

- `r0` and `r1` receive the result of the instructions `fmul`, `fmuls`, `fmulsu`, `mul`, `muls` and `mulsu`.
- `r26`/`r27`, `r28`/`r29` and `r30`/`r31` are labelled `X`, `Y` and `Z` respectively and are used for indirect load, store and jump.

If these are used, they are considered to belong to the main loop, and any interrupts must back them up (using `push`) beforehand and restore them (using `pop`) before `reti` (alongside `SREG`).

`r0` through `r15` are not directly usable with the instructions `cpi`, `fmul`, `fmuls`, `fmulsu`, `muls`, `mulsu`, `cbr`, `ldi`, `lds`, `ori`, `sbci`, `sbr`, `ser`, `sts`, `subi`, `andi` or `cbr`.  Consequently, if a use is found which is not made impossible or awkward through this limitation, these registers should be prioritized to leave the more flexible r16-r31 available for other operations.

The resulting mapping is as follows:

| Register | Name                                 | Description                                                                                                                                                                                    |
| -------- | ------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `r0`     | N/A                                  | Output for some instructions.                                                                                                                                                                  |
| `r1`     | N/A                                  | Output for some instructions.                                                                                                                                                                  |
| `r2`     | `pad_0`                              | State of pad 0 (set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right; all cleared when pad disconnected).                                       |
| `r3`     | `pad_1`                              | State of pad 1 (set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right; all cleared when pad disconnected).                                       |
| `r4`     | `pad_2`                              | State of pad 2 (set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right; all cleared when pad disconnected).                                       |
| `r5`     | `pad_3`                              | State of pad 3 (set bits indicate held buttons, ordered face right, face left, select, start, up, down, left, right; all cleared when pad disconnected).                                       |
| `r6`     | `main_loop_previous_video_row`       | Used by the main loop for state tracking.                                                                                                                                                      |
| `r7`     | `game_general_purpose_low_a`         | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                                                       |
| `r8`     | `game_general_purpose_low_b`         | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                                                       |
| `r9`     | `game_general_purpose_low_c`         | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                                                       |
| `r10`    | `game_general_purpose_low_d`         | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                                                       |
| `r11`    | `game_general_purpose_low_e`         | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                                                       |
| `r12`    | `game_general_purpose_low_f`         | Available for general purpose usage, though note that many instructions cannot be used with it directly.                                                                                       |
| `r13`    | `tv_standard_general_purpose_low_a`  | Available for general purpose usage, though note that many instructions cannot be used with it directly; allocated to TV standard driver interrupts.                                           |
| `r14`    | `tv_standard_general_purpose_low_b`  | Available for general purpose usage, though note that many instructions cannot be used with it directly; allocated to TV standard driver interrupts.                                           |
| `r15`    | `tv_standard_general_purpose_low_c`  | Available for general purpose usage, though note that many instructions cannot be used with it directly; allocated to TV standard driver interrupts.                                           |
| `r16`    | `video_next_row`                     | The row which the TV standard driver will be outputting next.  In a higher register for `cpi`.  Will remain 0 for longer than other values, in which `game_tick` is executed by the main loop. |
| `r17`    | `game_general_purpose_high_a`        | Available for general purpose usage.                                                                                                                                                           |
| `r18`    | `game_general_purpose_high_b`        | Available for general purpose usage.                                                                                                                                                           |
| `r19`    | `game_general_purpose_high_c`        | Available for general purpose usage.                                                                                                                                                           |
| `r20`    | `game_general_purpose_high_d`        | Available for general purpose usage.                                                                                                                                                           |
| `r21`    | `game_general_purpose_high_e`        | Available for general purpose usage.                                                                                                                                                           |
| `r22`    | `game_general_purpose_high_f`        | Available for general purpose usage.                                                                                                                                                           |
| `r23`    | `tv_standard_general_purpose_high_a` | Available for general purpose usage.                                                                                                                                                           |
| `r24`    | `tv_standard_general_purpose_high_b` | Available for general purpose usage; allocated to TV standard driver interrupts.                                                                                                               |
| `r25`    | `tv_standard_general_purpose_high_c` | Available for general purpose usage; allocated to TV standard driver interrupts.                                                                                                               |
| `r26`    | N/A                                  | `X` (low).                                                                                                                                                                                     |
| `r27`    | N/A                                  | `X` (high).                                                                                                                                                                                    |
| `r28`    | N/A                                  | `Y` (low).                                                                                                                                                                                     |
| `r29`    | N/A                                  | `Y` (high).                                                                                                                                                                                    |
| `r30`    | N/A                                  | `Z` (low).                                                                                                                                                                                     |
| `r31`    | N/A                                  | `Z` (high).                                                                                                                                                                                    |

## Installation

Add this directory to your include path, include the globals file, include [drivers](./engine/drivers/readme.md) of each type other than a TV standard driver, declare event handling macros for game logic, then include the TV standard driver and entry point file:

```assembly
.includepath "submodules/neomura/atmega328p-cartridge/engine"

.include "engine/globals.asm"

.include "engine/drivers/video/scanline/index.asm"

.macro game_setup
  ; Invoked after drivers have been configured, but before they or the main loop have been started.
.endm

.macro game_frame
  ; Invoked once per frame, immediately after reading pad data and before the first game_row, in the main loop.
  ; Use this opportunity to update game state.
.endm

.macro game_row
  ; Invoked once per pixel row, starting from the top, in the main loop.
  ; Use this opportunity to communicate with the video driver.
.endm

.macro game_sample
  ; Invoked once per audio sample, at approximately 15750Hz, during an interrupt.
  ; All registers are to be considered clobbered.
  ; Output the left channel to OCR0B, and the right channel to OCR0A.
.endm

.include "engine/drivers/tv-standards/ntsc/index.asm"
.include "engine/main.asm"
```

## Globals and utilities

A number of global declarations such as constants and macros can be found in:

- [globals.asm](./engine/globals.asm).
- [utilities.asm](./engine/utilities.asm).
- [audio](./engine/audio/readme.md)
