.text

main:
  lui $8 0x1001
  
  #desenhar fundo
fundo_prep:
	ori $9 $0 0x1F001F #roxo escuro fundo
	#8192
	addi $25 $0 5120
	
fundo_draw:
	beq $25 $0 tijolo_fundo_prep
	
	sw $9 0($8)
	sw $9 32768($8)
	
	addi $8 $8 4
	addi $25 $25 -1
	j fundo_draw


tijolo_fundo_prep:
	addi $8 $0 0
	lui $8 0x1001
	addi $25 $0 4481 #4504
	addi $24 $0 896
	
tijolo_fundo_draw:
	beq $25 $0 lava_prep
	
	jal teste_height
	
	addi $8 $8 4
	addi $24 $24 -1
	addi $25 $25 -1
	addi $22 $0 -1
	j tijolo_fundo_draw

lava_prep:
	addi $25 $0 39
	
lava_draw:
	jal lava_draw_func

	#desenhar solo
solo_prep:
	addi $8 $8 -4
	add $15 $0 $8
	ori $9 $0 0x9C73B9 #roxo solo
	addi $25 $0 3072
	
solo_draw:
	beq $25 $0 tijolo_solo_prep
	
	sw $9 0($8)
	
	addi $8 $8 4
	addi $25 $25 -1
	j solo_draw
	
	
tijolo_solo_prep:
	addi $25 $0 3072 #4504
	addi $24 $0 0
	
tijolo_solo_draw:
	beq $25 $0 canhao_main
	
	jal teste_height_solo
	
	addi $8 $8 -4
	addi $24 $24 -1
	addi $25 $25 -1
	j tijolo_solo_draw

# canhao
canhao_main:
	jal corrente_func_prep
	
	
npc_prep_main:
	addi $22 $0 20
	lui $8 0x1001
	lui $9 0x1001
	lui $25 0x1001
	addi $8 $8 19492 #altura sonic  !!!!!!!! proibido usar
	addi $9 $9 14748	#altura bala do canhao !!!!!!!! proibido usar
	lui $18 0xffff #registrador movimento !!!!!! proibido usar
	addi $17 $0 0 # l� o registrador movimento !!!!!!!!!!! proibido usar
	jal sonic_prep

npc_joaninha_laco_walk:
	#beq $24 $0 fim
	
	jal bala_canhao_prep
	
	addi $9 $9 -12
	addi $25 $25 -4
	jal timer
	jal reset_bala_verif
	
	add $11 $0 $17
	
	lw $17 0($18)
	beq $17 $0 npc_joaninha_laco_walk
	
	lw $17 4($18)
	
	jal sonic_prep
	
	      
       j npc_joaninha_laco_walk

fim:
  addi $2 $0 10
  syscall

#----------------------func-----------------------
	#funcao linhas hoorizontais fundo
	
teste_height:
	beq $24 $0 height_draw
	
	jr $31

height_draw:
	addi $24 $0 128
	add $20 $0 $31
	ori $10 $0 0x48214F #roxo linha fundo
		
height_draw_l1:
	beq $24 $0 height_fim
	
	sw $10 0($8)
	sw $10 32768($8)
	
	jal brick_test
	
	addi $8 $8 4
	addi $24 $24 -1
	addi $23 $23 -1
	
	j height_draw_l1
	
height_fim:
	addi $24 $0 896
	
	jr $20
	
	
	
	#funcao linhas verticais fundo
	
brick_test:
	beq $23 $0 brick_draw
	
	jr $31
	
brick_draw:
	sw $10 -512($8)
	sw $10 32256($8)
	
	sw $10 -1024($8)
	sw $10 31744($8)
	
	sw $10 -1536($8)
	sw $10 31232($8)
	
	sw $10 -2048($8)
	sw $10 30720($8)
	
	sw $10 -2560($8)
	sw $10 30208($8)
	
	sw $10 -3072($8)
	sw $10 29696($8)
	
	sw $10 -3584($8)
	sw $10 29184($8)
	
	sw $10 -4096($8)
	sw $10 28672($8)
	
	addi $23 $0 12
	jr $31



	#funcao solo linhas horizontais
	
