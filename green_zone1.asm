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

  #addi $25 $0 8192 #máximo da tela

  addi $25 $0 3303
  addi $24 $0 2605
  addi $23 $0 2320
  addi $22 $0 2142
  addi $21 $0 1368
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
	addi $8 $8 23588 #altura sonic  !!!!!!!! proibido usar
	addi $9 $9 23788	#altura peixe !!!!!!!! proibido usar
	addi $25 $25 15736	#altura vespa
	lui $18 0xffff #registrador movimento !!!!!! proibido usar
	addi $17 $0 0 # l  o registrador movimento !!!!!!!!!!! proibido usar
	jal sonic_prep

npc_joaninha_laco_walk:
	lui $10 0x1001
	addi $10 $10 24048 #final da tela
	
	beq $8 $10 green_zone_2
	#beq $8 $25 main
	#beq $8 $9 main
	
	jal npc_vespa_prep
	jal npc_joaninha_prep
	
	addi $9 $9 -4
	addi $25 $25 -4
	jal timer
	
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

#fun  o solo para prencher o solo de jeito alternado

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


#fun  o criar_nuvem 
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
  addi $16 $0 15000 #100000
  
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
	
	#ferr o
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
	
	# sapato luz anima  o
	
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
	
	# sapato sombra anima  o
	
	lw $24 32256($8)
	sw $24 -512($8)
	
	#pernas
	sw $12 -1032($8)
	sw $12 -1544($8)
	sw $12 -1540($8)
	sw $12 -1536($8)
	
	sw $12 -1020($8)
	sw $12 -1532($8)
	
	# pernas anima  o 
	
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
	
	# barriga anima  o
	
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
	
	#bra o anima  o
	
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
	
	#rosto anima  o
	
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

##################################### Green zone 2 ###################################

green_zone_2:
  lui $8 0x1001
  ori $9 $0 0x1D009F #azul ceu_gz_2
  ori $10 $0 0x0082E0 #azul mar_gz_2
  ori $11 $0 0x250000 #marrom escuro
  ori $12 $0 0x6A1B00 #marrom claro
  ori $13 $0 0x62FF36 #verde claro
  ori $14 $0 0x00AD2B #verde esuro
  ori $15 $0 0xFFFFFF #branco

  #addi $25 $0 8192 #mÃ¡ximo da tela

  addi $25 $0 3303
  addi $24 $0 2580
  addi $23 $0 2294
  addi $22 $0 2022
  addi $21 $0 1338
  addi $20 $0 735

ceu_gz_2:
  beq $25 $0 montanhas_prep_gz_2

  sw $9 0($8)

  addi $8 $8 4
  addi $25 $25 -1
  beq $25 $24 nuvem_gz_2
  beq $25 $23 nuvem_gz_2
  beq $25 $22 nuvem_gz_2 
  beq $25 $21 nuvem_gz_2 
  beq $25 $20 nuvem_gz_2 
  j ceu_gz_2

nuvem_gz_2:
  jal criar_nuvem_gz_2
  j ceu_gz_2

montanhas_prep_gz_2:
  addi $22 $0 10

montanha1_prep_gz_2:
  beq  $22 $0 mar_prep_gz_2
  addi $22 $22 -1
  addi $24 $0 7 #$24 > altura montanha 
  addi $23 $0 1

montanha1_gz_2:
  jal criar_montanha_gz_2

montanha2_prep_gz_2:
  addi $24 $0 5
  addi $23 $0 1 

montanha2_gz_2:
  jal criar_montanha_gz_2

  sw $11 0($8)
  addi $8 $8 4
  j montanha1_prep_gz_2

mar_prep_gz_2: 
  addi $25 $0 2176
  addi $8 $8 -8
  addi $23 $0 260

mar_gz_2:   
  beq $25 $0 grama_prep_gz_2
	
  sw $10 0($8)
  jal ondas_verif_gz_2

  addi $8 $8 4
  addi $25 $25 -1
  addi $23 $23 -1
  j mar_gz_2 



grama_prep_gz_2: 
  addi $25 $0 171
  addi $23 $0 81

grama_gz_2: 
  beq $25 $0 cachoeira_prep_gz_2
  sw $14 0($8)
  sw $14 4($8)
  sw $13 8($8)
  jal placa_verif_gz_2

  addi $8 $8 12
  addi $25 $25 -1
  addi $23 $23 -1
  j grama_gz_2

cachoeira_prep_gz_2: addi $8 $8 -1908
                addi $25 $0 2
                addi $20 $0 0 #variavel escolha tipo de cachoeira
                
cachoeira_grama_gz_2: beq $25 $0 solo_prep_gz_2
                 jal desenho_cachoeira_gz_2
                 addi $25 $25 -1
                 addi $8 $8 416
                 j cachoeira_grama_gz_2

solo_prep_gz_2: 
  addi $25 $25 8
  addi $8 $8 -656

  addi $20 $0 1 #variavel escolha tipo de cachoeira

solo_laco1_gz_2:
  beq $25 $0 ponte_prep_gz_2
  addi $24 $0 53
  add $22 $0 $24
  addi $21 $24 -18

  
  addi $8 $8 512
  addi $25 $25 -1

solo_laco2_gz_2:
  beq $24 $0 solo_laco1_gz_2

  beq $21 $24 cachoeira_solo_gz_2
  jal solo_gz_2
  
  addi $24 $24 -1
  addi $8 $8 8
  j solo_laco2_gz_2

cachoeira_solo_gz_2: 
                jal desenho_cachoeira_gz_2
                addi $8 $8 -512
                addi $24 $24 -1
                add $22 $0 $24
                j solo_laco2_gz_2

ponte_prep_gz_2: addi $8 $8 -9072
            jal ponte_des_gz_2
            addi $8 $8 524
            jal ponte_des_gz_2
            addi $8 $8 524
            jal ponte_des_gz_2
            addi $8 $8 12
            jal ponte_des_gz_2
            addi $8 $8 12
            jal ponte_des_gz_2
            addi $8 $8 12
            jal ponte_des_gz_2
            addi $8 $8 -500
            jal ponte_des_gz_2
            addi $8 $8 -500
            jal ponte_des_gz_2

moedas_prep: addi $11 $8 -8236
             jal moeda_desenho
             addi $11 $11 4184
             jal moeda_desenho
             addi $11 $11 52
             jal moeda_desenho
             addi $11 $11 52
             jal moeda_desenho

npc_prep_main_gz2:
	lui $8 0x1001
	lui $9 0x1001
	lui $25 0x1001
	addi $8 $8 23588 #altura sonic  !!!!!!!! proibido usar
	addi $9 $9 23788	#altura joaninha !!!!!!!! proibido usar
	addi $25 $25 15736	#altura vespa
	lui $18 0xffff #registrador movimento !!!!!! proibido usar
	addi $17 $0 0 # l  o registrador movimento !!!!!!!!!!! proibido usar
	jal sonic_prep

