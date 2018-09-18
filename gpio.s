; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
; ========================
; Defini��es de Valores

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



; ========================
; Defini��es dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; Defini��es dos Ports
;PORT A
GPIO_PORTA_AHB_LOCK_R    	EQU    0x40058520
GPIO_PORTA_AHB_CR_R      	EQU    0x40058524
GPIO_PORTA_AHB_AMSEL_R   	EQU    0x40058528
GPIO_PORTA_AHB_PCTL_R    	EQU    0x4005852C
GPIO_PORTA_AHB_DIR_R     	EQU    0x40058400
GPIO_PORTA_AHB_AFSEL_R   	EQU    0x40058420
GPIO_PORTA_AHB_DEN_R     	EQU    0x4005851C
GPIO_PORTA_AHB_PUR_R     	EQU    0x40058510	
GPIO_PORTA_AHB_DATA_R    	EQU    0x400583FC
GPIO_PORTA  				EQU    2_000000000000001
;PORT B
GPIO_PORTB_AHB_LOCK_R    	EQU    0x40059520
GPIO_PORTB_AHB_CR_R      	EQU    0x40059524
GPIO_PORTB_AHB_AMSEL_R   	EQU    0x40059528
GPIO_PORTB_AHB_PCTL_R    	EQU    0x4005952C
GPIO_PORTB_AHB_DIR_R     	EQU    0x40059400
GPIO_PORTB_AHB_AFSEL_R   	EQU    0x40059420
GPIO_PORTB_AHB_DEN_R     	EQU    0x4005951C
GPIO_PORTB_AHB_PUR_R     	EQU    0x40059510	
GPIO_PORTB_AHB_DATA_R    	EQU    0x400593FC
GPIO_PORTB  				EQU    2_000000000000010
;PORT C
;GPIO_PORTC_AHB_LOCK_R    	EQU    0x4005A520
;GPIO_PORTC_AHB_CR_R      	EQU    0x4005A524
;GPIO_PORTC_AHB_AMSEL_R   	EQU    0x4005A528
;GPIO_PORTC_AHB_PCTL_R    	EQU    0x4005A52C
;GPIO_PORTC_AHB_DIR_R     	EQU    0x4005A400
;GPIO_PORTC_AHB_AFSEL_R   	EQU    0x4005A420
;GPIO_PORTC_AHB_DEN_R     	EQU    0x4005A51C
;GPIO_PORTC_AHB_PUR_R     	EQU    0x4005A510	
;GPIO_PORTC_AHB_DATA_R    	EQU    0x4005A3FC
;GPIO_PORTC  				EQU    2_000000000000100
; PORT J
GPIO_PORTJ_AHB_LOCK_R    	EQU    0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU    0x4006052C
GPIO_PORTJ_AHB_DIR_R     	EQU    0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU    0x40060420
GPIO_PORTJ_AHB_DEN_R     	EQU    0x4006051C
GPIO_PORTJ_AHB_PUR_R     	EQU    0x40060510	
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ               	EQU    2_000000100000000
; PORT K
GPIO_PORTK_AHB_LOCK_R    	EQU    0x40061520
GPIO_PORTK_AHB_CR_R      	EQU    0x40061524
GPIO_PORTK_AHB_AMSEL_R   	EQU    0x40061528
GPIO_PORTK_AHB_PCTL_R    	EQU    0x4006152C
GPIO_PORTK_AHB_DIR_R     	EQU    0x40061400
GPIO_PORTK_AHB_AFSEL_R   	EQU    0x40061420
GPIO_PORTK_AHB_DEN_R     	EQU    0x4006151C
GPIO_PORTK_AHB_PUR_R     	EQU    0x40061510	
GPIO_PORTK_AHB_DATA_R    	EQU    0x400613FC
GPIO_PORTK               	EQU    2_000001000000000
; PORT L
GPIO_PORTL_AHB_LOCK_R    	EQU    0x40062520
GPIO_PORTL_AHB_CR_R      	EQU    0x40062524
GPIO_PORTL_AHB_AMSEL_R   	EQU    0x40062528
GPIO_PORTL_AHB_PCTL_R    	EQU    0x4006252C
GPIO_PORTL_AHB_DIR_R     	EQU    0x40062400
GPIO_PORTL_AHB_AFSEL_R   	EQU    0x40062420
GPIO_PORTL_AHB_DEN_R     	EQU    0x4006251C
GPIO_PORTL_AHB_PUR_R     	EQU    0x40062510	
GPIO_PORTL_AHB_DATA_R    	EQU    0x400623FC
GPIO_PORTL               	EQU    2_000010000000000
; PORT M
GPIO_PORTM_AHB_LOCK_R    	EQU    0x40063520
GPIO_PORTM_AHB_CR_R      	EQU    0x40063524
GPIO_PORTM_AHB_AMSEL_R   	EQU    0x40063528
GPIO_PORTM_AHB_PCTL_R    	EQU    0x4006352C
GPIO_PORTM_AHB_DIR_R     	EQU    0x40063400
GPIO_PORTM_AHB_AFSEL_R   	EQU    0x40063420
GPIO_PORTM_AHB_DEN_R     	EQU    0x4006351C
GPIO_PORTM_AHB_PUR_R     	EQU    0x40063510	
GPIO_PORTM_AHB_DATA_R    	EQU    0x400633FC
GPIO_PORTM               	EQU    2_000100000000000
; PORT N
;GPIO_PORTN_AHB_LOCK_R    	EQU    0x40064520
;GPIO_PORTN_AHB_CR_R      	EQU    0x40064524
;GPIO_PORTN_AHB_AMSEL_R   	EQU    0x40064528
;GPIO_PORTN_AHB_PCTL_R    	EQU    0x4006452C
;GPIO_PORTN_AHB_DIR_R     	EQU    0x40064400
;GPIO_PORTN_AHB_AFSEL_R   	EQU    0x40064420
;GPIO_PORTN_AHB_DEN_R     	EQU    0x4006451C
;GPIO_PORTN_AHB_PUR_R     	EQU    0x40064510	
;GPIO_PORTN_AHB_DATA_R    	EQU    0x400643FC
;GPIO_PORTN               	EQU    2_001000000000000	
;;PORT Q
;GPIO_PORTQ_AHB_LOCK_R    	EQU    0x40066520
;GPIO_PORTQ_AHB_CR_R      	EQU    0x40066524
;GPIO_PORTQ_AHB_AMSEL_R   	EQU    0x40066528
;GPIO_PORTQ_AHB_PCTL_R    	EQU    0x4006652C
;GPIO_PORTQ_AHB_DIR_R     	EQU    0x40066400
;GPIO_PORTQ_AHB_AFSEL_R   	EQU    0x40066420
;GPIO_PORTQ_AHB_DEN_R     	EQU    0x4006651C
;GPIO_PORTQ_AHB_PUR_R     	EQU    0x40066510	
;GPIO_PORTQ_AHB_DATA_R    	EQU    0x400663FC
;GPIO_PORTQ  				EQU    2_100000000000000


; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT PortA_Output			; Permite chamar PortN_Output de outro arquivo
		EXPORT PortB_Output			; Permite chamar PortN_Output de outro arquivo
		EXPORT PortK_Output			; Permite chamar PortN_Output de outro arquivo
		EXPORT PortM_Output			; Permite chamar PortN_Output de outro arquivo
		;EXPORT PortN_Output			; Permite chamar PortN_Output de outro arquivo
		EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo
									

;--------------------------------------------------------------------------------
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
GPIO_Init
;=====================
; ****************************************
; Escrever fun��o de inicializa��o dos GPIO
; Inicializar as portas J e N
; ****************************************
;=====================
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; ap�s isso verificar no PRGPIO se a porta est� pronta para uso.
; enable clock to GPIOF at clock gating register
            LDR     R0, =SYSCTL_RCGCGPIO_R  		;Carrega o endere�o do registrador RCGCGPIO
			MOV    	R1, #GPIO_PORTA	
			ORR  	R1, #GPIO_PORTB
			;ORR  	R1, #GPIO_PORTC
			ORR  	R1, #GPIO_PORTK
			ORR  	R1, #GPIO_PORTL
			ORR     R1, #GPIO_PORTJ					;Seta o bit da porta J, fazendo com OR
            ORR  	R1, #GPIO_PORTM
			;ORR		R1, #GPIO_PORTN                 ;Seta o bit da porta N
			;ORR  	R1, #GPIO_PORTQ
			STR     R1, [R0]						;Move para a mem�ria os bits das portas no endere�o do RCGCGPIO
 
            LDR     R0, =SYSCTL_PRGPIO_R			;Carrega o endere�o do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  LDR     R1, [R0]						;L� da mem�ria o conte�do do endere�o do registrador
			MOV    	R2, #GPIO_PORTA	
			ORR  	R2, #GPIO_PORTB
			;ORR  	R1, #GPIO_PORTC
			ORR     R2, #GPIO_PORTJ                 ;Seta o bit da porta J, fazendo com OR
            ORR  	R2, #GPIO_PORTK
			ORR  	R2, #GPIO_PORTL
			ORR  	R2, #GPIO_PORTM
			;ORR		R2, #GPIO_PORTN                 ;Seta os bits correspondentes �s portas para fazer a compara��o
			;ORR  	R2, #GPIO_PORTQ
			TST     R1, R2							;ANDS de R1 com R2
            BEQ     EsperaGPIO					    ;Se o flag Z=1, volta para o la�o. Sen�o continua executando
 