teste_height_solo:
	beq $24 $0 height_draw_solo
	
	jr $31

height_draw_solo:
	addi $24 $0 128
	add $20 $0 $31
	ori $10 $0 0x6A3F84 #roxo linha fundo
		
height_draw_solo_l1:
	beq $24 $0 height_fim_solo
	
	sw $10 0($8)
	jal brick_test_solo
	
	addi $8 $8 4
	addi $24 $24 -1
	addi $23 $23 -1
	
	j height_draw_solo_l1
	
height_fim_solo:
	addi $24 $0 896
	
	jr $20



	#funcao tijolo solo
brick_test_solo:
	beq $23 $0 brick_draw_solo
	
	jr $31
	
brick_draw_solo:
	sw $10 -512($8)
	sw $10 -1024($8)
	sw $10 -1536($8)
	sw $10 -2048($8)
	sw $10 -2560($8)
	sw $10 -3072($8)
	
	addi $23 $0 12
	jr $31
	

######## função lava

lava_draw_func:
	ori $10 $0 0xFF0000 #vermelho lava
	ori $11 $0 0xFF8A00 #laranja lava
	ori $12 $0 0xF9FC2B #amarelo lava
	
	sw $10 0($8)
	sw $10 32768($8)
	
	add $24 $0 $8
	addi $23 $25 -6
	addi $8 $8 -20612
	
lava_laco_start: beq $25 $23 lava_draw_laco_prep
                 addi $8 $8 416
                 addi $22 $0 8
                       
lava_laco2_start:     beq $22 $0 lava_laco3_start_prep
                      sw $10 0($8)
                      sw $10 32768($8)
                      
                      sw $11 4($8)
                      sw $11 32772($8)
                      
                      sw $12 8($8)
                      sw $12 32776($8)
                      
                      addi $8 $8 12
                      addi $22 $22 -1
                      j lava_laco2_start

lava_laco3_start_prep: addi $8 $8 416
                       addi $22 $0 8
                       addi $25 $25 -2
                       
lava_laco3_start:     beq $22 $0 lava_laco_start
		    						  sw $12 0($8)
		    						  sw $12 32768($8)
		    						  
                      sw $10 4($8)
                      sw $10 32772($8)
                                                                    
                      sw $11 8($8)
                      sw $11 32776($8)
                      
                      addi $8 $8 12
                      addi $22 $22 -1
                      j lava_laco3_start

lava_draw_laco_prep: addi $8 $8 -16
	
lava_draw_laco1: beq $25 $0 fim_func_lava
                 addi $8 $8 432
                 addi $25 $25 -1
                 addi $23 $0 2

lava_draw_laco2:     
							 sw $10 0($8)
							 sw $10 32768($8)
							 
	             sw $10 4($8)
	             sw $10 32772($8)
	             
	             sw $10 8($8)
	             sw $10 32776($8)
	             
	             sw $10 12($8)
	             sw $10 32780($8)
	             
	             beq $23 $0 lava_draw_laco1
	             
	             sw $11 16($8)
	             sw $11 32784($8)
	             
	             sw $11 20($8)
	             sw $11 32788($8)
	             
	             sw $11 24($8)
	             sw $11 32792($8)
	             
	             sw $12 28($8)
	             sw $12 32796($8)
	             
	             sw $12 32($8)
	             sw $12 32800($8)
	             
	             sw $12 36($8)
	             sw $12 32804($8)
	             
	             addi $8 $8 40
	             addi $23 $23 -1
	             j lava_draw_laco2
	
fim_func_lava: add $8 $0 $24
               jr $31


#funcao canhao
voltar:
	jr $31
	
#timer buffer

