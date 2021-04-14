; Delay for a number of CPU cycles, minimum 6.
; The number of CPU cycles to delay.
; - A r* to clobber.
.macro delay_immediate
  ldi @1, (@0 - 6)
  delay @1
.endm

; Delay for a number of CPU cycles, plus 5.
; - A r* containing the number of CPU cycles to delay (plus 5 more).  This will be clobbered.
.macro delay
  ; Repeatedly subtract 3 until the value is less than zero.
  ; Each loop takes 3 cycles.
  delay_three_cycle_countdown:
  subi @0, 3
  brcc delay_three_cycle_countdown

  ; Skip to the end (taking 3 cycles, totalling 5) if the value was zero before subtracting.
  ; Otherwise, carry on (taking 2 cycles, totalling 4 so far).
  cpi @0, -3
  breq delay_end

  ; Delay 2 more cycles (totalling 6) if the value was two before subtracting.
  ; Otherwise, delay 2 more (totalling 7) as the value was 1.
  cpi @0, -1
  breq delay_end

  delay_end:

  ; Timings:
  ; 0 -> subi (1) brcc (1) cpi  (1) breq (2) = 5
  ; 1 -> subi (1) brcc (1) cpi  (1) breq (1) cpi (1) breq (1) = 6
  ; 2 -> subi (1) brcc (1) cpi  (1) breq (1) cpi (1) breq (2) = 7
  ; 3 -> subi (1) brcc (2) subi (1) brcc (1) cpi (1) breq (2) = 8
  ; 4 -> subi (1) brcc (2) subi (1) brcc (1) cpi (1) breq (1) cpi (1) breq (1) = 9
  ; 5 -> subi (1) brcc (2) subi (1) brcc (1) cpi (1) breq (1) cpi (1) breq (2) = 10
.endm
