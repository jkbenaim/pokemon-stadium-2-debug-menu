target = usa.bin

sources = $(wildcard *.c)
objects = $(sources:.c=.o)
targetobj = $(target:.bin=.o)
linkscript = $(target:.bin=.ld)
CFLAGS=-Os -march=vr4300 -mabi=32 -Wno-multichar -Wall
CC=mips64-elf-gcc
LD=mips64-elf-ld

.PHONY: all
all: $(target)

.PHONY: clean
clean:
	rm -f $(objects) $(targetobj) $(target)

$(target): $(targetobj)
	mips64-elf-objcopy -O binary "$^" "$@"
	
$(targetobj): $(objects)
	$(LD) -o "$@" -T $(linkscript) $^