timer:
  addi $16 $0 100000 #100000
  
forT:
	beq $16 $0 voltar
  nop
  nop
  addi $16 $16 -1      
  j forT

corrente_func_prep:
	ori $10 $0 0x5F5F5F #cinza corrente
	
	addi $8 $8 -22148
	addi $8 $8 68
	addi $25 $0 4

corrente_func_draw:
	beq $25 $0 canhao_func_prep
	
	#elo de lado
	sw $10 0($8)
	sw $10 512($8)
	sw $10 1024($8)
	sw $10 1536($8)
	sw $10 2048($8)
	
	#elo de frente esquerda
	sw $10 1532($8)
	sw $10 2040($8)
	sw $10 2552($8)
	sw $10 3064($8)
	sw $10 3580($8)
	
	#elo de frente direita
	sw $10 1540($8)
	sw $10 2056($8)
	sw $10 2568($8)
	sw $10 3080($8)
	sw $10 3588($8)
	
	
	addi $25 $25 -1
	addi $8 $8 3072
	j corrente_func_draw
	
	
canhao_func_prep:
	ori $10 $0 0xF7ED3D #preto canhao 1C1C1C
	ori $11 $0 0xc9bb0e
	
	addi $8 $8 496
	addi $25 $0 3 #3
	
canhao_func_draw:
	beq $25 $0 canhao_func_fim_prep
	
	#boca do canhao
	sw $11 -4($8)
	sw $11 508($8)
	sw $10 512($8)
	sw $10 516($8)
	
	sw $11 -8($8)
	sw $11 504($8)
	sw $11 1016($8)
	sw $11 1528($8)
	sw $11 2040($8)
	sw $10 2552($8)
	
	sw $10 1028($8)
	
	sw $10 1024($8)
	sw $11 1020($8)
	sw $10 1540($8)
	sw $10 1536($8)
	
	sw $11 1532($8)
	sw $10 2048($8)
	sw $11 2044($8)
	sw $11 2556($8)
	
	#corpo
	sw $10 520($8)
	sw $10 524($8)
	sw $10 528($8)
	sw $10 532($8)
	sw $10 536($8)
	sw $10 540($8)
	sw $10 544($8)
	
	sw $10 1032($8)
	sw $10 1036($8)
	sw $10 1040($8)
	sw $10 1044($8)
	sw $10 1048($8)
	sw $10 1052($8)
	sw $10 1056($8)
	
	sw $10 1544($8)
	sw $10 1548($8)
	sw $10 1552($8)
	sw $10 1556($8)
	sw $10 1560($8)
	sw $10 1564($8)
	sw $10 1568($8)
	
	sw $10 2052($8)
	sw $10 2056($8)
	sw $10 2060($8)
	sw $10 2064($8)
	sw $10 2068($8)
	sw $10 2072($8)
	sw $10 2076($8)
	sw $10 2080($8)
	
	addi $25 $25 -1
	addi $8 $8 512
	j canhao_func_draw
	
canhao_func_fim_prep:
	addi $25 $0 2
	addi $8 $8 -1528
	
	ori $10 $0 0xF7ED3D #preto canhao	1C1C1C
	
canhao_func_draw_2:
	beq $25 $0 mario_reference_prep
	
	sw $10 1052($8)
	sw $10 1564($8)
	sw $10 2076($8)
	sw $10 1568($8)
	
	addi $25 $25 -1
	addi $8 $8 512
	j canhao_func_draw_2
	
mario_reference_prep:
	ori $10 $0 0x9B388B #vermelho
	
	addi $8 $8 -512
	

mario_reference_draw:
	#sw $10 504($8)
	#sw $10 536($8)
	sw $10 1020($8)
	sw $10 1044($8)
	sw $10 1536($8)
	sw $10 1552($8)
	
	sw $10 2052($8)
	sw $10 1544($8)
	sw $10 2060($8)
	
	j voltar


