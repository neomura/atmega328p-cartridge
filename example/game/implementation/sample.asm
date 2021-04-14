; Take the least significant bit of the frame counter to make a 30Hz square wave and shift it left to make it louder.
mov game_sample, game_frame_counter
andi game_sample, 0b00000001
lsl game_sample
lsl game_sample
lsl game_sample
lsl game_sample

output_left_audio game_sample
output_right_audio game_sample
