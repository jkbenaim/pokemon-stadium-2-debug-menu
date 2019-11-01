// fragments we don't use are commented out, to save space

struct {
	int num;
	unsigned int start;
	unsigned int end;
} frags[] = {
#ifdef japanese
	{112,0x167040,0x16e4d0},
	{122,0x1dae70,0x1dcd60},
	{124,0x1e39e0,0x1e58e0},
	{125,0x1e58e0,0x1e6570},
	{224,0x3570f0,0x357c00},
	{225,0x357c00,0x35cab0},
	{226,0x35cab0,0x35d510},
	{227,0x35d510,0x35e8a0},
	{228,0x35e8a0,0x3614a0},
	{229,0x3614a0,0x3621a0},
	{230,0x3621a0,0x363110},
	{231,0x365400,0x367cd0},
	{232,0x367cd0,0x36d110},
	{233,0x36d110,0x36ec10},
	{234,0x363110,0x365400},
	{235,0xd19d0,0xd6180},
	{236,0x42dfe0,0x430f40},
	{237,0x430f40,0x4335a0},
	{238,0x166ec0,0x167040},
#else
//	{0,0x15e8b0,0x165c50},
//	{1,0x165c50,0x165ec0},
//	{3,0xf8190,0x10cf70},
//	{4,0xe5310,0xee080},
//	{5,0x15877a0,0x15b9b60},
//	{6,0xd7ba0,0xe5310},
//	{7,0x120260,0x1210e0},
//	{8,0xae5e0,0xb4d90},
//	{9,0xad260,0xadca0},
//	{10,0xadca0,0xae5e0},
//	{11,0x435a70,0x436c20},
//	{12,0x436c20,0x437610},
//	{16,0x10d470,0x10f9c0},
//	{17,0x15a040,0x15e8b0},
//	{18,0x10f9c0,0x120260},
//	{19,0x1210e0,0x1280d0},
//	{20,0xee080,0xf8190},
//	{21,0x13ff80,0x14a2c0},
//	{22,0x1280d0,0x13ff80},
//	{23,0x14a2c0,0x14df30},
//	{24,0xd4c30,0xd7ba0},
//	{25,0x33cb00,0x357d20},
//	{26,0x14df30,0x14fe00},
//	{27,0x14fe00,0x15a040},
//	{28,0x429850,0x42f160},
//	{29,0x420e80,0x429850},
//	{30,0x3365f0,0x33cb00},
//	{31,0xcc6b0,0xd0480},
//	{32,0xba230,0xcc6b0},
//	{33,0xb5da0,0xba230},
//	{34,0xb4d90,0xb5da0},
//	{35,0x2bb830,0x2c8410},
//	{36,0x2c8410,0x2cd3b0},
//	{37,0xa8a80,0xad260},
//	{47,0x10cf70,0x10d470},
//	{49,0x36f890,0x419480},
//	{50,0x419480,0x41d750},
//	{51,0x41d750,0x420e80},
//	{52,0x434720,0x435a70},
//	{80,0x246620,0x256000},
//	{81,0x25a670,0x266a40},
//	{82,0x266a40,0x275e20},
//	{83,0x275e20,0x27e4c0},
//	{84,0x27e4c0,0x2894b0},
//	{85,0x2894b0,0x299920},
//	{86,0x299920,0x2a24e0},
//	{87,0x2a24e0,0x2b1540},
//	{88,0x2b1540,0x2bb830},
//	{89,0x2cd3b0,0x2e1080},
//	{90,0x2e1080,0x2f2f50},
//	{91,0x2f2f50,0x303510},
//	{92,0x303510,0x303970},
//	{108,0x256000,0x25a670},
//	{109,0x335dc0,0x3365f0},
//	{110,0x303970,0x322c70},
//	{111,0x322c70,0x335dc0},
	{112,0x166040,0x16d4d0},
//	{113,0x16d4d0,0x173280},
//	{114,0x173280,0x1b1310},
//	{115,0x1b1310,0x1bbbc0},
//	{116,0x1bbbc0,0x1bd610},
//	{117,0x1bd610,0x1ccc00},
//	{118,0x1ccc00,0x1ce9f0},
//	{119,0x1ce9f0,0x1d0960},
//	{120,0x1d0960,0x1d55f0},
//	{121,0x1d55f0,0x1da2e0},
	{122,0x1da2e0,0x1dc1d0},
//	{123,0x1dc1d0,0x1e2e90},
	{124,0x1e2e90,0x1e4d70},
	{125,0x1e4d70,0x1e59f0},
//	{155,0x225180,0x23c2e0},
//	{156,0x1e59f0,0x1ee270},
//	{158,0x23c2e0,0x246620},
//	{159,0x1ee270,0x225180},
	{224,0x357d20,0x358830},
	{225,0x358830,0x35dd90},
	{226,0x35dd90,0x35e900},
	{227,0x35e900,0x35fc90},
	{228,0x35fc90,0x362890},
	{229,0x362890,0x363590},
	{230,0x363590,0x364500},
	{231,0x3667f0,0x3690c0},
	{232,0x3690c0,0x36dd90},
	{233,0x36dd90,0x36f890},
	{234,0x364500,0x3667f0},
	{235,0xd0480,0xd4c30},
	{236,0x42f160,0x4320c0},
	{237,0x4320c0,0x434720},
	{238,0x165ec0,0x166040},
#endif
	{-1,0,0},
};