sonic_prep:
	ori $10	$0 0x000000 #preto
	ori $12 $0 0x1C2182 #azul sombra
	ori $13 $0 0xC60000 #vermelho luz
	ori $14 $0 0x8E0000 #vermelho sombra
	ori $15 $0 0xEDA137 #pele
	ori $16 $0 0xE0E0E0 #branco olhos
	addi $24 $0 0
	
	beq $17 'a' esquerda
        beq $17 's' baixo
        beq $17 'd' direita
        beq $17 'w' pulo
        beq $17 $0 sonic_draw_direita


esquerda: addi $8 $8 -4
          
          j sonic_costas_prep

direita: addi $8 $8 4

	j sonic_draw_direita

baixo: addi $8 $8 512
      
       jr $31

pulo: addi $8 $8 -512
      
      beq $11 'd' sonic_draw_direita
      beq $11 'a' sonic_draw_esquerda
	
	
sonic_draw_direita: 

	#sapato luz
	sw $13 0($8)
	sw $13 -4($8)
	sw $13 -8($8)
	sw $13 -12($8)
	sw $13 -516($8)
	sw $13 -520($8)
	sw $13 -524($8)
	
	# sapato luz anima��o
	
	lw $24 32752($8)
	sw $24 -16($8)
	
	lw $24 32240($8)
	sw $24 -528($8)
	
	#sapato sombra
	sw $14 4($8)
	sw $14 8($8)
	sw $14 12($8)
	sw $14 -508($8)
	sw $14 -504($8)
	
	# sapato sombra anima��o
	
	lw $24 32256($8)
	sw $24 -512($8)
	
	#pernas
	sw $12 -1032($8)
	sw $12 -1544($8)
	sw $12 -1540($8)
	sw $12 -1536($8)
	
	sw $12 -1020($8)
	sw $12 -1532($8)
	
	# pernas anima��o 
	
	lw $24 31220($8)
	sw $24 -1548($8)
	
	lw $24 31732($8)
	sw $24 -1036($8)
	
	lw $24 31744($8)
	sw $24 -1024($8)
	
	#barriga
	sw $12 -2056($8)
	sw $12 -2060($8)
	sw $12 -2576($8)
	sw $12 -3084($8)
	sw $12 -3592($8)
	sw $12 -4104($8)
	sw $12 -4100($8)
	sw $12 -4096($8)
	sw $12 -4092($8)
	sw $12 -3576($8)
	sw $12 -3060($8)
	sw $12 -2548($8)
	sw $12 -2040($8)
	sw $12 -2044($8)
	
	sw $15 -3588($8)
	sw $15 -3584($8)
	sw $15 -3580($8)
	
	sw $15 -3080($8)
	sw $15 -3076($8)
	sw $15 -3072($8)
	sw $15 -3068($8)
	sw $15 -3064($8)
	
	sw $12 -2572($8)
	sw $15 -2568($8)
	sw $15 -2564($8)
	sw $15 -2560($8)
	sw $15 -2556($8)
	sw $15 -2552($8)
	
	sw $15 -2052($8)
	sw $15 -2048($8)
	
	# barriga anima��o
	
	lw $24 28660($8)
	sw $24 -4108($8)
	
	#braco
	sw $15 -3596($8)
	sw $15 -3600($8)
	sw $15 -3604($8)
	
	sw $15 -3092($8)
	sw $15 -3088($8)
	sw $15 -2580($8)
	sw $15 -2576($8)
	
	sw $16 -2072($8)
	sw $16 -2068($8)
	sw $16 -2064($8)
	sw $16 -1556($8)
	sw $16 -1552($8)
	sw $16 -1044($8)
	
	#bra�o anima��o
	
	lw $24 29160($8)
	sw $24 -3608($8)
	
	lw $24 29672($8)
	sw $24 -3096($8)
	
	lw $24 30184($8)
	sw $24 -2584($8)
	
	lw $24 30692($8)
	sw $24 -2076($8)
	
	lw $24 31208($8)
	sw $24 -1560($8)
	
	lw $24 31720($8)
	sw $24 -1048($8)
	
	#rosto
	sw $15 -4608($8)
	sw $15 -4604($8)
	sw $15 -4600($8)
	sw $15 -4596($8)
	
	sw $15 -5120($8)
	sw $15 -5116($8)
	sw $15 -5112($8)
	sw $15 -5108($8)
	
	sw $15 -5632($8)
	sw $15 -5628($8)
	sw $15 -5624($8)
	sw $15 -5620($8)
	
	sw $12 -4612($8)
	sw $12 -4616($8)
	sw $12 -4620($8)
	sw $12 -4624($8)
	sw $12 -4628($8)
	
	sw $12 -5124($8)
	sw $12 -5128($8)
	sw $12 -5132($8)
	sw $12 -5136($8)
	sw $12 -5140($8)
	sw $12 -5144($8)
	sw $12 -5148($8)
	
	sw $12 -5636($8)
	sw $12 -5640($8)
	sw $12 -5644($8)
	sw $12 -5648($8)
	sw $12 -5652($8)
	sw $12 -5656($8)
	
	sw $12 -6148($8)
	sw $12 -6152($8)
	sw $12 -6156($8)
	sw $12 -6160($8)
	sw $12 -6164($8)
	
	sw $12 -6660($8)
	sw $12 -6664($8)
	sw $12 -6668($8)
	sw $12 -6672($8)
	sw $12 -6676($8)
	sw $12 -6680($8)
	sw $12 -6684($8)
	sw $12 -6688($8)
	
	sw $10 -6644($8)
	sw $10 -6132($8)
	sw $16 -6648($8)
	sw $16 -6136($8)
	sw $10 -6652($8)
	sw $10 -6140($8)
	sw $16 -6656($8)
	sw $16 -6144($8)
	
	sw $12 -7156($8)
	sw $12 -7160($8)
	sw $12 -7164($8)
	sw $12 -7168($8)
	sw $12 -7172($8)
	sw $12 -7176($8)
	sw $15 -7180($8)
	sw $15 -7184($8)
	sw $12 -7188($8)
	sw $12 -7192($8)
	sw $12 -7196($8)
	
	sw $12 -7672($8)
	sw $12 -7676($8)
	sw $12 -7680($8)
	sw $12 -7684($8)
	sw $12 -7688($8)
	sw $12 -7692($8)
	sw $15 -7696($8)
	sw $12 -7700($8)
	sw $12 -7704($8)
	
	sw $12 -8196($8)
	sw $12 -8200($8)
	sw $12 -8204($8)
	sw $15 -8208($8)
	sw $12 -8212($8)
	
	#rosto anima��o
	
	lw $24 24552($8)
	sw $24 -8216($8)
	
	lw $24 25060($8)
	sw $24 -7708($8)
	
	lw $24 25568($8)
	sw $24 -7200($8)
	
	lw $24 26076($8)
	sw $24 -6692($8)
	
	lw $24 26600($8)
	sw $24 -6168($8)
	
	lw $24 27108($8)
	sw $24 -5660($8)
	
	lw $24 27616($8)
	sw $24 -5152($8)
	
	lw $24 28136($8)
	sw $24 -4632($8)
               
               jr $31
 
               
       # desenho sonic andando pela esquerda
                                                  