npc_joaninha_laco_walk_gz_2:
	lui $10 0x1001
	addi $10 $10 24048 #final da tela
	
	beq $8 $10 marble_zone_1
	#beq $8 $25 main
	#beq $8 $9 main
	
	#jal peixe_prep
	
	addi $9 $9 -4
	addi $25 $25 -4
	jal timer
	
	add $11 $0 $17
	
	lw $17 0($18)
	beq $17 $0 npc_joaninha_laco_walk_gz_2
	
	lw $17 4($18)
	
	jal sonic_prep
	
	      
       j npc_joaninha_laco_walk_gz_2
       
fim_gz_2:
  addi $2 $0 10
  syscall

#----------------------func-----------------------

#função solo_gz_2 para prencher o solo_gz_2 de jeito alternado

solo_gz_2: 
  lw $23 -4($8)
  beq $22 $24 escolha_solo_gz_2

  beq $23 $12 marr_esc_gz_2
  j marr_claro_gz_2


escolha_solo_gz_2: 
  lw $23 -512($8)
  bne $23 $11 marr_esc_gz_2 

marr_claro_gz_2:
  sw $12 0($8)
  sw $12 4($8)
  sw $12 512($8)
  sw $12 516($8)
  j fim_func_solo_gz_2

marr_esc_gz_2:
  sw $11 0($8)
  sw $11 4($8)
  sw $11 512($8)
  sw $11 516($8)
  j fim_func_solo_gz_2

fim_func_solo_gz_2:
  jr $31

  sw $12 -512($8)
  sw $12 -1024($8)
  sw $10 -1536($8)
  sw $10 -2052($8)
  sw $10 -2044($8)
  sw $9 -2048($8)
  sw $10 -2560($8)


# função criar_montanha_gz_2 para criar as montanhas com as medidadas dadas
criar_montanha_gz_2:
  addi $21 $0 0
  addi $20 $0 1
  addi $19 $0 0
  addi $24 $24 2
  addi $8 $8 512

montanha_subindo_gz_2:
  beq $24 $23 montanha_descendo_prep_gz_2

montanha_subindo2_gz_2:
  beq $21 $23 fim_montanha_subindo_gz_2
  sw $11 -512($8)
  addi $21 $21 1 
  addi $8 $8 -512
  addi $19 $19 512
  j montanha_subindo2_gz_2

fim_montanha_subindo_gz_2:
  addi $23 $23 2
  addi $21 $0 0
  add $8 $8 $19
  addi $19 $0 0
  addi $8 $8 4
  j montanha_subindo_gz_2

montanha_descendo_prep_gz_2:
  addi $23 $23 -2

montanha_descendo_gz_2:
  beq $23 $20 fim_func_montanhas_gz_2
  addi $23 $23 -2


montanha_descendo2_gz_2:
  beq $21 $23 fim_montanha_descendo_gz_2
  sw $11 -512($8)
  addi $21 $21 1 
  addi $8 $8 -512
  addi $19 $19 512
  j montanha_descendo2_gz_2

fim_montanha_descendo_gz_2:
  addi $21 $0 0
  add $8 $8 $19
  addi $19 $0 0
  addi $8 $8 4
  j montanha_descendo_gz_2                  


fim_func_montanhas_gz_2: 
  addi $8 $8 -512
  jr $31
  
#função ondas
      
ondas_verif_gz_2:
	beq $23 $0 ondas_draw_gz_2
	
	jr $31
	
ondas_draw_gz_2:
	addi $9 $0 0
  ori $9 $0 0x87B8BD #espuma das ondas
  
  sw $9 -1024($8)
  sw $9 -1040($8)
  sw $9 -516($8)
  sw $9 -520($8)
  sw $9 -512($8)
  sw $9 -524($8)
  sw $9 -528($8)
  sw $9 -532($8)

  addi $23 $0 50
	jr $31

#função criar_nuvem_gz_2 

criar_nuvem_gz_2: 
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
  
# função desenho_cachoeira_gz_2
  
desenho_cachoeira_gz_2: 
                   addi $18 $0 2
                   addi $8 $8 -416
                      
laco1_cachoeira_gz_2: beq $18 $0 fim_func_cachoeira_gz_2
                 addi $18 $18 -1
                 addi $8 $8 416 
                 addi $19 $0 8
                 beq $20 $0 laco1_cachoeira_grama_gz_2
                 addi $19 $0 12
                  
laco2_cachoeira_gz_2: beq $19 $0 laco1_cachoeira_gz_2
                 sw $10 0($8)
                 sw $12 32768($8)
                 
                 sw $9 4($8)
                 sw $12 32772($8)
                 
                 addi $8 $8 8
                 addi $19 $19 -1
                 j laco2_cachoeira_gz_2
                 
laco1_cachoeira_grama_gz_2: beq $19 $0 laco2_cachoeira_grama_prep_gz_2
                       beq $18 $0 fim_func_cachoeira_gz_2
                       
                      sw $15 0($8)
                      sw $12 32768($8)
                      
                      sw $9 4($8)
                      sw $12 32772($8)
                      
                      sw $10 8($8)
                      sw $12 32776($8)
                      
                      addi $8 $8 12
                      addi $19 $19 -1
                      j laco1_cachoeira_grama_gz_2
                     
laco2_cachoeira_grama_prep_gz_2: addi $18 $18 -1
                            addi $8 $8 416 
                            addi $19 $0 8    
                            
laco2_cachoeira_grama_gz_2: beq $19 $0 laco1_cachoeira_gz_2
                       
                      sw $10 0($8)
                      sw $10 32768($8)
                      
                      sw $15 4($8)
                      sw $15 32772($8)
                      
                      sw $9 8($8)
                      sw $9 32776($8)
                      
                      addi $8 $8 12
                      addi $19 $19 -1
                      j laco2_cachoeira_grama_gz_2            
                 
fim_func_cachoeira_gz_2: jr $31  

#função ponte_des_gz_2 para desenhar ponte      
  
ponte_des_gz_2: sw $11 0($8)
           sw $12 4($8)
           sw $12 32772($8)
           
           sw $11 -508($8)
           sw $12 32260($8)
           
           sw $11 516($8)
           sw $12 33284($8)
           
           sw $11 8($8)
           sw $12 32776($8)
           
           jr $31
           
           
#função placa no final

placa_verif_gz_2:
	beq $23 $0 placa_draw_gz_2
	
	jr $31
	
