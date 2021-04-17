; Load a two-byte word into a register pair in 2 cycles.
; - The r* to load the low byte into.
; - The r* to load the high byte into.
; - The value to load.
.macro load_immediate_16
  ldi @0, LOW(@2)
  ldi @1, HIGH(@2)
.endm

; Load a two-byte constant into X in 2 cycles.
; - The value to load.
.macro load_immediate_x
  load_immediate_16 r26, r27, @0
.endm

; Load a two-byte constant into Y in 2 cycles.
; - The value to load.
.macro load_immediate_y
  load_immediate_16 r28, r29, @0
.endm

; Load a two-byte constant into Z in 2 cycles.
; - The value to load.
.macro load_immediate_z
  load_immediate_16 r30, r31, @0
.endm
