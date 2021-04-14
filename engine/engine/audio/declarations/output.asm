; Output the left audio channel in 1 cycle.
; - A r* containing the value to output.
.macro output_left_audio
  out OCR0B, @0
.endm

; Output the right audio channel in 1 cycle.
; - A r* containing the value to output.
.macro output_right_audio
  out OCR0A, @0
.endm
