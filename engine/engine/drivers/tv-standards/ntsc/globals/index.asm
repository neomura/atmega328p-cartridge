.ifdef NTSC
  .ifdef PAL_60
    .error "Both NTSC and PAL_60 have been defined."
  .else
    .include "engine/drivers/tv-standards/ntsc/globals/ntsc.asm"
  .endif
.else
  .ifdef PAL_60
    .include "engine/drivers/tv-standards/ntsc/globals/pal-60.asm"
  .else
    .error "Neither NTSC nor PAL_60 have been defined."
  .endif
.endif

; The number of VSYNC lines per frame.
.equ TV_STANDARD_NTSC_VSYNC_LINES = 3

; The number of lines between the VSYNC and active lines.
.equ TV_STANDARD_NTSC_PRE_BLANK_LINES = 27

; The number of lines between the VSYNC and active lines.
.equ TV_STANDARD_NTSC_POST_BLANK_LINES = 9

; The first VSYNC line.
.equ TV_STANDARD_NTSC_STATE_VSYNC_START = 0

; The last VSYNC line.
.equ TV_STANDARD_NTSC_STATE_VSYNC_END = TV_STANDARD_NTSC_VSYNC_LINES - 1

; The first pre-active blank line.
.equ TV_STANDARD_NTSC_STATE_PRE_BLANK_START = TV_STANDARD_NTSC_VSYNC_LINES

; The last pre-active blank line.
.equ TV_STANDARD_NTSC_STATE_PRE_BLANK_END = TV_STANDARD_NTSC_STATE_VSYNC_END + TV_STANDARD_NTSC_PRE_BLANK_LINES

; The first repeat of an active line.
.equ TV_STANDARD_NTSC_STATE_ACTIVE_A = TV_STANDARD_NTSC_STATE_PRE_BLANK_END + 1

; The second repeat of an active line.
.equ TV_STANDARD_NTSC_STATE_ACTIVE_B = TV_STANDARD_NTSC_STATE_ACTIVE_A + 1

; The first post-active blank line.
.equ TV_STANDARD_NTSC_STATE_POST_BLANK_START = TV_STANDARD_NTSC_STATE_ACTIVE_B + 1

; The last post-active blank line.
.equ TV_STANDARD_NTSC_STATE_POST_BLANK_END = TV_STANDARD_NTSC_STATE_ACTIVE_B + TV_STANDARD_NTSC_POST_BLANK_LINES

; Tracks the progress through the current frame (see TV_STANDARD_NTSC_STATE_*).
; TODO is there a better way of doing this?
.def tv_standard_ntsc_state = r23 ; tv_standard_general_purpose_high_a

.include "engine/drivers/tv-standards/ntsc/interrupt/index.asm"
