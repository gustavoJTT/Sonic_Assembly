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
	lui $8 0x1001
	lui $9 0x1001
	addi $8 $8 19492 #altura sonic
	addi $9 $9 19700	#altura doc
	
	addi $24 $0 30

npc_joaninha_laco_walk:
	beq $24 $0 fim
	
	jal sonic_prep
	jal doc_prep
	jal timer
	
	addi $9 $9 -4
	addi $24 $24 -1
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

lava_draw_laco2:     sw $10 0($8)
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
	addi $8 $8 48
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
	ori $11 $0 0x5D60C1	#azul luz
	ori $12 $0 0x1C2182 #azul sombra
	ori $13 $0 0xC60000 #vermelho luz
	ori $14 $0 0x8E0000 #vermelho sombra
	ori $15 $0 0xEDA137 #pele
	ori $16 $0 0xE0E0E0 #branco olhos
	
	addi $23 $0 1
	
	
sonic_draw:
	beq $23 $0 voltar

	#sapato luz
	sw $13 0($8)
	sw $13 -4($8)
	sw $13 -8($8)
	sw $13 -12($8)
	sw $13 -516($8)
	sw $13 -520($8)
	sw $13 -524($8)
	
	#sapato sombra
	sw $14 4($8)
	sw $14 8($8)
	sw $14 12($8)
	sw $14 -508($8)
	sw $14 -504($8)
	
	#pernas
	sw $12 -1032($8)
	sw $12 -1544($8)
	sw $12 -1540($8)
	sw $12 -1536($8)
	
	sw $12 -1020($8)
	sw $12 -1532($8)
	
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
	
	#sw $12 -7668($8)
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
	
	addi $23 $23 -1
	j sonic_draw

doc_prep:	#movimento com o $20 pq no $15 já tem cor
	ori $10	$0 0x000000 #preto
	ori $11 $0 0x8E0000 #vermelho sombra
	ori $12 $0 0xE0E0E0 #branco
	ori $13 $0 0xff7e00 #laranja roupa
	ori $14 $0 0x5c230b #marrom barba
	ori $15 $0 0xEDA137 #pele
	
	addi $23 $0 1
	