placa_draw_gz_2:
	ori $23 $0 0x919493 #cinza moldura placa
	ori $22 $0 0xF4FF2F #amarelo fundo placa
	ori $21 $0 0xFF0000 #vermelho jaqueta / vermelho nariz
	ori $20 $0 0xFFB797 #pele
	ori $19 $0 0x4F0005 #marrom barba
	ori $18 $0 0x2A72F4 #azul olhos
	
	#moldura
	sw $23 0($8)
	sw $23 -512($8)
	sw $23 -1024($8)
	sw $23 -1536($8)
	sw $23 -2048($8)
	
	#-4
	sw $23 -2044($8)
	sw $23 -2040($8)
	sw $23 -2036($8)
	sw $23 -2032($8)
	sw $23 -2028($8)
	
	#diminui 512
	sw $23 -2024($8)
	sw $23 -2536($8)
	sw $23 -3048($8)
	sw $23 -3560($8)
	sw $23 -4072($8)
	sw $23 -4584($8)
	sw $23 -5096($8)
	sw $23 -5608($8)
	
	#+4
	sw $23 -2052($8)
	sw $23 -2056($8)
	sw $23 -2060($8)
	sw $23 -2064($8)
	sw $23 -2068($8)
	
	#aumenta 512
	sw $23 -6168($8)
	sw $23 -5656($8)
	sw $23 -5144($8)
	sw $23 -4632($8)
	sw $23 -4120($8)
	sw $23 -3608($8)
	sw $23 -3096($8)
	sw $23 -2584($8)
	sw $23 -2072($8)
	
	#diminuir 4
	sw $23 -6164($8)
	sw $23 -6160($8)
	sw $23 -6156($8)
	sw $23 -6152($8)
	sw $23 -6148($8)
	sw $23 -6144($8)
	sw $23 -6140($8)
	sw $23 -6136($8)
	sw $23 -6132($8)
	sw $23 -6128($8)
	sw $23 -6124($8)
	sw $23 -6120($8)
	
	#fundo amarelo
	sw $22 -5632($8)
	sw $22 -3596($8)
	
	sw $22 -3572($8)
	sw $22 -4596($8)
	sw $22 -5108($8)
	sw $22 -5112($8)
	sw $22 -5624($8)
	sw $22 -5628($8)
	sw $22 -5620($8)
	sw $22 -5636($8)
	
	#aumenta 512
	sw $22 -5644($8)
	sw $22 -5132($8)
	sw $22 -4620($8)

	#aaumenta 512
	sw $22 -5640($8)
	sw $22 -5128($8)
	
	#aumenta 512
	sw $22 -5648($8)
	sw $22 -5136($8)
	sw $22 -4624($8)
	sw $22 -4112($8)
	sw $22 -3600($8)
	sw $22 -3088($8)
	sw $22 -2576($8)
	
	#aumenta 512
	sw $22 -5652($8)
	sw $22 -5140($8)
	sw $22 -4628($8)
	sw $22 -4116($8)
	sw $22 -3604($8)
	sw $22 -3092($8)
	sw $22 -2580($8)
	
	#aumentar 512
	sw $22 -5616($8)
	sw $22 -5104($8)
	sw $22 -4592($8)
	sw $22 -4080($8)
	sw $22 -3568($8)
	sw $22 -3056($8)
	sw $22 -2544($8)
	
	#aumentar 512
	sw $22 -5612($8)
	sw $22 -5100($8)
	sw $22 -4588($8)
	sw $22 -4076($8)
	sw $22 -3564($8)
	sw $22 -3052($8)
	sw $22 -2540($8)
	
	
	#pele
	sw $20 -2560($8)
	sw $20 -3072($8)
	
	sw $20 -2564($8)
	sw $20 -3076($8)
	
	sw $20 -2556($8)
	sw $20 -3068($8)
	sw $20 -4608($8)
	
	sw $20 -4600($8)
	sw $20 -4616($8)
	
	sw $20 -5120($8)
	sw $20 -5124($8)
	sw $20 -5116($8)
	
	
	#nariz
	sw $21 -4096($8)
	
	
	#olhos
	sw $18 -4604($8)
	sw $18 -4612($8)
	
	
	#barba
	sw $19 -3584($8)
	
	sw $19 -3588($8)
	sw $19 -4100($8)
	sw $19 -3592($8)
	sw $19 -4104($8)
	sw $19 -4108($8)
	
	sw $19 -3580($8)
	sw $19 -4092($8)
	sw $19 -3576($8)
	sw $19 -4088($8)
	sw $19 -4084($8)
	
	
	#roupa
	sw $21 -2568($8)
	sw $21 -3080($8)
	sw $21 -2572($8)
	sw $21 -3084($8)
	
	sw $21 -2548($8)
	sw $21 -3060($8)
	sw $21 -2552($8)
	sw $21 -3064($8)
	

	jr $31

# função desenho peixe
	
func_peixe: ori $11 $0 0xff0000
      ori $12 $0 0x777777
      ori $13 $0 0x000000
      ori $14 $0 0xffff00
      addi $15 $0 0
      
              
peixe: sw $11 -1024($9)
       sw $12 -512($9)
       sw $11 -508($9)
       sw $11 0($9)
       sw $11 4($9)
       sw $11 8($9)
       sw $12 512($9)
       sw $11 516($9)
       sw $13 520($9)
       sw $11 524($9)
       sw $11 1024($9)
       sw $11 1028($9)
       sw $11 1032($9)
       sw $11 1036($9)
       sw $11 1536($9)
       sw $11 1540($9)
       sw $11 1544($9)
       sw $11 2048($9)
       sw $11 2052($9)
       
       #corpo peixe animacao
       
       lw $15 35332($9)
       sw $15 2564($9)
       
       lw $15 34824($9)
       sw $15 2056($9)
       
       lw $15 34316($9)
       sw $15 1548($9)
       
       #parte baixo peixe
       
       sw $14 -516($9)
       sw $14 -4($9)
       sw $14 -8($9)
       sw $14 504($9)
       sw $14 508($9)
       sw $14 1016($9)
       sw $14 1020($9)
       sw $14 1532($9)

       #parte baixo peixe animacao
       
       lw $15 34296($9)
       sw $15 1528($9)
       
       lw $15 34812($9)
       sw $15 2044($9)
       
       
       #rabo
       
       sw $12 2560($9)
       sw $12 3068($9)
       sw $12 3072($9)
       sw $12 3076($9)
       sw $12 3580($9)
       sw $12 3588($9)
       sw $12 4092($9)
       sw $12 4100($9)
       
       
       # rabo animacao
       
       lw $15 36352($9)
       sw $15 3584($9)
       
       lw $15 37372($9)
       sw $15 4604($9)
       
       lw $15 37380($9)
       sw $15 4612($9)
       
       #cabinho cabeça
       
       sw $14 1040($9)
       sw $14 1044($9)
       sw $14 1556($9)
       sw $14 1560($9)
       
       #cabinho cabeca animacao
       
       lw $15 34320($9)
       sw $15 1552($9)
       
       lw $15 34836($9)
       sw $15 2068($9)
       
       lw $15 34840($9)
       sw $15 2072($9)
       
       jr $31
            
