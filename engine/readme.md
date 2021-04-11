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

## Creating a game

The entry point for AVRA will most likely look like this, assuming that this repository is the submodule `submodules/neomura/atmega328p-cartridge`:

```assembly
.includepath "submodules/neomura/atmega328p-cartridge/engine"
.include "engine/main.asm"
```

This expects a number of files to exist:

### `game/globals.asm`

Use this file to declare any constants, SRAM or register mappings which will be used in other files.  You will need to include the globals of any [drivers](./engine/drivers/readme.md) you use.

```assembly
.include "engine/drivers/tv-standards/ntsc/globals.asm"
.include "engine/drivers/video/scanline/globals.asm"

.equ EXAMPLE_GAME_CONSTANT = 0

.dseg

example_game_state: .byte 1
```

### `game/setup.asm`

Use this file to configure any SRAM, registers or hardware ahead of the game starting.  You will need to include the setup scripts of any [drivers](./engine/drivers/readme.md) you use.  `r31` should be safe to use here.

```assembly
.include "engine/drivers/tv-standards/ntsc/setup.asm"
.include "engine/drivers/video/scanline/setup.asm"

.cseg

store_immediate example_game_state, r31, EXAMPLE_GAME_CONSTANT
```

### `game/start.asm`

Use this file to perform final setup steps needed to start the game, such as enabling interrupts or hardware timers which were previously setup.  You will need to include the start scripts of any [drivers](./engine/drivers/readme.md) you use.  `r31` should be safe to use here.

```assembly
.include "engine/drivers/tv-standards/ntsc/start.asm"
```

### `game/frame.asm`

This file is executed once per frame, by the main loop.  It is executed after `game/start.asm`, and before the first execution of `game/row.asm`.

```assembly
.cseg

lds game_general_purpose_high_a, example_game_state
inc game_general_purpose_high_a
sts example_game_state, game_general_purpose_high_a
```

### `game/row.asm`

This file is executed once per pixel row, by the main loop.  It should be used to communicate with the [video driver](./engine/drivers/video/readme.md).

```assembly
.cseg

lds game_general_purpose_high_a, example_game_state
cp game_general_purpose_high_a, video_next_row
brsh game_row_palette_b

video_scanline_flags_store_immediate game_general_purpose_high_a, 0
rjmp game_row_configured_palette

game_row_palette_b:
video_scanline_flags_store_immediate game_general_purpose_high_a, (1 << VIDEO_SCANLINE_FLAG_PALETTE)

game_row_configured_palette:

video_scanline_buffer_load_z
ldi game_general_purpose_high_a, 0b10101010
st Z+, game_general_purpose_high_a
```

### `game/sample.asm`

This file is executed by the TV standard driver once per audio sample.  `r30` and `r31` are safe to use.  Any other registers should be `push`ed before use and `pop`ped after use to prevent interfering with either the main loop or the TV standard driver.  Output the left channel to `OCR0B`, and the right channel to `OCR0A`.

```assembly
.cseg

lds r31, example_game_state
out OCR0B, r31
out OCR0A, r31
```

### `game/video/before-columns.asm`

This file is executed by the TV standard driver before the first pixel on a row is output.  `r30` and `r31` are safe to use.  Any other registers should be `push`ed before use to prevent interfering with either the main loop or the TV standard driver.  Clear the T flag to select palette A, and set the T flag to select palette B.  Note that `game/video/before-columns.asm`/`game/video/column.asm`/`game/video/after-columns.asm` may be executed more than once per row (but only in that order) if the TV standard driver needs to repeat the signal.  Usually this just involves handover to the [video driver](./engine/drivers/video/readme.md).

```assembly
.include "engine/drivers/video/scanline/before-columns.asm"
```

### `game/video/column.asm`

This file is executed  Must take exactly 13 cycles, and store the next byte of four pixels in `UDR0`.  Usually this just involves handover to the [video driver](./engine/drivers/video/readme.md).

```assembly
.include "engine/drivers/video/scanline/column.asm"
```

### `game/video/after-columns.asm`

This file is executed by the TV standard driver immediately after the last pixel on a row is output.  `pop` all registers here which were `pushed`.  Usually this just involves handover to the [video driver](./engine/drivers/video/readme.md).

```assembly
.include "engine/drivers/video/scanline/after-columns.asm"
```

## Globals and utilities

A number of global declarations such as constants and macros can be found in:

- [globals.asm](./engine/globals.asm).
- [utilities.asm](./engine/utilities.asm).
- [audio](./engine/audio/readme.md)
