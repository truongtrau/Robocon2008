	.DEF _SoLanQuaVachNgang=R4
	.DEF _vt=R6
_3:
	.DB  0x21,0x0
	.DEF _vp=R8
_4:
	.DB  0x21,0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x06
	.DW  _3*2

	.DW  0x02
	.DW  0x08
	.DW  _4*2

	.DW  0
