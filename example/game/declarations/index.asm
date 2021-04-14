.equ EXAMPLE_GAME_CONSTANT = 0

example_game_state: .byte 1

.undef game_general_purpose_high_a
.def game_frame_counter = r19

.undef game_general_purpose_high_b
.def game_color = r20

.undef game_general_purpose_high_c
.def game_sample = r21
