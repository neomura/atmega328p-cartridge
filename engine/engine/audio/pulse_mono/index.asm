.equ AUDIO_PULSE_MONO_REGISTER_BYTES = 6

.equ AUDIO_PULSE_MONO_REGISTER_COUNTER_LOW = 0
.equ AUDIO_PULSE_MONO_REGISTER_COUNTER_HIGH = 1
.equ AUDIO_PULSE_MONO_REGISTER_RATE = 2
.equ AUDIO_PULSE_MONO_REGISTER_RATE_HIGH = 3
.equ AUDIO_PULSE_MONO_REGISTER_AMPLITUDE = 4
.equ AUDIO_PULSE_MONO_REGISTER_DUTY = 5

.cseg

; - A r* to clobber.
; - The SRAM address of the register.
.macro audio_pulse_mono_setup
  ldi @1, 0
  sts @0 + AUDIO_PULSE_MONO_REGISTER_COUNTER_LOW, @1
  sts @0 + AUDIO_PULSE_MONO_REGISTER_COUNTER_HIGH, @1
  sts @0 + AUDIO_PULSE_MONO_REGISTER_RATE, @1
  sts @0 + AUDIO_PULSE_MONO_REGISTER_RATE_HIGH, @1
  sts @0 + AUDIO_PULSE_MONO_REGISTER_AMPLITUDE, @1
  sts @0 + AUDIO_PULSE_MONO_REGISTER_DUTY, @1
.endm

; r0 and r1 will be clobbered; r1 with the resulting sample.
; - The SRAM address of the register.
.macro audio_pulse_mono_sample
  ; Increment the low byte of the counter.
  lds r0, @0 + AUDIO_PULSE_MONO_REGISTER_COUNTER_LOW
  lds r1, @0 + AUDIO_PULSE_MONO_REGISTER_RATE
  add r0, r1
  sts @0 + AUDIO_PULSE_MONO_REGISTER_COUNTER_LOW, r0

  ; Increment the high byte of the counter.
  lds r0, @0 + AUDIO_PULSE_MONO_REGISTER_COUNTER_HIGH
  lds r1, @0 + AUDIO_PULSE_MONO_REGISTER_RATE_HIGH
  adc r0, r1
  sts @0 + AUDIO_PULSE_MONO_REGISTER_COUNTER_HIGH, r0

  ; Compare the counter with the duty cycle.
  lds r1, @0 + AUDIO_PULSE_MONO_REGISTER_DUTY
  cp r0, r1
  brsh audio_pulse_mono_sample_low

  ; Output the amplitude as this is the high segment.
  lds r1, @0 + AUDIO_PULSE_MONO_REGISTER_AMPLITUDE
  rjmp audio_pulse_mono_sample_end

  audio_pulse_mono_sample_low:
  ; Zero the output as this is the low segment.
  eor r1, r1

  audio_pulse_mono_sample_end:
.endm
