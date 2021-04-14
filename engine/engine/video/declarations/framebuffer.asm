; Load the address of the framebuffer to write to into a register pair in 5-6 cycles.
; - A r* into which to load the low byte of a pointer to the buffer to write to.
; - A r* into which to load the high byte of a pointer to the buffer to write to.
.macro load_framebuffer
  sbrc video_next_row, 0
  rjmp load_framebuffer_even

  ; Odd.
  ldi @0, LOW(interrupt_framebuffer_a)
  ldi @1, HIGH(interrupt_framebuffer_a)
  rjmp load_framebuffer_end

  load_framebuffer_even:
  ldi @0, LOW(interrupt_framebuffer_b)
  ldi @1, HIGH(interrupt_framebuffer_b)

  load_framebuffer_end:
.endm

; Load the address of the framebuffer to write to into X in 5-6 cycles.
.macro load_framebuffer_x
  load_framebuffer r26, r27
.endm

; Load the address of the framebuffer to write to into Y in 5-6 cycles.
.macro load_framebuffer_y
  load_framebuffer r28, r29
.endm

; Load the address of the framebuffer to write to into Z in 5-6 cycles.
.macro load_framebuffer_z
  load_framebuffer r30, r31
.endm
