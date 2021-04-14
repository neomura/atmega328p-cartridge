; Delay an extra cycle if the alternative palette is selected.
brtc interrupt_active_video_wait_for_start_palette_a
dec r28
interrupt_active_video_wait_for_start_palette_a:
