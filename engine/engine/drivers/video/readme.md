# [neomura/atmega328p-cartridge](../../../../readme.md)/[Engine](../../../readme.md)/[Drivers](../readme.md)/Video

## Implementations

| Link                             | Description               |
| -------------------------------- | ------------------------- |
| [Scanline](./scanline/readme.md) | Double scanline buffer.   |

## Responsibilities

```assembly
.macro video_setup
  ; Invoked before the TV standard driver starts.
.endm

; The following three macros may be called multiple times per pixel row if, say, the TV standard driver emits the same pixel row multiple times.

.macro video_before_columns
  ; Invoked before any invocations of video_column on a line.
  ; TODO which registers can we use safely?
  ; If the T flag is cleared, palette A is selected for this line.
  ; If the T flag is set, palette B is selected for this line.
.endm

.macro video_column
  ; Invoked once per four pixel columns.
  ; Any register initialized in video_before_columns will be available for use here.
  ; Must take exactly 13 cycles; pad with NOPs if spare time is available.
  ; The last instruction must store the next pixel's data in UDR0.
.endm

.macro video_after_columns
  ; Invoked after the last invocation of video_column on a line.
  ; All registers pushed onto the stack in video_before_columns must be popped back into their respective registers here.
.endm
```
