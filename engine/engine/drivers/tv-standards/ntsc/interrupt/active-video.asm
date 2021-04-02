; - A r* to clobber.
; - A r* to clobber.
.macro tv_standard_ntsc_interrupt_active_video
  video_before_columns

  ; Delay until the start of the active video segment.
  ; Factored in:
  ; - 2 cycles to apply the palette.
  ; - 5 cycles of delay overhead.
  ; - 11 cycles to run video_column.
  ; - 2 cycles to copy its output to the serial register.
  ; - 3 cycles to start serial output.
  ldi @0, TV_STANDARD_NTSC_ACTIVE_VIDEO_START_CYCLES - 11 - 5 - 3
  lds @1, TCNT1L
  sub @0, @1

  delay @0

  ; Apply the palette.
  brtc tv_standard_ntsc_interrupt_active_video_after_palette
  tv_standard_ntsc_interrupt_active_video_after_palette:

  ; Pre-load the first byte of pixel columns into the serial port.
  video_column @0
  sts UDR0, @0

  ; Turn the serial port on, with 8-bit characters.
  store_immediate UCSR0B, @0, (1<<TXEN0)|(1<<UCSZ01)|(1<<UCSZ00)

  ; Loop through the remaining columns, loading them into the serial port.
  ldi @1, (VIDEO_COLUMNS / VIDEO_PIXELS_PER_BYTE) - 1

  tv_standard_ntsc_interrupt_active_video_loop:
  video_column @0
  sts UDR0, @0
  dec @1
  brne tv_standard_ntsc_interrupt_active_video_loop

  ; Turn the serial port off.
  store_immediate UCSR0B, @0, 0

  video_after_columns
.endm
