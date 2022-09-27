#include <stdbool.h>
#include "data.h"
#include "syms.h"

struct fraginfo {
	unsigned char num;
	unsigned char needs_gbpak;
} f[] = {
	{.num = 0,	.needs_gbpak = false},
	{.num = 225,	.needs_gbpak = false},	// model viewer
	{.num = 226,	.needs_gbpak = false},	// screen viewer
	{.num = 232,	.needs_gbpak = false},	// pokemon editor
	{.num = 233,	.needs_gbpak = true},	// gb-sram editor
	{.num = 234,	.needs_gbpak = false},	// ogawanoyu
	{.num = 231,	.needs_gbpak = false},	// ai editor
	{.num = 227,	.needs_gbpak = false},	// back up editor
	{.num = 228,	.needs_gbpak = false},	// creating icon
	{.num = 229,	.needs_gbpak = false},	// music room
	{.num = 230,	.needs_gbpak = false},	// trainer viewer
	{.num = 235,	.needs_gbpak = false},	// creating registrate pokemon
	{.num = 236,	.needs_gbpak = false},	// creating vs
	{.num = 237,	.needs_gbpak = false},	// message debug
	{.num = 0,	.needs_gbpak = false},	// room of legend TODO
	{.num = 124,	.needs_gbpak = false},	// clock editor
	{.num = 125,	.needs_gbpak = true},	// item editor

};

#define UDEV_ADDR_BASE		(0x18000000)
#define UDEV_ADDR_STATUS	(UDEV_ADDR_BASE + 0x0200)
#define UDEV_ADDR_COMMAND	(UDEV_ADDR_BASE + 0x0208)
#define UDEV_ADDR_MAGIC		(UDEV_ADDR_BASE + 0x02ec)

bool udev_is64drive() 
{
	unsigned int magic;
	osPiReadIo(UDEV_ADDR_MAGIC, &magic);
	return magic == 'UDEV';
}

void udev_allow_rom_writes(bool allow)
{
	unsigned int status;
	do {
		osPiReadIo(UDEV_ADDR_STATUS, &status);
		status &= 0x1000;
	} while (status != 0);
	
	const unsigned int enable = 0xf0;
	const unsigned int disable = 0xf1;

	osPiWriteIo(UDEV_ADDR_COMMAND, allow?enable:disable);
}

int __attribute__((short_call)) getfrag(int num)
{
	int idx = 0;
	while ( (frags[idx].num != num) && (frags[idx].num != -1) ) {
		idx++;
	}

	if (frags[idx].num == -1)
		return -1;
	return idx;
}

void * __attribute__((short_call)) loadfrag(int num)
{
	int idx = getfrag(num);
	return load_fragment(
		frags[idx].num,
		frags[idx].start,
		frags[idx].end
	);
}

int __attribute__((short_call)) runfrag(int num, int arg1, int arg2)
{
	int idx = getfrag(num);
	int rc = run_code_fragment(
		frags[idx].num,
		frags[idx].start,
		frags[idx].end,
		arg1,
		arg2
	);

	return rc;
	
}

bool is_gbpak1_connected(void)
{
	int rc;
	rc = get_is_gbpak_connected();
	return rc & 1;
}

struct __attribute__((packed)) csel_params {
	short bg;
	short unused;
	int config;
};

/*
int __attribute__((short_call)) csel(int param1, struct csel_params param2)
{
	int rc;
	enter_unit('CSEL');
	loadfrag(6);
	loadfrag(8);
	rc = runfrag(24, param1, (int)&param2);
	exit_unit('CSEL');
	return rc;
}
*/

const char version[] = "debug menu patch np3e0-v1";
const char creds[] = "jrra 2019";
const char ad[] = "find me on efnet in #n64dev";
const char greets[] = "s/o to mikeryan, nico, marshallh, marathonman, hcs, zoinkity, emu_kidid";

void __attribute__((short_call)) mode_dbsl(void)
{
	__label__ quit, loop;
	int rc = 0;

loop:
	switch_song(41);
	enter_unit('dbsl');
	rc = runfrag(224, rc, 0);
	exit_unit('dbsl');


	switch (rc) {
	case 0:
		goto quit;
		break;
	case 1 ... 15:
		if (!f[rc].num) break;
		if (f[rc].needs_gbpak && !is_gbpak1_connected()) break;
		if (udev_is64drive())
			udev_allow_rom_writes(true);
		runfrag(f[rc].num, 0, 0);
		if (udev_is64drive())
			udev_allow_rom_writes(false);
		break;
	case 16: // item editor
	{
		if (!is_gbpak1_connected()) break;
		enter_unit('item');
		loadfrag(112);
		loadfrag(122);
		runfrag(125, 0, 0);
		exit_unit('item');
	}
		break;
	default:
		break;
	}
	goto loop;

quit:
	// exit
	update_gamemode(GAMEMODE_MAINSELECT);
	return;
}

void __attribute__((section(".start"))) _start(int mode)
{
	mode_dbsl();
}

