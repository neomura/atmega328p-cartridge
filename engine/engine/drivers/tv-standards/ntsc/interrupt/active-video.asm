.macro tv_standard_ntsc_interrupt_active_video
  .include "game/video/before-columns.asm"

  ; Delay until the start of the active video segment.
  ; Factored in:
  ; - 1 cycle to calculate the delay length.
  ; - 5 cycles of delay overhead.
  ; - 1-2 cycles to apply the palette.
  ; - 1 cycle to prepare the loop.
  ; - 3 cycles to start serial output.
  ; - 13 cycles to emit the first column.
  ldi tv_standard_general_purpose_high_b, TV_STANDARD_NTSC_ACTIVE_VIDEO_START_CYCLES - 1 - 5 - 1 - 1 - 3 - 13
  lds tv_standard_general_purpose_high_c, TCNT1L
  sub tv_standard_general_purpose_high_b, tv_standard_general_purpose_high_c

  delay tv_standard_general_purpose_high_b

  ; Apply the palette.
  brtc tv_standard_ntsc_interrupt_active_video_after_palette
  tv_standard_ntsc_interrupt_active_video_after_palette:

  ; This will be used in the below loop.
  ldi tv_standard_general_purpose_high_b, (VIDEO_COLUMNS / VIDEO_PIXELS_PER_BYTE)

  ; Turn the serial port on, with 8-bit characters.
  store_immediate UCSR0B, tv_standard_general_purpose_high_c, (1<<TXEN0)|(1<<UCSZ01)|(1<<UCSZ00)

  ; Loop through the columns, loading them into the serial port.
  tv_standard_ntsc_interrupt_active_video_loop:
  .include "game/video/column.asm"
  dec tv_standard_general_purpose_high_b
  brne tv_standard_ntsc_interrupt_active_video_loop

  ; Turn the serial port off.
  store_immediate UCSR0B, tv_standard_general_purpose_high_b, 0

  .include "game/video/after-columns.asm"
.endm
