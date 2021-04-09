# [neomura/atmega328p-cartridge](../readme.md)/Engine

This engine is written in [AVRA assembler](https://github.com/Ro5bert/avra).

## Installation

Add this directory to your include path, include the globals file, include a [driver](./engine/drivers/readme.md) of each type, declare event handling macros for game logic, then include the entry point file:

```assembly
.includepath "submodules/neomura/atmega328p-cartridge/engine"

.include "engine/globals.asm"

.include "engine/drivers/video/scanline/index.asm"

.macro game_setup
  ; Invoked after drivers have been configured, but before they or the main loop have been started.
.endm

.macro game_frame
  ; Invoked once per frame, immediately after reading pad data and before the first game_row.
  ; Use this opportunity to update game state.
  ; All registers are to be considered clobbered.
.endm

.macro game_row
  ; Invoked once per pixel row, starting from the top.
  ; Use this opportunity to communicate with the video driver.
  ; All registers are to be considered clobbered.
.endm

.macro game_sample
  ; Invoked once per audio sample, at approximately 15750Hz.
  ; All registers are to be considered clobbered.
  ; Any registers except r16 and r17 need to be pushed to the stack before use, and popped before exit.
  ; Output the left channel to OCR0B, and the right channel to OCR0A.
.endm

.include "engine/drivers/tv-standards/ntsc/index.asm"
.include "engine/main.asm"
```

## Globals and utilities

A number of global declarations such as constants and macros can be found in:

- [globals.asm](./globals.asm).
- [utilities.asm](./utilities.asm).
