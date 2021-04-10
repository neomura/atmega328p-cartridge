.macro tv_standard_ntsc_interrupt_wait_until_start_of_colorburst
  ; Calculate the number of cycles to delay until the start of the colorburst.
  ; Takes into account:
  ; - 1 cycle to calculate the delay length.
  ; - 5 cycles of overhead for the delay.
  ; - 3 cycles to load the pulse pattern into the serial buffer.
  ; - 3 cycles to turn the serial port on.
  ldi tv_standard_general_purpose_high_b, TV_STANDARD_NTSC_COLORBURST_START_CYCLES - 1 - 5 - 3 -3
  lds tv_standard_general_purpose_high_c, TCNT1L
  sub tv_standard_general_purpose_high_b, tv_standard_general_purpose_high_c

  delay tv_standard_general_purpose_high_b
.endm

.macro tv_standard_ntsc_interrupt_colorburst
  tv_standard_ntsc_interrupt_wait_until_start_of_colorburst

  ; Load the pulse pattern into the serial buffer.
  ; Note that the start bit will produce the first pulse, so this actually produces 5 pulses.
  store_immediate UDR0, tv_standard_general_purpose_high_b, 0b01010101

  ; Turn the serial port on, with 8-bit characters.
  store_immediate UCSR0B, tv_standard_general_purpose_high_b, (1<<TXEN0)|(1<<UCSZ01)|(1<<UCSZ00)

  ; Wait for the colorburst to be emitted.
  delay_immediate 13, tv_standard_general_purpose_high_b

  ; Turn the serial port off.
  store_immediate UCSR0B, tv_standard_general_purpose_high_b, 0
.endm