; 2. Limpar o AMSEL para desabilitar a anal�gica
            MOV     R1, #0x00						;Colocar 0 no registrador para desabilitar a fun��o anal�gica
            LDR     R0, =GPIO_PORTA_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
			LDR     R0, =GPIO_PORTB_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
			LDR     R0, =GPIO_PORTC_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            LDR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
			AND		R1, #2_11110000
			ORR		R1, #0x00
			STR		R1, [R0]
			LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
            LDR     R0, =GPIO_PORTK_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
			LDR     R0, =GPIO_PORTL_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
			LDR     R0, =GPIO_PORTM_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
			;LDR     R0, =GPIO_PORTN_AHB_AMSEL_R		;Carrega o R0 com o endere�o do AMSEL para a porta N
            ;STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta N da mem�ria
			;LDR     R0, =GPIO_PORTQ_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            ;STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
			
; 3. Limpar PCTL para selecionar o GPIO
            MOV     R1, #0x00					    ;Colocar 0 no registrador para selecionar o modo GPIO
            LDR     R0, =GPIO_PORTA_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta N
            STR     R1, [R0]  
			LDR     R0, =GPIO_PORTB_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta N
            STR     R1, [R0]  
			LDR     R0, =GPIO_PORTC_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta N
            LDR     R1, [R0]
			LDR		R2,=0x11110000
			BIC		R1,R2
			STR		R1, [R0]
			LDR     R0, =GPIO_PORTJ_AHB_PCTL_R		;Carrega o R0 com o endere�o do PCTL para a porta J
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da mem�ria
            LDR     R0, =GPIO_PORTK_AHB_PCTL_R		;Carrega o R0 com o endere�o do PCTL para a porta J
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTL_AHB_PCTL_R		;Carrega o R0 com o endere�o do PCTL para a porta J
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTM_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta N
            STR     R1, [R0]  			
			;LDR     R0, =GPIO_PORTN_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta N
            ;STR     R1, [R0]                        ;Guarda no registrador PCTL da porta N da mem�ria
			;LDR     R0, =GPIO_PORTQ_AHB_PCTL_R      ;Carrega o R0 com o endere�o do PCTL para a porta N
            ;STR     R1, [R0]  					    ;Guarda no registrador AMSEL da porta N da mem�ria 