sonic_costas_prep:

        ori $10	$0 0x000000 #preto
	ori $12 $0 0x1C2182 #azul sombra
	ori $13 $0 0xC60000 #vermelho luz
	ori $14 $0 0x8E0000 #vermelho sombra
	ori $15 $0 0xEDA137 #pele
	ori $16 $0 0xE0E0E0 #branco olhos
	addi $24 $0 0
	
	
	beq $11 'd' limpa_sonic_frente
	
limpa_sonic_frente:# addi $11 $11 -1
                    
	lw $24 31224($8)
	sw $24 -1548($8)
	
	lw $24 31748($8)
	sw $24 -1020($8)

	lw $24 30708($8)
	sw $24 -2060($8)

	lw $24 29172($8)
	sw $24 -3596($8)
	lw $24 29168($8)
	sw $24 -3600($8)
	lw $24 29164($8)
	sw $24 -3604($8)
	
	lw $24 29676($8)
	sw $24 -3092($8)
	lw $24 29680($8)
	sw $24 -3088($8)
	lw $24 30188($8)
	sw $24 -2580($8)
	lw $24 30192($8)
	sw $24 -2576($8)
	
	lw $24 30696($8)
	sw $24 -2072($8)
	lw $24 30700($8)
	sw $24 -2068($8)
	lw $24 30704($8)
	sw $24 -2064($8)
	lw $24 31212($8)
	sw $24 -1556($8)
	lw $24 31216($8)
	sw $24 -1552($8)
	lw $24 31720($8)
	sw $24 -1048($8)

	lw $24 28140($8)
	sw $24 -4628($8)
	
	lw $24 27628($8)
	sw $24 -5140($8)
	lw $24 27624($8)
	sw $24 -5144($8)
	lw $24 27620($8)
	sw $24 -5148($8)
	
	lw $24 27116($8)
	sw $24 -5652($8)
	lw $24 27112($8)
	sw $24 -5656($8)
	
	lw $24 26604($8)
	sw $24 -6164($8)
	
	lw $24 26092($8)
	sw $24 -6676($8)
	lw $24 26088($8)
	sw $24 -6680($8)
	lw $24 26084($8)
	sw $24 -6684($8)
	lw $24 26080($8)
	sw $24 -6688($8)
	
	lw $24 25580($8)
	sw $24 -7188($8)
	lw $24 25576($8)
	sw $24 -7192($8)
	lw $24 25572($8)
	sw $24 -7196($8)
	
	lw $24 25072($8)
	sw $24 -7696($8)
	lw $24 25068($8)
	sw $24 -7700($8)
	lw $24 25064($8)
	sw $24 -7704($8)
	
	lw $24 24572($8)
	sw $24 -8196($8)
	lw $24 24568($8)
	sw $24 -8200($8)
	lw $24 24564($8)
	sw $24 -8204($8)
	lw $24 24560($8)
	sw $24 -8208($8)
	lw $24 24556($8)
	sw $24 -8212($8)
	
    
