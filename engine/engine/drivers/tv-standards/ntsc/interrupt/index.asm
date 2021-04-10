.include "engine/drivers/tv-standards/ntsc/interrupt/active-video.asm"
.include "engine/drivers/tv-standards/ntsc/interrupt/colorburst.asm"

.org OC1Baddr
  ; Back up registers we will be clobbering to the stack.
  push r30
  push r31
  in r30, SREG
  push r30

  ; Skip past this logic if this is not a VSYNC line.
  cpi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_PRE_BLANK_START
  brsh tv_standard_ntsc_interrupt_non_vsync

  ; If this isn't the last VSYNC line, skip colorburst and active video without any other actions being taken.
  cpi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_VSYNC_END
  brne tv_standard_ntsc_interrupt_save_next_state_and_exit_near

  ; Otherwise, convert the VSYNC pulse into a HSYNC pulse.
  store_immediate_16 OCR1AL, tv_standard_general_purpose_high_b, TV_STANDARD_NTSC_HSYNC_PULSE_CYCLES

  ; Skip colorburst and active video.
  rjmp tv_standard_ntsc_interrupt_save_next_state_and_exit_near


  tv_standard_ntsc_interrupt_non_vsync:
  tv_standard_ntsc_interrupt_colorburst


  ; If this is a pre-blank line...
  cpi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_ACTIVE_A
  brsh tv_standard_ntsc_interrupt_non_pre_blank

  ; If this is not the last pre-blank line, don't do anything beyond skipping active video.
  cpi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_PRE_BLANK_END
  brne tv_standard_ntsc_interrupt_save_next_state_and_exit_near

  ; Otherwise, get the main loop to start preparing the second line before skipping active video.
  inc video_next_row
  rjmp tv_standard_ntsc_interrupt_save_next_state_and_exit_near


  tv_standard_ntsc_interrupt_non_pre_blank:

  ; Skip past this logic if this is not a post-blank line.
  cpi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_POST_BLANK_START
  brlo tv_standard_ntsc_interrupt_non_blank

  ; If this isn't the last post-blank line, skip colorburst and active video without any other actions being taken.
  cpi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_POST_BLANK_END
  brne tv_standard_ntsc_interrupt_save_next_state_and_exit_near

  ; Otherwise, convert the HSYNC pulse into a VSYNC pulse.
  store_immediate_16 OCR1AL, tv_standard_general_purpose_high_b, TV_STANDARD_NTSC_VSYNC_PULSE_CYCLES

  ; Start from the top.
  ldi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_VSYNC_START

  ; Skip colorburst and active video.
  rjmp tv_standard_ntsc_interrupt_save_state_and_exit

  tv_standard_ntsc_interrupt_save_next_state_and_exit_near:
  rjmp tv_standard_ntsc_interrupt_save_next_state_and_exit


  tv_standard_ntsc_interrupt_non_blank:

  tv_standard_ntsc_interrupt_active_video

  ; The active video segment is now complete, update state for the next run.

  ; If we've just finished the first repetition of this line, skip to code which increments to the next state.
  cpi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_ACTIVE_A
  breq tv_standard_ntsc_interrupt_save_next_state_and_exit

  ; Otherwise, we've just finished the second repetition of this line.

  ; If this is the last active line, skip to code which handles that scenario.
  cpi video_next_row, VIDEO_ROWS
  breq tv_standard_ntsc_interrupt_last_row

  ; This is not the last active line.  Move onto the next row.
  inc video_next_row

  ; The next line is its first repetition.
  ldi tv_standard_ntsc_state, TV_STANDARD_NTSC_STATE_ACTIVE_A

  rjmp tv_standard_ntsc_interrupt_save_state_and_exit

  tv_standard_ntsc_interrupt_last_row:

  ; Tell the main loop to start work on the first row again.
  clr video_next_row

  tv_standard_ntsc_interrupt_save_next_state_and_exit:

  ; Move to the next state.
  inc tv_standard_ntsc_state

  tv_standard_ntsc_interrupt_save_state_and_exit:

  ; todo looks like we're generally reserving r30/r31 in interrupts need to doc that
  .include "game/sample.asm"

  ; TODO can we reduce the need for this
  ; TODO are these regs documented?
  .include "engine/pads/poll.asm"

  ; Restore clobbered registers from the stack.
  pop r30
  out SREG, r30
  pop r31
  pop r30

  reti
