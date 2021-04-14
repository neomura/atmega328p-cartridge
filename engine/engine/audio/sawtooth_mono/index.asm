.equ AUDIO_SAWTOOTH_MONO_REGISTER_BYTES = 5

.equ AUDIO_SAWTOOTH_MONO_REGISTER_COUNTER_LOW = 0
.equ AUDIO_SAWTOOTH_MONO_REGISTER_COUNTER_HIGH = 1
.equ AUDIO_SAWTOOTH_MONO_REGISTER_RATE = 2
.equ AUDIO_SAWTOOTH_MONO_REGISTER_RATE_HIGH = 3
.equ AUDIO_SAWTOOTH_MONO_REGISTER_AMPLITUDE = 4

; - A r* to clobber.
; - The SRAM address of the register.
.macro audio_sawtooth_mono_setup
  ldi @1, 0
  sts @0 + AUDIO_SAWTOOTH_MONO_REGISTER_COUNTER_LOW, @1
  sts @0 + AUDIO_SAWTOOTH_MONO_REGISTER_COUNTER_HIGH, @1
  sts @0 + AUDIO_SAWTOOTH_MONO_REGISTER_RATE, @1
  sts @0 + AUDIO_SAWTOOTH_MONO_REGISTER_RATE_HIGH, @1
  sts @0 + AUDIO_SAWTOOTH_MONO_REGISTER_AMPLITUDE, @1
.endm

; r0 and r1 will be clobbered; r1 with the resulting sample.
; - The SRAM address of the register.
.macro audio_sawtooth_mono_sample
  ; Increment the low byte of the counter.
  lds r0, @0 + AUDIO_SAWTOOTH_MONO_REGISTER_COUNTER_LOW
  lds r1, @0 + AUDIO_SAWTOOTH_MONO_REGISTER_RATE
  add r0, r1
  sts @0 + AUDIO_SAWTOOTH_MONO_REGISTER_COUNTER_LOW, r0

  ; Increment the high byte of the counter.
  lds @0, @0 + AUDIO_SAWTOOTH_MONO_REGISTER_COUNTER_HIGH
  lds r1, @0 + AUDIO_SAWTOOTH_MONO_REGISTER_RATE_HIGH
  adc @0, r1
  sts @0 + AUDIO_SAWTOOTH_MONO_REGISTER_COUNTER_HIGH, r0

  ; Amplify the high byte of the counter.
  lds r1, @0 + AUDIO_SAWTOOTH_MONO_REGISTER_AMPLITUDE
  mul r0, r1
.endm
