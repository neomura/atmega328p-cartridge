; Calculate the number of cycles to delay until the start of the colorburst.
; Takes into account:
; - 1 cycle to calculate the delay length.
; - 5 cycles of overhead for the delay.
; - 3 cycles to load the pulse pattern into the serial buffer.
; - 3 cycles to turn the serial port on.
ldi r30, COLORBURST_START_CYCLES - 1 - 5 - 3 -3

.ifdef PAL_60
  ; The colorburst needs to be adjusted 90° on every second line.
  sbrc interrupt_flags, INTERRUPT_FLAG_ALTERNATE_LINE
  inc r30
.endif

lds r31, TCNT1L
sub r30, r31

delay r30
