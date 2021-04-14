; Load a two-byte word into a register pair in 4 cycles.
; - The r* to load the low byte into.
; - The r* to load the high byte into.
; - The address of the low byte to load.
.macro load_direct_16
  lds @0, @2
  lds @1, @2 + 1
.endm

; Load a two-byte word into X in 4 cycles.
; - The address of the low byte to load.
.macro load_direct_16_x
  load_direct_16 r26, r27, @0
.endm

; Load a two-byte word into Y in 4 cycles.
; - The address of the low byte to load.
.macro load_direct_16_y
  load_direct_16 r28, r29, @0
.endm

; Load a two-byte word into Z in 4 cycles.
; - The address of the low byte to load.
.macro load_direct_16_z
  load_direct_16 r30, r31, @0
.endm
