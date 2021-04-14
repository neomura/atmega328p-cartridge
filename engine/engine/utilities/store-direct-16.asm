; Store a two-byte word from a register pair in 4 cycles.
; - The address of the low byte to store.
; - The r* to store the low byte from.
; - The r* to store the high byte from.
.macro store_direct_16
  ; This order is necessary as some registers seem to clear the low byte on setting the high.
  sts @0 + 1, @2
  sts @0, @1
.endm

; Store a two-byte word from X in 4 cycles.
; - The address of the low byte to store.
.macro store_direct_16_x
  store_direct_16 @0, r26, r27
.endm

; Store a two-byte word from X in 4 cycles.
; - The address of the low byte to store.
.macro store_direct_16_y
  store_direct_16 @0, r28, r29
.endm

; Store a two-byte word from Z in 4 cycles.
; - The address of the low byte to store.
.macro store_direct_16_z
  store_direct_16 @0, r30, r31
.endm
