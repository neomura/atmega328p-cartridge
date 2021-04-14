; Load the first byte of pixels into the serial port.
ld r29, Z+
sts UDR0, r29

; Turn the serial port on, with 8-bit characters.
store_immediate UCSR0B, r29, (1 << TXEN0) | (1 << UCSZ01) | (1 << UCSZ00)

; Load the number of pixels we have left to copy.
ldi r28, (VIDEO_COLUMNS / VIDEO_PIXELS_PER_BYTE) - 1

nop
nop

; Loop through the columns, loading them into the serial port.
interrupt_active_video_loop:

nop
nop
nop
nop
nop
nop
nop
nop
nop
ld r29, Z+
sts UDR0, r29

dec r28
brne interrupt_active_video_loop

; Turn the serial port off.
sts UCSR0B, r28
