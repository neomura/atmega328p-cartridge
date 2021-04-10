# [neomura/atmega328p-cartridge](../../../../readme.md)/[Engine](../../../readme.md)/[Audio](../readme.md)/Pulse (mono)

Monaural pulse wave generator with variable duty cycle.

## Registers

| Name                                  | Type  | Description                                                                                                                                                              |
| ------------------------------------- | ----- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `AUDIO_PULSE_MONO_REGISTER_RATE`      | `U16` | The oscillator completes one cycle every 65536 / `AUDIO_PULSE_MONO_REGISTER_RATE` samples.                                                                               |
| `AUDIO_PULSE_MONO_REGISTER_AMPLITUDE` | `U8`  | Output alternates between 0 and `AUDIO_PULSE_MONO_REGISTER_AMPLITUDE`.                                                                                                   |
| `AUDIO_PULSE_MONO_REGISTER_DUTY`      | `U8`  | The point during a cycle at which the oscillator switches from `AUDIO_PULSE_MONO_REGISTER_AMPLITUDE` to 0.  0 = at the start, 128 = 50% duty (square), 255 = at the end. |