; 4. DIR para 0 se for entrada, 1 se for sa�da
			LDR     R0, =GPIO_PORTA_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta N
			MOV     R1, #2_11110000					;PA7 & PA4 para LED
            STR     R1, [R0]						;Guarda no registrador
			LDR     R0, =GPIO_PORTB_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta N
			MOV     R1, #2_00110000					;PA7 & PA4 para LED
            STR     R1, [R0]		
			LDR     R0, =GPIO_PORTC_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta N
			LDR		R1, [R0]
			BIC		R1, #2_11110000					;Guarda no registrador
			ORR		R1, #2_11110000
			STR		R1, [R0]
			LDR     R0, =GPIO_PORTK_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta N
			MOV     R1, #2_11111111					;PA7 & PA4 para LED
            STR     R1, [R0]		
			LDR     R0, =GPIO_PORTL_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta N
			MOV     R1, #0x00					;PA7 & PA4 para LED
            STR     R1, [R0]						;Guarda no registrador
			LDR     R0, =GPIO_PORTM_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta N
			MOV     R1, #2_01000111					;PA7 & PA4 para LED
            STR     R1, [R0]						;Guarda no registrador
            ;LDR     R0, =GPIO_PORTN_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta N
			;MOV     R1, #BIT0						;PN1 & PN0 para LED
			;ORR     R1, #BIT1      					;Enviar o valor 0x03 para habilitar os pinos como sa�da
            ;STR     R1, [R0]						;Guarda no registrador
			;LDR     R0, =GPIO_PORTQ_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta N
			;MOV     R1, #2_00001111					;PA7 & PA4 para LED
            ;STR     R1, [R0]						;Guarda no registrador

			; O certo era verificar os outros bits da PJ para n�o transformar entradas em sa�das desnecess�rias
            LDR     R0, =GPIO_PORTJ_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com sa�da
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
; 5. Limpar os bits AFSEL para 0 para selecionar GPIO 
;    Sem fun��o alternativa
            MOV     R1, #0x00						;Colocar o valor 0 para n�o setar fun��o alternativa
            LDR     R0, =GPIO_PORTA_AHB_AFSEL_R		;Carrega o endere�o do AFSEL da porta N
            STR     R1, [R0]						;Escreve na porta
			LDR     R0, =GPIO_PORTB_AHB_AFSEL_R		;Carrega o endere�o do AFSEL da porta N
            STR     R1, [R0]						;Escreve na porta
			LDR     R0, =GPIO_PORTC_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
            LDR     R1, [R0]                        ;Escreve na porta
			BIC		R1, #2_11110000
			ORR		R1, #0x00
			STR		R1, [R0]
			LDR     R0, =GPIO_PORTK_AHB_AFSEL_R		;Carrega o endere�o do AFSEL da porta N
            STR     R1, [R0]						;Escreve na porta
			LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTL_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTM_AHB_AFSEL_R		;Carrega o endere�o do AFSEL da porta N
            STR     R1, [R0]						;Escreve na porta
			;LDR     R0, =GPIO_PORTN_AHB_AFSEL_R		;Carrega o endere�o do AFSEL da porta N
            ;STR     R1, [R0]						;Escreve na porta
			;LDR     R0, =GPIO_PORTQ_AHB_AFSEL_R		;Carrega o endere�o do AFSEL da porta N
            ;STR     R1, [R0]						;Escreve na porta
; 6. Setar os bits de DEN para habilitar I/O digital
			LDR     R0, =GPIO_PORTA_AHB_DEN_R			;Carrega o endere�o do DEN
            LDR     R1, [R0]							;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			MOV     R2, #2_11110000
            ORR     R1, R2
            STR     R1, [R0]	
			
			LDR     R0, =GPIO_PORTB_AHB_DEN_R			;Carrega o endere�o do DEN
            LDR     R1, [R0]							;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			MOV     R2, #2_00110000
            ORR     R1, R2
            STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital 
			
			LDR     R0, =GPIO_PORTC_AHB_DEN_R			;Carrega o endere�o do DEN
            LDR     R1, [R0]							;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			MOV		R1, R0
			MOV     R2, #0xF0
            ORR     R1, R2
            STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital 
			
			LDR     R0, =GPIO_PORTJ_AHB_DEN_R			;Carrega o endere�o do DEN
            LDR     R1, [R0]                            ;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			MOV     R2, #BIT0                           
			ORR     R2, #BIT1			                ;Habilitar funcionalidade digital na DEN os bits 0 e 1
            ORR     R1, R2                              
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital

			LDR     R0, =GPIO_PORTK_AHB_DEN_R			;Carrega o endere�o do DEN
            LDR     R1, [R0]							;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			MOV     R2, #2_11111111
            ORR     R1, R2
            STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital
			
			LDR     R0, =GPIO_PORTL_AHB_DEN_R			;Carrega o endere�o do DEN
            LDR     R1, [R0]							;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			MOV     R2, #0x0F
            ORR     R1, R2
            STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital
			
			LDR     R0, =GPIO_PORTM_AHB_DEN_R			;Carrega o endere�o do DEN
            LDR     R1, [R0]							;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			MOV     R2, #2_01000111
            ORR     R1, R2
            STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital

            ;LDR     R0, =GPIO_PORTN_AHB_DEN_R			;Carrega o endere�o do DEN
            ;LDR     R1, [R0]							;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			;MOV     R2, #BIT0
			;ORR     R2, #BIT1							;Habilitar funcionalidade digital na DEN os bits 0 e 1
            ;ORR     R1, R2
            ;STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital 

			;LDR     R0, =GPIO_PORTQ_AHB_DEN_R			;Carrega o endere�o do DEN
            ;LDR     R1, [R0]							;Ler da mem�ria o registrador GPIO_PORTN_AHB_DEN_R
			;MOV     R2, #2_00001111
            ;ORR     R1, R2
            ;STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital 
			
