; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Desenvolvido por:
; Bruno Arrielo Chagas
; Gustavo Terabe Moy
; Ver 1 19/03/2018
; Ver 2 26/08/2018


; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Definições de Valores

BIT0	EQU 2_0001
BIT1	EQU 2_0010


;Numero 0 a 9 LCD
USE_0	EQU	2_00110000
USE_1	EQU	2_00110001
USE_2	EQU	2_00110010
USE_3	EQU	2_00110011
USE_4	EQU	2_00110100
USE_5	EQU	2_00110101
USE_6	EQU	2_00110110
USE_7	EQU	2_00110111
USE_8	EQU	2_00111000
USE_9	EQU	2_00111001
USE_EQ	EQU	2_00111101
USE_x	EQU	2_01111000
USE_MU	EQU	2_00101010
USE_AD	EQU	2_00101011
USE_SU	EQU	2_00101101

;Alfabeto LCD
USE_SPC	EQU	2_00100000
USE_A	EQU	2_01000001
USE_B	EQU	2_01000010
USE_C	EQU	2_01000011
USE_D	EQU	2_01000100
USE_E	EQU	2_01000101
USE_F	EQU	2_01000110
USE_G	EQU	2_01000111
USE_H	EQU	2_01001000
USE_I	EQU	2_01001001
USE_J	EQU	2_01001010
USE_K	EQU	2_01001011
USE_L	EQU	2_01001100
USE_M	EQU	2_01001101
USE_N	EQU	2_01001110
USE_O	EQU	2_01001111
USE_P	EQU	2_01010000
USE_Q	EQU	2_01010001
USE_R	EQU	2_01010010
USE_S	EQU	2_01010011
USE_T	EQU	2_01010100
USE_U	EQU	2_01010101
USE_V	EQU	2_01010110
USE_W	EQU	2_01010111
USE_X	EQU	2_01011000
USE_Y	EQU	2_01011001
USE_Z	EQU	2_01011010

; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		
vetor	SPACE 10
; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
		
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
		IMPORT  PortA_Output
		IMPORT  PortB_Output
		IMPORT  PortK_Output
		IMPORT  PortM_Output
        ;IMPORT  PortN_Output
        IMPORT  PortJ_Input	


; -------------------------------------------------------------------------------
; Função main()
Start
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	pop		{LR}
	MOV 	R0, #50				 ;Registrador Faz-tudo
	BL		SysTick_Wait1ms
	MOV 	R5, #0				 ;Registrador do Enable, Rs e Rw	
	MOV 	R6, #10				 ;Registrador das Dezenas
	MOV 	R7, #0				 ;Registrador das Multiplicações
	MOV 	R8, #0				 ;Registrador dos Multiplicadores
	MOV 	R9, #0     			 ;Registrador Auxiliar
	MOV		R10,#10	
	LDR 	R11, =vetor
Zera_vetor
	MOV		R0, #0
	CMP 	R8, #10
	BEQ		Inicializa_LCD
	STRB	R0,[R11,R8]
	ADD		R8, #1
	MOV		R0, #0
	B		Zera_vetor
Ativa_Enable
	MOV 	R0, #5
	PUSH	{LR}
	BL		SysTick_Wait1ms
	BIC 	R5, #2_00000100
	MOV		R0, #2_00000100
	ORR 	R5,R5,R0
	BL		PortM_Output
	MOV 	R0, #5
	BL		SysTick_Wait1ms
	BIC 	R5, #2_00000100
	MOV 	R0, #2_00000000
	ORR 	R5,R5,R0
	BL		PortM_Output
	POP 	{LR}
	BX 		LR
Desativa_Rs
	PUSH	{LR}
	MOV 	R5,	#2_00000000
	BL		PortM_Output
	POP		{LR}
	BX		LR
Ativa_Rs
	PUSH	{LR}
	MOV 	R5,	#2_00000001
	BL		PortM_Output
	POP		{LR}
	BX		LR
Limpa_Display
	PUSH	{LR}
	BL		Desativa_Rs
	MOV 	R0,	#2_00000001
	BL		PortK_Output
	BL		Ativa_Enable
	BL		Ativa_Rs
	POP		{LR}
	BX		LR
