;CodeVisionAVR C Compiler V1.24.4a Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;e-mail:office@hpinfotech.com

;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 12.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Automatic register allocation : On

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@2,@0+@1
	.ENDM

	.MACRO __GETWRMN
	LDS  R@2,@0+@1
	LDS  R@3,@0+@1+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM


	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM


	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM


	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "AUT.vec"
	.INCLUDE "AUT.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,0x60
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x160)
	LDI  R29,HIGH(0x160)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160
;       1 
;       2 /*
;       3 Project :  ROBOCON PUNE INDIA 2008         
;       4 Version :          2008
;       5 Date    : 1/28/2008
;       6 Author  : Tran Van Truong-Le Hong Lien                
;       7 Company :        IT-POWER   
;       8 Comments:     
;       9 Chip type           : ATmega16
;      10 Program type        : Application
;      11 Clock frequency     : 12.000000 MHz
;      12 Memory model        : Small
;      13 */
;      14 #include <mega16.h>  
;      15 //CAC HANG SO  
;      16 #define Tien            1
;      17 #define Start           1
;      18 #define Stop            0    
;      19 #define Lui 		1
;      20 #define Vach 		1
;      21 #define Nen 		0
;      22 #define Dung 		0
;      23 #define   Len  		1 
;      24 #define   Xuong 	1 
;      25 #define   Ra  		1 
;      26 #define   Vao  		1         
;      27 //Do rong xung-thay doi toc do dong co  
;      28 #define   VanTocTrai  OCR2
;      29 #define   VanTocPhai  OCR0
;      30 //So vach ngang
;      31 int SoLanQuaVachNgang;                         
;      32 //=>> Giam min trai -> giam max trai 
;      33 
;      34 #define intTraiMin         21//20.5//17//15//23.6//22//129//Dinh muc trai 22.6   
;      35 #define intTraiTrungBinh   33.5//31//29//172      
;      36 #define intTraiMax         43//43//43//255      
;      37 #define intCuaTrai         17.5//17//15.5//13.5//11.5//10.5//8.5//20.5//22//129
;      38 #define stTrai             9.5//11//9
;      39 //---------------------------------------------
;      40 #define intPhaiMin         20//18//16//22.8//22.7//20.3//17//13//17//20.5//22//129//Dinh muc phai 17.
;      41 #define intPhaiTrungBinh   33//31//29//172 
;      42 #define intPhaiMax         43//43//43//255      
;      43 #define intCuaPhai         16.5//12.5//10.5//9.5//7.5//18.8//18.7//16.3//20.9//16.9//11//11//20.5//22//129  
;      44 #define stPhai             9//10//8
;      45 //Bien thien van toc 
;      46 int  vt = intTraiTrungBinh;     
;      47 int  vp = intPhaiTrungBinh;
;      48 //Cac dinh muc van toc 
;      49 // unsigned int   VanT oc[7]={
;      50 //  
;      51 //       0, //0 MIN-Voi van toc nay chac Robot khong chay duoc,,,
;      52 //       vt, //1 
;      53 //       vt*2,//2
;      54 //       vt*3,       //3
;      55 //       vt*4,       //4
;      56 //       vt*6,       //5
;      57 //       vt*6-3       //6 MAX -Voi toc do nay thi Robot co the boc dau roi,,       
;      58 //       //Van toc max =43*6`=255
;      59 //       //Van toc trung binh =43*4=172 ; 172/6=29
;      60 //       //Van toc cham = 43*3=129      ; 129/6=22     
;      61 // };                 
;      62 //Bien thien van toc 
;      63 //DINH NGHIA BIEN 
;      64 //int intVachNgang ;          
;      65 bit bitVungTrai;
;      66 bit bitVungPhai;    
;      67 //DINH NGHIA CAM BIEN 
;      68 #define SensorTrungTamTrai		PINA.3
;      69 #define SensorTrai			PINA.2
;      70 #define SensorTraiNgoai			PINA.1
;      71 #define SensorTrungTamPhai		PINA.4
;      72 #define SensorPhai		        PINA.5
;      73 #define SensorPhaiNgoai			PINA.6
;      74 #define SensorDemTrai			PINA.7
;      75 #define SensorDemPhai			PINA.0 
;      76 //=============== DONG CO PHAI =====================
;      77 #define DongCoPhaiTien		 	PORTB.0
;      78 #define DongCoPhaiLui                   PORTB.1
;      79 //Xung->dong co phai
;      80 #define Pulse_Phai	 		PORTB.2 
;      81 //=============== DONG CO TRAI =====================
;      82 #define   DongCoTraiTien    	 	PORTB.2
;      83 #define   DongCoTraiLui    	 	PORTB.4
;      84 //Xung->dong co trai
;      85 #define   Pulse_Trai		        PORTB.5	
;      86 //==============DONG CO CUON =======================
;      87 #define DongCoCuonXuong		        PORTB.5
;      88 #define DongCoCuonLen			PORTB.6
;      89 #define DongCoKep		        PORTD.1
;      90 #define DongCoNha			PORTD.2            
;      91 //#define     CoKep		        PORTD.1
;      92 //#define      CoNha			PORTD.2            
;      93 //==========PHIM CHIEN THUAT========================
;      94 #define Phim1   		        PIND.5
;      95 #define Phim2   			PIND.6            
;      96 #define Phim3   		        PINC.7
;      97 #define Phim4   			PINC.6//test ok            
;      98 #define Phim5   		        PINC.4//ok test
;      99 #define Phim6  			        PINC.5//ok test            
;     100 //==========HANH HA - A NHAM ,, HANH TRINH ========================
;     101 //#define hToCentral  		        PINC.2
;     102 //#define hToUp   			PINC.5 
;     103 #define hGovida  			PINC.0 
;     104 #define hAut     			PINC.1           
;     105 //=================DONG CO KEP =========================
;     106 //chua biet dinh nghia the nao ???
;     107 //#define DongCoIn			
;     108 //#define DongCoOut                                                 
;     109 //CAC CHUONG TRINH CON 
;     110 //Khoi tao Atmega16
;     111 void Initial();     
;     112 //Vi tri robocon      
;     113 unsigned  int RoboconLocation();
;     114 //Dieu khien robocon 
;     115 void RoboconController(unsigned  int control);     
;     116 // Dieu khien huong ro bot 
;     117 void RoboconVector(unsigned  int vec); 
;     118 //Dieu khien van toc 
;     119 void VanTocTraiPhai(int,int);
;     120 //Do duong, theo vach trang
;     121 void Running();
;     122 //Dem so vach ngang
;     123 void CounterIsLine();
;     124 //---Ham delays 1 mili giay---
;     125 void Delay(unsigned int SoMS);
;     126 //Dinh muc van toc 
;     127  unsigned int   spTrai(int);      
;     128  unsigned int   spPhai(int);   
;     129  void Max();     
;     130  void Min();
;     131  void Ave(); 
;     132  void Turn();
;     133 //Run - Line Or Ti
;     134 void RunAs(int);
;     135 void Up();
;     136 void Down();
;     137 void StopUp();
;     138 void StopDown();
;     139 void In();
;     140 void StopIn();
;     141 void Out();
;     142 void StopOut();
;     143 void RunOf(int);
;     144 void RunAsTime(int); 
;     145 void FStop();          
;     146 void TurnLeft();
;     147 void TurnRight();   
;     148 //Phuong an chien thuat   
;     149 void Vic1();
;     150 void Vic2();
;     151 void Vic3();
;     152 void Vic4();
;     153 void Vic5();
;     154 void Vic6();
;     155 // End phuong an            
;     156 //=========================================CHUONG TRINH CHINH DAY============================
;     157 interrupt [EXT_INT0] void ext_int0_isr(void)
;     158 {                                                 

	.CSEG
_ext_int0_isr:
;     159 // Place your code here                                                  
;     160 }
	RETI
