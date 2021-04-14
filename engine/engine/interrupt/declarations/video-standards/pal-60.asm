; Approximately 63.5usec, the duration of a scanline in CPU cycles, rounded to the nearest multiple of the colorburst frequency.
.equ SCANLINE_CYCLES = 1127

; Approximately 4.7usec, the duration of a HSYNC pulse in CPU cycles.
.equ HSYNC_PULSE_CYCLES = 83

; Approximately 58.8usec, the duration of of a VSYNC pulse in CPU cycles.
.equ VSYNC_PULSE_CYCLES = 1043

; Approximately 5.3usec, the point during a line at which the colorburst starts.
.equ COLORBURST_START_CYCLES = 94

; Approximately 12.15usec, the point during a line at which active video starts, plus a safe area border.
.equ ACTIVE_VIDEO_START_CYCLES = 216

; The point during a line at which the interrupt should fire.
; This figure has been set as high as possible without overwhelming the timing jitter correction through experimentation.
.equ INTERRUPT_START_CYCLES = 58
