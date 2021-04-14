; Enable internal pull-ups on data inputs.
sbi PORTC, 0
sbi PORTC, 1
sbi PORTC, 2
sbi PORTC, 3

; Configure the clock output as an output and raise it.
sbi DDRC, 4
sbi PORTC, 4

; Configure the latch output as an output.  We'll raise it in end-polling.
sbi DDRC, 5

; Zero the pad status registers.
eor pad_0, pad_0
eor pad_1, pad_1
eor pad_2, pad_2
eor pad_3, pad_3
