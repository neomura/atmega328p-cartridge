main:
  globals_setup
  tv_standard_setup
  video_setup

  ; Configure audio output PWM - this is common to all drivers, so done here.
  ; Non-inverting fast PWM mode without a clock prescaler.
  out_immediate TCCR0A, r16, (1 << COM0A1) | (1 << COM0B1) | (1 << WGM01) | (1 << WGM00)
  out_immediate TCCR0B, r16, (1 << CS00)
  sbi DDRD, DDD5
  sbi DDRD, DDD6

  game_setup

  tv_standard_start

  ; Track the line which has last been drawn.
  ldi r16, 255

  main_loop:

  lds r17, video_next_row

  ; If the video driver is not yet expecting the next line, busy wait.
  cp r16, r17
  breq main_loop

  push r17

  ; If this is not the first line, skip the game tick.
  cpi r17, 0
  brne main_loop_skip_game_frame

  game_frame

  main_loop_skip_game_frame:

  game_row

  pop r16
  rjmp main_loop
