# [neomura/atmega328p-cartridge](../../../readme.md)/[Engine](../../readme.md)/[Audio](../readme.md)/Triangle (mono)

Monaural triangle wave generator.

## Registers

| Name                                   | Type  | Description                                                                                 |
| -------------------------------------- | ----- | ------------------------------------------------------------------------------------------- |
| AUDIO_TRIANGLE_MONO_REGISTER_RATE      | U16   | The oscillator completes one cycle every AUDIO_TRIANGLE_MONO_REGISTER_RATE / 65536 samples. |
| AUDIO_TRIANGLE_MONO_REGISTER_AMPLITUDE | U8    | Output travels from 0 to AUDIO_TRIANGLE_MONO_REGISTER_AMPLITUDE / 2 and back to 0.          |
