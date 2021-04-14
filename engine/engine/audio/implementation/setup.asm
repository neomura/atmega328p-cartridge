; Configure audio output PWM - this is common to all drivers, so done here.
; Non-inverting fast PWM mode without a clock prescaler.
out_immediate TCCR0A, r31, (1 << COM0A1) | (1 << COM0B1) | (1 << WGM01) | (1 << WGM00)
out_immediate TCCR0B, r31, (1 << CS00)
sbi DDRD, DDD5
sbi DDRD, DDD6
