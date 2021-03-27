.equ AUDIO_NOISE_MONO_REGISTER_BYTES = 5

.equ AUDIO_NOISE_MONO_REGISTER_COUNTER = 0
.equ AUDIO_NOISE_MONO_REGISTER_RATE = 1
.equ AUDIO_NOISE_MONO_REGISTER_AMPLITUDE = 2
.equ AUDIO_NOISE_MONO_REGISTER_BITS_LOW = 3
.equ AUDIO_NOISE_MONO_REGISTER_BITS_HIGH = 4

.cseg

; - A r* to clobber.
; - The SRAM address of the register.
.macro audio_noise_mono_setup
  ldi @1, 0
  sts @0 + AUDIO_NOISE_MONO_REGISTER_COUNTER, @1
  sts @0 + AUDIO_NOISE_MONO_REGISTER_RATE, @1
  sts @0 + AUDIO_NOISE_MONO_REGISTER_AMPLITUDE, @1
  sts @0 + AUDIO_NOISE_MONO_REGISTER_BITS_LOW, @1
  store_immediate @0 + AUDIO_NOISE_MONO_REGISTER_BITS_LOW, @1, 1
.endm

; r0, r1 and r2 will be clobbered; r1 with the resulting sample.
; - The SRAM address of the register.
.macro audio_noise_mono_sample
  ; Increment the high byte of the counter.
  lds r0, @0 + AUDIO_NOISE_MONO_REGISTER_COUNTER
  lds r1, @0 + AUDIO_NOISE_MONO_REGISTER_RATE
  add r0, r1
  sts @0 + AUDIO_NOISE_MONO_REGISTER_COUNTER, r0

  lds r0, @0 + AUDIO_NOISE_MONO_REGISTER_BITS_LOW

  ; Update the noise generator if the counter has overflowed.
  brbc 0, audio_noise_mono_sample_skip_noise_update

  lds r1, @0 + AUDIO_NOISE_MONO_REGISTER_BITS_HIGH

  ; Determine the next high bit (in r2 bit 0).
  mov r2, r0
  lsr r2
  eor r2, r0

  ; Load it into the bit which is currently out of range, via the T flag.
  bst r2, 0
  bld r1, 7

  ; Shift right and save.
  lsr r1
  ror r0
  sts @0 + AUDIO_NOISE_MONO_REGISTER_BITS_LOW, r0
  sts @0 + AUDIO_NOISE_MONO_REGISTER_BITS_HIGH, r1

  audio_noise_mono_sample_skip_noise_update:

  ; Prepare the output the amplitude.
  lds r1, @0 + AUDIO_NOISE_MONO_REGISTER_AMPLITUDE

  ; Zero the output if this is a low bit (leaving it at amplitude if this is a high bit).
  sbrs r0, 0
  eor r1, r1

.endm
