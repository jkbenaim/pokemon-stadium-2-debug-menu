// pokeymans trainer, wip
// 2019 jrra

constant japanese(0)

arch n64.cpu
endian msb
include "n64.inc"
output "out.z64", create

origin 0x0
if (japanese) {
	insert "np3j0.z64"
} else {
	insert "np3e0.z64"
}

if (japanese) {
	constant	run_code_fragment(0x80065748)
	constant	big_unused_function(0x8007bcd0)
	constant	mode_options(0x800658a4)
} else {
	constant	update_gamemode(0x80064dfc)
	constant	gbemu_init(0x80065f50)
	constant	calls_calls_graph(0x80008574)
	constant	Verify_IPL3(0x80064c20)
	constant	Verify_IPL3_end(0x80064c88)
	constant	title_select_next_mode(0x800657b0)
	constant	unit_dbug(0x80065220)
	constant	run_code_fragment(0x80064ce8)
	constant	osPiReadIo(0x80077020)
	constant	__osPiRawReadIo(0x80078380)
	constant	osSetIntMask(0x80073e20)
	constant	main_loop(0x80064fb0)
	constant	unit_GAME(0x80064ed0)
	constant	load_fragment(0x800047f8)
	constant	mode_debugger(0x800354b4)
	constant	unit_loop(0x80065a18)
	constant	reset_menu_system(0x800355d4)
	constant	mode_init(0x80065b20)
	constant	unit_gbch(0x80065bb0)
	constant	create_some_object(0x800082e0)
	constant	configure_debug_stuff(0x80007ba8)
	constant	enter_unit(0x80002b44)
	constant	exit_unit(0x80002bf8)
	constant	big_unused_function(0x8007a8a4)
	constant	switch_menu(0x800355e4)
	constant	mode_options(0x80064e44)
}

constant	gamemode_title(1)
constant	gamemode_mainselect(2)
constant	gamemode_whitecity(3)
constant	gamemode_gbemu(4)
constant	gamemode_oakslab(5)
constant	gamemode_class(6)
constant	gamemode_bedroom(7)
constant	gamemode_stadium(8)
constant	gamemode_castle(9)
constant	gamemode_minigames(10)
constant	gamemode_options(11)
constant	gamemode_crash12(12)
constant	gamemode_eventbattle(13)
constant	gamemode_battlenow(14)
constant	gamemode_vsrival(15)
constant	gamemode_freebattle(16)
constant	gamemode_init(17)
constant	gamemode_mainselect18(18)
constant	gamemode_mysterygift(19)
constant	gamemode_dbsl(20)

seek(big_unused_function)
mode_dbsl:
if (japanese) {
	insert "c/jap.bin"
} else {
	insert "c/usa.bin"
}

// patch to add another gamemode to main_loop.
if (0) {
seek(main_loop+0x20)
sltiu at, t6, 0x14
seek(0x800a541c)	// end of jump table
dw 0x800651f4
seek(0x800651f4)	// space for extra mode
jal mode_dbsl
addiu a0, zero, 0
b 0x80064fec
nop
}

// patches mode_init to send us somewhere else after the title card
if (0) {
seek(mode_init)

addiu sp, -32
sw ra, 28(sp)
ori a0, zero, 47
li a1, 0x10cf70
li a2, (0x10cf70 + 0x500)
move a3, zero
sw zero, 16(sp)
jal run_code_fragment
nop

jal update_gamemode
addiu a0, zero, gamemode_title
lw ra, 28(sp)
addiu sp, 32
jr ra
nop
}

// patches mode_options to send us somewhere else after options
seek(mode_options+0x68)
//addiu a0, zero, gamemode_dbsl

seek(mode_options)
j mode_dbsl
nop
//addiu a0, zero, 0

// patches jpt in unit_gbch (mainselect menu) to add another option
//seek(0x800a548c)
//dw 0x80000000
//seek(unit_gbch+0xd4)
//sltiu at, t9, 8

//seek(unit_dbug+0x1e8)
// low byte: game
//	0 = gray?
//	1 = red
//	2 = green
//	3 = blue
//	4 = yellow
//	5 = gold
//	6 = silver
//	7 = crystal
//ori a3, zero, 1
// pokemon number.
// number 201 is unown-A,
// other unowns are 254-278.
// 279 = pikachu?
// >=280 = garbage
//ori at, zero, 25
//jal run_code_fragment
//sw at, 0x10(sp)
//b 0x80065798
//lui a0, 0x6462

if (1) {
constant	vi_mode_table(0x800871d4)
seek(vi_mode_table)
db	OS_VI_PAL_LPN1
db	OS_VI_PAL_LAN1
db	OS_VI_PAL_HPF1
db	OS_VI_PAL_HAF1
db	OS_VI_NTSC_LPN1
db	OS_VI_NTSC_LPN1
db	OS_VI_NTSC_HPN1
db	OS_VI_NTSC_HPN1
db	OS_VI_MPAL_LPN1
db	OS_VI_MPAL_LAN1
db	OS_VI_MPAL_HPF1
db	OS_VI_MPAL_HAF1
db	OS_VI_FPAL_LPN1
db	OS_VI_FPAL_LAN1
db	OS_VI_FPAL_HPF1
db	OS_VI_FPAL_HAF1
}

constant	os_vi_scale_something(0x80084a50)
seek(os_vi_scale_something+0x1c)
if (1) {
lui at, 0x3f80
addiu a0, v0, 0
sw at, 0x24(t6)
}

// gbem x-scaling
if (1) {
origin 0x15b5e40
dw 0x3f800000
dw 0x3f800000
dw 0x3f800000
dw 0x3f800000
dw 0x3f800000
dw 0x3f800000
dw 0x3f800000
}

constant	get_setting(0x8006d268)
seek(get_setting)
if (0) {
ori v0, zero, 0xffff
jr ra
nop
}

// enable debug menu on titl
if (0) {
origin 0xde4+0x10d470
ori t0, zero, 1
origin 0xe08+0x10d470
sw t0, 0x1ec4(at)
}

