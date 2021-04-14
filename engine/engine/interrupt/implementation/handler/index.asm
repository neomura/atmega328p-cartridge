.org OC1Baddr
  ; Back up registers we will be clobbering to the stack.
  push r28
  push r29
  push r30
  push r31
  in r31, SREG
  push r31

  ; Skip past this logic if this is not a VSYNC line.
  cpi interrupt_state, INTERRUPT_STATE_PRE_BLANK_START
  brsh interrupt_non_vsync

  ; If this isn't the last VSYNC line, skip colorburst and active video without any other actions being taken.
  cpi interrupt_state, INTERRUPT_STATE_VSYNC_END
  brne interrupt_increment_state_and_exit_near

  ; Otherwise, convert the VSYNC pulse into a HSYNC pulse.
  store_immediate_16 OCR1AL, r31, HSYNC_PULSE_CYCLES

  ; Skip colorburst and active video.
  rjmp interrupt_increment_state_and_exit_near

  interrupt_non_vsync:
  .include "engine/interrupt/implementation/handler/colorburst/index.asm"

  ; If this is a pre-blank line...
  cpi interrupt_state, INTERRUPT_STATE_ACTIVE_A
  brsh interrupt_non_pre_blank

  ; If this is not the last pre-blank line, don't do anything beyond skipping active video.
  cpi interrupt_state, INTERRUPT_STATE_PRE_BLANK_END
  brne interrupt_increment_state_and_exit_near

  ; Otherwise, get the main loop to start preparing the second line.
  inc video_next_row

  .include "engine/pads/implementation/start-poll.asm"

  ; And then skip active video
  rjmp interrupt_increment_state_and_exit_near

  interrupt_non_pre_blank:

  ; Skip past this logic if this is not a post-blank line.
  cpi interrupt_state, INTERRUPT_STATE_POST_BLANK_START
  brlo interrupt_non_blank

  ; If this isn't the last post-blank line, skip colorburst and active video without any other actions being taken.
  cpi interrupt_state, INTERRUPT_STATE_POST_BLANK_END
  brne interrupt_increment_state_and_exit_near

  ; Otherwise, convert the HSYNC pulse into a VSYNC pulse.
  store_immediate_16 OCR1AL, r31, VSYNC_PULSE_CYCLES

  ; Start from the top.
  ldi interrupt_state, INTERRUPT_STATE_VSYNC_START

  .include "engine/pads/implementation/end-poll.asm"

  ; Skip colorburst and active video.
  rjmp interrupt_handler_skip_to_end

  interrupt_increment_state_and_exit_near:
  rjmp interrupt_increment_state_and_exit

  interrupt_non_blank:

  ; Pads are polled once per button.
  ; The first repetition of each line is used to read the input while the second is used to adjust the clock line.
  cpi video_next_row, NUMBER_OF_BUTTONS_PER_PAD + 1
  brsh interrupt_after_pads

  ; Use line repeat flag to determine whether this is the first or second line covering this button.
  cpi interrupt_state, INTERRUPT_STATE_ACTIVE_A
  brne interrupt_odd

  .include "engine/pads/implementation/poll-even.asm"
  rjmp interrupt_after_pads

  interrupt_odd:
  .include "engine/pads/implementation/poll-odd.asm"

  interrupt_after_pads:
  .include "engine/interrupt/implementation/handler/active-video/index.asm"

  ; If we've just finished the first repetition of this line, skip to code which increments to the next state.
  cpi interrupt_state, INTERRUPT_STATE_ACTIVE_A
  breq interrupt_increment_state_and_exit

  ; Otherwise, we've just finished the second repetition of this line.

  ; If this is the last active line, skip to code which handles that scenario.
  cpi video_next_row, VIDEO_ROWS
  breq interrupt_last_row

  ; This is not the last active line.  Move onto the next row.
  inc video_next_row

  ; The next line is its first repetition.
  ldi interrupt_state, INTERRUPT_STATE_ACTIVE_A

  rjmp interrupt_handler_skip_to_end

  interrupt_last_row:

  ; Tell the main loop to start work on the first row again.
  clr video_next_row

  interrupt_increment_state_and_exit:

  ; Move to the next state.
  inc interrupt_state

  interrupt_handler_skip_to_end:

  .include "game/implementation/sample.asm"

  .ifdef PAL_60
    ldi r31, 1 << INTERRUPT_FLAG_ALTERNATE_LINE
    eor interrupt_flags, r31
  .endif

  ; Restore clobbered registers from the stack.
  pop r31
  out SREG, r31
  pop r31
  pop r30
  pop r29
  pop r28

  reti
