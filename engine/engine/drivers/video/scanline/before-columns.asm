.cseg

; Check whether we are on an odd or even row.
bst video_next_row, 0
brts video_scanline_before_columns_odd

; Even.
lds r30, video_scanline_flags_b
bst r30, VIDEO_SCANLINE_FLAG_PALETTE
load_immediate_z video_scanline_buffer_b
rjmp video_scanline_before_columns_end

video_scanline_before_columns_odd:
lds r30, video_scanline_flags_a
bst r30, VIDEO_SCANLINE_FLAG_PALETTE
load_immediate_z video_scanline_buffer_a

video_scanline_before_columns_end:
