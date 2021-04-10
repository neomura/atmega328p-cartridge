.cseg

.macro video_setup
.endm

.macro video_before_columns
.endm

.macro video_column
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
ldi r30, 0
sts UDR0, r30
.endm

.macro video_after_columns
.endm
