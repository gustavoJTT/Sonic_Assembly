.text

main:
  lui $8 0x1001
  ori $9 $0 0x1D009F #azul ceu
  ori $10 $0 0x0082E0 #azul mar
  ori $11 $0 0x250000 #marrom escuro
  ori $12 $0 0x6A1B00 #marrom claro
  ori $13 $0 0x62FF36 #verde claro
  ori $14 $0 0x00AD2B #verde esuro
  ori $15 $0 0xFFFFFF #branco

  #addi $25 $0 8192 #mÃ¡ximo da tela

  addi $25 $0 3303
  addi $24 $0 2655
  addi $23 $0 2320
  addi $22 $0 2132
  addi $21 $0 1338
  addi $20 $0 908

ceu:
  beq $25 $0 montanhas_prep

  sw $9 0($8)

  addi $8 $8 4
  addi $25 $25 -1
  beq $25 $24 nuvem
  beq $25 $23 nuvem
  beq $25 $22 nuvem 
  beq $25 $21 nuvem 
  beq $25 $20 nuvem 
  j ceu

nuvem:
  jal criar_nuvem
  j ceu

montanhas_prep:
  addi $22 $0 10

montanha1_prep:
  beq  $22 $0 mar_prep
  addi $22 $22 -1
  addi $24 $0 7 #$24 > altura montanha 
  addi $23 $0 1

montanha1:
  jal criar_montanha

montanha2_prep:
  addi $24 $0 5
  addi $23 $0 1 

montanha2:
  jal criar_montanha

  sw $11 0($8)
  addi $8 $8 4
  j montanha1_prep

mar_prep: 
  addi $25 $0 2262
  addi $8 $8 -8
  addi $23 $0 260

mar:   
  beq $25 $0 grama_prep
	
  sw $10 0($8)
  sw $10 32768($8)
  jal ondas_verif

  addi $8 $8 4
  addi $25 $25 -1
  addi $23 $23 -1
  j mar 



grama_prep: 
  addi $25 $0 142
  addi $23 $0 90

grama: 
  beq $25 $0 solo_prep
  jal flor_verif
  
  sw $14 0($8)
  sw $14 32768($8)
  
  sw $14 4($8)
  sw $14 32772($8)
  
  sw $13 8($8)
  sw $13 32776($8)

  addi $8 $8 12
  addi $25 $25 -1
  addi $23 $23 -1
  j grama

solo_prep: 
  addi $25 $25 8
  addi $8 $8 -512


solo_laco1:
  beq $25 $0 npc_prep_main
  addi $24 $0 64
  add $22 $0 $24

  addi $8 $8 512
  addi $25 $25 -1

solo_laco2:
  beq $24 $0 solo_laco1

  jal solo

  addi $24 $24 -1
  addi $8 $8 8
	j solo_laco2

npc_prep_main:
	lui $8 0x1001
	lui $9 0x1001
	lui $25 0x1001
	addi $8 $8 23908 #altura sonic
	addi $9 $9 23888	#altura joaninha
	addi $25 $25 15736	#altura vespa
	
	addi $24 $24 30

npc_joaninha_laco_walk:
	#beq $24 $0 fim
	
	jal npc_vespa_prep
	jal npc_joaninha_prep
	jal sonic_prep
	jal timer
	
	addi $9 $9 -4
	addi $25 $25 -4
	addi $24 $24 -1
	j npc_joaninha_laco_walk

fim:
  addi $2 $0 10
  syscall

#----------------------func-----------------------

#função solo para prencher o solo de jeito alternado

solo: 
  lw $23 -4($8)
  beq $22 $24 escolha_solo

  beq $23 $12 marr_esc
  j marr_claro


escolha_solo: 
  lw $23 -512($8)
  bne $23 $11 marr_esc 

marr_claro:
  sw $12 0($8)
  sw $12 4($8)
  sw $12 512($8)
  sw $12 516($8)
  j fim_func_solo

marr_esc:
  sw $11 0($8)
  sw $11 4($8)
  sw $11 512($8)
  sw $11 516($8)
  j fim_func_solo

fim_func_solo:
  jr $31


# função criar_montanha para criar as montanhas com as medidadas dadas
criar_montanha:
  addi $21 $0 0
  addi $20 $0 1
  addi $19 $0 0
  addi $24 $24 2
  addi $8 $8 512

montanha_subindo:
  beq $24 $23 montanha_descendo_prep

montanha_subindo2:
  beq $21 $23 fim_montanha_subindo
  sw $11 -512($8)
  addi $21 $21 1 
  addi $8 $8 -512
  addi $19 $19 512
  j montanha_subindo2

fim_montanha_subindo:
  addi $23 $23 2
  addi $21 $0 0
  add $8 $8 $19
  addi $19 $0 0
  addi $8 $8 4
  j montanha_subindo

