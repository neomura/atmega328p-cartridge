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
