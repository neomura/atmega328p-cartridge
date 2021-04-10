.include "engine/drivers/tv-standards/ntsc/interrupt/active-video.asm"
.include "engine/drivers/tv-standards/ntsc/interrupt/colorburst.asm"

.org OC1Baddr
  ; Back up registers we will be clobbering to the stack.
  push r16
  push r17
  in r16, SREG
  push r16

  lds r16, tv_standard_ntsc_state

  ; Skip past this logic if this is not a VSYNC line.
  cpi r16, TV_STANDARD_NTSC_STATE_PRE_BLANK_START
  brsh tv_standard_ntsc_interrupt_non_vsync

  ; If this isn't the last VSYNC line, skip colorburst and active video without any other actions being taken.
  cpi r16, TV_STANDARD_NTSC_STATE_VSYNC_END
  brne tv_standard_ntsc_interrupt_save_next_state_and_exit_near

  ; Otherwise, convert the VSYNC pulse into a HSYNC pulse.
  store_immediate_16 OCR1AL, r17, TV_STANDARD_NTSC_HSYNC_PULSE_CYCLES

  ; Skip colorburst and active video.
  rjmp tv_standard_ntsc_interrupt_save_next_state_and_exit_near


  tv_standard_ntsc_interrupt_non_vsync:
  tv_standard_ntsc_interrupt_colorburst r16, r17

  lds r16, tv_standard_ntsc_state


  ; If this is a pre-blank line...
  cpi r16, TV_STANDARD_NTSC_STATE_ACTIVE_A
  brsh tv_standard_ntsc_interrupt_non_pre_blank

  ; If this is not the last pre-blank line, don't do anything beyond skipping active video.
  cpi r16, TV_STANDARD_NTSC_STATE_PRE_BLANK_END
  brne tv_standard_ntsc_interrupt_save_next_state_and_exit_near

  ; Otherwise, get the main loop to start preparing the second line before skipping active video.
  store_immediate video_next_row, r17, 1
  rjmp tv_standard_ntsc_interrupt_save_next_state_and_exit_near


  tv_standard_ntsc_interrupt_non_pre_blank:

  ; Skip past this logic if this is not a post-blank line.
  cpi r16, TV_STANDARD_NTSC_STATE_POST_BLANK_START
  brlo tv_standard_ntsc_interrupt_non_blank

  ; If this isn't the last post-blank line, skip colorburst and active video without any other actions being taken.
  cpi r16, TV_STANDARD_NTSC_STATE_POST_BLANK_END
  brne tv_standard_ntsc_interrupt_save_next_state_and_exit_near

  ; Otherwise, convert the HSYNC pulse into a VSYNC pulse.
  store_immediate_16 OCR1AL, r16, TV_STANDARD_NTSC_VSYNC_PULSE_CYCLES

  ; Start from the top.
  ldi r16, TV_STANDARD_NTSC_STATE_VSYNC_START

  ; Skip colorburst and active video.
  rjmp tv_standard_ntsc_interrupt_save_state_and_exit

  tv_standard_ntsc_interrupt_save_next_state_and_exit_near:
  rjmp tv_standard_ntsc_interrupt_save_next_state_and_exit


  tv_standard_ntsc_interrupt_non_blank:

  tv_standard_ntsc_interrupt_active_video r16, r17

  ; The active video segment is now complete, update state for the next run.
  lds r16, tv_standard_ntsc_state

  ; If we've just finished the first repetition of this line, skip to code which increments to the next state.
  cpi r16, TV_STANDARD_NTSC_STATE_ACTIVE_A
  breq tv_standard_ntsc_interrupt_save_next_state_and_exit

  ; Otherwise, we've just finished the second repetition of this line.
  lds r17, video_next_row

  ; If this is the last active line, skip to code which handles that scenario.
  cpi r17, VIDEO_ROWS - 1
  breq tv_standard_ntsc_interrupt_last_row

  ; This is not the last active line.  Move onto the next row.
  inc r17
  sts video_next_row, r17

  ; The next line is its first repetition.
  ldi r16, TV_STANDARD_NTSC_STATE_ACTIVE_A

  rjmp tv_standard_ntsc_interrupt_save_state_and_exit

  tv_standard_ntsc_interrupt_last_row:

  ; Tell the main loop to start work on the first row again.
  store_immediate video_next_row, r17, 0

  tv_standard_ntsc_interrupt_save_next_state_and_exit:

  ; Move to the next state.
  inc r16

  tv_standard_ntsc_interrupt_save_state_and_exit:

  sts tv_standard_ntsc_state, r16

  game_sample

  .include "engine/pads/poll.asm"

  ; Restore clobbered registers from the stack.
  pop r16
  out SREG, r16
  pop r17
  pop r16

  reti
