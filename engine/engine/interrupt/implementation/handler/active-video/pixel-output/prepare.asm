; Check whether we are on an odd or even row and load the appropriate framebuffer; additionally load the palette into the T flag.
sbrc video_next_row, 0
rjmp interrupt_active_video_pixel_output_prepare_odd

; Even.
load_immediate_z interrupt_framebuffer_b
bst interrupt_flags, INTERRUPT_FLAG_PALETTE_B
rjmp interrupt_active_video_pixel_output_prepare_end

interrupt_active_video_pixel_output_prepare_odd:
load_immediate_z interrupt_framebuffer_a
bst interrupt_flags, INTERRUPT_FLAG_PALETTE_A

interrupt_active_video_pixel_output_prepare_end:
