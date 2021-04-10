.include "m328Pdef.inc"

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

; The number of the row which is to be prepared.
; When 0, some time is available to execute game logic (but row 0 is still needed).
.def video_next_row = r16

; Used by the main loop to track which video row was drawn last.
.def main_loop_previous_video_row = r6

; A general-purpose register in the r2-r15 range for use by games.
.def game_general_purpose_low_a = r7

; A general-purpose register in the r2-r15 range for use by games.
.def game_general_purpose_low_b = r8

; A general-purpose register in the r2-r15 range for use by games.
.def game_general_purpose_low_c = r9

; A general-purpose register in the r2-r15 range for use by games.
.def game_general_purpose_low_d = r10

; A general-purpose register in the r2-r15 range for use by games.
.def game_general_purpose_low_e = r11

; A general-purpose register in the r2-r15 range for use by games.
.def game_general_purpose_low_f = r12

; A general-purpose register in the r2-r15 range for use by tv standard drivers.
.def tv_standard_general_purpose_low_a = r13

; A general-purpose register in the r2-r15 range for use by tv standard drivers.
.def tv_standard_general_purpose_low_b = r14

; A general-purpose register in the r2-r15 range for use by tv standard drivers.
.def tv_standard_general_purpose_low_c = r15

; A general-purpose register in the r17-r25 range for use by games.
.def game_general_purpose_high_a = r17

; A general-purpose register in the r17-r25 range for use by games.
.def game_general_purpose_high_b = r18

; A general-purpose register in the r17-r25 range for use by games.
.def game_general_purpose_high_c = r19

; A general-purpose register in the r17-r25 range for use by games.
.def game_general_purpose_high_d = r20

; A general-purpose register in the r17-r25 range for use by games.
.def game_general_purpose_high_e = r21

; A general-purpose register in the r17-r25 range for use by games.
.def game_general_purpose_high_f = r22

; A general-purpose register in the r17-r25 range for use by tv standard drivers.
.def tv_standard_general_purpose_high_a = r23

; A general-purpose register in the r17-r25 range for use by tv standard drivers.
.def tv_standard_general_purpose_high_b = r24

; A general-purpose register in the r17-r25 range for use by tv standard drivers.
.def tv_standard_general_purpose_high_c = r25

.include "engine/pads/globals.asm"

.cseg

.macro globals_setup
  ldi video_next_row, 0
.endm

.org 0x00
  jmp main

.include "engine/utilities.asm"
.include "engine/audio/sawtooth_mono/index.asm"
.include "engine/audio/noise_mono/index.asm"
.include "engine/audio/pulse_mono/index.asm"
.include "engine/audio/triangle_mono/index.asm"
.include "game/globals.asm"
