# [neomura/atmega328p-cartridge](../../readme.md)/[Documentation](../readme.md)/NTSC Composite Simplifications

Generating a correct NTSC composite video signal from a microcontroller is quite difficult without custom silicon such as the AD725 as found in the Uzebox.  Most retro consoles included complex region-specific analog electronics to convert signals from their graphics processors into NTSC composite video signals.  To keep cost down, these usually took a number of shortcuts to produce a signal which would still work, but is not entirely correct.

Lines can be lengthened very slightly so that they are an even multiple in duration of the colorburst interval (63.5µs -> 63.7µs).

The equalizing pulses around VSYNC can usually be omitted entirely; they are only needed by older TVs from before the 1980s.

The timing of the VSYNC signal itself can be shortened to match normal lines (64µs -> 63.7µs), simplifying timing, while the second pulse within that "line" can also be dropped.

Most retro consoles only emit one field repeatedly (either even or odd).  This halves their vertical resolution to 240 rows, but removes the need to consider interlacing, and increases framerate to 60Hz.

Similar to how grayscale TVs ignore the sine wave added for color as it is outside their expected frequency space, color TVs ignore content significantly above their expected 3.579545MHz carrier frequency.  As a consequence, pulse waves can stand in for sine waves as TVs will filter off the upper harmonics.

This is part of what constitutes an "artifact color", a singificant contributor to the Apple II's unique look.

## References

| Link                                                                                                                                                                                                             | Description                                                  |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ |
| [https://www.hdretrovision.com/blog/2018/10/22/engineering-csync-part-1-setting-the-stage](https://www.hdretrovision.com/blog/2018/10/22/engineering-csync-part-1-setting-the-stage)                             | Details on 240p60 mode, and simplified VSYNC.                |
| [https://www.eevblog.com/forum/beginners/ntsc-composite-timing-for-retroconsoles/msg3483262/#msg3483262](https://www.eevblog.com/forum/beginners/ntsc-composite-timing-for-retroconsoles/msg3483262/#msg3483262) | Details on how line length and colorburst interval interact. |
| [http://nerdlypleasures.blogspot.com/2013/09/the-overlooked-artifact-color.html](http://nerdlypleasures.blogspot.com/2013/09/the-overlooked-artifact-color.html)                                                 | Details on artifact color.                                   |
