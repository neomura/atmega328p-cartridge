; Delay until the start of the active video segment.
; Factored in:
; - 1 cycle to calculate the delay length.
; - 5 cycles of delay overhead.
; - 2 cycles to apply the palette.
; - 2 cycles to load the first byte of pixels.
; - 2 cycles to load it into the serial port.
; - 3 cycles to start the serial port.
ldi r28, ACTIVE_VIDEO_START_CYCLES - 1 - 5 - 2 - 2 - 2 - 3
lds r29, TCNT1L
sub r28, r29

delay r28
