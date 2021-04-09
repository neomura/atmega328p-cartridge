# [neomura/atmega328p-cartridge](../../../readme.md)/[Engine](../../readme.md)/[Drivers](../readme.md)/TV Standards

A TV standard driver is responsible for both communicating with the TV (implementing the video and audio [capabilities](../../../documentation/capabilities/readme.md) specification as best as possible) and invoking other drivers, including:

- Invoking the `audio_sample` macro at approximately 15750Hz.
- Invoking the `video_column` macro and sending its output to the display.
- Updating the `video_next_row` counter to the row number of the next visible line.  For example, this should be 0 after the last line on the screen, then 1 while the first line is being drawn to the display, etc.
- Invoking the `pads_poll` macro at least 17 times per frame, spaced at least 12μs apart.

## Implementations

| Link                         | Description                              |
| ---------------------------- | ---------------------------------------- |
| [NTSC](./ntsc/readme.md)     | Approximation of NTSC composite video.   |
| [PAL 60](./pal-60/readme.md) | Approximation of PAL 60 composite video. |