;     161              
;     162 void main(void)
;     163 {      
_main:
;     164         //Khoi tao chip
;     165         Initial();   
	RCALL _Initial
;     166         Out();Up();
	RCALL _Out
	RCALL _Up
;     167         Delay(800);
	LDI  R30,LOW(800)
	LDI  R31,HIGH(800)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Delay
;     168         StopOut();    
	RCALL _StopOut
;     169         Delay(2200);StopUp();    
	LDI  R30,LOW(2200)
	LDI  R31,HIGH(2200)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Delay
	RCALL _StopUp
;     170         while(Phim1&&Phim2&&Phim3&&Phim4&&Phim5&&Phim6){}
_0x5:
	SBIS 0x10,5
	RJMP _0x8
	SBIS 0x10,6
	RJMP _0x8
	SBIS 0x13,7
	RJMP _0x8
	SBIS 0x13,6
	RJMP _0x8
	SBIS 0x13,4
	RJMP _0x8
	SBIC 0x13,5
	RJMP _0x9
_0x8:
	RJMP _0x7
_0x9:
	RJMP _0x5
_0x7:
;     171        	if(Phim1==0){ Vic1();}                             
	SBIC 0x10,5
	RJMP _0xA
	RCALL _Vic1
;     172 	else if(Phim2==0){Vic2();}                   
	RJMP _0xB
_0xA:
	SBIC 0x10,6
	RJMP _0xC
	RCALL _Vic2
;     173 	else if(Phim3==0){Vic3();}
	RJMP _0xD
_0xC:
	SBIC 0x13,7
	RJMP _0xE
	RCALL _Vic3
;     174 	else if(Phim4==0){Vic4();}  
	RJMP _0xF
_0xE:
	SBIC 0x13,6
	RJMP _0x10
	RCALL _Vic4
;     175 	else if(Phim5==0){Vic5();}  
	RJMP _0x11
_0x10:
	SBIC 0x13,4
	RJMP _0x12
	RCALL _Vic5
;     176 	else if(Phim6==0){Vic6();}   
	RJMP _0x13
_0x12:
	SBIC 0x13,5
	RJMP _0x14
	RCALL _Vic6
;     177 	else return;
	RJMP _0x15
_0x14:
_0x16:
	RJMP _0x16
;     178 }                                                                    
_0x15:
_0x13:
_0x11:
_0xF:
_0xD:
_0xB:
_0x17:
	RJMP _0x17
;     179 //=== END MAIN ============              
;     180 
;     181 //====DINH MUC VAN TOC ==============      
;     182  unsigned int   spTrai(int i){      
_spTrai:
;     183         switch(i){
	LD   R30,Y
	LDD  R31,Y+1
;     184                 case 0:{
	SBIW R30,0
	BRNE _0x1B
;     185                         return 0;                
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0xCE
;     186                 }
;     187                 case 1:{
_0x1B:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x1C
;     188                         return(vt);                
	__GETW1R 6,7
	RJMP _0xCE
;     189                 }
;     190                 case 2:{
_0x1C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x1D
;     191                          return(vt*2);                
	__GETW1R 6,7
	LSL  R30
	ROL  R31
	RJMP _0xCE
;     192                 }
;     193                 case 3:{
_0x1D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x1E
;     194                         return(vt*3);                
	__GETW2R 6,7
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CALL __MULW12
	RJMP _0xCE
;     195                 }       
;     196                 case 4:{
_0x1E:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x1F
;     197                         return(vt*4);                
	__GETW1R 6,7
	CALL __LSLW2
	RJMP _0xCE
;     198                 }
;     199                 case 5:{
_0x1F:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x20
;     200                         return(vt*5);                
	__GETW2R 6,7
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL __MULW12
	RJMP _0xCE
;     201                 }
;     202                 case 6:{
_0x20:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x1A
;     203                         return(vt*6);                
	__GETW2R 6,7
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __MULW12
	RJMP _0xCE
;     204                 }                                                   
;     205         }
_0x1A:
;     206 }
	RJMP _0xCE
;     207  unsigned int   spPhai(int i){      
_spPhai:
;     208         switch(i){
	LD   R30,Y
	LDD  R31,Y+1
;     209                 case 0:{
	SBIW R30,0
	BRNE _0x25
;     210                         return 0;                
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0xCE
;     211                 }
;     212                 case 1:{
_0x25:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x26
;     213                         return(vp);                
	__GETW1R 8,9
	RJMP _0xCE
;     214                 }
;     215                 case 2:{
_0x26:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x27
;     216                          return(vp*2);                
	__GETW1R 8,9
	LSL  R30
	ROL  R31
	RJMP _0xCE
;     217                 }
;     218                 case 3:{
_0x27:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x28
;     219                         return(vp*3);                
	__GETW2R 8,9
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CALL __MULW12
	RJMP _0xCE
;     220                 }       
;     221                 case 4:{
_0x28:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x29
;     222                         return(vp*4);                
	__GETW1R 8,9
	CALL __LSLW2
	RJMP _0xCE
;     223                 }
;     224                 case 5:{
_0x29:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x2A
;     225                         return(vp*5);                
	__GETW2R 8,9
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL __MULW12
	RJMP _0xCE
;     226                 }
;     227                 case 6:{
_0x2A:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x24
;     228                         return(vp*6);                
	__GETW2R 8,9
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CALL __MULW12
	RJMP _0xCE
;     229                 }                                                   
;     230         }
_0x24:
;     231 }
	RJMP _0xCE
;     232 
;     233 
;     234 void Max(){
;     235         vt=intTraiMax; 
;     236         vp=intPhaiMax;            
;     237 } 
;     238  
;     239 void Min(){
_Min:
;     240         vt=intTraiMin;
	LDI  R30,LOW(21)
	LDI  R31,HIGH(21)
	__PUTW1R 6,7
;     241         vp=intPhaiMin;
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	__PUTW1R 8,9
;     242         
;     243                      
;     244 }
	RET
;     245 void Ave(){
;     246         vt=intTraiTrungBinh;              
;     247         vp=intPhaiTrungBinh;              
;     248 
;     249 }
;     250 void Turn(){
_Turn:
;     251         vt=intCuaTrai;              
	LDI  R30,LOW(17)
	LDI  R31,HIGH(17)
	__PUTW1R 6,7
;     252         vp=intCuaPhai;                         
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	__PUTW1R 8,9
;     253           
;     254 
;     255 } 
	RET
;     256 void St(){
_St:
;     257         vt=stTrai;              
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	__PUTW1R 6,7
;     258         vp=stPhai;      
	__PUTW1R 8,9
;     259           
;     260 
;     261 }           
	RET
