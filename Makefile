# Set the compiler
CC=arm-none-eabi-gcc
OC=arm-none-eabi-objcopy
FIX=gbafix

# Set the flags
CFLAGS=-Os -fomit-frame-pointer -fdata-sections -ffunction-sections -mcpu=arm7tdmi -nostartfiles 
CFLAGS+= -mthumb -mno-tpcs-frame -mthumb-interwork -DCARTRIDGE_RELEASE

LDFLAGS = -Wl,--as-needed -Wl,--gc-sections -s

# Set the source and output files
SOURCES=crt0.s main.c gbalib.c title.c game.c oldman.c oldman2.c bar.c white.c
OUTFILE=game.out
BINFILE=game.gba

# Set the linker script
LNKSCRIPT=lnkscript

all: $(BINFILE)

$(BINFILE): $(OUTFILE)
	$(OC) -O binary $< $@
	$(FIX) $@
	
$(OUTFILE): $(SOURCES)
	$(CC) $^ -T$(LNKSCRIPT) $(CFLAGS) -o $@ $(LDFLAGS)

.PHONY: clean

clean:
	rm -f $(OUTFILE) $(BINFILE) *.raw *.o
