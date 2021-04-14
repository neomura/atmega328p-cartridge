; Selects the palette for the next frame in 2 cycles.
; To be used in game/frame.asm.
; Sets palette A when the T flag is cleared and palette B when the T flag is set.
.macro set_palette_for_frame_from_t_flag
  bld interrupt_flags, INTERRUPT_FLAG_PALETTE_A
  bld interrupt_flags, INTERRUPT_FLAG_PALETTE_B
.endm

; Selects the palette for the next row in 4-5 cycles.
; To be used in game/row.asm.
; Sets palette A when the T flag is cleared and palette B when the T flag is set.
.macro set_palette_for_row_from_t_flag
  sbrc video_next_row, 0
  rjmp set_palette_for_row_from_t_flag_even

  ; Odd.
  bld interrupt_flags, INTERRUPT_FLAG_PALETTE_A
  rjmp set_palette_for_frame_from_t_flag_end

  set_palette_for_row_from_t_flag_even:
  bld interrupt_flags, INTERRUPT_FLAG_PALETTE_B

  set_palette_for_row_from_t_flag_end:
.endm

; Selects palette A for the next frame in 1 cycle.
; To be used in game/frame.asm.
.macro set_palette_a_for_frame
  cbr interrupt_flags, (1 << INTERRUPT_FLAG_PALETTE_A) | (1 << INTERRUPT_FLAG_PALETTE_B)
.endm

; Selects palette B for the next frame in 1 cycle.
; To be used in game/frame.asm.
.macro set_palette_b_for_frame
  sbr interrupt_flags, (1 << INTERRUPT_FLAG_PALETTE_A) | (1 << INTERRUPT_FLAG_PALETTE_B)
.endm

; Selects palette A for the next row in 4-5 cycles.
; To be used in game/row.asm.
.macro set_palette_a_for_row
  sbrc video_next_row, 0
  rjmp set_palette_a_for_row_even

  ; Odd.
  cbr interrupt_flags, 1 << INTERRUPT_FLAG_PALETTE_A
  rjmp set_palette_a_for_row_end

  set_palette_a_for_row_even:
  cbr interrupt_flags, 1 << INTERRUPT_FLAG_PALETTE_B

  set_palette_a_for_row_end:
.endm

; Selects palette B for the next row in 4-5 cycles.
; To be used in game/row.asm.
.macro set_palette_b_for_row
  sbrc video_next_row, 0
  rjmp set_palette_b_for_row_even

  ; Odd.
  sbr interrupt_flags, 1 << INTERRUPT_FLAG_PALETTE_A
  rjmp set_palette_b_for_row_end

  set_palette_b_for_row_even:
  sbr interrupt_flags, 1 << INTERRUPT_FLAG_PALETTE_B

  set_palette_b_for_row_end:
.endm