montanha_descendo_prep:
  addi $23 $23 -2

montanha_descendo:
  beq $23 $20 fim_func_montanhas
  addi $23 $23 -2


montanha_descendo2:
  beq $21 $23 fim_montanha_descendo
  sw $11 -512($8)
  addi $21 $21 1 
  addi $8 $8 -512
  addi $19 $19 512
  j montanha_descendo2

fim_montanha_descendo:
  addi $21 $0 0
  add $8 $8 $19
  addi $19 $0 0
  addi $8 $8 4
  j montanha_descendo                  


fim_func_montanhas: 
  addi $8 $8 -512
  jr $31
  
  
ondas_verif:
	beq $23 $0 ondas_draw
	
	jr $31
	
ondas_draw:
	addi $9 $0 0
  ori $9 $0 0x87B8BD #espuma das ondas
  
  sw $9 -1024($8)
  sw $9 31744($8)
  
  sw $9 -1040($8)
  sw $9 31728($8)
  
  sw $9 -516($8)
  sw $9 32252($8)
  
  sw $9 -520($8)
  sw $9 32248($8)
  
  sw $9 -512($8)
  sw $9 32256($8)
  
  sw $9 -524($8)
  sw $9 32244($8)
  
  sw $9 -528($8)
  sw $9 32240($8)
  
  sw $9 -532($8)
  sw $9 32236($8)

  addi $23 $0 50
	jr $31


flor_verif:
  beq $23 $0 flor_draw

  jr $31

flor_draw:
  addi $9 $0 0
  ori $9 $0 0x442305 #marrom meio flor
  addi $10 $0 0
  ori $10 $0 0xF7D10F #cor flor

  sw $12 -512($8)
  sw $12 32256($8)
  
  sw $12 -1024($8)
  sw $12 31744($8)
  
  sw $10 -1536($8)
  sw $10 31232($8)
  
  sw $10 -2052($8)
  sw $10 30716($8)
  
  sw $10 -2044($8)
  sw $10 30724($8)
  
  sw $9 -2048($8)
  sw $9 30720($8)
  
  sw $10 -2560($8)
  sw $10 30208($8)

  addi $23 $0 10
	jr $31


#função criar_nuvem 
criar_nuvem: 
  sw $15 -516($8)
  sw $15 -520($8)
  sw $15 -1028($8)
  sw $15 0($8)
  sw $15 -512($8)
  sw $15 -1024($8)
  sw $15 4($8)
  sw $15 -508($8)
  sw $15 -1020($8)
  sw $15 -1532($8)
  sw $15 8($8)
  sw $15 -504($8)
  sw $15 -1016($8)
  sw $15 -1528($8)
  sw $15 12($8)
  sw $15 -1012($8)
  sw $15 -1008($8)
  sw $15 -1004($8)
  sw $15 -500($8)
  sw $15 -496($8)
  sw $15 -492($8)
  sw $15 16($8)
  addi $8 $8 20
  
  jr $31


#voltar para o principal

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


# npc vespa

npc_vespa_prep:
	addi $23 $0 1
	ori $10	$0 0x000000	#preto
	ori $11	$0 0xC60000	#vermelho
	ori $13	$0 0xE0AD40	#amarelo
	ori $12 $0 0xffffff #branco
	
npc_vespa_draw:
	beq $23 $0 voltar
	
	sw $11 -516($25)
	sw $11 -512($25)
	sw $11 -1028($25)
	
	lw $15 32260($25)
	sw $15 -508($25)
	
	lw $15 31744($25)
	sw $15 -1024($25)
	
	sw $11 -500($25)
	sw $11 -496($25)
	sw $11 -1008($25)
	
	lw $15 32276($25)
	sw $15 -492($25)
	
	lw $15 31764($25)
	sw $15 -1004($25)
	
	sw $11 0($25)
	sw $11 4($25)
	sw $11 8($25)
	sw $11 12($25)
	
	lw $15 32784($25)
	sw $15 16($25)
	
	sw $10 508($25)
	sw $12 512($25)
	sw $10 516($25)
	sw $12 520($25)
	sw $11 524($25)
	
	sw $11 1016($25)
	sw $11 1020($25)
	sw $11 1024($25)
	sw $11 1028($25)
	sw $11 1032($25)
	sw $11 1036($25)
	
	sw $11 1540($25)
	sw $11 1536($25)
	sw $11 1532($25)
	sw $11 1544($25)
	
	lw $15 31228($25)
	sw $15 1548($25)
	
	#corpo
	sw $10 1040($25)
	sw $10 1044($25)
	sw $10 1048($25)
	sw $10 1052($25)
	sw $10 1056($25)
	
	lw $15 33828($25)
	sw $15 1060($25)
	
	sw $10 1552($25)
	sw $10 1556($25)
	sw $10 1560($25)
	sw $10 1564($25)
	
	lw $15 314336($25)
	sw $15 1568($25)
	
	sw $10 528($25)
	sw $10 536($25)
	sw $10 540($25)
	
	lw $15 33312($25)
	sw $15 544($25)
	
	#tanque
	sw $12 532($25)
	sw $12 24($25)
	sw $12 28($25)
	sw $12 32($25)
	
	#parte de tras do tanque com animacao
	lw $15 32804($25) #lembrar de adicionar 4 -> (32768 - local de desenho + 4)
	sw $15 36($25)
	
	#meio entre o corpo e o rabo
	sw $12 2088($25)
	sw $12 1572($25)
	
	lw $15 34344($25)
	sw $15 1576($25)
	
	#rabo
	sw $10 2600($25)
	sw $10 2092($25)
	
	sw $13 3112($25)
	sw $13 2604($25)
	sw $13 2096($25)

	
	#rabo animacao
	
	lw $15 34868($25)
	sw $15 2100($25)
	
	sw $10 3116($25)
	sw $10 2608($25)
	
	sw $13 3628($25)
	sw $13 3120($25)
	sw $13 2612($25)
	
	
	lw $15 35384($25)
	sw $15 2616($25)
	
	sw $10 3632($25)
	sw $10 3124($25)

	
	lw $15 35896($25)
	sw $15 3128($25)
	
	#ferrão
	sw $12 3636($25)
	sw $12 4152($25)

	

        #ferrao com animacao

	lw $15 36408($25)
	sw $15 3640($25)
	
	lw $15 36924($25)
	sw $15 4156($25)
	
	addi $23 $23 -1
	j npc_vespa_draw
	
	
