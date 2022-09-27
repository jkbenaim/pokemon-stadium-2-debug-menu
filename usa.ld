load_fragment		= 0x800047f8;
run_code_fragment	= 0x80064ce8;
enter_unit		= 0x80002b44;
exit_unit		= 0x80002bf8;
update_gamemode		= 0x80064dfc;
switch_song		= 0x800355e4;
get_is_gbpak_connected	= 0x8005d8c0;
draw_text		= 0x80009094;
big_unused_function	= 0x8007a8a4;

osPiReadIo		= 0x80077020;
osPiWriteIo		= 0x80082910;

ENTRY(_start);

MEMORY
{
	big_unused_function (rwx) : ORIGIN = 0x8007a8a4, LENGTH = 0x8007ae00-0x8007a8a4
}

SECTIONS
{
	. = big_unused_function;
	.start : {
		*(.start)
	}
	payload : {
		*(.text)
		*(.data)
		*(.bss)
	}
}