;     262         
;     263 //---End dinh muc van toc 
;     264   
;     265 //====VI TRI ROBOT ====
;     266 //------Vi tri robot -> Kiem tra Sensor ----------
;     267 unsigned  int RoboconLocation(){  
_RoboconLocation:
;     268 //        0       0       0       0       0       0       0       0
;     269 //        1       2       3       4       5       6       7       8
;     270     
;     271        //vi tri trung tam 2 sensor 4,5 =vach
;     272         if(SensorTrungTamTrai == Vach & SensorTrungTamPhai==Vach)        
	LDI  R30,0
	SBIC 0x19,3
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,4
	LDI  R30,1
	CALL __EQB12
	POP  R26
	AND  R30,R26
	BREQ _0x2C
;     273          	return 0 ; 
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RET
;     274         //vung trai 2
;     275         if(SensorTrungTamTrai==Vach & SensorTrai==Vach)
_0x2C:
	LDI  R30,0
	SBIC 0x19,3
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,2
	LDI  R30,1
	CALL __EQB12
	POP  R26
	AND  R30,R26
	BREQ _0x2D
;     276                 return 22 ;
	LDI  R30,LOW(22)
	LDI  R31,HIGH(22)
	RET
;     277          //vung trai 1
;     278  	if(SensorTrungTamTrai==Vach)
_0x2D:
	SBIS 0x19,3
	RJMP _0x2E
;     279  	        return 21;
	LDI  R30,LOW(21)
	LDI  R31,HIGH(21)
	RET
;     280  	//vung phai 2
;     281        	 if(SensorTrungTamPhai==Vach & SensorPhai==Vach)
_0x2E:
	LDI  R30,0
	SBIC 0x19,4
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,5
	LDI  R30,1
	CALL __EQB12
	POP  R26
	AND  R30,R26
	BREQ _0x2F
;     282  	        return 12 ;
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	RET
;     283         //vung phai 1
;     284         if(SensorTrungTamPhai== Vach)
_0x2F:
	SBIS 0x19,4
	RJMP _0x30
;     285  	        return 11 ; 
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	RET
;     286         
;     287        	//vung trai 4
;     288         if(SensorTrai==Vach & SensorTraiNgoai==Vach)
_0x30:
	LDI  R30,0
	SBIC 0x19,2
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,1
	LDI  R30,1
	CALL __EQB12
	POP  R26
	AND  R30,R26
	BREQ _0x31
;     289  	        return 24 ;
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	RET
;     290         //vung trai 3
;     291        	if( SensorTrai==Vach)
_0x31:
	SBIS 0x19,2
	RJMP _0x32
;     292  	        return 23 ;
	LDI  R30,LOW(23)
	LDI  R31,HIGH(23)
	RET
;     293         //vung phai 4
;     294        	 if(SensorPhai==Vach & SensorPhaiNgoai==Vach)
_0x32:
	LDI  R30,0
	SBIC 0x19,5
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,6
	LDI  R30,1
	CALL __EQB12
	POP  R26
	AND  R30,R26
	BREQ _0x33
;     295  	        return 14 ;
	LDI  R30,LOW(14)
	LDI  R31,HIGH(14)
	RET
;     296         //vung phai 3
;     297        	 if( SensorPhai==Vach)
_0x33:
	SBIS 0x19,5
	RJMP _0x34
;     298  	        return 13 ;
	LDI  R30,LOW(13)
	LDI  R31,HIGH(13)
	RET
;     299        	
;     300        	//vung trai 5
;     301        	if(SensorTraiNgoai==Vach)
_0x34:
	SBIS 0x19,1
	RJMP _0x35
;     302 	        return 25 ; 	       
	LDI  R30,LOW(25)
	LDI  R31,HIGH(25)
	RET
;     303         //vung phai 5
;     304        	 if( SensorPhaiNgoai==Vach)
_0x35:
	SBIS 0x19,6
	RJMP _0x36
;     305  	        return 15 ;
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	RET
;     306        	//vung phai 6
;     307        	 if(bitVungPhai)
_0x36:
	SBRS R2,1
	RJMP _0x37
;     308  	        return 16 ;	
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	RET
;     309          // vung trai 6
;     310        	if(bitVungTrai)
_0x37:
	SBRS R2,0
	RJMP _0x38
;     311  	        return 26 ;
	LDI  R30,LOW(26)
	LDI  R31,HIGH(26)
	RET
;     312 
;     313 }
_0x38:
	RET
;     314 //--End kiem tra cam bien ---
;     315 //=====DIEU KHIEN MOTOR-> DIEU KHIEN TRANG THAI ROBOT  
;     316 // Dieu khien huong Robot 
;     317 void RoboconVector(unsigned  int vec){
_RoboconVector:
;     318  switch(vec){
	LD   R30,Y
	LDD  R31,Y+1
;     319         case 1:    {
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x3C
;     320                 DongCoTraiTien=Start;
	SBI  0x18,2
;     321                 DongCoTraiLui =Stop; 
	CBI  0x18,4
;     322                 DongCoPhaiTien=Start;
	SBI  0x18,0
;     323                 DongCoPhaiLui=Stop;
	CBI  0x18,1
;     324               }                                    
;     325                  break;
	RJMP _0x3B
;     326         case 2:{
_0x3C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x3D
;     327                 DongCoTraiTien=Stop;
	CBI  0x18,2
;     328                 DongCoTraiLui =Start; 
	SBI  0x18,4
;     329                 DongCoPhaiTien=Stop;
	CBI  0x18,0
;     330                 DongCoPhaiLui=Start;
	SBI  0x18,1
;     331                 }     
;     332                  break;
	RJMP _0x3B
;     333         //Trai     
;     334         case 3:{   
_0x3D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x3E
;     335                 //DC trai
;     336                 DongCoTraiTien=Stop;
	CBI  0x18,2
;     337                 DongCoTraiLui =Start; 
	SBI  0x18,4
;     338                 //DC phai
;     339                 DongCoPhaiTien=Start;
	SBI  0x18,0
;     340                 DongCoPhaiLui=Stop;
	CBI  0x18,1
;     341         
;     342         }     
;     343         break;
	RJMP _0x3B
;     344         //Phai 
;     345         case 4:{
_0x3E:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x3B
;     346                 DongCoTraiTien=Start;
	SBI  0x18,2
;     347                 DongCoTraiLui =Stop; 
	CBI  0x18,4
;     348                 DongCoPhaiTien=Stop;
	CBI  0x18,0
;     349                 DongCoPhaiLui=Start;
	SBI  0x18,1
;     350         }     
;     351                 break;
;     352     }    
_0x3B:
;     353 } 
	RJMP _0xCE
;     354 //Set van toc 
;     355 void VanTocTraiPhai(int trai, int phai){
_VanTocTraiPhai:
;     356               VanTocTrai=spTrai(trai); 
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _spTrai
	OUT  0x23,R30
;     357               VanTocPhai=spPhai(phai);
	LD   R30,Y
	LDD  R31,Y+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _spPhai
	OUT  0x3C,R30
;     358           
;     359       }
	ADIW R28,4
	RET
