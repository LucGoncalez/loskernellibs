;===========================================================================
;	Este arquivo pertence ao Projeto do Sistema Operacional LuckyOS (LOS).
;	--------------------------------------------------------------------------
;	Copyright (C) 2013 - Luciano L. Goncalez
;	--------------------------------------------------------------------------
;	a.k.a.: Master Lucky
;	eMail : master.lucky.br@gmail.com
;	Home  : http://lucky-labs.blogspot.com.br
;===========================================================================
;	Este programa e software livre; voce pode redistribui-lo e/ou modifica-lo
;	sob os termos da Licenca Publica Geral GNU, conforme publicada pela Free
;	Software Foundation; na versao 2 da	Licenca.
;
;	Este programa e distribuido na expectativa de ser util, mas SEM QUALQUER
;	GARANTIA; sem mesmo a garantia implicita de COMERCIALIZACAO ou de
;	ADEQUACAO A QUALQUER PROPOSITO EM PARTICULAR. Consulte a Licenca Publica
;	Geral GNU para obter mais detalhes.
;
;	Voce deve ter recebido uma copia da Licenca Publica Geral GNU junto com
;	este programa; se nao, escreva para a Free Software Foundation, Inc., 59
;	Temple Place, Suite 330, Boston, MA	02111-1307, USA. Ou acesse o site do
;	GNU e obtenha sua licenca: http://www.gnu.org/
;===========================================================================
;	kwrap.asm
;	--------------------------------------------------------------------------
;		Arquivo escrito em Assembly que "envolve" o código escrito em linguagem
;	de alto nivel, ele server para fazer a inicializacao inicial do kernel.
;	--------------------------------------------------------------------------
;	Versao: 0.1
;	Data: 29/04/2013
;	--------------------------------------------------------------------------
;	Compilar: Compilavel pelo nasm (montar)
;	> nasm -f elf32 kwrap.asm
;	------------------------------------------------------------------------
;	Executar: Este arquivo precisa ser linkado com o LD para ser carregado
;		pelo bootloader.
;===========================================================================

; configuracao do kernel
	CPUMin			EQU	3						; 80386
	MemAlign		EQU	12					; 2^12 = 4K
	EntryPoint	EQU 0x00100000	;	1M
	StackSize		EQU	0x00000000	; Extensivel
	HeapSize		EQU	0x00000000	; Extensivel

GLOBAL start
EXTERN kernelinit

SECTION .text

[BITS 32]

start:
	jmp near kstart

	; *** Tabela de dados do kernel usada no boot
	; IMPORTANTE: nao altere, use as constantes de cofiguracao acima
	KT:				; kernel table
	.LOS_Sign		DB	'LOS', 0		;	4 B
	.KT_Sign		DB	'BKT', 0		;	4 B
	.Version		DB	1						;	1 B
	.CPUMin			DB	CPUMin			; 1 B
	.MemAlign		DB	MemAlign		; 1 B
	.EntryPoint	DD	EntryPoint	; 4 B
	.StackSize	DD	StackSize		; 4 B
	.HeapSize		DD	HeapSize		; 4 B
	; total 23 bytes
	; *** Tabela de dados do kernel usada no boot

kstart:
	push eax
	call kernelinit
