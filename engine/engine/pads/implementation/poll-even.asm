; For each pad, load the latest button state into the carry flag, and shift that onto their register.
clc
sbis PINC, 3
sec
ror pad_0

clc
sbis PINC, 2
sec
ror pad_1

clc
sbis PINC, 1
sec
ror pad_2

clc
sbis PINC, 0
sec
ror pad_3

; Lower the clock line.
cbi PORTC, 4
