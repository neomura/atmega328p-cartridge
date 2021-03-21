# [neomura/atmega328p-cartridge](../../readme.md)/[Documentation](../readme.md)/ATMega Feature Usage

This project derives from Arduinocade, so much of what this document describes is similar to Arduinocade.

## Video

The ATMega range has a number of hardware timers which can repeatedly count CPU cycles in the background while the program executes.  Most timers are 8-bit, but timer 1 is always 16-bit.  This timer is configured to count the number of CPU cycles on a NTSC line.

Each timer has 2 or more channels; each being a comparison value and either a GPIO pin which can be directly controlled by the timer, or an interrupt which can be raised to act upon it.

The first channel is used to produce the HSYNC and VSYNC pulses; it is configured to directly control a GPIO pin, with the comparison value changed to switch between the two signals.

The second channel is used to trigger an interrupt (which is where the above comparison value change is performed).  The colorburst and active video content are generated by serial output during this interrupt, which, at its maximum speed, can output 7.15909MBit/s.

The HSYNC/VSYNC pulse GPIO and serial output are combined using a resistor divider.

| Pin                    | ATMega328P | Arduino | Resistor |
| ---------------------- | ---------- | ------- | -------- |
| HSYNC/VSYNC pulse GPIO | PB1        | 9       | 1K       |
| Serial output          | PD1        | 1       | 470R     |

When the 75R input impedence of the receiving system is taken into account, this produces the following voltages, though, only approximately:

| HSYNC/VSYNC pulse GPIO | Serial output         | Voltage   | IRE       | Offset IRE |
| ---------------------- | --------------------- | --------- | --------- | ---------- |
| 0V                     | 0V                    | 0V        | 0         | -42        |
| 5V                     | 0V                    | 0.303748V | 42.52472  | 0.52472    |
| 0V                     | 5V                    | 0.646273V | 90.47822  | 48.47822   |
| 5V                     | 5V                    | 0.950022V | 133.00308 | 91.00308   |

This produces values offset by approximately 40 IRE.  This will, however, still work.

## Audio

An 8-bit timer is used to generate stereo audio; two channels are configured to directly control GPIO pins, which are then filtered through basic RC bandpasses based upon the Raspberry Pi's audio output circuitry.

The channels' comparison values are updated during the video interrupt, allowing for pulse width modulated audio.

## Pads

All pads are directly connected to GPIO:

| Cartridge pin | ATMega328P | Arduino |
| ------------- | ---------- | ------- |
| PAD_LATCH     | PC5        | A5      |
| PAD_CLOCK     | PC4        | A4      |
| PAD_DATA_0    | PC3        | A3      |
| PAD_DATA_1    | PC2        | A2      |
| PAD_DATA_2    | PC1        | A1      |
| PAD_DATA_3    | PC0        | A0      |

Internal pull-ups are enabled on the data input pins.

## References

| Link                                                                                                                                                                       | Description                                       |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| [https://github.com/rossumur/Arduinocade](https://github.com/rossumur/Arduinocade)                                                                                         | Arduinocade project, from which this was derived. |
| [https://hackaday.com/2018/07/13/behind-the-pin-how-the-raspberry-pi-gets-its-audio/](https://hackaday.com/2018/07/13/behind-the-pin-how-the-raspberry-pi-gets-its-audio/) | Schematics for the Raspberry Pi's audio output.   |