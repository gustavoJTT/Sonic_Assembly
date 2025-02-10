.text

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

pulo: addi $8 $8 -2560
      
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

voltar:
	jr $31

timer:
  addi $16 $0 15000 #100000
  
forT:
	beq $16 $0 voltar
  nop
  nop
  addi $16 $16 -1      
  j forT