npc_joaninha_prep:
	addi $23 $0 1
	ori $10	$0 0x000000	#preto
	ori $11	$0 0xC60000	#vermelho
	ori $12 $0 0xffffff #branco
	ori $13	$0 0xE0AD40	#amarelo
	ori $14 $0 0x0000E2 #azul
	
npc_joaninha_draw:
	beq $23 $0 voltar
	
	#peneu
	sw $10 -4($9)
	sw $10 -8($9)
	sw $10 -12($9)
	sw $10 -512($9)
	sw $10 -516($9)
	sw $10 -520($9)
	sw $10 -524($9)
	sw $10 0($9)
	sw $10 -508($9)
	
	#parte de tras do peneu com animacao
	lw $15 32772($9) #lembrar de adicionar 4 -> (32768 - local de desenho + 4)
	sw $15 4($9)	#loc + 4(sempre +4)
	
	lw $15 32264($9)
	sw $15 -504($9)
	
	#corpo
	sw $11 -1032($9)
	sw $11 -1028($9)
	sw $11 -1024($9)
	sw $11 -1020($9)
	sw $11 -1016($9)
	
	lw $15 31756($9)
	sw $15 -1012($9)
	
	sw $11 -1532($9)
	sw $11 -1536($9)
	sw $11 -1540($9)
	sw $11 -1544($9)
	sw $11 -1528($9)
	
	lw $15 31244($9)
	sw $15 -1524($9)
	
	sw $11 -2048($9)
	sw $11 -2052($9)
	sw $11 -2056($9)
	sw $11 -2044($9)
	
	lw $15 30728($9)
	sw $15 -2040($9)
	
	sw $11 -2564($9)
	sw $11 -2568($9)
	sw $11 -2572($9)
	sw $11 -2576($9)
	sw $11 -2580($9)
	sw $11 -2560($9)
	
	lw $15 30212($9)
	sw $15 -2556($9)
	
	sw $11 -3080($9)
	sw $11 -3084($9)
	sw $11 -3088($9)
	sw $11 -3076($9)
	
	lw $15 29696($9)
	sw $15 -3072($9)
	
	#rosto
	sw $12 -528($9)
	sw $12 -1048($9)
	sw $14 -1044($9)
	sw $12 -1040($9)
	sw $14 -1036($9)
	sw $12 -536($9)
	
	lw $15 32232($9)
	sw $15 -532($9)
	
	sw $12 -1548($9)
	sw $10 -1552($9)
	sw $12 -1556($9)
	sw $10 -1560($9)
	
	sw $14 -2060($9)
	sw $14 -2064($9)
	sw $14 -2068($9)
	sw $14 -2072($9)
	
	addi $23 $23 -1
	j npc_joaninha_draw

		
#movimento
#dir:
	#addi $8 $8 4

sonic_prep:
	ori $10	$0 0x000000 #preto
	ori $11 $0 0x5D60C1	#azul luz
	ori $12 $0 0x1C2182 #azul sombra
	ori $13 $0 0xC60000 #vermelho luz
	ori $14 $0 0x8E0000 #vermelho sombra
	ori $15 $0 0xEDA137 #pele
	ori $16 $0 0xE0E0E0 #branco olhos
	
	addi $23 $23 1
	
	
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
