# [neomura/atmega328p-cartridge](../../../../readme.md)/[Engine](../../../readme.md)/[Audio](../readme.md)/Sawtooth (mono)

Monaural rising sawtooth wave generator.

## Registers

| Name                                     | Type  | Description                                                                                   |
| ---------------------------------------- | ----- | --------------------------------------------------------------------------------------------- |
| `AUDIO_SAWTOOTH_MONO_REGISTER_RATE`      | `U16` | The oscillator completes one cycle every 65536 / `AUDIO_SAWTOOTH_MONO_REGISTER_RATE` samples. |
| `AUDIO_SAWTOOTH_MONO_REGISTER_AMPLITUDE` | `U8`  | Output travels from 0 to `AUDIO_SAWTOOTH_MONO_REGISTER_AMPLITUDE`.                            |
