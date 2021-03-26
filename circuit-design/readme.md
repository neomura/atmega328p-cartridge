# [neomura/atmega328p-cartridge](../readme.md)/Circuit Design

| Link                                         | Description                        |
| -------------------------------------------- | ---------------------------------- |
| [cartridge.pro](./cartridge.pro)             | KiCAD project.                     |
| [cartridge.sch](./cartridge.sch)             | KiCAD schematic.                   |
| [cartridge.kicad_pcb](./cartridge.kicad_pcb) | KiCAD PCB layout.                  |

## Bill of materials

Links are included for reference only and are not endorsements.

| Reference   | Description                                                          | Model No.         | Link                                                                                                                                                                                               |
| ----------- | -------------------------------------------------------------------- | ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| J1          | Cartridge connector (right-angled 1x15 2.54mm male pin header)       | Unknown           | [https://www.aliexpress.com/item/4000660389713.html?spm=a2g0s.9042311.0.0.65b74c4dMpBmdG](https://www.aliexpress.com/item/4000660389713.html?spm=a2g0s.9042311.0.0.65b74c4dMpBmdG)                 |
| J2          | ICSP header (right-angled 2x3 2.54mm male pin header)                | Unknown           | [https://www.aliexpress.com/item/32863048486.html?spm=a2g0s.9042311.0.0.65b74c4dMpBmdG](https://www.aliexpress.com/item/32863048486.html?spm=a2g0s.9042311.0.0.65b74c4dMpBmdG)                     |
| U1          | Microcontroller                                                      | ATMega328P-PU     | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=140_161_162&products_id=1225](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=140_161_162&products_id=1225)     |
| X1          | 14.31818MHz (NTSC) or 17.734MHz (PAL 60) HC-49S crystal              | Unknown           | [https://www.aliexpress.com/item/32496964768.html?spm=a2g0s.9042311.0.0.65b74c4dMpBmdG](https://www.aliexpress.com/item/32496964768.html?spm=a2g0s.9042311.0.0.65b74c4dMpBmdG) or [https://www.ebay.co.uk/itm/20pcs-17-734MHz-HC-49S-Crystal-Oscillator-Passive-Quartz-Resonator/253056403948?_trkparms=aid%3D111001%26algo%3DREC.SEED%26ao%3D1%26asc%3D20160908105057%26meid%3D80fd100fd3114f5ba72a3c52a978bf7f%26pid%3D100675%26rk%3D1%26rkt%3D15%26mehot%3Dnone%26sd%3D253056403948%26itm%3D253056403948%26pmt%3D1%26noa%3D1%26pg%3D2380057%26brand%3DUnbranded&_trksid=p2380057.c100675.m4236&_trkparms=pageci%3Ae010b98a-7b73-11eb-b850-3214b911b9a1%7Cparentrq%3Af3c20fd51770a7b3a0b1a3e8fffcf90a%7Ciid%3A1](https://www.ebay.co.uk/itm/20pcs-17-734MHz-HC-49S-Crystal-Oscillator-Passive-Quartz-Resonator/253056403948?_trkparms=aid%3D111001%26algo%3DREC.SEED%26ao%3D1%26asc%3D20160908105057%26meid%3D80fd100fd3114f5ba72a3c52a978bf7f%26pid%3D100675%26rk%3D1%26rkt%3D15%26mehot%3Dnone%26sd%3D253056403948%26itm%3D253056403948%26pmt%3D1%26noa%3D1%26pg%3D2380057%26brand%3DUnbranded&_trksid=p2380057.c100675.m4236&_trkparms=pageci%3Ae010b98a-7b73-11eb-b850-3214b911b9a1%7Cparentrq%3Af3c20fd51770a7b3a0b1a3e8fffcf90a%7Ciid%3A1) |
| R1          | 1M load resistor                                                     | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=480](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=480)             |
| C1/C2       | 22pF load capacitor                                                  | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=187](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=187)             |
| D1          | Reset protection diode                                               | 1N4148            | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=140_141_143&products_id=925](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=140_141_143&products_id=925)       |
| R2          | 4.7k reset pull-up resistor                                          | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=452](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=452)             |
| C3          | 100nF reset bypass capacitor                                         | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210)             |
| C4          | 100nF +5V bypass capacitor                                           | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=210)             |
| R3          | 470R video carrier resistor                                          | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=441](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=441)             |
| R4          | 1K video sync resistor                                               | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=445](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=445)             |
| R5/R7       | 270R audio low-pass resistor                                         | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=438](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=438)             |
| C5/C7       | 33nF audio low-pass capacitor                                        | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=208](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=65_75_67&products_id=208)             |
| R6/R8       | 150R audio output resistor                                           | Unknown           | [https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=435](https://www.bitsbox.co.uk/index.php?main_page=product_info&cPath=83_84_85&products_id=435)             |
| C6/C8       | 10uF audio output capacitor                                          | Unknown           | [https://www.amazon.co.uk/gp/product/B08D647KCD/ref=ppx_yo_dt_b_asin_title_o00_s00?ie=UTF8&psc=1](https://www.amazon.co.uk/gp/product/B08D647KCD/ref=ppx_yo_dt_b_asin_title_o00_s00?ie=UTF8&psc=1) |

### Possible substitutions

#### J1

Right-angled male pin headers appear to come in two distinct styles; one where the plastic retainer is in contact with the PCB, and one where it is instead in contact with the corresponding female socket.  This PCB is designed for the latter, and the former will not fit inside a cartridge shell.

#### J2

Non right-angled pin headers will work if they do not have to fit in a cartridge shell.

#### U1

Other pin-compatible ATMega ICs may work.  Note that most will have smaller flash space and may not be able to store complex games.

#### X1/R1/C1/C2

Most 14.31818MHz crystals which are HC49 or smaller will work as long as appropriate bypass capacitors and resistor are included.  To be compatible with Arduinocade games instead of Neomura games, a 28.6363MHz crystal such as [https://www.aliexpress.com/item/32910067235.html?spm=a2g0s.9042311.0.0.5bfd4c4d3a2EOO](https://www.aliexpress.com/item/32910067235.html?spm=a2g0s.9042311.0.0.5bfd4c4d3a2EOO) may be used instead.

It may be possible to omit the load resistor.

#### D1

This diode is included to prevent accidental high-voltage programming.  It can be omitted.

## Assembly instructions

- Start by soldering J1 and J2.  I would recommend using some kind of clamp such as a crocodile clip to keep it firmly attached to the board (note that it will act as a heatsink, making soldering more difficult, if in contact with pins).  Use short bursts of high heat and allow time to cool between joints to avoid melting the plastic retainer.  After soldering, use a female socket to ensure that pins are straight, and use said female socket to correct the pins if not parallel with the PCB.
- Solder all other components.  There is not much room inside the shell once constructed, so ensure that these are as close to the board top as possible and that leads are clipped shore.
- Place the PCB, logo up, into the back half of the shell.
- Place the front half of the shell on top and press fit.

### Program

J2 is a standard 2x3 ICSP header.

```
               .-----.
Right 4 (MISO) | O O | Right 2 (VCC)
Right 3 (SCK)   |O O | Right 5 (MOSI)
Right 6 (RST)  | O O | Right 1 (GND)
               '-----'
```

If using an [Arduino as an ISP](https://www.arduino.cc/en/Tutorial/BuiltInExamples/ArduinoISP), connect the following pins (where the Arduino has multiple pins labelled the same, any will work):

| Arduino | ICSP  |
| ------- | ----- |
| GND     | GND.  |
| 5V      | VCC.  |
| 13      | SCK.  |
| 12      | MISO. |
| 11      | MOSI. |
| 10      | RST.  |

In either case, **do not use both J1 and J2 to power the cartridge**.  This may damage the cartridge, your programmer, the console, or all of them.  Most programmers include a jumper which can be used to disable their VCC line, such as J3 with a USBtiny.

#### Set fuse bits

By default, an ATMega328P will use its internal 8MHz clock rather than an external crystal.  To configure this, use [AVRDUDE](https://www.nongnu.org/avrdude/) to set the correct fuse bits:

```shell
avrdude -pM328P -Ulfuse:w:0xf7:m -Uhfuse:w:0xde:m -Uefuse:w:0xfd:m
```

Note that you will need to add command line arguments to this to specify which programmer you are using, for example:

| Programmer                                 | Suffix                         |
| ------------------------------------------ | ------------------------------ |
| USBtiny                                    | -cusbtiny                      |
| Arduino as ISP on COM port 3 under Windows | -cavrisp -b 19200 -Pcom3       |
| Arduino as ISP on COM port 3 under Linux   | -cavrisp -b 19200 -P/dev/ttyS3 |

If you are running AVRDUDE under Windows Subsystem for Linux, you may find that the remapped COM ports do not work.  In these instances, running AVRDUDE under Windows at least once seems to resolve this.

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
| [https://www.avrfreaks.net/forum/unable-reset-fuses-atmega328p](https://www.avrfreaks.net/forum/unable-reset-fuses-atmega328p)                           | Workaround for AVRDUDE problem.        |
| [https://www.ladyada.net/learn/avr/avrdude.html](https://www.ladyada.net/learn/avr/avrdude.html)                                                         | AVRDUDE instructions.                  |
