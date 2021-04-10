; Store a constant value in 3 cycles.
; - The address to which to store.
; - The value to store.
; - A r* to clobber.
.macro store_immediate
  ldi @1, @2
  sts @0, @1
.endm

; Store a two-byte constant value in 6 cycles.
; - The address of the first byte to which to store.
; - A r* to clobber.
; - The value to store.
.macro store_immediate_16
  ; This order is necessary as some registers seem to clear the low byte on setting the high.
  store_immediate (@0 + 1), @1, HIGH(@2)
  store_immediate @0, @1, LOW(@2)
.ENDM

; Load a two-byte constant into X in 2 cycles.
; - The value to load.
.macro load_immediate_x
  ldi r26, LOW(@0)
  ldi r27, HIGH(@0)
.endm

; Load a two-byte constant into Y in 2 cycles.
; - The value to load.
.macro load_immediate_y
  ldi r28, LOW(@0)
  ldi r29, HIGH(@0)
.endm

; Load a two-byte constant into Z in 2 cycles.
; - The value to load.
.macro load_immediate_z
  ldi r30, LOW(@0)
  ldi r31, HIGH(@0)
.endm

; Load a two-byte word into a register pair in 4 cycles.
; - The r* to load the low byte into.
; - The r* to load the high byte into.
; - The address of the low byte to load.
.macro load_16_direct
  lds @0, @2
  lds @1, @2 + 1
.endm

; Load a two-byte word into X in 4 cycles.
; - The address of the low byte to load.
.macro load_16_direct_x
  load_16_direct r26, r27, @0
.endm

; Load a two-byte word into Y in 4 cycles.
; - The address of the low byte to load.
.macro load_16_direct_y
  load_16_direct r28, r29, @0
.endm

; Load a two-byte word into Z in 4 cycles.
; - The address of the low byte to load.
.macro load_16_direct_z
  load_16_direct r30, r31, @0
.endm

; Store a two-byte word from a register pair in 4 cycles.
; - The address of the low byte to store.
; - The r* to store the low byte from.
; - The r* to store the high byte from.
.macro store_16_direct
  ; This order is necessary as some registers seem to clear the low byte on setting the high.
  sts @0 + 1, @2
  sts @0, @1
.endm

; Store a two-byte word from X in 4 cycles.
; - The address of the low byte to store.
.macro store_16_direct_x
  store_16_direct @0, r26, r27
.endm

; Store a two-byte word from X in 4 cycles.
; - The address of the low byte to store.
.macro store_16_direct_y
  store_16_direct @0, r28, r29
.endm

; Store a two-byte word from Z in 4 cycles.
; - The address of the low byte to store.
.macro store_16_direct_z
  store_16_direct @0, r30, r31
.endm

; Write a constant value to an IO port in 3 cycles.
; - The address to which to write.
; - The value to store.
; - A r* to clobber.
.macro out_immediate
  ldi @1, @2
  out @0, @1
.endm

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