#trocar posição do peixe

peixe_troca_func: 
                  #limpar cenario rabo
                  
                  lw $15 32256($9)
                  sw $15 -512($9)
                  
                  lw $15 32768($9)
                  sw $15 0($9)
                  
                  lw $15 33272($9)
                  sw $15 504($9)
                  
                  lw $15 33288($9)
                  sw $15 520($9)
                  
                  lw $15 33784($9)
                  sw $15 1016($9)
                  
                  lw $15 33788($9)
                  sw $15 1020($9)
                  
                  lw $15 33796($9)
                  sw $15 1028($9)
                  
                  lw $15 33800($9)
                  sw $15 1032($9)
                  
                  lw $15 33804($9)
                  sw $15 1036($9)
                  
    
                 
    #corpo vermelho limpa
                
                  lw $15 34296($9)
                  sw $15 1528($9)
                
                  lw $15 34300($9)
                  sw $15 1532($9)
                
                  lw $15 34312($9)
                  sw $15 1544($9)
    
                  lw $15 34316($9)
                  sw $15 1548($9)
                  
                  lw $15 34320($9)
                  sw $15 1552($9)
                  
                  lw $15 34324($9)
                  sw $15 1556($9)
                  
                  lw $15 34836($9)
                  sw $15 2068($9)
                  
                  lw $15 34840($9)
                  sw $15 2072($9)
                  
                  lw $15 37372($9)
                  sw $15 4604($9)
                  
                  lw $15 37380($9)
                  sw $15 4612($9)
                  
                  jr $31

peixe_descendo_func: ori $11 $0 0xff0000 #vermelho
                  ori $12 $0 0x777777 #cinza
                  ori $13 $0 0x000000 #preto
                  ori $14 $0 0xffff00 #amarelo
                  
                  #rabo
                  
                  sw $12 -516($9)
                  sw $12 -508($9)
                  sw $12 -4($9) #$9 = 0 no meio do rabo
                  sw $12 4($9)
                  sw $12 508($9)
                  sw $12 512($9)
                  sw $12 516($9)
                  sw $12 1024($9)
                  
      #rabo animacao
                  
                  lw $15 31740($9)
                  sw $15 -1028($9)            
                  
                  lw $15 31748($9)
                  sw $15 -1020($9)
                  
                  lw $15 32768($9)
                  sw $15 0($9)
                  
                  #corpo vermelho
                  
                  sw $11 1536($9)
                  sw $11 1540($9)
                  sw $11 2048($9)
                  sw $11 2052($9)
                  sw $11 2056($9)
                  sw $11 2560($9)
                  sw $11 2564($9)
                  sw $11 2568($9)
                  sw $11 2572($9)
                  sw $12 3072($9)
                  sw $11 3076($9)
                  sw $13 3080($9)
                  sw $11 3084($9)
                  sw $11 3584($9)
                  sw $11 3588($9)
                  sw $11 3592($9)
                  sw $12 4096($9)
                  sw $11 4100($9)
                  sw $11 4608($9)
                  
      #corpo vermelho animacao
                 
                  lw $15 33796($9)
                  sw $15 1028($9)
                  
                  lw $15 34312($9)
                  sw $15 1544($9)
                  
                  lw $15 34828($9)
                  sw $15 2060($9)
                  
      #corpo amarelo
                  sw $14 1532($9)
                  sw $14 2040($9)
                  sw $14 2044($9)
                  sw $14 2552($9)
                  sw $14 2556($9)
                  sw $14 3064($9)
                  sw $14 3068($9)
                  sw $14 3576($9)
                  sw $14 3580($9)
                  sw $14 4092($9)
                  
       # corpo amarelo animacao
       
                  lw $15 33788($9)
                  sw $15 1020($9)
                  
                  lw $15 34296($9)
                  sw $15 1528($9)
                  
       # cabinho amarelo cabeça
       
                  sw $14 2068($9)
                  sw $14 2072($9)
                  sw $14 2576($9)
                  sw $14 2580($9)
                  
       # cabinho amarelo animacao
       
                  lw $15 34324($9)
                  sw $15 1556($9)
                  
                  lw $15 34328($9)
                  sw $15 1560($9)
                  
                  lw $15 34832($9)
                  sw $15 2064($9)
       
       
##### funcao moeda
       
moeda_desenho: ori $9 $0 0xffff00
               ori $10 $0 0xffffff
               
               sw $9 0($11)
               sw $9 4($11)
               sw $9 8($11)
               sw $9 508($11)
               sw $9 524($11)
               sw $9 1020($11)
               sw $9 1036($11)
               sw $9 1532($11)
               sw $10 1548($11)
               sw $9 2048($11)
               sw $10 2052($11)
               sw $10 2056($11)
               
               
               jr $31
               
peixe_prep: addi $9 $9 10168
            addi $25 $0 35
                  

peixe_laco1: beq $25 $0 peixe_troca_pos
             jal func_peixe
             addi $9 $9 52
             jal func_peixe
             
             addi $25 $25 -1
             addi $9 $9 -564
             jal timer
             j peixe_laco1

peixe_troca_pos: jal peixe_troca_func
                 addi $9 $9 52
                 jal peixe_troca_func
                 addi $9 $9 -52

peixe_laco_descendo_prep: addi $25 $0 36

peixe_laco_descendo: beq $25 $0 fim
                     jal peixe_descendo_func
                     addi $9 $9 52
                     jal peixe_descendo_func
                     
                     addi $25 $25 -1
                     addi $8 $8 460
                     
                     jal timer
                     j peixe_laco_descendo


############################# Marble Zone 1 ##############################

marble_zone_1:
  lui $8 0x1001


ceu_prep_mz_1: addi $25 $0 1704
          addi $24 $0 744

ceu_nublado_mz_1: jal ceu_nublado_func_mz_1
  
ceu_normal_mz_1: jal ceu_normal_func_mz_1

montanhas_prep_mz_1:
  addi $22 $0 4
  ori $9 $0 0x250000 #marrom escuro

montanha1_prep_mz_1:
  beq  $22 $0 montanha3_mz_1
  addi $22 $22 -1
  addi $24 $0 7 #$24 > altura montanha 


montanha1_mz_1:
  jal criar_montanha_mz_1

montanha2_prep_mz_1:
  addi $24 $0 9 

montanha2_mz_1:
  jal criar_montanha_mz_1
  addi $8 $8 -4
 
  j montanha1_prep_mz_1

montanha3_mz_1: addi $24 $0 7
           jal criar_montanha_mz_1
           
           addi $8 $8 -20
           
cespugli_prep_mz_1: addi $25 $0 172
               addi $24 $0 4
               addi $17 $25 -43
               addi $8 $8 16

cespugli_laco1_mz_1: beq $25 $0 castelo_mz_1

