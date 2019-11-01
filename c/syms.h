#ifndef _SYMS_H_
#define _SYMS_H_

#include "data.h"

extern int run_code_fragment(int, int, int, int, int);
extern void *load_fragment(int, int, int);
extern void enter_unit(int);
extern void exit_unit(int);
extern void update_gamemode(enum gamemode_e);
extern void switch_song(int new_song);
extern int get_is_gbpak_connected(void);
extern void draw_text(int x, int y, char *string, ...);
extern int osPiWriteIo(unsigned int devAddr, unsigned int data);
extern int osPiReadIo(unsigned int devAddr, unsigned int *data);

#endif
