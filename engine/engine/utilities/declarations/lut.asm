; Load a byte from a look-up table in flash in 8 cycles.
; Clobbers Z.
; - A r* to which to write the looked-up byte.
; - A r* from which to read an offset into the look-up table.  This can be the r* stored to.
; - The address of the start of the look-up table.
.macro lut
  load_immediate_z @2
  add r30, @1
  adc r31, zero
  lpm @0, Z
.endm
