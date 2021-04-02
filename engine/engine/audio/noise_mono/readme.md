# [neomura/atmega328p-cartridge](../../../readme.md)/[Engine](../../readme.md)/[Audio](../readme.md)/Noise (mono)

Monaural 15-bit linear-feedback shift register noise generator.

## Registers

| Name                                | Type | Description                                                                                 |
| ----------------------------------- | ---- | ------------------------------------------------------------------------------------------- |
| AUDIO_NOISE_MONO_REGISTER_RATE      | U8   | The oscillator advances to the next bit every 256 / AUDIO_NOISE_MONO_REGISTER_RATE samples. |
| AUDIO_NOISE_MONO_REGISTER_AMPLITUDE | U8   | Output alternates between 0 and AUDIO_NOISE_MONO_REGISTER_AMPLITUDE.                        |