doc_draw:
	beq $23 $0 voltar
	
	#perna esq
	sw $10 -1532($9)
	
	lw $20 31240($9)
	sw $20 -1528($9)
	
	sw $10 -1020($9)
	
	lw $20 31732($9)
	sw $20 -1016($9)
	
	sw $10 -508($9)
	
	lw $20 32264($9)
	sw $20 -504($9)
	
	sw $10 -512($9)
	sw $10 -4($9)
	
	lw $20 32768($9)
	sw $20 0($9)
	
	sw $10 0($9)
	sw $10 4($9)
	
	lw $20 32776($9)
	sw $20 8($9)
	
	#perna dir
	sw $10 -1516($9)
	
	lw $20 31252($9)
	sw $20 -1512($9)
	
	sw $10 -1004($9)
	
	lw $20 31768($9)
	sw $20 -1000($9)
	
	sw $10 -492($9)
	sw $10 -488($9)
	
	lw $20 32284($9)
	sw $20 -484($9)
	
	sw $10 20($9)
	sw $10 24($9)
	sw $10 28($9)
	
	lw $20 32796($9)
	sw $20 32($9)
	
	#barriga
		#esq
	sw $10 -2036($9) #do meio
	sw $10 -2040($9)
	sw $10 -2044($9)
	sw $10 -2048($9)
	
	sw $10 -2548($9)
	sw $10 -2552($9)
	sw $13 -2556($9)
	sw $13 -2560($9)
	sw $10 -2564($9)
	sw $10 -2568($9)
	
	sw $10 -3060($9)
	sw $10 -3064($9)
	sw $13 -3068($9)
	sw $13 -3072($9)
	sw $10 -3076($9)
	sw $10 -3080($9)
	sw $10 -3084($9)
	
	sw $10 -3572($9)
	sw $10 -3576($9)
	sw $13 -3580($9)
	sw $13 -3584($9)
	sw $10 -3588($9)
	sw $10 -3592($9)
	sw $10 -3596($9)
	
	sw $10 -4084($9)
	sw $10 -4088($9)
	sw $10 -4092($9)
	sw $10 -4096($9)
	sw $10 -4100($9)
	sw $10 -4104($9)
	sw $10 -4108($9)
		
		#dir
	sw $10 -2036($9)
	sw $10 -2032($9)
	sw $10 -2028($9)
	sw $10 -2024($9)
	
	lw $20 30748($9)
	sw $20 -2020($9)
	
	sw $10 -2548($9)
	sw $10 -2544($9)
	sw $13 -2540($9)
	sw $13 -2536($9)
	sw $10 -2532($9)
	sw $10 -2528($9)
	
	sw $10 -3060($9)
	sw $10 -3056($9)
	sw $13 -3052($9)
	sw $13 -3048($9)
	sw $10 -3044($9)
	sw $10 -3040($9)
	sw $10 -3036($9)
	
	sw $10 -3572($9)
	sw $10 -3568($9)
	sw $13 -3564($9)
	sw $13 -3560($9)
	sw $10 -3556($9)
	sw $10 -3552($9)
	sw $10 -3548($9)

	sw $10 -4084($9)
	sw $10 -4080($9)
	sw $10 -4076($9)
	sw $10 -4072($9)
	sw $10 -4068($9)
	sw $10 -4064($9)
	sw $10 -4060($9)

	#blusa
		#esq
	sw $11 -4596($9)
	sw $11 -4600($9)
	sw $11 -4604($9)
	sw $11 -4608($9)
	sw $11 -4612($9)
	sw $11 -4616($9)
	sw $11 -4620($9)
	
	sw $11 -5108($9)
	sw $11 -5112($9)
	sw $11 -5116($9)
	sw $13 -5120($9)
	sw $11 -5124($9)
	sw $11 -5128($9)
	sw $11 -5132($9)
	
	sw $11 -5620($9)
	sw $11 -5624($9)
	sw $13 -5628($9)
	sw $13 -5632($9)
	sw $13 -5636($9)
	sw $11 -5640($9)
	
	sw $11 -6132($9)
	sw $11 -6136($9)
	sw $13 -6140($9)
	sw $13 -6144($9)
	sw $13 -6148($9)
	
					#braço esq
	sw $11 -5136($9)
	sw $11 -5140($9)
	
	sw $11 -4624($9)
	sw $11 -4628($9)
	
	sw $11 -4112($9)
	sw $11 -4116($9)
	
	sw $12 -3600($9)
	sw $12 -3604($9)
	sw $12 -3608($9)

	sw $12 -3088($9)
	sw $12 -3092($9)
	
	sw $12 -2580($9)
	
	lw $20 30192($9)
	sw $20 -2576($9)
	
		#dir
	sw $11 -4592($9)
	sw $11 -4588($9)
	sw $11 -4584($9)
	sw $11 -4580($9)
	sw $11 -4576($9)
	sw $11 -4572($9)

	sw $11 -5104($9)
	sw $11 -5100($9)
	sw $13 -5096($9)
	sw $11 -5092($9)
	sw $11 -5088($9)
	sw $11 -5084($9)
	
	sw $11 -5616($9)
	sw $13 -5612($9)
	sw $13 -5608($9)
	sw $13 -5604($9)
	sw $11 -5600($9)
	
	lw $20 27172($9)
	sw $20 -5596($9)

	sw $11 -6128($9)
	sw $13 -6124($9)
	sw $13 -6120($9)
	sw $13 -6116($9)
	
	lw $20 26656($9)
	sw $20 -6112($9)
	
				#braco dir
	sw $11 -5076($9)#
	sw $11 -5080($9)
	
	lw $20 27696($9)#
	sw $20 -5072($9)
	
	sw $11 -4564($9)#
	sw $11 -4568($9)
	
	lw $20 28208($9)
	sw $20 -4560($9)
	
	sw $11 -4052($9)
	sw $11 -4056($9)
	
	lw $20 28720($9)
	sw $20 -4048($9)
	
	sw $12 -3540($9)
	sw $12 -3544($9)
	sw $12 -3548($9)
	
	lw $20 29232($9)
	sw $20 -3536($9)

	sw $12 -3028($9)
	sw $12 -3032($9)
	
	lw $20 29744($9)
	sw $20 -3024($9)
	
	sw $12 -2520($9)
	
	lw $20 30252($9)
	sw $20 -2516($9)

	#rosto
		#dentes
	sw $12 -6652($9)	
	sw $12 -6648($9)	
	sw $12 -6644($9)
	sw $12 -6640($9)
	sw $12 -6636($9)
	
		#barba
	sw $14 -7160($9)
	sw $11 -7156($9)
	sw $14 -7152($9)
	
			#esq
	sw $14 -7164($9)
	#sw $14 -6652($9)
	
	sw $14 -7168($9)
	sw $14 -6656($9)

	sw $14 -7172($9)
	
	sw $14 -7688($9)
	
	lw $20 25084($9)
	sw $20 -7684($9)
	
			#dir
	sw $14 -7148($9)
	
	sw $14 -7144($9)
	
	sw $14 -6632($9)
	sw $14 -7140($9)
	sw $14 -7648($9)
	
	lw $20 26140($9)
	sw $20 -6628($9)
	
	lw $20 25628($9)
	sw $20 -7136($9)
	
	lw $20 25124($9)
	sw $20 -7644($9)
				
		#careca
	sw $15 -7656($9)
	sw $15 -8168($9)
	sw $15 -8684($9)
	sw $15 -8688($9)
	sw $15 -8692($9)
	sw $15 -8688($9)
	sw $15 -8692($9)
	sw $15 -8696($9)
	sw $15 -8700($9)
	sw $15 -8192($9)
	sw $15 -7680($9)
	
	lw $20 25116($9)
	sw $20 -7652($9)
	
	lw $20 24600($9)
	sw $20 -8164($9)
	
	lw $20 24088($9)
	sw $20 -8680($9)
	
	sw $10 -8188($9)
	sw $10 -7676($9)
	sw $16 -8184($9)
	sw $16 -7672($9)
	sw $15 -8180($9)
	sw $15 -7668($9)
	sw $10 -8176($9)
	sw $10 -7664($9)
	sw $16 -8172($9)
	sw $16 -7660($9)
	
	addi $23 $23 -1
	j doc_draw
