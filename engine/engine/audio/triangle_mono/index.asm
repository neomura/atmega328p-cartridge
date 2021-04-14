.equ AUDIO_TRIANGLE_MONO_REGISTER_BYTES = 5

.equ AUDIO_TRIANGLE_MONO_REGISTER_COUNTER_LOW = 0
.equ AUDIO_TRIANGLE_MONO_REGISTER_COUNTER_HIGH = 1
.equ AUDIO_TRIANGLE_MONO_REGISTER_RATE = 2
.equ AUDIO_TRIANGLE_MONO_REGISTER_RATE_HIGH = 3
.equ AUDIO_TRIANGLE_MONO_REGISTER_AMPLITUDE = 4

; - A r* to clobber.
; - The SRAM address of the register.
.macro audio_triangle_mono_setup
  ldi @1, 0
  sts @0 + AUDIO_TRIANGLE_MONO_REGISTER_COUNTER_LOW, @1
  sts @0 + AUDIO_TRIANGLE_MONO_REGISTER_COUNTER_HIGH, @1
  sts @0 + AUDIO_TRIANGLE_MONO_REGISTER_RATE, @1
  sts @0 + AUDIO_TRIANGLE_MONO_REGISTER_RATE_HIGH, @1
  sts @0 + AUDIO_TRIANGLE_MONO_REGISTER_AMPLITUDE, @1
.endm

; r0 and r1 will be clobbered; r1 with the resulting sample.
; - The SRAM address of the register.
.macro audio_triangle_mono_sample
  ; Increment the low byte of the counter.
  lds r0, @0 + AUDIO_TRIANGLE_MONO_REGISTER_COUNTER_LOW
  lds r1, @0 + AUDIO_TRIANGLE_MONO_REGISTER_RATE
  add r0, r1
  sts @0 + AUDIO_TRIANGLE_MONO_REGISTER_COUNTER_LOW, r0

  ; Increment the high byte of the counter.
  lds r0, @0 + AUDIO_TRIANGLE_MONO_REGISTER_COUNTER_HIGH
  lds r1, @0 + AUDIO_TRIANGLE_MONO_REGISTER_RATE_HIGH
  adc r0, r1
  sts @0 + AUDIO_TRIANGLE_MONO_REGISTER_COUNTER_HIGH, r0

  ; If we're more than half way through the cycle, we're on the falling edge, not the rising.
  sbrc r0, 7
  neg r0

  ; Amplify the resulting triangle wave.
  lds r1, @0 + AUDIO_TRIANGLE_MONO_REGISTER_AMPLITUDE
  mul r0, r1
.endm
