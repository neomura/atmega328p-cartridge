ldi interrupt_state, INTERRUPT_STATE_POST_BLANK_START
clr interrupt_flags

; Configure timer 1.
; - Set "compare match" mode - OC1A will be pulled high on reaching OCR1A, then pulled low on wrapping back to 0.
; - Set "fast PWM" mode.
; - Disable the clock divider.
store_immediate TCCR1A, r31, (1 << COM1A1) | (1 << COM1A0) | (1 << WGM11)
store_immediate TCCR1B, r31, (1 << WGM12) | (1 << WGM13) | (1 << CS10)

; Use the first channel to output the first HSYNC pulse.
store_immediate_16 ICR1L, r31, SCANLINE_CYCLES
store_immediate_16 OCR1AL, r31, HSYNC_PULSE_CYCLES

; Use the second channel to trigger an interrupt which fires a little earlier than the end of a HSYNC pulse.
store_immediate_16 OCR1BL, r31, INTERRUPT_START_CYCLES
store_immediate TIMSK1, r31, 1<<OCIE1B

; Disable the SPI clock divider.
store_immediate_16 UBRR0L, r31, 0

; Enable Master SPI mode.
store_immediate UCSR0C, r31, (1<<UMSEL01)|(1<<UMSEL00)

; Set the TX pin as an output.  SPI will still work if this isn't done, but
; it will be high during inactivity rather than low.
sbi DDRD, DDD1

; Enable the VSYNC/HSYNC output.
sbi DDRB, DDB1

; Enable the interrupt.
sei
