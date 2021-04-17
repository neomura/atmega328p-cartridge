; Load a byte from a look-up table in flash in 8 cycles.
; Clobbers Z.
; - A r* from which to read an offset into the look-up table.  The value will be written to this.
; - The address of the start of the look-up table.
.macro lut
  load_immediate_z @1
  add r30, @0
  clr @0
  adc r31, @0
  lpm @0, Z
.endm
