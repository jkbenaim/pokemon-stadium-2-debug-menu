target = usa.bin

.PHONY: upload-partial
upload-partial: out.z64
	64drive -v -c 103 -z 2097152 -l $<

.PHONY: upload-full
upload-full: out.z64
	64drive -v -c 103 -l $<

.PHONY: clean
clean:
	rm -f out.z64

out.z64: patch.asm c/$(target)
	bass -sym syms.map $<
	romjudge -f $@

c/$(target):
	make -C c $(target)

patch.vcdiff: out.z64 np3e0.z64
	xdelta3 -f -s np3e0.z64 out.z64 patch.vcdiff