sonic_draw_esquerda: 
	
	#sapato luz
	sw $13 0($8)
	sw $13 4($8)
	sw $13 8($8)
	sw $13 12($8)
	sw $13 -508($8)
	sw $13 -504($8)
	sw $13 -500($8)
	
	# sapato luz animação
	
	lw $24 32784($8) 
	sw $24 16($8) 
	
	lw $24 32272($8)
	sw $24 -496($8) 
	
	#sapato sombra
	sw $14 -4($8)
	sw $14 -8($8)
	sw $14 -12($8)
	sw $14 -516($8)
	sw $14 -520($8)
	
	# sapato sombra animação
	
	lw $24 32256($8)
	sw $24 -512($8)
	
	#pernas
	sw $12 -1028($8)
	sw $12 -1540($8)
	sw $12 -1536($8)
	sw $12 -1532($8)
	
	sw $12 -1016($8)
	sw $12 -1528($8)
	
	# pernas animação 
	
	lw $24 31244($8)
	sw $24 -1524($8)
	
	lw $24 31756($8)
	sw $24 -1012($8) 
	
	lw $24 31744($8)
	sw $24 -1024($8)
	
	#barriga
	sw $12 -2036($8)
	sw $12 -2040($8)
	sw $12 -2052($8)
	sw $12 -2056($8)
	sw $12 -2572($8)
	sw $12 -3084($8)
	sw $12 -3592($8)
	sw $12 -4104($8)
	sw $12 -4100($8)
	sw $12 -4096($8)
	sw $12 -4092($8)
	sw $12 -3576($8)
	sw $12 -3060($8)
	sw $12 -2548($8)
	
	sw $15 -3588($8)
	sw $15 -3584($8)
	sw $15 -3580($8)
	
	sw $15 -3080($8)
	sw $15 -3076($8)
	sw $15 -3072($8)
	sw $15 -3068($8)
	sw $15 -3064($8)
	
	
	sw $15 -2568($8)
	sw $15 -2564($8)
	sw $15 -2560($8)
	sw $15 -2556($8)
	sw $15 -2552($8)
	
	sw $15 -2048($8)
	sw $15 -2044($8)
	
	# barriga animação
	
	lw $24 28680($8)
	sw $24 -4088($8) 
	
	#braco
	sw $15 -3572($8)
	sw $15 -3568($8)
	sw $15 -3564($8)
	
	sw $15 -3056($8)
	sw $15 -3052($8)
	
	sw $15 -2544($8)
	sw $15 -2540($8)
	
	sw $16 -2024($8)
	sw $16 -2028($8)
	sw $16 -2032($8)
	sw $16 -1520($8)
	sw $16 -1516($8)
	sw $16 -1004($8)
	
	#braço animação
	
	lw $24 29208($8)
	sw $24 -3560($8) 
	
	lw $24 29720($8)
	sw $24 -3048($8) 
	
	lw $24 30232($8)
	sw $24 -2536($8) 
	
	lw $24 30748($8)
	sw $24 -2020($8) 
	
	lw $24 31256($8)
	sw $24 -1512($8)
	
	lw $24 31768($8)
	sw $24 -1000($8) 
	
	#rosto
	
	sw $15 -4624($8)
	sw $15 -4620($8)
	sw $15 -4616($8)
	sw $15 -4612($8)
	
	sw $15 -5136($8)
	sw $15 -5132($8)
	sw $15 -5128($8)
	sw $15 -5124($8)
	
	sw $15 -5648($8) 
	sw $15 -5644($8)
	sw $15 -5640($8)
	sw $15 -5636($8)
	
	sw $12 -4608($8)
	sw $12 -4604($8)
	sw $12 -4600($8)
	sw $12 -4596($8)
	sw $12 -4592($8)
	
	sw $12 -5120($8)
	sw $12 -5116($8)
	sw $12 -5112($8)
	sw $12 -5108($8)
	sw $12 -5104($8)
	sw $12 -5100($8)
	sw $12 -5096($8)
	
	sw $12 -5632($8)
	sw $12 -5628($8)
	sw $12 -5624($8)
	sw $12 -5620($8)
	sw $12 -5616($8)
	sw $12 -5612($8)
	
	sw $12 -6144($8)
	sw $12 -6140($8)
	sw $12 -6136($8)
	sw $12 -6132($8)
	sw $12 -6128($8)
	
	sw $12 -6656($8)
	sw $12 -6652($8)
	sw $12 -6648($8)
	sw $12 -6644($8)
	sw $12 -6640($8)
	sw $12 -6636($8)
	sw $12 -6632($8)
	sw $12 -6628($8)
	
	sw $10 -6672($8)
	sw $10 -6160($8)
	sw $16 -6668($8)
	sw $16 -6156($8)
	sw $10 -6664($8)
	sw $10 -6152($8)
	sw $16 -6660($8)
	sw $16 -6148($8)
	
	sw $12 -7184($8)
	sw $12 -7180($8)
	sw $12 -7176($8)
	sw $12 -7172($8)
	sw $12 -7168($8)
	sw $12 -7164($8)
	sw $15 -7160($8)
	sw $15 -7156($8)
	sw $12 -7152($8)
	sw $12 -7148($8)
	sw $12 -7144($8)
	
	sw $12 -7692($8)
	sw $12 -7688($8)
	sw $12 -7684($8)
	sw $12 -7680($8)
	sw $12 -7676($8)
	sw $12 -7672($8)
	sw $15 -7668($8) 
	sw $12 -7664($8)
	sw $12 -7660($8)
	
	sw $12 -8192($8)
	sw $12 -8188($8)
	sw $12 -8184($8)
	sw $15 -8180($8)
	sw $12 -8176($8)
	
	#rosto animação
	
	lw $24 24596($8)
	sw $24 -8172($8) 
	
	lw $24 25116($8)
	sw $24 -7656($8)
	
	lw $24 25628($8)
	sw $24 -7140($8)
	
	lw $24 26144($8)
	sw $24 -6624($8)
	
	lw $24 26644($8)
	sw $24 -6124($8)
	
	lw $24 27160($8)
	sw $24 -5608($8)
	
	lw $24 27676($8)
	sw $24 -5092($8)
	
	lw $24 28180($8)
	sw $24 -4588($8)
	
	jr $31        

