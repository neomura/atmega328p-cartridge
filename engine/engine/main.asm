.include "m328Pdef.inc"

.dseg

.include "engine/utilities/declarations/index.asm"
.include "engine/audio/declarations/index.asm"
.include "engine/video/declarations/index.asm"
.include "engine/interrupt/declarations/index.asm"
.include "engine/pads/declarations/index.asm"
.include "engine/main-loop/declarations/index.asm"
.include "game/declarations/index.asm"

.cseg

.org 0x00
  jmp main

.include "engine/interrupt/implementation/handler/index.asm"

main:
  .include "engine/audio/implementation/setup.asm"
  .include "engine/video/implementation/setup.asm"
  .include "engine/pads/implementation/setup.asm"
  .include "engine/main-loop/implementation/setup.asm"
  .include "game/implementation/setup.asm"
  .include "engine/interrupt/implementation/setup.asm"

  .include "engine/main-loop/implementation/run.asm"
