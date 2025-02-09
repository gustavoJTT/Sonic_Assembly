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
                   sw $9 4($8)
                   
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
                  sw $9 4($8)
                  sw $9 8($8)
                  sw $10 12($8)
                  sw $11 16($8)
                  sw $11 20($8)
                  
                  addi $8 $8 24
                  subi $25 $25 6
                  j laco_ceu_nublado_mz_1
                  
laco_ceu_nublado2_prep_mz_1: addi $23 $23 -108

laco_ceu_nublado2_mz_1: beq $23 $25 prep_laco_ceu_nublado_mz_1
                   sw $9 0($8)  
                   sw $9 4($8)   
                   sw $11 8($8)
                   sw $10 12($8)  
                   sw $10 16($8) 
                   sw $12 20($8)
                   
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
                            
                            addi $25 $25 -1
                            addi $8 $8 4
                            j laco1_solo_marble_zone_func_mz_1
                            
buraco_func_laco1_mz_1: jal buraco_func_mz_1  
                   j laco1_solo_marble_zone_func_mz_1                       

laco2_solo_marble_zone_func_prep_mz_1: addi $24 $24 -128

laco2_solo_marble_zone_func_mz_1: beq $25 $24 solo_marble_zone_func_linha_prep_mz_1
                             beq $25 $23 buraco_func_laco2_mz_1
                             sw $10 0($8)
                             sw $9 4($8)
                             
                             addi $8 $8 8
                             addi $25 $25 -2
                             j laco2_solo_marble_zone_func_mz_1 
   
buraco_func_laco2_mz_1: jal buraco_func_mz_1
                   j laco2_solo_marble_zone_func_mz_1 

solo_marble_zone_func_linha_prep_mz_1: addi $24 $24 -128

solo_marble_zone_func_linha_mz_1: beq $24 $25 laco3_solo_marble_zone_func_mz_1
                                   beq $25 $23 buraco_func_linha_mz_1
                                   sw $9 0($8)
                                   
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
                             sw $10 4($8)
                             addi $25 $25 -2
                             addi $8 $8 8
                             beq $25 $23 buraco_func_laco3_mz_1
                             
laco3_solo_marble_zone_func_parte2_mz_1: sw $10 0($8)
                                    sw $9 4($8)   
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
                                   
                                   addi $8 $8 4
                                   addi $25 $25 -1
                                   j solo_marble_zone_func_linha_laco3_mz_1
                                   
buraco_func_linha_laco3_mz_1: jal buraco_func_mz_1
                         j solo_marble_zone_func_linha_laco3_mz_1                                  
      
laco4_solo_marble_zone_func_parte1_prep_mz_1: addi $24 $0 50

laco4_solo_marble_zone_func_parte1_mz_1: beq $24 $0 solo_marble_zone_func_linha_laco4_prep_mz_1
                             sw $10 0($8)
                             sw $9 4($8)
                             addi $25 $25 -2
                             addi $8 $8 8
                             beq $25 $23 buraco_func_laco4_mz_1
                             
laco4_solo_marble_zone_func_parte2_mz_1: sw $10 0($8)
                                    sw $10 4($8)   
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