load_fragment		= 0x800047d8;
run_code_fragment	= 0x80065748;
enter_unit		= 0x80002b34;
exit_unit		= 0x80002be8;
update_gamemode		= 0x8006585c;
switch_song		= 0x800354e4;
get_is_gbpak_connected	= 0x8005dee0;
draw_text		= 0x80009060;
big_unused_function	= 0x8007bcd0;

osPiReadIo		= 0x80078900;
osPiWriteIo		= 0x800841f0;

ENTRY(_start);

MEMORY
{
	big_unused_function (rwx) : ORIGIN = 0x8007bcd0, LENGTH = 0x8007c6e0-0x8007bcd0
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