cespugli_laco2_mz_1: beq $25 $17 cespugli_outro_strato_mz_1
               jal criar_cespugli_prep_mz_1
               addi $25 $25 -1      
               j cespugli_laco1_mz_1 
               
cespugli_outro_strato_mz_1: addi $8 $8 1536
                       addi $17 $17 -43
                       j cespugli_laco2_mz_1               

castelo_mz_1: 

grama_marble_zone_prep_mz_1: addi $8 $8 1520
												add $20 $8 $0
												add $19 $8 $0
                        ori $9 $0 0x00AD2B #verde escuro
                        ori $10 $0 0x62FF36 #verde claro
                        addi $25 $0 384
                        

grama_marble_zone_mz_1: beq $25 $0 solo_marble_zone1_mz_1
                   sw $10 0($8)
                   sw $10 32768($8)
                   
                   sw $9 4($8)
                   sw $9 32772($8)
                   
                   addi $8 $8 8
                   addi $25 $25 -2
                   j grama_marble_zone_mz_1
                   
solo_marble_zone1_mz_1: addi $25 $25 3712
                   addi $24 $25 -256
                   addi $23 $25 -34
                   
                   jal solo_marble_zone_func_mz_1                 

castelo_base_luz_main_mz_1:
	jal castelo_luz_prep_func_mz_1

castelo_base_sombra_main_mz_1:
	jal castelo_sombra_prep_func_mz_1
	
castelo_coluna_luz_main_mz_1:
	addi $20 $19 296
	jal castelo_coluna_luz_prep_func_mz_1
	
castelo_coluna_sombra_main_mz_1:
	addi $20 $19 296
	jal castelo_coluna_sombra_prep_func_mz_1


castelo_base_luz_main_2_mz_1:
	addi $20 $19 108
	jal castelo_luz_prep_func_mz_1

castelo_base_sombra_main_2_mz_1:
	jal castelo_sombra_prep_func_mz_1
	
castelo_coluna_luz_main_2_mz_1:
	addi $20 $19 404
	jal castelo_coluna_luz_prep_func_mz_1
	
castelo_coluna_sombra_main_2_mz_1:
	addi $20 $19 404
	jal castelo_coluna_sombra_prep_func_mz_1
	
castelo_topo_main_mz_1:
	addi $20 $19 280
	jal castelo_topo_prep_func_mz_1
	
	npc_prep_main_mz_1:
	lui $8 0x1001
	lui $9 0x1001
	lui $25 0x1001
	addi $8 $8 17444 #altura sonic  !!!!!!!! proibido usar
	addi $9 $9 23788	#altura joaninha !!!!!!!! proibido usar
	addi $25 $25 15736	#altura vespa
	lui $18 0xffff #registrador movimento !!!!!! proibido usar
	addi $17 $0 0 # l  o registrador movimento !!!!!!!!!!! proibido usar
	jal sonic_prep

npc_joaninha_laco_walk_mz_1:
	lui $10 0x1001
	addi $10 $10 24048 #final da tela
	
	beq $8 $10 fim_mz_1
	#beq $8 $25 main
	#beq $8 $9 main
	
	#jal peixe_prep
	
	addi $9 $9 -4
	addi $25 $25 -4
	jal timer
	
	add $11 $0 $17
	
	lw $17 0($18)
	beq $17 $0 npc_joaninha_laco_walk_mz_1
	
	lw $17 4($18)
	
	jal sonic_prep
	
	      
       j npc_joaninha_laco_walk_mz_1
	

fim_mz_1: addi $2 $0 10
     syscall
  
  
###################### funções ######################

# funcão ceu nublado  

ceu_nublado_func_mz_1: ori $9 $0 0x0082E0 # azul nuvem
                  ori $10 $0 0x87B8BD # azul ondas
                  ori $11 $0 0x1D009F # azul ceu
                  ori $12 $0 0xFFFFFF # branco
                                    
prep_laco_ceu_nublado_mz_1: beq $25 $24 fim_func_ceu_nublado_mz_1
                       addi $23 $25 -132

laco_ceu_nublado_mz_1: beq $23 $25 laco_ceu_nublado2_prep_mz_1

                  sw $9 0($8)
                  sw $9 32768($8)
                  
                  sw $9 4($8)
                  sw $9 32772($8)
                  
                  sw $9 8($8)
                  sw $9 32776($8)
                  
                  sw $10 12($8)
                  sw $10 32780($8)
                  
                  sw $11 16($8)
                  sw $11 32784($8)
                  
                  sw $11 20($8)
                  sw $11 32788($8)
                  
                  addi $8 $8 24
                  subi $25 $25 6
                  j laco_ceu_nublado_mz_1
                  
laco_ceu_nublado2_prep_mz_1: addi $23 $23 -108

laco_ceu_nublado2_mz_1: beq $23 $25 prep_laco_ceu_nublado_mz_1
                   sw $9 0($8)
                   sw $9 32768($8)
                     
                   sw $9 4($8)   
                   sw $9 32772($8)
                   
                   sw $11 8($8)
                   sw $11 32776($8)
                   
                   sw $10 12($8)
                   sw $10 32780($8)
                     
                   sw $10 16($8)
                   sw $10 32784($8)
                   
                   sw $12 20($8)
                   sw $12 32788($8)
                   
                   addi $8 $8 24
                  subi $25 $25 4
                  j laco_ceu_nublado2_mz_1       
                  
fim_func_ceu_nublado_mz_1: jr $31
  
#func ceu normal

ceu_normal_func_mz_1: ori $9 $0 0x1D009F # azul ceu

laco_ceu_normal_mz_1: beq $25 $0 fim_func_ceu_normal_mz_1
                 sw $9 0($8)
                 
                 addi $8 $8 4
                 addi $25 $25 -1
                 
                 j laco_ceu_normal_mz_1
  
fim_func_ceu_normal_mz_1: jr $31  
  
# função montanhas marble zone

criar_montanha_mz_1:
                ori $9 $0 0x48214F #roxo montanhas
                addi $23 $0 1
  		addi $21 $0 0
  		addi $20 $0 1
  		addi $19 $0 0
 	        addi $24 $24 1
 	        addi $8 $8 512

montanha_subindo_mz_1:
  beq $24 $23 montanha_descendo_prep_mz_1

montanha_subindo2_mz_1:
  beq $21 $23 fim_montanha_subindo_mz_1
  sw $9 -512($8)
  sw $9 32256($8)
  
  addi $21 $21 1 
  addi $8 $8 -512
  addi $19 $19 512
  j montanha_subindo2_mz_1

fim_montanha_subindo_mz_1:
  addi $23 $23 1
  addi $21 $0 0
  add $8 $8 $19
  addi $19 $0 0
  addi $8 $8 4
  j montanha_subindo_mz_1

montanha_descendo_prep_mz_1:
  addi $23 $23 -1

montanha_descendo_mz_1:
  beq $23 $20 fim_func_montanhas_mz_1
  addi $23 $23 -1


montanha_descendo2_mz_1:
  beq $21 $23 fim_montanha_descendo_mz_1
  sw $9 -512($8)
  sw $10 32256($8)
  
  addi $21 $21 1 
  addi $8 $8 -512
  addi $19 $19 512
  j montanha_descendo2_mz_1

fim_montanha_descendo_mz_1:
  addi $21 $0 0
  add $8 $8 $19
  addi $19 $0 0
  addi $8 $8 4
  j montanha_descendo_mz_1                  


fim_func_montanhas_mz_1: 
  addi $8 $8 -512
  jr $31  
  
#função criar cespugli marble zone
  
criar_cespugli_prep_mz_1:
                ori $9 $0 0x62FF36 #verde claro
                ori $10 $0 0x067826 #verde mais escuro
  		addi $20 $0 4
  		addi $23 $0 0 #contagem cespugli
  		addi $22 $0 0
 	        addi $8 $8 1536

cespugli_subindo_mz_1:
  beq $23 $24 fim_cespugli_subindo_mz_1
  sw $9 0($8)
  sw $9 32768($8)
  
  addi $23 $23 1 
  addi $8 $8 -512
  addi $22 $22 512
  j cespugli_subindo_mz_1

fim_cespugli_subindo_mz_1:
  addi $24 $24 2
  addi $23 $0 0
  add $8 $8 $22
  addi $22 $0 0
  addi $8 $8 4

cespugli_descendo_prep_mz_1:
  beq $24 $20 fim_func_cespugli_mz_1
  addi $24 $24 -1

cespugli_descendo_mz_1:
  beq $24 $23 fim_cespugli_descendo_mz_1
  sw $10 0($8)
  sw $10 32768($8)
  
  addi $23 $23 1 
  addi $8 $8 -512
  addi $22 $22 512
  j cespugli_descendo_mz_1

fim_cespugli_descendo_mz_1:
  addi $23 $0 0
  ori $10 $0 0x00AD2B #verde escuro
  add $8 $8 $22
  addi $22 $0 0
  addi $8 $8 4
  j cespugli_descendo_prep_mz_1             


fim_func_cespugli_mz_1: 
  addi $8 $8 -1536
  jr $31 
  
# função solo marble zone

solo_marble_zone_func_mz_1: ori $9 $0 0x6A3F84 #roxo escuro solo
                       ori $10 $0 0x9C73B9 #roxo claro solo
                       ori $11 $0 0x48214F #roxo montanhas
                       add $22 $0 $31

laco1_solo_marble_zone_func_mz_1: beq $25 $24 laco2_solo_marble_zone_func_prep_mz_1
                            beq $25 $23 buraco_func_laco1_mz_1

                            sw $9 0($8)
                            sw $9 32768($8)
                            
                            addi $25 $25 -1
                            addi $8 $8 4
                            j laco1_solo_marble_zone_func_mz_1
                            
buraco_func_laco1_mz_1: jal buraco_func_mz_1  
                   j laco1_solo_marble_zone_func_mz_1                       

laco2_solo_marble_zone_func_prep_mz_1: addi $24 $24 -128

laco2_solo_marble_zone_func_mz_1: beq $25 $24 solo_marble_zone_func_linha_prep_mz_1
                             beq $25 $23 buraco_func_laco2_mz_1
                             sw $10 0($8)
                             sw $10 32768($8)
                             
                             sw $9 4($8)
                             sw $9 32772($8)
                             
                             addi $8 $8 8
                             addi $25 $25 -2
                             j laco2_solo_marble_zone_func_mz_1 
   
buraco_func_laco2_mz_1: jal buraco_func_mz_1
                   j laco2_solo_marble_zone_func_mz_1 

solo_marble_zone_func_linha_prep_mz_1: addi $24 $24 -128

solo_marble_zone_func_linha_mz_1: beq $24 $25 laco3_solo_marble_zone_func_mz_1
                                   beq $25 $23 buraco_func_linha_mz_1
                                   sw $9 0($8)
                                   sw $9 32768($8)
                                   
                                   addi $8 $8 4
                                   addi $25 $25 -1
                                   j solo_marble_zone_func_linha_mz_1 
    
buraco_func_linha_mz_1: jal buraco_func_mz_1
                         j solo_marble_zone_func_linha_mz_1
        
laco3_solo_marble_zone_func_mz_1: beq $0 $25 fim_solo_marble_zone_func_mz_1

laco3_solo_marble_zone_func_prep_mz_1: addi $24 $0 50

laco3_solo_marble_zone_func_parte1_mz_1: beq $24 $0 solo_marble_zone_func_linha_laco3_prep_mz_1
                             beq $25 $0 fim_solo_marble_zone_func_mz_1
                             sw $10 0($8)
                             sw $10 32768($8)
                             
                             sw $10 4($8)
                             sw $10 32772($8)
                             
                             addi $25 $25 -2
                             addi $8 $8 8
                             beq $25 $23 buraco_func_laco3_mz_1
                             
laco3_solo_marble_zone_func_parte2_mz_1: sw $10 0($8)
																				 sw $10 32768($8)
																				 
                                    sw $9 4($8)
                                    sw $9 32772($8)
                                    
                                    addi $24 $24 -1
                                    addi $8 $8 8
                                    addi $25 $25 -2                     
                                    j laco3_solo_marble_zone_func_parte1_mz_1
  
buraco_func_laco3_mz_1: jal buraco_func_mz_1
                   j laco3_solo_marble_zone_func_parte2_mz_1  
                   
solo_marble_zone_func_linha_laco3_prep_mz_1: addi $24 $25 -128

solo_marble_zone_func_linha_laco3_mz_1: beq $24 $25 laco4_solo_marble_zone_func_parte1_prep_mz_1
                                   beq $25 $23 buraco_func_linha_laco3_mz_1
                                   sw $9 0($8)
                                   sw $9 32768($8)
                                   
                                   addi $8 $8 4
                                   addi $25 $25 -1
                                   j solo_marble_zone_func_linha_laco3_mz_1
                                   
buraco_func_linha_laco3_mz_1: jal buraco_func_mz_1
                         j solo_marble_zone_func_linha_laco3_mz_1                                  
      
laco4_solo_marble_zone_func_parte1_prep_mz_1: addi $24 $0 50

laco4_solo_marble_zone_func_parte1_mz_1: beq $24 $0 solo_marble_zone_func_linha_laco4_prep_mz_1
                             sw $10 0($8)
                             sw $10 32768($8)
                             
                             sw $9 4($8)
                             sw $10 32772($8)
                             
                             addi $25 $25 -2
                             addi $8 $8 8
                             beq $25 $23 buraco_func_laco4_mz_1
                             
laco4_solo_marble_zone_func_parte2_mz_1: sw $10 0($8)
																				 sw $10 32768($8)
																				 
                                    sw $10 4($8)
                                    sw $10 32772($8)
                                    
                                    addi $24 $24 -1
                                    addi $8 $8 8
                                    addi $25 $25 -2                     
                                    j laco4_solo_marble_zone_func_parte1_mz_1    
                                    
buraco_func_laco4_mz_1: jal buraco_func_mz_1
                   j laco4_solo_marble_zone_func_parte2_mz_1    
                  
solo_marble_zone_func_linha_laco4_prep_mz_1: addi $24 $25 -128

solo_marble_zone_func_linha_laco4_mz_1: beq $24 $25 laco3_solo_marble_zone_func_mz_1
                                   beq $25 $23 buraco_func_linha_laco4_mz_1
                                   sw $9 0($8)
                                   sw $9 32768($8)
                                   
                                   addi $8 $8 4
                                   
                                   addi $25 $25 -1
                                   j solo_marble_zone_func_linha_laco4_mz_1
                                   
buraco_func_linha_laco4_mz_1: jal buraco_func_mz_1
                         j solo_marble_zone_func_linha_laco4_mz_1                                
                                                      
fim_solo_marble_zone_func_mz_1: add $31 $0 $22 
                           jr $31
                           

# função buraco marble zone



buraco_func_mz_1: addi $23 $23 -28

buraco_func_laco_mz_1: beq $25 $23 fim_func_buraco_mz_1
                  sw $11 0($8)
                  sw $11 32768($8)
                  
                  add $8 $8 4
                  addi $25 $25 -1
                  j buraco_func_laco_mz_1

fim_func_buraco_mz_1: addi $23 $23 -100
                 jr $31



	#func castelo_mz_1
	
voltar_mz_1:
	jr $31
	
voltar_alternativo_mz_1:
	jr $18
	
	#base clara
castelo_luz_prep_func_mz_1:
	addi $20 $20 280 #final da grama + dist para dps do buraco
	addi $25 $0 3
	
	ori $9 $0 0xA9DFAF #verde claro luz
	ori $10 $0 0x72987B #verde escuro luz
	
	sw $9 -516($20)
	sw $9 -512($20)
	sw $9 -508($20)
	sw $9 -504($20)
	sw $9 -500($20)
	sw $9 -496($20)
	sw $9 -492($20)
	sw $9 -488($20)
	
	sw $9 -1024($20)
	sw $9 -1020($20)
	sw $9 -1016($20)
	sw $10 -1012($20)
	sw $9 -1008($20)
	sw $9 -1004($20)
	sw $9 -1000($20)

castelo_base_luz_func_mz_1:
	beq $25 $0 voltar_mz_1
	
	sw $9 1024($20)
	sw $9 512($20)
	sw $9 0($20)
	
	sw $10 1028($20)
	sw $10 516($20)
	sw $10 4($20)
	
	sw $9 1032($20)
	sw $9 520($20)
	sw $9 8($20)
	
	addi $20 $20 8
	addi $25 $25 -1
	j castelo_base_luz_func_mz_1
	
	
	#base escura
castelo_sombra_prep_func_mz_1:
	addi $20 $20 4
	addi $25 $0 3
	
	ori $9 $0 0x5D956D #verde claro sombra
	ori $10 $0 0x0D6334 #verde escuro sombra
	
	sw $9 -484($20)
	sw $9 -512($20)
	sw $9 -508($20)
	sw $9 -504($20)
	sw $9 -500($20)
	sw $9 -496($20)
	sw $9 -492($20)
	sw $9 -488($20)
	
	sw $9 -1024($20)
	sw $9 -1020($20)
	sw $9 -1016($20)
	sw $10 -1012($20)
	sw $9 -1008($20)
	sw $9 -1004($20)
	sw $9 -1000($20)

castelo_base_sombra_func_mz_1:
	beq $25 $0 voltar_mz_1
	
	sw $10 1024($20)
	sw $10 512($20)
	sw $10 0($20)
	
	sw $9 1028($20)
	sw $9 516($20)
	sw $9 4($20)
	
	sw $10 1032($20)
	sw $10 520($20)
	sw $10 8($20)
	
	addi $20 $20 8
	addi $25 $25 -1
	j castelo_base_sombra_func_mz_1
	
	
	#coluna clara
castelo_coluna_luz_prep_func_mz_1:
	addi $25 $0 2
	
	ori $9 $0 0xA9DFAF #verde claro luz
	ori $10 $0 0x72987B #verde escuro luz
	
castelo_coluna_luz_func_mz_1:
	beq $25 $0 voltar_mz_1
	
	sw $9 -1552($20)
	sw $9 -1548($20)
	sw $10 -1544($20)
	sw $10 -1540($20)
	sw $10 -1536($20)
	sw $9 -1532($20)
	sw $9 -1528($20)
	
	sw $9 -2064($20)
	sw $10 -2060($20)
	sw $10 -2056($20)
	sw $9 -2052($20)
	sw $10 -2048($20)
	sw $10 -2044($20)
	sw $9 -2040($20)
	
	sw $9 -2576($20)
	sw $10 -2572($20)
	sw $10 -2568($20)
	sw $9 -2564($20)
	sw $10 -2560($20)
	sw $10 -2556($20)
	sw $9 -2552($20)
	
	sw $9 -3088($20)
	sw $9 -3084($20)
	sw $10 -3080($20)
	sw $10 -3076($20)
	sw $10 -3072($20)
	sw $9 -3068($20)
	sw $9 -3064($20)
	
	sw $9 -3600($20)
	sw $9 -3596($20)
	sw $9 -3592($20)
	sw $10 -3588($20)
	sw $9 -3584($20)
	sw $9 -3580($20)
	sw $9 -3576($20)
	
	addi $20 $20 -2560
	addi $25 $25 -1
	j castelo_coluna_luz_func_mz_1
	
	#coluna sombra
castelo_coluna_sombra_prep_func_mz_1:
	addi $25 $0 2
	
	ori $9 $0 0x5D956D #verde claro sombra
	ori $10 $0 0x0D6334 #verde escuro sombra
	
castelo_coluna_sombra_func_mz_1:
	beq $25 $0 voltar_mz_1
	
	sw $9 -1524($20)
	sw $9 -1520($20)
	sw $10 -1516($20)
	sw $10 -1512($20)
	sw $10 -1508($20)
	sw $9 -1504($20)
	sw $9 -1500($20)
	
	sw $9 -2036($20)
	sw $10 -2032($20)
	sw $10 -2028($20)
	sw $9 -2024($20)
	sw $10 -2020($20)
	sw $10 -2016($20)
	sw $9 -2012($20)
	
	sw $9 -2548($20)
	sw $10 -2544($20)
	sw $10 -2540($20)
	sw $9 -2536($20)
	sw $10 -2532($20)
	sw $10 -2528($20)
	sw $9 -2524($20)
	
	sw $9 -3060($20)
	sw $9 -3056($20)
	sw $10 -3052($20)
	sw $10 -3048($20)
	sw $10 -3044($20)
	sw $9 -3040($20)
	sw $9 -3036($20)
	
	sw $9 -3572($20)
	sw $9 -3568($20)
	sw $9 -3564($20)
	sw $10 -3560($20)
	sw $9 -3556($20)
	sw $9 -3552($20)
	sw $9 -3548($20)
	
	addi $20 $20 -2560
	addi $25 $25 -1
	j castelo_coluna_sombra_func_mz_1
	
	
	#topo do castelo_mz_1