; 7. Para habilitar resistor de pull-up interno, setar PUR para 1
			;LDR     R0, =GPIO_PORTC_AHB_PUR_R			;Carrega o endere�o do PUR para a porta J
			;MOV     R1, #2_11110000
            ;STR     R1, [R0]							;Escreve no registrador da mem�ria do resistor de pull-up
			;BX      LR
			
			LDR     R0, =GPIO_PORTJ_AHB_PUR_R			;Carrega o endere�o do PUR para a porta J
			MOV     R1, #BIT0							;Habilitar funcionalidade digital de resistor de pull-up 
			ORR     R1, #BIT1							;nos bits 0 e 1
            STR     R1, [R0]							;Escreve no registrador da mem�ria do resistor de pull-up
			BX      LR
			
			LDR		R0, =GPIO_PORTL_AHB_PUR_R
			MOV		R1, #0x0F
			STR		R1, [R0]
			BX		LR

; -------------------------------------------------------------------------------
; Fun��o PortN_Output
; Par�metro de entrada: 
; Par�metro de sa�da: N�o tem
PortA_Output
	LDR	R1, =GPIO_PORTA_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11110000                   	;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11111100
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta N o barramento de dados dos pinos [N5-N0]
	BX LR	

PortB_Output
	LDR	R1, =GPIO_PORTB_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	;LDR R2, [R1]
	;BIC R2, #2_00110000                  	;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11111100
	;ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	MOV	R0, #2_00000000
	STR R0, [R1]                            ;Escreve na porta N o barramento de dados dos pinos [N5-N0]
	BX LR
	
PortK_Output
	LDR	R1, =GPIO_PORTK_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11111111                		;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11111100
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta N o barramento de dados dos pinos [N5-N0]
	BX LR

PortM_Output
	LDR	R1, =GPIO_PORTM_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_01000111                    	;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11111100
	ORR R5, R5, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R5, [R1]                            ;Escreve na porta N o barramento de dados dos pinos [N5-N0]
	BX LR
	
;PortN_Output
	;LDR	R1, =GPIO_PORTN_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	;LDR R2, [R1]
	;BIC R2, #2_00000011                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11111100
	;ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	;STR R0, [R1]                            ;Escreve na porta N o barramento de dados dos pinos [N5-N0]
	;BX LR	

;PortQ_Output
	;LDR	R1, =GPIO_PORTQ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	;LDR R2, [R1]
	;BIC R2, #2_00001111                    	
	;ORR R0, R0, R2                          
	;STR R0, [R1]                            
	;BX LR	

; -------------------------------------------------------------------------------
; Fun��o PortJ_Input
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: R0 --> o valor da leitura
PortJ_Input
	LDR	R1, =GPIO_PORTJ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	LDR R0, [R1]                            ;L� no barramento de dados dos pinos [J1-J0]
	BX LR	
; ****************************************
; Escrever fun��o que l� a chave e retorna 
; um registrador se est� ativada ou n�o
; ****************************************

; -------------------------------------------------------------------------------

	



    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo