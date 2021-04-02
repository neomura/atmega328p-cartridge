.cseg

; Draws a point on the current scanline.
; Clobbers r30 and r31.
; - A r* to clobber.
; - A r* to clobber.
; - A r* containing the number of pixels between the left edge of the screen and the point to draw.
; - A r* containing the color to use, repeated to fill the byte.
.macro video_scanline_point
  ; This will detect both being left of 0, and right of VIDEO_COLUMNS.
  cpi @2, VIDEO_COLUMNS
  brsh video_scanline_point_end

  ; Determine which byte we need to write to.
  mov @0, @2
  lsr @0
  lsr @0

  ; Load this into Z.
  video_scanline_buffer_load_z
  add r30, @0
  ldi @0, 0
  adc r31, @0

  ; Read the pixel we'll be modifying and make a copy of the color we'll be using.
  ld @0, Z
  mov @1, @3

  ; Determine which crumb we'll be modifying - checking the high bit here, so between 0, 1 and 2, 3.
  sbrc @2, 1
  rjmp video_scanline_point_2_3

  ; Determine which crumb we'll be modifying - checking the low bit here where the high bit is 0, so between 0 and 1.
  sbrc @2, 0
  rjmp video_scanline_point_1

  ; It's crumb 0.
  andi @0, 0b00111111
  andi @1, 0b11000000
  rjmp video_scanline_point_write_and_end

  video_scanline_point_1:
  andi @0, 0b11001111
  andi @1, 0b00110000
  rjmp video_scanline_point_write_and_end

  ; Determine which crumb we'll be modifying - checking the low bit here where the high bit is 1, so between 2 and 3.
  video_scanline_point_2_3:
  sbrc @2, 0
  rjmp video_scanline_point_3

  ; It's crumb 2.
  andi @0, 0b11110011
  andi @1, 0b00001100
  rjmp video_scanline_point_write_and_end

  video_scanline_point_3:
  andi @0, 0b11111100
  andi @1, 0b00000011

  video_scanline_point_write_and_end:
  or @0, @1
  st Z, @0

  video_scanline_point_end:
.endm
