.include "engine/globals.asm"

.cseg

main:
  globals_setup

  ; Configure audio output PWM - this is common to all drivers, so done here.
  ; Non-inverting fast PWM mode without a clock prescaler.
  ; TODO move this into a file
  out_immediate TCCR0A, r31, (1 << COM0A1) | (1 << COM0B1) | (1 << WGM01) | (1 << WGM00)
  out_immediate TCCR0B, r31, (1 << CS00)
  sbi DDRD, DDD5
  sbi DDRD, DDD6

  .include "engine/pads/setup.asm"
  .include "game/setup.asm"

  ; Track the line which has last been drawn.  Initialize as 255 so that a change to 0 is seen.
  clr main_loop_previous_video_row
  com main_loop_previous_video_row

  .include "game/start.asm"

  main_loop:

  ; If the video driver is not yet expecting the next line, busy wait.
  cp video_next_row, main_loop_previous_video_row
  breq main_loop

  mov main_loop_previous_video_row, video_next_row

  ; If this is not the first line, skip the game tick.
  cpi video_next_row, 0

  breq main_loop_do_not_skip_game_frame
  jmp main_loop_skip_game_frame
  main_loop_do_not_skip_game_frame:

  .include "game/frame.asm"

  main_loop_skip_game_frame:

  .include "game/row.asm"

  jmp main_loop