;     360 //
;     361 void RoboconController(unsigned  int control){
_RoboconController:
;     362         RoboconVector(1); //
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RoboconVector
;     363         switch(control){
	LD   R30,Y
	LDD  R31,Y+1
;     364         
;     365         case 0:    
	SBIW R30,0
	BRNE _0x43
;     366                VanTocTraiPhai(6,6);  
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	RJMP _0xD0
;     367                // VanTocTrai=VanToc[6];
;     368                //VanTocPhai=VanToc[6];    
;     369         break;
;     370         case 11:     
_0x43:
	CPI  R30,LOW(0xB)
	LDI  R26,HIGH(0xB)
	CPC  R31,R26
	BRNE _0x44
;     371                 // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
;     372                 VanTocTraiPhai(5,6);                     
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RJMP _0xD0
;     373             
;     374         break;
;     375         case 12:
_0x44:
	CPI  R30,LOW(0xC)
	LDI  R26,HIGH(0xC)
	CPC  R31,R26
	BRNE _0x45
;     376                 // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
;     377                 VanTocTraiPhai(4,6)  ;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RCALL SUBOPT_0x0
;     378                 bitVungTrai=1;
	BLD  R2,0
;     379                 bitVungPhai=0;
	CLT
	BLD  R2,1
;     380      
;     381         break;
	RJMP _0x42
;     382         case 13:
_0x45:
	CPI  R30,LOW(0xD)
	LDI  R26,HIGH(0xD)
	CPC  R31,R26
	BRNE _0x46
;     383                 // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
;     384                 VanTocTraiPhai(3,6);
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL SUBOPT_0x0
;     385                 bitVungTrai=1;
	BLD  R2,0
;     386                 bitVungPhai=0;
	CLT
	BLD  R2,1
;     387 
;     388         
;     389         break;
	RJMP _0x42
;     390         case 14:
_0x46:
	CPI  R30,LOW(0xE)
	LDI  R26,HIGH(0xE)
	CPC  R31,R26
	BRNE _0x47
;     391                // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
;     392                VanTocTraiPhai(2,6);
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x0
;     393                bitVungTrai=1;
	BLD  R2,0
;     394                bitVungPhai=0;
	CLT
	BLD  R2,1
;     395 
;     396              
;     397         break;
	RJMP _0x42
;     398         case 15:
_0x47:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x48
;     399                // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
;     400                VanTocTraiPhai(1,6);                                                
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x0
;     401                 bitVungTrai=1;
	BLD  R2,0
;     402                 bitVungPhai=0;             
	CLT
	BLD  R2,1
;     403         break;
	RJMP _0x42
;     404         case 16:
_0x48:
	CPI  R30,LOW(0x10)
	LDI  R26,HIGH(0x10)
	CPC  R31,R26
	BRNE _0x49
;     405                // Cac SensorTrai=vach->Lech phai->GIU vantoc PHAI-GIAM van toc TRAI
;     406                VanTocTraiPhai(6,0);                                    
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0xD1
;     407                     
;     408         break;            
;     409        case 21:
_0x49:
	CPI  R30,LOW(0x15)
	LDI  R26,HIGH(0x15)
	CPC  R31,R26
	BRNE _0x4A
;     410                // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
;     411                VanTocTraiPhai(6,5);                
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RJMP _0xD1
;     412                     
;     413         break;
;     414         case 22:
_0x4A:
	CPI  R30,LOW(0x16)
	LDI  R26,HIGH(0x16)
	CPC  R31,R26
	BRNE _0x4B
;     415                // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
;     416                VanTocTraiPhai(6,4);                
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RCALL SUBOPT_0x1
;     417                bitVungTrai=0;
	BLD  R2,0
;     418                bitVungPhai=1;            
	SET
	BLD  R2,1
;     419                   
;     420                break;
	RJMP _0x42
;     421          case 23:
_0x4B:
	CPI  R30,LOW(0x17)
	LDI  R26,HIGH(0x17)
	CPC  R31,R26
	BRNE _0x4C
;     422                // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
;     423                VanTocTraiPhai(6,3);                
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RCALL SUBOPT_0x1
;     424                bitVungTrai=0;
	BLD  R2,0
;     425                bitVungPhai=1;                
	SET
	BLD  R2,1
;     426         break;
	RJMP _0x42
;     427          case 24:
_0x4C:
	CPI  R30,LOW(0x18)
	LDI  R26,HIGH(0x18)
	CPC  R31,R26
	BRNE _0x4D
;     428                // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
;     429                VanTocTraiPhai(6,2);                
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x1
;     430                bitVungTrai=0;
	BLD  R2,0
;     431                bitVungPhai=1;                    
	SET
	BLD  R2,1
;     432         break;
	RJMP _0x42
;     433          case 25:
_0x4D:
	CPI  R30,LOW(0x19)
	LDI  R26,HIGH(0x19)
	CPC  R31,R26
	BRNE _0x4E
;     434                // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
;     435                VanTocTraiPhai(6,1);                
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x1
;     436                bitVungTrai=0;
	BLD  R2,0
;     437                bitVungPhai=1;                    
	SET
	BLD  R2,1
;     438         break;
	RJMP _0x42
;     439          case 26:
_0x4E:
	CPI  R30,LOW(0x1A)
	LDI  R26,HIGH(0x1A)
	CPC  R31,R26
	BRNE _0x42
;     440                // Cac SensorPhai=vach->Lech Trai->GIU vantoc TRAI-GIAM van toc PHAI
;     441                VanTocTraiPhai(0,6);                
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
_0xD0:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
_0xD1:
	ST   -Y,R31
	ST   -Y,R30
	RCALL _VanTocTraiPhai
;     442 
;     443 
;     444  }
_0x42:
;     445 } 
	RJMP _0xCE
;     446 //=====DO DUONG ,DAY ============
;     447 //--Chay theo vach trang  --
;     448 void    Running(){       
_Running:
;     449       RoboconController(RoboconLocation());          
	RCALL _RoboconLocation
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RoboconController
;     450 }   
	RET
;     451 //---Count Line ---
;     452 void CounterIsLine(){
_CounterIsLine:
	PUSH R15
;     453  unsigned int y=3100;
;     454 unsigned int x = 100000;//50000;//20000 
;     455 	bit	QuaVachNgang = 0;	
;     456 	if((SensorDemTrai==Nen)&&(SensorDemPhai==Nen))
	CALL __SAVELOCR4
;	y -> R16,R17
;	x -> R18,R19
;	QuaVachNgang -> R15.0
	CLR  R15
	LDI  R16,28
	LDI  R17,12
	LDI  R18,160
	LDI  R19,134
	SBIC 0x19,7
	RJMP _0x51
	SBIS 0x19,0
	RJMP _0x52
_0x51:
	RJMP _0x50
_0x52:
;     457 		return;					
	RJMP _0xCF
;     458 	if(SensorDemTrai==Vach){		
_0x50:
	SBIS 0x19,7
	RJMP _0x53
;     459 		while(x>0){	
;	QuaVachNgang -> R15.0
_0x54:
	CLR  R0
	CP   R0,R18
	CPC  R0,R19
	BRSH _0x56
;     460 			x--;
;	QuaVachNgang -> R15.0
	__SUBWRN 18,19,1
;     461 			//DoDuong();
;     462 			Running();			
	RCALL _Running
;     463 			if(SensorDemPhai==Vach && QuaVachNgang==0)
	SBIS 0x19,0
	RJMP _0x58
	SBRS R15,0
	RJMP _0x59
_0x58:
	RJMP _0x57
_0x59:
;     464 			{
;     465 				SoLanQuaVachNgang++;
;	QuaVachNgang -> R15.0
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 4,5,30,31
;     466 				//P3_7 = 1 ; // Bao dem 
;     467 				QuaVachNgang = 1;
	SET
	BLD  R15,0
;     468 				while(y>0){
_0x5A:
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRSH _0x5C
;     469 				        y--;
;	QuaVachNgang -> R15.0
	__SUBWRN 16,17,1
;     470 				        Running();
	RCALL _Running
;     471 				}								
	RJMP _0x5A
_0x5C:
;     472 		  	}
;     473 			if (QuaVachNgang==1 & SensorDemPhai==Nen)
_0x57:
	LDI  R30,0
	SBRC R15,0
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,0
	LDI  R30,1
	LDI  R26,LOW(0)
	CALL __EQB12
	POP  R26
	AND  R30,R26
	BREQ _0x5D
;     474 				return;
	RJMP _0xCF
;     475 		}
_0x5D:
	RJMP _0x54
_0x56:
;     476 	}
;     477 	else if(SensorDemPhai==Vach){		
	RJMP _0x5E
_0x53:
	SBIS 0x19,0
	RJMP _0x5F
;     478 		while(x>0){	
;	QuaVachNgang -> R15.0
_0x60:
	CLR  R0
	CP   R0,R18
	CPC  R0,R19
	BRSH _0x62
;     479 			x--;
;	QuaVachNgang -> R15.0
	__SUBWRN 18,19,1
;     480 			//DoDuong();		
;     481 			Running();
	RCALL _Running
;     482 			if((SensorDemTrai==Vach) &( QuaVachNgang==0)){
	LDI  R30,0
	SBIC 0x19,7
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBRC R15,0
	LDI  R30,1
	LDI  R26,LOW(0)
	CALL __EQB12
	POP  R26
	AND  R30,R26
	BREQ _0x63
;     483 				SoLanQuaVachNgang ++ ;	
;	QuaVachNgang -> R15.0
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 4,5,30,31
;     484 				//P3_7 = 1 ; // Bao dem 
;     485 				QuaVachNgang=1;
	SET
	BLD  R15,0
;     486 				while(y>0){
_0x64:
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRSH _0x66
;     487 				        y--;
;	QuaVachNgang -> R15.0
	__SUBWRN 16,17,1
;     488 				        Running();
	RCALL _Running
;     489 				}				
	RJMP _0x64
_0x66:
;     490 			}
;     491 			if (QuaVachNgang==1 && SensorDemTrai==Nen)
_0x63:
	SBRS R15,0
	RJMP _0x68
	SBIS 0x19,7
	RJMP _0x69
_0x68:
	RJMP _0x67
_0x69:
;     492 				return;
	RJMP _0xCF
;     493 		}
_0x67:
	RJMP _0x60
_0x62:
;     494 	}
;     495 }	
_0x5F:
_0x5E:
_0xCF:
	CALL __LOADLOCR4
	ADIW R28,4
	POP  R15
	RET
