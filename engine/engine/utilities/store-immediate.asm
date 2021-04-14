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
