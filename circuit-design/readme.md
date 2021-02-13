# [neomura/atmega328p-cartridge](../readme.md)/Circuit Design

| Link                                         | Description                        |
| -------------------------------------------- | ---------------------------------- |
| [How it works](./how-it-works/readme.md)     | Details on how this circuit works. |
| [cartridge.pro](./cartridge.pro)             | KiCAD project.                     |
| [cartridge.sch](./cartridge.sch)             | KiCAD schematic.                   |
| [cartridge.kicad_pcb](./cartridge.kicad_pcb) | KiCAD PCB layout.                  |

## Bill of materials

Links are included for reference only and are not endorsements.

| Reference   | Description                                                          | Model No.         | Link                                                                                                                                                                                                                                                                                                                                                           |
| ----------- | -------------------------------------------------------------------- | ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| J1          | Cartridge connector (two right-angled 1x6 2.54mm male pin headers)   | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=225_230&products_id=3128](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=225_230&products_id=3128)                                                                                                                                                                         |
| U1          | Microcontroller                                                      | ATMega328P-PU     | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=140_161_162&products_id=1225](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=140_161_162&products_id=1225)                                                                                                                                                                 |
| X1          | 14.31818MHz HC49 crystal                                             | CMACKD 0335       | [https://www.ebay.co.uk/itm/Crystal-14-31818MHZ-HC49-made-by-C-MAC-pack-of-10-Uk-stock-Z3798/293447907451?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2060353.m2749.l2649](https://www.ebay.co.uk/itm/Crystal-14-31818MHZ-HC49-made-by-C-MAC-pack-of-10-Uk-stock-Z3798/293447907451?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2060353.m2749.l2649)                     |
| R1          | 1M load resistor                                                     | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=480](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=480)                                                                                                                                                                         |
| C1/C2       | 22pF load capacitor                                                  | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=187](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=187)                                                                                                                                                                         |
| D1          | Reset protection diode                                               | 1N4148            | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=140_141_143&products_id=925](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=140_141_143&products_id=925)                                                                                                                                                                   |
| R2          | 4.7k reset pull-up resistor                                          | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=452](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=452)                                                                                                                                                                         |
| C3          | 100nF reset bypass capacitor                                         | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210)                                                                                                                                                                         |
| C4          | 100nF analog reference capacitor                                     | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210)                                                                                                                                                                         |
| C5          | 100nF +5V bypass capacitor                                           | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210)                                                                                                                                                                         |
| R3          | 470R video carrier resistor                                          | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=441](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=441)                                                                                                                                                                         |
| R4          | 1K video sync resistor                                               | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=445](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=445)                                                                                                                                                                         |
| R5          | 100K audio resistor                                                  | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=468](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=468)                                                                                                                                                                         |

### Possible substitutions

#### J1

Right-angled male pin headers appear to come in two distinct styles; one where the plastic retainer is in contact with the PCB, and one where it is instead in contact with the corresponding female socket.  This PCB is designed for the former, and the latter will not fit inside a cartridge shell.

#### U1

Other pin-compatible ATMega ICs may work.  Note that most will have smaller flash space and may not be able to store complex games.

#### X1/R1/C1/C2

Most 14.31818MHz crystals which are HC49 or smaller will work as long as appropriate bypass capacitors and resistor are included.  To be compatible with Arduinocade games instead of Neomura games, a 28.6363MHz crystal such as [https://www.aliexpress.com/item/32910067235.html?spm=a2g0s.9042311.0.0.5bfd4c4d3a2EOO](https://www.aliexpress.com/item/32910067235.html?spm=a2g0s.9042311.0.0.5bfd4c4d3a2EOO) may be used instead.

It may be possible to omit the load resistor.

#### D1

This diode is included to prevent accidental high-voltage programming.  It can be omitted.

#### C4

This capacitor is recommended for improving the noise levels of the ATMega328P-PU's analog-to-digital converter, but there are currently no plans to use it.  This component can be omitted.

## Assembly instructions

- Start by soldering J1.  I would recommend using some kind of clamp such as a crocodile clip to keep it firmly attached to the board (note that it will act as a heatsink, making soldering more difficult, if in contact with pins).  Use short bursts of high heat and allow time to cool between joints to avoid melting the plastic retainer.  After soldering, use a female socket to ensure that pins are straight, and use said female socket to correct the pins if not parallel with the PCB.
- Solder U1.  Note that the label will be upside down when oriented correctly.
- Solder X1, R1, C1, C2, D1, R2, C3, C4, C5, R3, R4 and R5.
- Place the PCB, logo up, into the back half of the shell.
- Place the front half of the shell on top and press fit.

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
