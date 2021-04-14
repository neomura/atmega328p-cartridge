# [neomura/atmega328p-cartridge](../../readme.md)/[Documentation](../readme.md)/PAL 60

PAL 60 is a hybrid of NTSC and PAL video, using the refresh rate and resolution of NTSC with the color system of PAL; the color sine wave's frequency is increased to 4.43361875MHz and the color sine's phase offset alternates every second line.

During alternate lines, the colorburst is delayed 90°, and the active video section's sine wave is offset 180°.

The advantage of this approach is that it retains the exact resolution and timing properties of NTSC, for easy game compatibility.