;     496                                             
;     497 
;     498 //--End dem vach ngang--       
;     499 //---Ham delays 1 mili giay---
;     500 void Delay(unsigned int SoMS)
;     501 {
_Delay:
;     502  	unsigned long Time;
;     503 	while (SoMS--){
	SBIW R28,4
;	SoMS -> Y+4
;	Time -> Y+0
_0x6A:
	RCALL SUBOPT_0x2
	BREQ _0x6C
;     504 		for(Time=0;Time<300;Time++);
	__CLRD1S 0
_0x6E:
	__GETD2S 0
	__CPD2N 0x12C
	BRSH _0x6F
	RCALL SUBOPT_0x3
	RJMP _0x6E
_0x6F:
;     505         }                      
	RJMP _0x6A
_0x6C:
;     506 }       
	RJMP _0xCD
;     507 //---Dieu khien Robocon---
;     508 
;     509 void RunAs(int intSoVachNgang )
;     510 {	
_RunAs:
;     511 	
;     512 	do{ 
_0x71:
;     513 		Running();      
	RCALL _Running
;     514 		//kiem tra qua vach ngang
;     515                 CounterIsLine();
	RCALL _CounterIsLine
;     516 	}
;     517 	while(SoLanQuaVachNgang < intSoVachNgang);
	LD   R30,Y
	LDD  R31,Y+1
	CP   R4,R30
	CPC  R5,R31
	BRLT _0x71
;     518 	SoLanQuaVachNgang = 0 ;
	CLR  R4
	CLR  R5
;     519 	FStop();
	RCALL _FStop
;     520 }
	RJMP _0xCE
;     521 void RunOf(int intSoVachNgang )
;     522 {	
_RunOf:
;     523 	Turn();
	RCALL _Turn
;     524 	do{ 
_0x74:
;     525 		Running();      
	RCALL _Running
;     526 		//kiem tra qua vach ngang
;     527                 CounterIsLine();
	RCALL _CounterIsLine
;     528 	}
;     529 	while(SoLanQuaVachNgang < intSoVachNgang);
	LD   R30,Y
	LDD  R31,Y+1
	CP   R4,R30
	CPC  R5,R31
	BRLT _0x74
;     530 	//DelayMS(700) ;      
;     531 	SoLanQuaVachNgang = 0 ;     
	CLR  R4
	CLR  R5
;     532 	FStop();
	RCALL _FStop
;     533 }     
_0xCE:
	ADIW R28,2
	RET
;     534      
;     535 void RunAsTime(int intThoiGian)
;     536 {		
_RunAsTime:
;     537  	unsigned long Time; 	
;     538 	while (intThoiGian--)
	SBIW R28,4
;	intThoiGian -> Y+4
;	Time -> Y+0
_0x76:
	RCALL SUBOPT_0x2
	BREQ _0x78
;     539 	{
;     540 		for(Time=0;Time<300;Time++)		
	__CLRD1S 0
_0x7A:
	__GETD2S 0
	__CPD2N 0x12C
	BRSH _0x7B
;     541 		Running();			
	RCALL _Running
;     542 	}  
	RCALL SUBOPT_0x3
	RJMP _0x7A
_0x7B:
	RJMP _0x76
_0x78:
;     543 	FStop();
	RCALL _FStop
;     544 } 
_0xCD:
	ADIW R28,6
	RET
;     545 void FStop(){
_FStop:
;     546 	//Pulse_Trai = Stop;
;     547 	//Pulse_Phai = Stop ;
;     548 	DongCoTraiTien=!Tien;
	CBI  0x18,2
;     549 	DongCoPhaiTien=!Tien;
	CBI  0x18,0
;     550 	DongCoPhaiLui=!Lui;
	CBI  0x18,1
;     551 	DongCoTraiLui=!Lui;
	CBI  0x18,4
;     552 }  
	RET
;     553 
;     554 void XuatPhat(){
_XuatPhat:
;     555         Turn();
	RCALL _Turn
;     556         RunAsTime(80);//qua vung xuat phat
	LDI  R30,LOW(80)
	LDI  R31,HIGH(80)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunAsTime
;     557 
;     558 } 
	RET
;     559 void Up(){
_Up:
;     560 DongCoCuonLen=1;
	SBI  0x18,6
;     561 }
	RET
;     562 void Down(){
_Down:
;     563 DongCoCuonXuong=1;
	SBI  0x18,5
;     564 }  
	RET
;     565 void StopUp(){
_StopUp:
;     566 DongCoCuonLen=0;
	CBI  0x18,6
;     567 }
	RET
;     568 void StopDown(){
_StopDown:
;     569 DongCoCuonXuong=0;
	CBI  0x18,5
;     570 }       
	RET
;     571 void In(){
_In:
;     572 DongCoKep=1;
	SBI  0x12,1
;     573 }    
	RET
;     574 void StopIn(){
_StopIn:
;     575 DongCoKep=0;
	CBI  0x12,1
;     576 }        
	RET
;     577 void Out(){
_Out:
;     578 DongCoNha=1;
	SBI  0x12,2
;     579 }
	RET
;     580 void StopOut(){
_StopOut:
;     581 DongCoNha=0;
	CBI  0x12,2
;     582 }  
	RET
;     583 void TurnLeft(){
_TurnLeft:
;     584        	FStop();
	RCALL SUBOPT_0x4
;     585 	Delay(300);                  
;     586         Min();
	RCALL _Min
;     587 while((SensorDemPhai==0)|(SensorTrungTamTrai==Vach)){
_0x7C:
	LDI  R30,0
	SBIC 0x19,0
	LDI  R30,1
	LDI  R26,LOW(0)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,3
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	POP  R26
	OR   R30,R26
	BREQ _0x7E
;     588 	DongCoPhaiTien = Tien;
	SBI  0x18,0
;     589 	DongCoPhaiLui=!Tien; 	
	CBI  0x18,1
;     590 	DongCoTraiTien  =  !Tien;
	CBI  0x18,2
;     591         DongCoTraiLui	 = Lui;
	SBI  0x18,4
;     592         VanTocTraiPhai(5,5);
	RCALL SUBOPT_0x5
;     593 	}
	RJMP _0x7C
_0x7E:
;     594 
;     595 	do {
_0x80:
;     596 	VanTocTraiPhai(5,5);
	RCALL SUBOPT_0x5
;     597 	DongCoPhaiTien = Tien;      
	SBI  0x18,0
;     598 	DongCoTraiTien =  !Tien;
	CBI  0x18,2
;     599   	DongCoTraiLui	 = Lui;
	SBI  0x18,4
;     600       }
;     601 while((SensorTrungTamPhai!=Vach)||(SensorTrungTamTrai!=Vach));
	SBIS 0x19,4
	RJMP _0x82
	SBIC 0x19,3
	RJMP _0x81
_0x82:
	RJMP _0x80
_0x81:
;     602 	DongCoTraiLui = !Lui; 
	CBI  0x18,4
;     603 	DongCoPhaiTien = Tien;
	SBI  0x18,0
;     604 	FStop();
	RCALL SUBOPT_0x4
;     605 	Delay(300);                  
;     606 }
	RET
