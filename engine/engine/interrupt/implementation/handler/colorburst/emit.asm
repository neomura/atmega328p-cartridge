; Load the pulse pattern into the serial buffer.
; Note that the start bit will produce the first pulse, so this actually produces 5 pulses.
store_immediate UDR0, r31, 0b01010101

; Turn the serial port on, with 8-bit characters.
store_immediate UCSR0B, r31, (1<<TXEN0)|(1<<UCSZ01)|(1<<UCSZ00)

; Wait for the colorburst to be emitted.
delay_immediate 13, r31

; Turn the serial port off.
store_immediate UCSR0B, r31, 0
