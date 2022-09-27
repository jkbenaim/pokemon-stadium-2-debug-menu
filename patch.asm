// pokeymans trainer, wip
// 2019 jrra

arch n64.cpu
endian msb
include "n64.inc"

origin 0x0
if (REGION==1) {
	output "jap.z64", create
	insert "np3j0.z64"
	constant	run_code_fragment(0x80065748)
	constant	big_unused_function(0x8007bcd0)
	constant	mode_options(0x800658a4)
} else {
	output "usa.z64", create
	insert "np3e0.z64"
	constant	run_code_fragment(0x80064ce8)
	constant	big_unused_function(0x8007a8a4)
	constant	mode_options(0x80064e44)
}

constant	gamemode_title(1)

seek(big_unused_function)
mode_dbsl:
if (REGION==1) {
	insert "jap.bin"
} else {
	insert "usa.bin"
}

seek(mode_options)
j mode_dbsl
nop