;     607 //---          
;     608 void TurnRight(){
_TurnRight:
;     609 	FStop();
	RCALL SUBOPT_0x4
;     610 	Delay(300);                  
;     611         Min();
	RCALL _Min
;     612 while((SensorDemTrai==0)|(SensorTrungTamPhai==Vach)){
_0x84:
	LDI  R30,0
	SBIC 0x19,7
	LDI  R30,1
	LDI  R26,LOW(0)
	CALL __EQB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,4
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __EQB12
	POP  R26
	OR   R30,R26
	BREQ _0x86
;     613 	DongCoTraiTien = Tien;
	SBI  0x18,2
;     614 	DongCoTraiLui=!Tien; 	
	CBI  0x18,4
;     615 	DongCoPhaiTien  =  !Tien ;
	CBI  0x18,0
;     616         DongCoPhaiLui	 = Lui ;
	SBI  0x18,1
;     617         VanTocTraiPhai(5,5);
	RCALL SUBOPT_0x5
;     618 	}
	RJMP _0x84
_0x86:
;     619 	do {
_0x88:
;     620 	VanTocTraiPhai(5,5);
	RCALL SUBOPT_0x5
;     621 	DongCoTraiTien = Tien  ;
	SBI  0x18,2
;     622 	DongCoPhaiTien =  !Tien ;
	CBI  0x18,0
;     623   	DongCoPhaiLui	 = Lui ;
	SBI  0x18,1
;     624  	}
;     625 	while((SensorTrungTamTrai!=Vach)|(SensorTrungTamPhai!=Vach));
	LDI  R30,0
	SBIC 0x19,3
	LDI  R30,1
	LDI  R26,LOW(1)
	CALL __NEB12
	PUSH R30
	LDI  R30,0
	SBIC 0x19,4
	LDI  R30,1
	CALL __NEB12
	POP  R26
	OR   R30,R26
	BRNE _0x88
;     626 	DongCoPhaiLui = !Lui;
	CBI  0x18,1
;     627 	DongCoTraiTien = Tien ;
	SBI  0x18,2
;     628 	FStop();
	RCALL SUBOPT_0x4
;     629 	Delay(300);
;     630 }     
	RET
;     631 //Go to govia cuop qua vang 
;     632 void ToCentral( )
;     633 { 
;     634 
;     635 }     
;     636 //-------------------------------------------------------------------------  
;     637 //=============CAC PHUONG AN CHIEN THUAT===================================
;     638 void Vic1(){
_Vic1:
;     639 int x=5000000;//wait phim 
;     640         XuatPhat();
	ST   -Y,R17
	ST   -Y,R16
;	x -> R16,R17
	LDI  R16,64
	LDI  R17,75
	RCALL _XuatPhat
;     641         RunOf(2);
	RCALL SUBOPT_0x6
;     642         TurnRight();
	RCALL SUBOPT_0x7
;     643         RunOf(1);
;     644         Min();RunAs(2);
;     645         RunOf(1);
;     646         TurnLeft();
;     647         RunOf(4);
	RCALL SUBOPT_0x8
;     648         St();
	RCALL _St
;     649         RunAsTime(35);
	LDI  R30,LOW(35)
	LDI  R31,HIGH(35)
	RCALL SUBOPT_0x9
;     650         FStop();
;     651         //cho
;     652         while(hAut){}
_0x8A:
	SBIC 0x13,1
	RJMP _0x8A
;     653         //    
;     654         while(x>0){x--;}
_0x8D:
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRGE _0x8F
	__SUBWRN 16,17,1
	RJMP _0x8D
_0x8F:
;     655         while(hAut){}  
_0x90:
	SBIC 0x13,1
	RJMP _0x90
;     656         Delay(1500);               
	RCALL SUBOPT_0xA
;     657         while(hGovida){       
_0x93:
	SBIS 0x13,0
	RJMP _0x95
;     658         Down();}    
	RCALL _Down
	RJMP _0x93
_0x95:
;     659         StopDown();
	RCALL SUBOPT_0xB
;     660         Delay(200);               
;     661         In();                 
;     662         Delay(900);
;     663         StopIn();    
;     664         Down();Delay(1000);StopDown();       
;     665         Delay(8000);
;     666         //Delay(3000);//mod         
;     667         Up();Delay(2100);StopUp;  
	LDI  R30,LOW(2100)
	LDI  R31,HIGH(2100)
	RCALL SUBOPT_0xC
;     668         Delay(1000);
;     669         FStop();//mod
	RCALL _FStop
;     670         RunOf(1);
	RCALL SUBOPT_0xD
;     671         FStop();     
	RCALL _FStop
;     672         while(1);
_0x96:
	RJMP _0x96
;     673             
;     674   }
	RJMP _0xCC
;     675 void Vic2(){
_Vic2:
;     676         int x=5000000;//wait phim 
;     677         XuatPhat();
	ST   -Y,R17
	ST   -Y,R16
;	x -> R16,R17
	LDI  R16,64
	LDI  R17,75
	RCALL _XuatPhat
;     678         RunOf(1);
	RCALL SUBOPT_0xD
;     679         Min();RunAs(2);
	RCALL _Min
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0xE
;     680         RunOf(1);
;     681         TurnRight();
	RCALL SUBOPT_0x7
;     682         RunOf(1);
;     683         Min();RunAs(2);
;     684         RunOf(1);
;     685         TurnLeft();
;     686         RunOf(2);
	RCALL SUBOPT_0x6
;     687         St();
	RCALL _St
;     688         RunAsTime(38);
	LDI  R30,LOW(38)
	LDI  R31,HIGH(38)
	RCALL SUBOPT_0x9
;     689         FStop();
;     690         //cho
;     691         while(hAut){}
_0x99:
	SBIC 0x13,1
	RJMP _0x99
;     692         //    
;     693         while(x>0){x--;}
_0x9C:
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRGE _0x9E
	__SUBWRN 16,17,1
	RJMP _0x9C
_0x9E:
;     694         while(hAut){}  
_0x9F:
	SBIC 0x13,1
	RJMP _0x9F
;     695         Delay(1500);               
	RCALL SUBOPT_0xA
;     696         while(hGovida){       
_0xA2:
	SBIS 0x13,0
	RJMP _0xA4
;     697         Down();}    
	RCALL _Down
	RJMP _0xA2
_0xA4:
;     698         StopDown();
	RCALL SUBOPT_0xB
;     699         Delay(200);               
;     700         In();                 
;     701         Delay(900);
;     702         StopIn();    
;     703         Down();Delay(1000);StopDown();       
;     704         Delay(8000);         
;     705         Up();Delay(2000);StopUp;  
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	RCALL SUBOPT_0xC
;     706         Delay(1000);  
;     707         RunOf(1);
	RCALL SUBOPT_0xD
;     708         FStop();
	RCALL _FStop
;     709         while(1);
_0xA5:
	RJMP _0xA5
;     710                 
;     711         }                            
	RJMP _0xCC
