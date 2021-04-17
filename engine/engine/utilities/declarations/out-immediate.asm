; Write a constant value to an IO port in 3 cycles.
; - The address to which to write.
; - A r* to clobber.
; - The value to store.
.macro out_immediate
  ldi @1, @2
  out @0, @1
.endm
