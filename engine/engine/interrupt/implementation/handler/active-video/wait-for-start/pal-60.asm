; If this is palette A, we need to offset 180°.
; If this is palette B, we need to offset 180° every alternate line.
brtc interrupt_active_video_wait_for_start_palette_a
sbrc interrupt_flags, INTERRUPT_FLAG_ALTERNATE_LINE
interrupt_active_video_wait_for_start_palette_a:
subi r28, -2
