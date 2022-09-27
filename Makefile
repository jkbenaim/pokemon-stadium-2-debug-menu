targets := usa.z64 jap.z64

sources = $(wildcard *.c)
objects = $(sources:.c=.o)
CFLAGS=-Os -march=vr4300 -mabi=32 -Wno-multichar -Wall
CC=mips64-elf-gcc
LD=mips64-elf-ld

.PHONY: all
all: $(targets)

.PHONY: clean
clean:
	rm -f $(objects) $(targets) usa.o usa.bin jap.o jap.bin patch.usa.o data.usa.o patch.jap.o data.jap.o romjudge bass np3e0.vcdiff np3j0.vcdiff
	$(MAKE) -C external/bass clean
	$(MAKE) -C external/romjudge clean

patch.usa.o: $(sources)
	$(CC) $(CFLAGS) -DREGION=0 -c -o patch.usa.o patch.c

data.usa.o: $(sources)
	$(CC) $(CFLAGS) -DREGION=0 -c -o data.usa.o data.c

usa.o: patch.usa.o data.usa.o
	$(LD) -o "$@" -T usa.ld $^

usa.bin: usa.o
	mips64-elf-objcopy -O binary $^ $@
	
usa.z64: patch.asm usa.bin bass romjudge
	./bass -c REGION=0 $<
	./romjudge -f $@

patch.jap.o: $(sources)
	$(CC) $(CFLAGS) -DREGION=1 -c -o patch.jap.o patch.c

data.jap.o: $(sources)
	$(CC) $(CFLAGS) -DREGION=1 -c -o data.jap.o data.c

jap.o: patch.jap.o data.jap.o
	$(LD) -o "$@" -T jap.ld $^

jap.bin: jap.o
	mips64-elf-objcopy -O binary $^ $@
	
jap.z64: patch.asm jap.bin bass romjudge
	./bass -c REGION=1 $<
	./romjudge -f $@

.PHONY: patches
patches: usa.z64 jap.z64
	xdelta3 -f -s np3e0.z64 usa.z64 np3e0.vcdiff
	xdelta3 -f -s np3j0.z64 jap.z64 np3j0.vcdiff

bass:
	$(MAKE) -C external/bass
	mv external/bass/bass .

romjudge:
	$(MAKE) -C external/romjudge
	mv external/romjudge/romjudge .
