  main_loop:

  ; If the interrupt is not yet expecting the next line, busy wait.
  cp video_next_row, main_loop_previous_video_row
  breq main_loop

  mov main_loop_previous_video_row, video_next_row

  ; If this is not the first line, skip the game tick.
  cpi video_next_row, 0

  breq main_loop_do_not_skip_game_frame
  jmp main_loop_skip_game_frame
  main_loop_do_not_skip_game_frame:

  .include "game/implementation/frame.asm"

  main_loop_skip_game_frame:

  .include "game/implementation/row.asm"

  jmp main_loop
