; Approximately 63.5usec, the duration of a scanline in CPU cycles, rounded to the nearest multiple of the colorburst frequency.
.equ TV_STANDARD_NTSC_SCANLINE_CYCLES = 911

; Approximately 4.7usec, the duration of a HSYNC pulse in CPU cycles.
.equ TV_STANDARD_NTSC_HSYNC_PULSE_CYCLES = 66

; Approximately 58.8usec, the duration of of a VSYNC pulse in CPU cycles.
.equ TV_STANDARD_NTSC_VSYNC_PULSE_CYCLES = 840

; Approximately 5.3usec, the point during a line at which the colorburst starts.
.equ TV_STANDARD_NTSC_COLORBURST_START_CYCLES = 76

; Approximately 12.15usec, the point during a line at which active video starts, plus a safe area border.
.equ TV_STANDARD_NTSC_ACTIVE_VIDEO_START_CYCLES = 174

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