Escreve_Linha2
	PUSH	{LR}
	BL		Desativa_Rs
	MOV     R0, #0xC0
	BL		PortK_Output
	BL		Ativa_Enable
	BL		Ativa_Rs
	POP		{LR}
	BX		LR
Print_LCD
	PUSH	{LR}
	BL		PortK_Output
	BL		Ativa_Enable
	POP		{LR}
	BX		LR
Inicializa_LCD
	;Configuração Display Incializar modo 2 linhas
	MOV 	R0, #2_00111000
	BL		PortK_Output
	BL		Ativa_Enable
	;Configuração Cursor INICIALIZAÇÃO
	MOV 	R0, #2_00001100
	BL		PortK_Output
	BL		Ativa_Enable
	;Autoincremento Cursor
	MOV 	R6, #2_00000110
	BL		PortK_Output
	BL		Ativa_Enable
	;Limpa e envia para home o Cursor
	BL		Limpa_Display
	;Liga a frase
	BL		Ativa_Rs
	MOV 	R0,	#USE_P
	BL		Print_LCD
	MOV 	R0,	#USE_R
	BL		Print_LCD
	MOV 	R0,	#USE_E
	BL		Print_LCD
	MOV 	R0,	#USE_C
	BL		Print_LCD
	MOV 	R0,	#USE_I
	BL		Print_LCD
	MOV 	R0,	#USE_S
	BL		Print_LCD
	MOV 	R0,	#USE_O
	BL		Print_LCD
	MOV 	R0,	#USE_SPC
	BL		Print_LCD
	MOV 	R0,	#USE_D
	BL		Print_LCD
	MOV 	R0,	#USE_E
	BL		Print_LCD
	MOV 	R0,	#USE_SPC
	BL		Print_LCD
	MOV 	R0,	#USE_N
	BL		Print_LCD
	MOV 	R0,	#USE_O
	BL		Print_LCD
	MOV 	R0,	#USE_T
	BL		Print_LCD
	MOV 	R0,	#USE_A
	BL		Print_LCD
	B		Loop
	
Escreve_FraseM
	PUSH	{LR}
	MOV 	R0, #USE_T
	BL		Print_LCD
	MOV 	R0, #USE_A
	BL		Print_LCD
	MOV 	R0, #USE_B
	BL		Print_LCD
	MOV 	R0, #USE_U
	BL		Print_LCD
	MOV 	R0, #USE_A
	BL		Print_LCD
	MOV 	R0, #USE_D
	BL		Print_LCD
	MOV 	R0, #USE_A
	BL		Print_LCD
	MOV 	R0, #USE_SPC
	BL		Print_LCD
	MOV 	R0, #USE_D
	BL		Print_LCD
	MOV 	R0, #USE_O
	BL		Print_LCD
	MOV 	R0, #USE_SPC
	BL		Print_LCD
	MOV		R6,R10
	BL		Escreve_Num
	POP		{LR}
	BX		LR	
Escreve_Eq
	PUSH	{LR}
	MOV		R6,R10
	BL		Escreve_Num
	MOV 	R0, #USE_x
	BL		Print_LCD
	POP		{LR}
	BX		LR
Escreve_Num	
	PUSH	{LR}
	CMP		R6, #0
	BLEQ 	Num_0
	CMP		R6, #1
	BLEQ 	Num_1
	CMP		R6, #2
	BLEQ 	Num_2
	CMP		R6, #3
	BLEQ 	Num_3
	CMP		R6, #4
	BLEQ 	Num_4
	CMP		R6, #5
	BLEQ 	Num_5
	CMP		R6, #6
	BLEQ 	Num_6
	CMP		R6, #7
	BLEQ 	Num_7
	CMP		R6, #8
	BLEQ 	Num_8
	CMP		R6, #9
	BLEQ 	Num_9
	CMP		R6, #10
	BLEQ 	Num_1
	BLEQ 	Num_0
	POP	{LR}
	MOV R6,#10
	BX	LR