;     712 
;     713 void Vic3(){  
_Vic3:
;     714         int x=5000000;//wait phim 
;     715         XuatPhat();
	ST   -Y,R17
	ST   -Y,R16
;	x -> R16,R17
	LDI  R16,64
	LDI  R17,75
	RCALL _XuatPhat
;     716         RunOf(1); 
	RCALL SUBOPT_0xD
;     717         Min();RunAs(3);
	RCALL SUBOPT_0xF
;     718         RunOf(1);
;     719         TurnRight();
	RCALL SUBOPT_0x7
;     720         RunOf(1);   
;     721         Min(); RunAs(2);   
;     722         RunOf(1);   
;     723         TurnLeft();
;     724         //St();
;     725         RunOf(1);
	RCALL SUBOPT_0xD
;     726         //St();
;     727         RunAsTime(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	RCALL SUBOPT_0x9
;     728         FStop();
;     729         //cho
;     730         while(hAut){}
_0xA8:
	SBIC 0x13,1
	RJMP _0xA8
;     731         //    
;     732         while(x>0){x--;}
_0xAB:
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRGE _0xAD
	__SUBWRN 16,17,1
	RJMP _0xAB
_0xAD:
;     733         while(hAut){}  
_0xAE:
	SBIC 0x13,1
	RJMP _0xAE
;     734         Delay(1500);               
	RCALL SUBOPT_0xA
;     735         while(hGovida){       
_0xB1:
	SBIS 0x13,0
	RJMP _0xB3
;     736         Down();}    
	RCALL _Down
	RJMP _0xB1
_0xB3:
;     737         StopDown();
	RCALL SUBOPT_0xB
;     738         Delay(200);               
;     739         In();                 
;     740         Delay(900);
;     741         StopIn();    
;     742         Down();Delay(1000);StopDown();       
;     743         Delay(8000);         
;     744         Up();Delay(2000);StopUp;  
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	RCALL SUBOPT_0xC
;     745         Delay(1000);  
;     746         RunOf(1);
	RCALL SUBOPT_0xD
;     747         FStop();     
	RCALL _FStop
;     748         while(1);
_0xB4:
	RJMP _0xB4
;     749 }                    
	RJMP _0xCC
;     750 void Vic4(){    
_Vic4:
;     751         int x=5000000;//wait phim 
;     752         XuatPhat();
	ST   -Y,R17
	ST   -Y,R16
;	x -> R16,R17
	LDI  R16,64
	LDI  R17,75
	RCALL _XuatPhat
;     753         RunOf(3); 
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunOf
;     754         TurnLeft();
	RCALL _TurnLeft
;     755         RunOf(1);
	RCALL SUBOPT_0xD
;     756         RunAs(5);
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL SUBOPT_0xE
;     757         //St();
;     758         RunOf(1);
;     759         //St();
;     760         RunAsTime(20);
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	RCALL SUBOPT_0x9
;     761         FStop();
;     762         //cho
;     763         while(hAut){}
_0xB7:
	SBIC 0x13,1
	RJMP _0xB7
;     764         //    
;     765         while(x>0){x--;}
_0xBA:
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRGE _0xBC
	__SUBWRN 16,17,1
	RJMP _0xBA
_0xBC:
;     766         
;     767         while(hAut){}  
_0xBD:
	SBIC 0x13,1
	RJMP _0xBD
;     768         Delay(1500);               
	RCALL SUBOPT_0xA
;     769         while(hGovida){       
_0xC0:
	SBIS 0x13,0
	RJMP _0xC2
;     770         Down();}    
	RCALL _Down
	RJMP _0xC0
_0xC2:
;     771         StopDown();
	RCALL SUBOPT_0xB
;     772         Delay(200);               
;     773         In();                 
;     774         Delay(900);
;     775         StopIn();    
;     776         Down();Delay(1000);StopDown();       
;     777         Delay(8000);         
;     778         Up();Delay(2000);StopUp;  
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	RCALL SUBOPT_0xC
;     779         Delay(1000);  
;     780         RunOf(2);
	RCALL SUBOPT_0x6
;     781         FStop();     
	RCALL _FStop
;     782         while(1);
_0xC3:
	RJMP _0xC3
;     783 
;     784    
;     785 }
_0xCC:
	LD   R16,Y+
	LD   R17,Y+
	RET
;     786 void Vic5(){  
_Vic5:
;     787         XuatPhat();
	RCALL _XuatPhat
;     788         RunOf(1);
	RCALL SUBOPT_0xD
;     789         TurnRight();
	RCALL _TurnRight
;     790         RunOf(1);
	RCALL SUBOPT_0xD
;     791         Min();RunAs(3);
	RCALL SUBOPT_0xF
;     792         RunOf(1);
;     793         In();                 
	RCALL SUBOPT_0x10
;     794         Delay(600);
;     795         StopIn();    
;     796         TurnLeft();
	RCALL _TurnLeft
;     797         RunOf(1);
	RCALL SUBOPT_0xD
;     798         Min();
	RCALL _Min
;     799         RunAs(5);
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunAs
;     800         RunOf(2);
	RCALL SUBOPT_0x6
;     801         TurnLeft();
	RCALL _TurnLeft
;     802         RunAs(3);
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunAs
;     803         while(1){
_0xC6:
;     804         RunOf(4);
	RCALL SUBOPT_0x8
;     805         TurnRight();
	RCALL _TurnRight
;     806         RunOf(1);
	RCALL SUBOPT_0xD
;     807         RunAsTime(10);
	RCALL SUBOPT_0x11
;     808         TurnRight();
;     809         RunOf(4);
	RCALL SUBOPT_0x8
;     810         TurnRight();
	RCALL _TurnRight
;     811         RunOf(1);
	RCALL SUBOPT_0xD
;     812         RunAsTime(10);
	RCALL SUBOPT_0x11
;     813         TurnRight();
;     814         Delay(5000); 
	RCALL SUBOPT_0x12
;     815 }
	RJMP _0xC6
;     816       
;     817 }
	RET
;     818 void Vic6(){
_Vic6:
;     819         XuatPhat();
	RCALL _XuatPhat
;     820         RunOf(1);
	RCALL SUBOPT_0xD
;     821         Min();RunAs(3);
	RCALL SUBOPT_0xF
;     822         RunOf(1);
;     823         In();                 
	RCALL SUBOPT_0x10
;     824         Delay(600);
;     825         StopIn();   
;     826         TurnRight();
	RCALL _TurnRight
;     827         RunOf(1);
	RCALL SUBOPT_0xD
;     828         Min();RunAs(1);
	RCALL _Min
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0xE
;     829         RunOf(1);
;     830         TurnLeft();
	RCALL _TurnLeft
;     831         RunOf(4);
	RCALL SUBOPT_0x8
;     832         
;     833         TurnLeft();
	RCALL _TurnLeft
;     834         RunAs(1);
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunAs
;     835     while(1){
_0xC9:
;     836         RunOf(4);
	RCALL SUBOPT_0x8
;     837         TurnRight();
	RCALL _TurnRight
;     838         RunOf(1);
	RCALL SUBOPT_0xD
;     839         RunAsTime(10);
	RCALL SUBOPT_0x11
;     840         TurnRight();
;     841         RunOf(4);
	RCALL SUBOPT_0x8
;     842         TurnRight();
	RCALL _TurnRight
;     843         RunOf(1);   
	RCALL SUBOPT_0xD
;     844         RunAsTime(10);
	RCALL SUBOPT_0x11
;     845         TurnRight();
;     846         Delay(5000); 
	RCALL SUBOPT_0x12
;     847 }       
	RJMP _0xC9
;     848 }
	RET
;     849 //----End phuong an 
;     850 
;     851 void Initial(){
_Initial:
;     852 // Declare your local variables here
;     853 // Input/Output Ports initialization
;     854 // Port A initialization
;     855 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     856 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     857 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     858 DDRA=0x00;
	OUT  0x1A,R30
;     859 
;     860 // Port B initialization
;     861 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
;     862 // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
;     863 PORTB=0x00;
	OUT  0x18,R30
;     864 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     865 
;     866 // Port C initialization
;     867 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     868 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     869 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     870 DDRC=0x00;
	OUT  0x14,R30
;     871 
;     872 // Port D initialization
;     873 // Func7=Out Func6=In Func5=In Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
;     874 // State7=0 State6=T State5=T State4=0 State3=0 State2=0 State1=0 State0=0 
;     875 PORTD=0x00;
	OUT  0x12,R30
;     876 DDRD=0x9F;
	LDI  R30,LOW(159)
	OUT  0x11,R30
;     877 
;     878 //-0--
;     879 // Timer/Counter 0 initialization
;     880 // Clock source: System Clock
;     881 // Clock value: 125.000 kHz
;     882 // Mode: Fast PWM top=FFh
;     883 // OC0 output: Non-Inverted PWM
;     884 TCCR0=0x6A;
	LDI  R30,LOW(106)
	RCALL SUBOPT_0x13
;     885 TCNT0=0x00;
;     886 OCR0=0x7F;   
	LDI  R30,LOW(127)
	OUT  0x3C,R30
;     887 //
;     888 TCCR2=0x6A;
	LDI  R30,LOW(106)
	RCALL SUBOPT_0x14
;     889 TCNT2=0x00;
;     890 OCR2=0x6E;   
	LDI  R30,LOW(110)
	RCALL SUBOPT_0x15
;     891 //---
;     892 //---
;     893 
;     894 
;     895 // External Interrupt(s) initialization
;     896 // INT0: Off
;     897 // INT1: Off
;     898 // INT2: Off
;     899 MCUCR=0x00;
;     900 MCUCSR=0x00;   
;     901 // Timer(s)/Counter(s) Interrupt(s) initialization
;     902 TIMSK=0x00;    
;     903 // Analog Comparator initialization
;     904 // Analog Comparator: Off
;     905 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     906 ACSR=0x80;
;     907 SFIOR=0x00; 
;     908 
;     909 //
;     910 // External Interrupt(s) initialization
;     911 // INT0: On
;     912 // INT0 Mode: Low level
;     913 // INT1: Off
;     914 // INT2: Off
;     915 GICR|=0x40;
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
;     916 MCUCR=0x00;
	LDI  R30,LOW(0)
	OUT  0x35,R30
;     917 MCUCSR=0x00;
	OUT  0x34,R30
;     918 GIFR=0x40;    
	LDI  R30,LOW(64)
	OUT  0x3A,R30
;     919 ///////////////
;     920 // Timer/Counter 0 initialization
;     921 // Clock source: System Clock
;     922 // Clock value: 46.875 kHz
;     923 // Mode: Fast PWM top=FFh
;     924 // OC0 output: Non-Inverted PWM
;     925 TCCR0=0x6C;
	LDI  R30,LOW(108)
	RCALL SUBOPT_0x13
;     926 TCNT0=0x00;
;     927 OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x3C,R30
;     928 // Timer/Counter 1 initialization
;     929 // Clock source: System Clock
;     930 // Clock value: 46.875 kHz
;     931 // Mode: Normal top=FFFFh
;     932 // OC1A output: Discon.
;     933 // OC1B output: Discon.
;     934 // Noise Canceler: Off
;     935 // Input Capture on Falling Edge
;     936 TCCR1A=0x00;
	OUT  0x2F,R30
;     937 TCCR1B=0x04;
	LDI  R30,LOW(4)
	OUT  0x2E,R30
;     938 TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;     939 TCNT1L=0x00;
	OUT  0x2C,R30
;     940 ICR1H=0x00;
	OUT  0x27,R30
;     941 ICR1L=0x00;
	OUT  0x26,R30
;     942 OCR1AH=0x00;
	OUT  0x2B,R30
;     943 OCR1AL=0x00;
	OUT  0x2A,R30
;     944 OCR1BH=0x00;
	OUT  0x29,R30
;     945 OCR1BL=0x00;
	OUT  0x28,R30
;     946 // Timer/Counter 2 initialization
;     947 // Clock source: System Clock
;     948 // Clock value: 46.875 kHz
;     949 // Mode: Fast PWM top=FFh
;     950 // OC2 output: Non-Inverted PWM
;     951 ASSR=0x00;
	OUT  0x22,R30
;     952 TCCR2=0x6E;
	LDI  R30,LOW(110)
	RCALL SUBOPT_0x14
;     953 TCNT2=0x00;
;     954 OCR2=0x00;
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x15
;     955 // External Interrupt(s) initialization
;     956 // INT0: Off
;     957 // INT1: Off
;     958 // INT2: Off
;     959 MCUCR=0x00;
;     960 MCUCSR=0x00;
;     961 // Timer(s)/Counter(s) Interrupt(s) initialization
;     962 TIMSK=0x00;
;     963 // Analog Comparator initialization
;     964 // Analog Comparator: Off
;     965 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     966 ACSR=0x80;
;     967 SFIOR=0x00;
;     968 }
	RET


;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x0:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _VanTocTraiPhai
	SET
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x1:
	ST   -Y,R31
	ST   -Y,R30
	RCALL _VanTocTraiPhai
	CLT
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	ADIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3:
	__GETD1S 0
	__SUBD1N -1
	__PUTD1S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x4:
	RCALL _FStop
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _Delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x5:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R31
	ST   -Y,R30
	RJMP _VanTocTraiPhai

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x6:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _RunOf

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x7:
	RCALL _TurnRight
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunOf
	RCALL _Min
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunAs
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunOf
	RJMP _TurnLeft

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x8:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _RunOf

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x9:
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunAsTime
	RJMP _FStop

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xA:
	LDI  R30,LOW(1500)
	LDI  R31,HIGH(1500)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _Delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xB:
	RCALL _StopDown
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Delay
	RCALL _In
	LDI  R30,LOW(900)
	LDI  R31,HIGH(900)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Delay
	RCALL _StopIn
	RCALL _Down
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Delay
	RCALL _StopDown
	LDI  R30,LOW(8000)
	LDI  R31,HIGH(8000)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Delay
	RJMP _Up

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xC:
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Delay
	LDI  R30,LOW(_StopUp)
	LDI  R31,HIGH(_StopUp)
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _Delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 22 TIMES
SUBOPT_0xD:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _RunOf

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0xE:
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunAs
	RJMP SUBOPT_0xD

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xF:
	RCALL _Min
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RJMP SUBOPT_0xE

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x10:
	RCALL _In
	LDI  R30,LOW(600)
	LDI  R31,HIGH(600)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _Delay
	RJMP _StopIn

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x11:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _RunAsTime
	RJMP _TurnRight

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x12:
	LDI  R30,LOW(5000)
	LDI  R31,HIGH(5000)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _Delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x13:
	OUT  0x33,R30
	LDI  R30,LOW(0)
	OUT  0x32,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x14:
	OUT  0x25,R30
	LDI  R30,LOW(0)
	OUT  0x24,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x15:
	OUT  0x23,R30
	LDI  R30,LOW(0)
	OUT  0x35,R30
	OUT  0x34,R30
	OUT  0x39,R30
	LDI  R30,LOW(128)
	OUT  0x8,R30
	LDI  R30,LOW(0)
	OUT  0x30,R30
	RET

__ANEGW1:
	COM  R30
	COM  R31
	ADIW R30,1
	RET

__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__NEB12:
	CP   R30,R26
	LDI  R30,1
	BRNE __NEB12T
	CLR  R30
__NEB12T:
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