# desenho sonic virando bola
	
bala_canhao_prep:
	ori $10	$0 0xc9bb0e #preto
	
	addi $23 $0 1
	
bala_canhao_draw:
	beq $23 $0 voltar
	
	sw $10 -1032($9)
	sw $10 -1036($9)
	sw $10 -1040($9)
	
	lw $20 31740($9)
	sw $20 -1028($9)
	
	lw $20 31744($9)
	sw $20 -1024($9)
	
	lw $20 31748($9)
	sw $20 -1020($9)
	
	sw $10 -516($9)
	sw $10 -520($9)
	sw $10 -524($9)
	sw $10 -528($9)
	sw $10 -532($9)
	
	lw $20 32256($9)
	sw $20 -512($9)
	
	lw $20 32260($9)
	sw $20 -508($9)
	
	lw $20 32264($9)
	sw $20 -504($9)
	
	sw $10 -4($9)
	sw $10 -8($9)
	sw $10 -12($9)
	sw $10 -16($9)
	sw $10 -20($9)
	
	lw $20 32768($9)
	sw $20 0($9)
	
	lw $20 32772($9)
	sw $20 4($9)
	
	lw $20 32776($9)
	sw $20 8($9)
	
	sw $10 508($9)
	sw $10 504($9)
	sw $10 500($9)
	sw $10 496($9)
	sw $10 492($9)
	
	lw $20 33280($9)
	sw $20 512($9)
	
	lw $20 33284($9)
	sw $20 516($9)
	
	lw $20 33288($9)
	sw $20 520($9)
	
	sw $10 1016($9)
	sw $10 1012($9)
	sw $10 1008($9)

	lw $20 33788($9)
	sw $20 1020($9)
	
	lw $20 33792($9)
	sw $20 1024($9)
	
	lw $20 33796($9)
	sw $20 1028($9)
	
	addi $22 $22 -1
	addi $23 $23 -1
	j bala_canhao_draw


reset_bala_verif:
	beq $22 $0 reset_bala
	
	j voltar
	
reset_bala:
	ori $10 $0 0x1F001F

	sw $10 -1020($9)
	sw $10 -1024($9)
	sw $10 -1028($9)
	
	sw $10 -504($9)
	sw $10 -508($9)
	sw $10 -512($9)
	sw $10 -516($9)
	sw $10 -520($9)
	
	sw $10 8($9)
	sw $10 4($9)
	sw $10 0($9)
	sw $10 -4($9)
	sw $10 -8($9)
	
	sw $10 520($9)
	sw $10 516($9)
	sw $10 512($9)
	sw $10 508($9)
	sw $10 504($9)
	
	sw $10 1028($9)
	sw $10 1024($9)
	sw $10 1020($9)

	
	addi $22 $0 20
	lui $9 0x1001
	addi $9 $9 14748

	j voltar