Num_0
	PUSH	{LR}
	MOV 	R0, #USE_0
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_1
	PUSH	{LR}
	MOV 	R0, #USE_1
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_2
	PUSH	{LR}
	MOV 	R0, #USE_2
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_3
	PUSH	{LR}
	MOV 	R0, #USE_3
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_4
	PUSH	{LR}
	MOV 	R0, #USE_4
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_5
	PUSH	{LR}
	MOV 	R0, #USE_5
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_6
	PUSH	{LR}
	MOV 	R0, #USE_6
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_7
	PUSH	{LR}
	MOV 	R0, #USE_7
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_8
	PUSH	{LR}
	MOV 	R0, #USE_8
	BL		Print_LCD
	POP		{LR}
	BX		LR
Num_9	
	PUSH	{LR}
	MOV 	R0, #USE_9
	BL		Print_LCD
	POP		{LR}
	BX		LR
EQUAL
	PUSH	{LR}
	MOV 	R0, #USE_EQ
	BL		Print_LCD
	POP		{LR}
	BX		LR
Set_1
	MOV		R10, #1
	B		Multiplicador
Set_2
	MOV		R10, #2
	B		Multiplicador
Set_3	
	MOV		R10, #3
	B		Multiplicador
Set_4
	MOV		R10, #4
	B		Multiplicador
Set_5	
	MOV 	R10, #5
	B		Multiplicador
Set_6
	MOV		R10, #6
	B		Multiplicador
Set_7
	MOV		R10, #7
	B		Multiplicador
Set_8
	MOV		R10, #8
	B		Multiplicador
Set_9
	MOV		R10, #9
	B		Multiplicador

Multiplicador
	MOV		R0, R10
	SUB		R0, #1
	LDRB	R8,	[R11,R0]
	BL		Limpa_Display
	BL		Escreve_FraseM
	BL		Escreve_Linha2
	BL		Escreve_Eq
	MOV		R6,R8
	BL		Escreve_Num
	MOV 	R0, #USE_EQ
	BL		Print_LCD
	MUL		R7,R10,R8
	ADD 	R8, #1
	MOV		R9, #1
	CMP		R8, #10
	BEQ		Reboot_Multiplicador
	MOV		R0, R10
	SUB		R0, #1
	STRB	R8, [R11,R0]
	B		Identifica_Dezena
Acende_LED
	MOV 	R0, #2_00010000
	BL		PortA_Output
	BL		PortB_Output
	MOV 	R5,	#2_01000000
	BL		PortM_Output
	MOV 	R0, #2000
	BL		SysTick_Wait1ms
	MOV 	R0, #2_00000000
	BL		PortA_Output
	MOV		R9, #25
	B 		Loop
Reboot_Multiplicador
	MOV		R8, #0
	MOV		R0, R10
	SUB		R0, #1
	STRB	R8, [R11,R0]
	MOV		R10, #10
	B		Identifica_Dezena
Contador
	ADD 	R9, #1
	MOV 	R0, #20
	BL		SysTick_Wait1ms
	B		Loop
Loop
	CMP		R9, #25
	BNE		Contador
	BL 		PortJ_Input				 ;Chama a subrotina que lê o estado das chaves e coloca o resultado em R0
	CMP		R0,	#2_0001
	BEQ		Set_3
	CMP		R0,	#2_0010
	BEQ		Set_6
	CMP		R0,	#2_0000
	BEQ		Set_9
	B 		Loop
	
Identifica_Dezena
	CMP 	R7,R6
	BGE 	Multiplicador10
	CMP		R9, #1
	BEQ		Identifica_Unidade
	SUB		R9, #1
	MOV		R6, #10
	MUL		R6, R9
	SUB		R7,	R6
	MOV		R6, R9
	BL		Escreve_Num
	MUL		R6, R9
	MOV		R9, #1
	B		Identifica_Dezena
Multiplicador10
	ADD		R9, #1
	MOV		R6, #10
	MUL		R6, R9
	B		Identifica_Dezena	
Identifica_Unidade
	MOV		R9, #0
	MOV		R6, R7
	BL		Escreve_Num
	CMP 	R10, #10
	BEQ		Acende_LED
	B		Loop
	

	

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
	ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo
