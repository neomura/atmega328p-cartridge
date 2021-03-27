# [neomura/atmega328p-cartridge](../../readme.md)/[Engine](../readme.md)/Audio

These helper functions generate various waveforms which can be mixed to produce game audio.

| Link                                         | Description                                                     |
| -------------------------------------------- | --------------------------------------------------------------- |
| [Noise (mono)](./noise_mono/readme.md)       | Monaural 15-bit linear-feedback shift register noise generator. |
| [Pulse (mono)](./pulse_mono/readme.md)       | Monaural pulse wave generator with variable duty cycle.         |
| [Sawtooth (mono)](./sawtooth_mono/readme.md) | Monaural rising sawtooth wave generator.                        |
| [Triangle (mono)](./triangle_mono/readme.md) | Monaural triangle wave generator.                               |

## Pattern

Most will follow a pattern like the following, assuming that the oscillator is called "example":

```assembly
; This is a block of bytes which will control the oscillator and allow it to track its state between samples.
.dseg example_register: .byte AUDIO_EXAMPLE_REGISTER_BYTES

.cseg
.macro game_setup
  audio_example_setup example_register, r16
.endm

.macro game_frame
  ; Oscillators will include helpers to read/write specific areas of their registers.
  ; Frequency control uses a "rate", which is the amount by which their internal counters increment every sample.
  lds r16, example_register + AUDIO_EXAMPLE_REGISTER_RATE

  ; Increase this rate once per frame.
  inc r16

  lds example_register + AUDIO_EXAMPLE_REGISTER_RATE, r16
.endm

.macro game_sample
  ; Most oscillators use r0 and r1.
  push r0
  push r1

  ; Generate the next audio sample.  Most oscillators output to r1.
  audio_example_sample example_register

  out OCR0B, r1
  out OCR0A, r1

  pop r1
  pop r0
.endm
```
