# [neomura/atmega328p-cartridge](../../../../readme.md)/[Engine](../../../readme.md)/[Drivers](../../readme.md)/[Video](../readme.md)/Scanline

Two regions of SRAM (video_scanline_buffer_a/video_scanline_buffer_b) describe a double scanline buffer which is directly sent to the display.

Two locations in SRAM (video_scanline_flags_a/video_scanline_flags_b) additionally define double-buffered flags describing how the next line should be output:

| Bit                         | When cleared       | When set           |
| --------------------------- | ------------------ | ------------------ |
| VIDEO_SCANLINE_FLAG_PALETTE | Palette A is used. | Palette B is used. |

The appropriate buffer/flags should be overwritten during game_row.

| video_next_row | Write to buffer/flags |
| -------------- | --------------------- |
| Odd (1, 3, 5)  | A                     |
| Even (0, 2, 4) | B                     |

The video_scanline_buffer_load macro will load a pointer to the buffer to write to its given register pair.

The video_scanline_buffer_load_x, video_scanline_buffer_load_y and video_scanline_buffer_load_z will do the same, but to the specified register pairs.

The video_scanline_flags_store macro will store the given register in the appropriate flag.

The video_scanline_flags_store_immediate macro will do the same, but for a constant value (using a register which will be clobbered).

## Example

```assembly
.macro game_row
  ; Switch to the alternative palette.
  video_scanline_flags_store_immediate r16, 1 << VIDEO_SCANLINE_FLAG_PALETTE

  ; Draw the following pixels from left to right:
  ; - Aquamarine
  ; - Black
  ; - Crimson
  ; - Pumice
  ; - Black
  ; - Crimson
  ; - Black
  ; - Aquamarine
  video_scanline_buffer_load_z
  ldi r16, 0b10000111
  st Z+, r16
  ldi r16, 0b00010010
  st Z+, r16
.endm
```