castelo_topo_prep_func_mz_1:
	addi $25 $0 49
	
	ori $9 $0 0xA7D4B1 #verde claro
	ori $10 $0 0x89B996 #verde escuro
	
castelo_topo_base_mz_1:
	beq $25 $0 castelo_topo_lateral_prep_mz_1
	
	sw $10 -6672($20)	#inicio do triagulo em cima
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_base_mz_1
	
castelo_topo_lateral_prep_mz_1:
	addi $25 $0 2
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_lateral_mz_1:
	beq $25 $0 castelo_topo_lateral_esquerda_prep_mz_1
	
	sw $9 -6672($20)	#esquerda
	sw $9 -6480($20)	#direita
	
	addi $25 $25 -1
	addi $20 $20 -512
	j castelo_topo_lateral_mz_1
	
castelo_topo_lateral_esquerda_prep_mz_1:
	addi $25 $0 9
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_lateral_esquerda_mz_1:
	beq $25 $0 castelo_topo_lateral_direita_prep_mz_1
	
	sw $9 -7692($20)
	sw $9 -7688($20)
	
	
	addi $25 $25 -1
	addi $20 $20 8
	addi $20 $20 -512
	j castelo_topo_lateral_esquerda_mz_1


castelo_topo_lateral_direita_prep_mz_1:
	addi $25 $0 9
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_lateral_direita_mz_1:
	beq $25 $0 castelo_topo_cima_prep_mz_1
	
	sw $9 -7508($20)
	sw $9 -7512($20)
	
	addi $25 $25 -1
	addi $20 $20 -8
	addi $20 $20 -512
	j castelo_topo_lateral_direita_mz_1


castelo_topo_cima_prep_mz_1:
	addi $25 $0 12
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_cima_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_mz_1
	
	sw $9 -11676($20)
	
	addi $25 $25 -1
	addi $20 $20 -4
	j castelo_topo_cima_mz_1
	
#topo do castelo_mz_1 preencher 1
castelo_topo_preencher_prep_mz_1:
	addi $25 $0 47
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_preencher_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_2_mz_1
	
	sw $9 -7180($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_mz_1
	
#topo do castelo_mz_1 preencher 2
castelo_topo_preencher_prep_2_mz_1:
	addi $25 $0 43
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_2_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_3_mz_1
	
	sw $9 -7684($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_2_mz_1
	
#topo do castelo_mz_1 preencher 3
castelo_topo_preencher_prep_3_mz_1:
	addi $25 $0 39
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_3_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_4_mz_1
	
	sw $9 -8188($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_3_mz_1
	
#topo do castelo_mz_1 preencher 4
castelo_topo_preencher_prep_4_mz_1:
	addi $25 $0 35
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_4_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_5_mz_1
	
	sw $9 -8692($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_4_mz_1
	
#topo do castelo_mz_1 preencher 5
castelo_topo_preencher_prep_5_mz_1:
	addi $25 $0 31
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_5_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_6_mz_1
	
	sw $9 -9196($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_5_mz_1
	
#topo do castelo_mz_1 preencher 6
castelo_topo_preencher_prep_6_mz_1:
	addi $25 $0 25
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_6_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_7_mz_1
	
	sw $9 -9196($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_6_mz_1
	
#topo do castelo_mz_1 preencher 7
castelo_topo_preencher_prep_7_mz_1:
	addi $25 $0 21
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_7_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_8_mz_1
	
	sw $9 -9196($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_7_mz_1

#topo do castelo_mz_1 preencher 8
castelo_topo_preencher_prep_8_mz_1:
	addi $25 $0 27
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_8_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_9_mz_1
	
	sw $9 -9700($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_8_mz_1
	
#topo do castelo_mz_1 preencher 9
castelo_topo_preencher_prep_9_mz_1:
	addi $25 $0 23
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_9_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_10_mz_1
	
	sw $9 -10204($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_9_mz_1
	
#topo do castelo_mz_1 preencher 10
castelo_topo_preencher_prep_10_mz_1:
	addi $25 $0 19
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_10_mz_1:
	beq $25 $0 castelo_topo_preencher_prep_11_mz_1
	
	sw $9 -10708($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_10_mz_1
	
#topo do castelo_mz_1 preencher 11
castelo_topo_preencher_prep_11_mz_1:
	addi $25 $0 15
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_11_mz_1:
	beq $25 $0 castelo_topo_desenho_prep_mz_1
	
	sw $9 -11212($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_11_mz_1
	
#desenhos castelo_mz_1 topo

castelo_topo_desenho_prep_mz_1:
	addi $25 $0 4
	addi $20 $19 280
	addi $20 $20 8
	
	ori $9 $0 0x5D956D #verde claro sombra
	
castelo_topo_desenho_mz_1:
	beq $25 $0 castelo_topo_desenho_prep_2_mz_1
	
	sw $9 -8180($20)
	sw $9 -8176($20)
	sw $9 -7664($20)
	sw $9 -7660($20)
	sw $9 -7144($20)
	sw $9 -7652($20)
	sw $9 -7648($20)
	sw $9 -8160($20)
	sw $9 -8156($20)
	
	#topo flor
	sw $9 -8168($20)
	sw $9 -8676($20)
	sw $9 -8684($20)
	sw $9 -9192($20)
	
	addi $25 $25 -1
	addi $20 $20 32
	j castelo_topo_desenho_mz_1
	
castelo_topo_desenho_prep_2_mz_1:
	addi $25 $0 2
	addi $20 $19 280
	addi $20 $20 -2560
	addi $20 $20 40
	
	ori $9 $0 0x5D956D #verde claro sombra
	
castelo_topo_desenho_2_mz_1:
	beq $25 $0 voltar_mz_1
	
	sw $9 -8180($20)
	sw $9 -8176($20)
	sw $9 -7664($20)
	sw $9 -7660($20)
	sw $9 -7144($20)
	sw $9 -7652($20)
	sw $9 -7648($20)
	sw $9 -8160($20)
	sw $9 -8156($20)
	
	#topo flor
	sw $9 -8168($20)
	sw $9 -8676($20)
	sw $9 -8684($20)
	sw $9 -9192($20)
	
	addi $25 $25 -1
	addi $20 $20 32
	j castelo_topo_desenho_2_mz_1