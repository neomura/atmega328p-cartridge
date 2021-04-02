; Approximately 63.5usec, the duration of a scanline in CPU cycles, rounded to the nearest multiple of the colorburst frequency.
.equ TV_STANDARD_NTSC_SCANLINE_CYCLES = 911

; Approximately 4.7usec, the duration of a HSYNC pulse in CPU cycles.
.equ TV_STANDARD_NTSC_HSYNC_PULSE_CYCLES = 66

; Approximately 58.8usec, the duration of of a VSYNC pulse in CPU cycles.
.EQU TV_STANDARD_NTSC_VSYNC_PULSE_CYCLES = 840

; Approximately 5.3usec, the point during a line at which the colorburst starts.
.equ TV_STANDARD_NTSC_COLORBURST_START_CYCLES = 76

; Approximately 12.85usec, the point during a line at which active video starts, plus a safe area border.
.equ TV_STANDARD_NTSC_ACTIVE_VIDEO_START_CYCLES = 171

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

.dseg

; Tracks the progress through the current frame (see TV_STANDARD_NTSC_STATE_*).
tv_standard_ntsc_state: .BYTE 1

.cseg

.include "engine/drivers/tv-standards/ntsc/interrupt/index.asm"

.macro tv_standard_setup
  store_immediate tv_standard_ntsc_state, R16, TV_STANDARD_NTSC_STATE_POST_BLANK_START


  ; Configure timer 1.
  ; - Set "compare match" mode - OC1A will be pulled high on reaching OCR1A, then pulled low on wrapping back to 0.
  ; - Set "fast PWM" mode.
  ; - Disable the clock divider.
  store_immediate TCCR1A, R16, (1 << COM1A1) | (1 << COM1A0) | (1 << WGM11)
  store_immediate TCCR1B, R16, (1 << WGM12) | (1 << WGM13) | (1 << CS10)

  ; Use the first channel to output the first HSYNC pulse.
  store_immediate_16 ICR1L, R16, TV_STANDARD_NTSC_SCANLINE_CYCLES
  store_immediate_16 OCR1AL, R16, TV_STANDARD_NTSC_HSYNC_PULSE_CYCLES

  ; Use the second channel to trigger an interrupt which fires a little earlier than the end of a HSYNC pulse.
  ; This figure has been set as high as possible without overwhelming the timing jitter correction through experimentation.
  ; TODO check whether moveable.
  store_immediate_16 OCR1BL, R16, 44
  store_immediate TIMSK1, R16, 1<<OCIE1B


  ; Disable the SPI clock divider.
  store_immediate_16 UBRR0L, R16, 0

  ; Enable Master SPI mode.
  store_immediate UCSR0C, R16, (1<<UMSEL01)|(1<<UMSEL00)

  ; Set the TX pin as an output.  SPI will still work if this isn't done, but
  ; it will be high during inactivity rather than low.
  sbi DDRD, DDD1
.endm

.macro tv_standard_start
  ; Enable the VSYNC/HSYNC output.
  sbi DDRB, DDB1

  ; Enable the interrupt.
  sei
.endm
