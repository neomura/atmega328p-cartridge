; Switch palettes by comparing the position on the Y axis with the frame counter.

cp game_frame_counter, video_next_row
brsh game_row_palette_b

set_palette_a_for_row
rjmp game_row_configured_palette

game_row_palette_b:
set_palette_b_for_row

game_row_configured_palette:

load_framebuffer_z

; Set the first four pixels to black.
ldi game_color, 0b00000000
st Z+, game_color

; Set the next four pixels to avocado/aquamarine.
ldi game_color, 0b01010101
st Z+, game_color

; Set the next four pixels to majorelle blue/crimson.
ldi game_color, 0b10101010
st Z+, game_color

; Set the last four pixels to white.
ldi game_color, 0b11111111
st Z+, game_color

; The rest of the display will be filled with random noise due to the SRAM being uninitialized.
