.equ VIDEO_SCANLINE_FLAG_PALETTE = 0

.dseg

video_scanline_flags_a: .byte 1
video_scanline_buffer_a: .byte VIDEO_COLUMNS / VIDEO_PIXELS_PER_BYTE
video_scanline_flags_b: .byte 1
video_scanline_buffer_b: .byte VIDEO_COLUMNS / VIDEO_PIXELS_PER_BYTE

.cseg

; - A r* into which to load the low byte of a pointer to the buffer to write to.
; - A r* into which to load the high byte of a pointer to the buffer to write to.
.macro video_scanline_buffer_load
  ; Check whether we are on an odd or even row.
  bst video_next_row, 0
  brts video_scanline_buffer_load_even

  ; Odd.
  ldi @0, LOW(video_scanline_buffer_a)
  ldi @1, HIGH(video_scanline_buffer_a)
  rjmp video_scanline_buffer_load_end

  video_scanline_buffer_load_even:
  ldi @0, LOW(video_scanline_buffer_b)
  ldi @1, HIGH(video_scanline_buffer_b)

  video_scanline_buffer_load_end:
.endm

.macro video_scanline_buffer_load_x
  video_scanline_buffer_load r26, r27
.endm

.macro video_scanline_buffer_load_y
  video_scanline_buffer_load r28, r29
.endm

.macro video_scanline_buffer_load_z
  video_scanline_buffer_load r30, r31
.endm

; - A r* to clobber.
; - A r* containing the flags to store.
.macro video_scanline_flags_store
  ; Check whether we are on an odd or even row.
  bst video_next_row, 0
  brts video_scanline_flags_store_even

  ; Odd.
  sts video_scanline_flags_a, @1
  rjmp video_scanline_flags_store_end

  video_scanline_flags_store_even:
  sts video_scanline_flags_b, @1

  video_scanline_flags_store_end:
.endm

; - A r* to clobber.
; - The flags to store.
.macro video_scanline_flags_store_immediate
  ; Check whether we are on an odd or even row.
  bst video_next_row, 0
  brts video_scanline_flags_store_even

  ; Odd.
  store_immediate video_scanline_flags_a, @0, @1
  rjmp video_scanline_flags_store_end

  video_scanline_flags_store_even:
  store_immediate video_scanline_flags_b, @0, @1

  video_scanline_flags_store_end:
.endm

.include "engine/drivers/video/scanline/point.asm"
