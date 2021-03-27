# [neomura/atmega328p-cartridge](../../../readme.md)/[Engine](../../readme.md)/[Audio](../readme.md)/Noise (mono)

Monaural 15-bit linear-feedback shift register noise generator.

## Registers

| Name                                | Type | Description                                                                                 |
| ----------------------------------- | ---- | ------------------------------------------------------------------------------------------- |
| AUDIO_NOISE_MONO_REGISTER_RATE      | U8   | The oscillator advances to the next bit every AUDIO_NOISE_MONO_REGISTER_RATE / 256 samples. |
| AUDIO_NOISE_MONO_REGISTER_AMPLITUDE | U8   | Output alternates between 0 and AUDIO_NOISE_MONO_REGISTER_AMPLITUDE.                        |
