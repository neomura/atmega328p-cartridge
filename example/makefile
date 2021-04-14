ENGINE_ASSEMBLY_FILES=$(shell find ../engine -type f -iname "*.asm")
GAME_VIDEO_STANDARDS=ntsc pal-60
GAME_ASSEMBLY_FILES=$(shell find . -type f -iname "*.asm")

all: $(addsuffix .hex, $(GAME_VIDEO_STANDARDS))

%.hex: $(ENGINE_ASSEMBLY_FILES) $(GAME_ASSEMBLY_FILES) makefile
	avra -o $@ ../engine/engine/main.asm --includedir ../engine --define $(shell echo $(basename $@) | tr [:lower:] [:upper:] | tr - _)

deploy-%: %.hex
	avrdude -p M328p -c avrisp -b 19200 -P /dev/ttyS3 -U flash:w:$*.hex

clean:
	rm -f ../engine/engine/*.eep.hex ../engine/engine/*.obj *.hex
