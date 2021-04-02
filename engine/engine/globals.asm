.include "m328Pdef.inc"
.include "engine/utilities.asm"
.include "engine/pads.asm"
.include "engine/audio/sawtooth_mono/index.asm"
.include "engine/audio/noise_mono/index.asm"
.include "engine/audio/pulse_mono/index.asm"
.include "engine/audio/triangle_mono/index.asm"

; The number of pixel columns in a frame.
.equ VIDEO_COLUMNS = 156

; The number of pixel rows in a frame.
.equ VIDEO_ROWS = 113

; The number of pixels per byte.
.equ VIDEO_PIXELS_PER_BYTE = 4

; The numerical value of the color black.
.equ COLOR_BLACK = 0

; The numerical value of the color avocado (when using palette A).
.equ COLOR_AVOCADO = 1

; The numerical value of the color majorelle blue (when using palette A).
.equ COLOR_MAJORELLE_BLUE = 2

; The numerical value of the color aquamarine (when using palette B).
.equ COLOR_AQUAMARINE = 1

; The numerical value of the color crimson (when using palette B).
.equ COLOR_CRIMSON = 2

; The numerical value of the color white.
.equ COLOR_WHITE = 3

; The number of frames per second.
.equ FRAME_RATE = 60

; The number of audio samples per second.
.equ SAMPLE_RATE = 15750

.dseg

; The number of the row which is to be prepared.
; When 0, some time is available to execute game logic (but row 0 is still needed).
video_next_row: .byte 1

.cseg

.macro globals_setup
  store_immediate video_next_row, r16, 0
.endm

.org 0x00
  jmp main
