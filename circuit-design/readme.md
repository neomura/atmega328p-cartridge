# [neomura/atmega328p-cartridge](../readme.md)/Circuit Design

## Bill of materials

TODO

## Assembly instructions

TODO

### Potential pitfalls

The ATMega328P-PU's labelling will be upside down relative to the board when oriented correctly.

### Program

A standard ICSP programmer can be attached to the following pins when looking from the front of the cartridge, so the back of the PCB:

| Cartridge pin | ICSP pin                                                        |
| ------------- | --------------------------------------------------------------- |
| Left 1        | Do not connect.                                                 |
| Left 2        | Do not connect.                                                 |
| Left 3        | Do not connect.                                                 |
| Left 4        | Do not connect.                                                 |
| Left 5        | Do not connect.                                                 |
| Left 6        | Do not connect.                                                 |
| Right 1       | GND.                                                            |
| Right 2       | VCC.                                                            |
| Right 3       | SCK.                                                            |
| Right 4       | MISO.                                                           |
| Right 5       | MOSI.                                                           |
| Right 6       | RST.                                                            |

These correspond to the following on a 2x3 ICSP header when viewed from above:

```
               *
               .-----.
Right 4 (MISO) | O O | Right 2 (VCC)
Right 3 (SCK)   |O O | Right 5 (MOSI)
Right 6 (RST)  | O O | Right 1 (GND)
               '-----'
```

And to the following on a 2x5 ICSP header when viewed from above:

```
               *
               .-----.
Right 5 (MOSI) | O O | Right 2 (VCC)
               | O O | Right 1 (GND)
Right 6 (RST)   |O O |
Right 3 (SCK)  | O O |
Right 4 (MISO) | O O |
               '-----'
```

If using an [Arduino as an ISP](https://www.arduino.cc/en/Tutorial/BuiltInExamples/ArduinoISP), connect the following pins (where the Arduino has multiple pins labelled the same, any will work):

| Cartridge pin | Arduino pin | Description |
| ------------- | ----------- | ----------- |
| Right 1       | GND         | GND.        |
| Right 2       | 5V          | VCC.        |
| Right 3       | 13          | SCK.        |
| Right 4       | 12          | MISO.       |
| Right 5       | 11          | MOSI.       |
| Right 6       | 10          | RST.        |

#### Set fuse bits

By default, an ATMega328P will use its internal 8MHz clock rather than an external crystal.  To configure this, use [AVRDUDE](https://www.nongnu.org/avrdude/) to set the correct fuse bits:

```shell
avrdude -pM328P -Ulfuse:w:0xff:m -Uhfuse:w:0xde:m -Uefuse:w:0x05:m
```

Note that you will need to add command line arguments to this to specify which programmer you are using, for example:

| Programmer                                 | Suffix                   |
| ------------------------------------------ | ------------------------ |
| USBtiny                                    | -cusbtiny                |
| Arduino as ISP on COM port 3 under Windows | -cavrisp -Pcom3          |
| Arduino as ISP on COM port 3 under Linux   | -cavrisp /dev/ttyS3      |

#### Flash

Next, write a program to flash.  Make sure that a .hex file to write exists in the current working directory, then execute:

```shell
avrdude -pM328P -Uflash:w:name-of-your-hex-file.hex
```

As before, you will need to add command line arguments to specify the correct programmer.

After following these steps, you should be able to connect the video pin (cartridge left 1) to the composite video input on a NTSC-compatible display and see a picture.

## References

| Link                                                                                                                                                     | Description                            |
| -------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| [https://www.instructables.com/Adding-ICSP-header-to-your-ArduinoAVR-board/](https://www.instructables.com/Adding-ICSP-header-to-your-ArduinoAVR-board/) | Source for ICSP header layout.         |
| [https://www.arduino.cc/en/Tutorial/BuiltInExamples/ArduinoISP](https://www.arduino.cc/en/Tutorial/BuiltInExamples/ArduinoISP)                           | Details on using an Arduino as an ISP. |
| [https://forum.arduino.cc/index.php?topic=71580.0](https://forum.arduino.cc/index.php?topic=71580.0)                                                     | Source for default Arduino fuses.      |
| [https://www.ladyada.net/learn/avr/avrdude.html](https://www.ladyada.net/learn/avr/avrdude.html)                                                         | AVRDUDE instructions.                  |
