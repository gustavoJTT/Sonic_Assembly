.text

main:
  lui $8 0x1001


ceu_prep: addi $25 $0 1704
          addi $24 $0 744

ceu_nublado: jal ceu_nublado_func
  
ceu_normal: jal ceu_normal_func

contador: jal contador_prep

montanhas_prep:
  addi $22 $0 4

montanha1_prep:
  beq  $22 $0 montanha3
  addi $22 $22 -1
  addi $24 $0 7 #$24 > altura montanha 


montanha1:
  jal criar_montanha

montanha2_prep:
  addi $24 $0 9 

montanha2:
  jal criar_montanha
  addi $8 $8 -4
 
  j montanha1_prep

montanha3: addi $24 $0 7
           jal criar_montanha
           
           addi $8 $8 -20
           
cespugli_prep: addi $25 $0 172
               addi $24 $0 4
               addi $17 $25 -43
               addi $8 $8 16

cespugli_laco1: beq $25 $0 castelo

cespugli_laco2: beq $25 $17 cespugli_outro_strato
               jal criar_cespugli_prep
               addi $25 $25 -1      
               j cespugli_laco1 
               
cespugli_outro_strato: addi $8 $8 1536
                       addi $17 $17 -43
                       j cespugli_laco2               

castelo: 

grama_marble_zone_prep: addi $8 $8 1520
												add $20 $8 $0
												add $19 $8 $0
                        ori $9 $0 0x00AD2B #verde escuro
                        ori $10 $0 0x62FF36 #verde claro
                        addi $25 $0 384
                        

grama_marble_zone: beq $25 $0 solo_marble_zone1
                   sw $10 0($8)
                   sw $10 32768($8)
                   sw $9 4($8)
                   sw $9 32772($8)
                   
                   addi $8 $8 8
                   addi $25 $25 -2
                   j grama_marble_zone
                   
solo_marble_zone1: addi $25 $25 3712
                   addi $24 $25 -256
                   addi $23 $25 -34
                   
                   jal solo_marble_zone_func                 

castelo_base_luz_main:
	jal castelo_luz_prep_func

castelo_base_sombra_main:
	jal castelo_sombra_prep_func
	
castelo_coluna_luz_main:
	addi $20 $19 296
	jal castelo_coluna_luz_prep_func
	
castelo_coluna_sombra_main:
	addi $20 $19 296
	jal castelo_coluna_sombra_prep_func


castelo_base_luz_main_2:
	addi $20 $19 108
	jal castelo_luz_prep_func

castelo_base_sombra_main_2:
	jal castelo_sombra_prep_func
	
castelo_coluna_luz_main_2:
	addi $20 $19 404
	jal castelo_coluna_luz_prep_func
	
castelo_coluna_sombra_main_2:
	addi $20 $19 404
	jal castelo_coluna_sombra_prep_func
	
castelo_topo_main:
	addi $20 $19 280
	jal castelo_topo_prep_func

fim: addi $2 $0 10
     syscall
  
  
###################### funções ######################

# funcão ceu nublado  

ceu_nublado_func: ori $9 $0 0x0082E0 # azul nuvem
                  ori $10 $0 0x87B8BD # azul ondas
                  ori $11 $0 0x1D009F # azul ceu
                  ori $12 $0 0xFFFFFF # branco
                                    
prep_laco_ceu_nublado: beq $25 $24 fim_func_ceu_nublado
                       addi $23 $25 -132

laco_ceu_nublado: beq $23 $25 laco_ceu_nublado2_prep

                  sw $9 0($8)
                  sw $9 4($8)
                  sw $9 8($8)
                  sw $10 12($8)
                  sw $11 16($8)
                  sw $11 20($8)
                  
                  addi $8 $8 24
                  subi $25 $25 6
                  j laco_ceu_nublado
                  
laco_ceu_nublado2_prep: addi $23 $23 -108

laco_ceu_nublado2: beq $23 $25 prep_laco_ceu_nublado
                   sw $9 0($8)  
                   sw $9 4($8)   
                   sw $11 8($8)
                   sw $10 12($8)  
                   sw $10 16($8) 
                   sw $12 20($8)
                   
                   addi $8 $8 24
                  subi $25 $25 4
                  j laco_ceu_nublado2       
                  
fim_func_ceu_nublado: jr $31
  
#func ceu normal

ceu_normal_func: ori $9 $0 0x1D009F # azul ceu

laco_ceu_normal: beq $25 $0 fim_func_ceu_normal
                 sw $9 0($8)
                 
                 addi $8 $8 4
                 addi $25 $25 -1
                 
                 j laco_ceu_normal
  
fim_func_ceu_normal: jr $31  
  
# função montanhas marble zone

criar_montanha:
                ori $9 $0 0x48214F #roxo montanhas
                addi $23 $0 1
  		addi $21 $0 0
  		addi $20 $0 1
  		addi $19 $0 0
 	        addi $24 $24 1
 	        addi $8 $8 512

montanha_subindo:
  beq $24 $23 montanha_descendo_prep

montanha_subindo2:
  beq $21 $23 fim_montanha_subindo
  sw $9 -512($8)
  addi $21 $21 1 
  addi $8 $8 -512
  addi $19 $19 512
  j montanha_subindo2

fim_montanha_subindo:
  addi $23 $23 1
  addi $21 $0 0
  add $8 $8 $19
  addi $19 $0 0
  addi $8 $8 4
  j montanha_subindo

montanha_descendo_prep:
  addi $23 $23 -1

montanha_descendo:
  beq $23 $20 fim_func_montanhas
  addi $23 $23 -1


montanha_descendo2:
  beq $21 $23 fim_montanha_descendo
  sw $9 -512($8)
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
  
#função criar cespugli marble zone
  
criar_cespugli_prep:
                ori $9 $0 0x62FF36 #verde claro
                ori $10 $0 0x067826 #verde mais escuro
  		addi $20 $0 4
  		addi $23 $0 0 #contagem cespugli
  		addi $22 $0 0
 	        addi $8 $8 1536

cespugli_subindo:
  beq $23 $24 fim_cespugli_subindo
  sw $9 0($8)
  sw $9 32768($8)
  
  addi $23 $23 1 
  addi $8 $8 -512
  addi $22 $22 512
  j cespugli_subindo

fim_cespugli_subindo:
  addi $24 $24 2
  addi $23 $0 0
  add $8 $8 $22
  addi $22 $0 0
  addi $8 $8 4

cespugli_descendo_prep:
  beq $24 $20 fim_func_cespugli
  addi $24 $24 -1

cespugli_descendo:
  beq $24 $23 fim_cespugli_descendo
  sw $10 0($8)
  sw $10 32768($8)
  
  addi $23 $23 1 
  addi $8 $8 -512
  addi $22 $22 512
  j cespugli_descendo

fim_cespugli_descendo:
  addi $23 $0 0
  ori $10 $0 0x00AD2B #verde escuro
  add $8 $8 $22
  addi $22 $0 0
  addi $8 $8 4
  j cespugli_descendo_prep             


fim_func_cespugli: 
  addi $8 $8 -1536
  jr $31 
  
# função solo marble zone

solo_marble_zone_func: ori $9 $0 0x6A3F84 #roxo escuro solo
                       ori $10 $0 0x9C73B9 #roxo claro solo
                       ori $11 $0 0x48214F #roxo montanhas
                       add $22 $0 $31

laco1_solo_marble_zone_func: beq $25 $24 laco2_solo_marble_zone_func_prep
                            beq $25 $23 buraco_func_laco1

                            sw $9 0($8)
                            
                            addi $25 $25 -1
                            addi $8 $8 4
                            j laco1_solo_marble_zone_func
                            
buraco_func_laco1: jal buraco_func  
                   j laco1_solo_marble_zone_func                       

laco2_solo_marble_zone_func_prep: addi $24 $24 -128

laco2_solo_marble_zone_func: beq $25 $24 solo_marble_zone_func_linha_prep
                             beq $25 $23 buraco_func_laco2
                             sw $10 0($8)
                             sw $9 4($8)
                             
                             addi $8 $8 8
                             addi $25 $25 -2
                             j laco2_solo_marble_zone_func 
   
buraco_func_laco2: jal buraco_func
                   j laco2_solo_marble_zone_func 

solo_marble_zone_func_linha_prep: addi $24 $24 -128

solo_marble_zone_func_linha: beq $24 $25 laco3_solo_marble_zone_func
                                   beq $25 $23 buraco_func_linha
                                   sw $9 0($8)
                                   
                                   addi $8 $8 4
                                   addi $25 $25 -1
                                   j solo_marble_zone_func_linha 
    
buraco_func_linha: jal buraco_func
                         j solo_marble_zone_func_linha
        
laco3_solo_marble_zone_func: beq $0 $25 fim_solo_marble_zone_func

laco3_solo_marble_zone_func_prep: addi $24 $0 50

laco3_solo_marble_zone_func_parte1: beq $24 $0 solo_marble_zone_func_linha_laco3_prep
                             beq $25 $0 fim_solo_marble_zone_func
                             sw $10 0($8)
                             sw $10 4($8)
                             addi $25 $25 -2
                             addi $8 $8 8
                             beq $25 $23 buraco_func_laco3
                             
laco3_solo_marble_zone_func_parte2: sw $10 0($8)
                                    sw $9 4($8)   
                                    addi $24 $24 -1
                                    addi $8 $8 8
                                    addi $25 $25 -2                     
                                    j laco3_solo_marble_zone_func_parte1
  
buraco_func_laco3: jal buraco_func
                   j laco3_solo_marble_zone_func_parte2  
                   
solo_marble_zone_func_linha_laco3_prep: addi $24 $25 -128

solo_marble_zone_func_linha_laco3: beq $24 $25 laco4_solo_marble_zone_func_parte1_prep
                                   beq $25 $23 buraco_func_linha_laco3
                                   sw $9 0($8)
                                   
                                   addi $8 $8 4
                                   addi $25 $25 -1
                                   j solo_marble_zone_func_linha_laco3
                                   
buraco_func_linha_laco3: jal buraco_func
                         j solo_marble_zone_func_linha_laco3                                  
      
laco4_solo_marble_zone_func_parte1_prep: addi $24 $0 50

laco4_solo_marble_zone_func_parte1: beq $24 $0 solo_marble_zone_func_linha_laco4_prep
                             sw $10 0($8)
                             sw $9 4($8)
                             addi $25 $25 -2
                             addi $8 $8 8
                             beq $25 $23 buraco_func_laco4
                             
laco4_solo_marble_zone_func_parte2: sw $10 0($8)
                                    sw $10 4($8)   
                                    addi $24 $24 -1
                                    addi $8 $8 8
                                    addi $25 $25 -2                     
                                    j laco4_solo_marble_zone_func_parte1    
                                    
buraco_func_laco4: jal buraco_func
                   j laco4_solo_marble_zone_func_parte2    
                  
solo_marble_zone_func_linha_laco4_prep: addi $24 $25 -128

solo_marble_zone_func_linha_laco4: beq $24 $25 laco3_solo_marble_zone_func
                                   beq $25 $23 buraco_func_linha_laco4
                                   sw $9 0($8)
                                   
                                   addi $8 $8 4
                                   
                                   addi $25 $25 -1
                                   j solo_marble_zone_func_linha_laco4
                                   
buraco_func_linha_laco4: jal buraco_func
                         j solo_marble_zone_func_linha_laco4                                
                                                      
fim_solo_marble_zone_func: add $31 $0 $22 
                           jr $31
                           

# função buraco marble zone



buraco_func: addi $23 $23 -28

buraco_func_laco: beq $25 $23 fim_func_buraco
                  sw $11 0($8)
                  sw $11 32768($8)
                  
                  add $8 $8 4
                  addi $25 $25 -1
                  j buraco_func_laco

fim_func_buraco: addi $23 $23 -100
                 jr $31



	#func castelo
	
voltar:
	jr $31
	
voltar_alternativo:
	jr $18
	
	#base clara
castelo_luz_prep_func:
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

castelo_base_luz_func:
	beq $25 $0 voltar
	
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
	j castelo_base_luz_func
	
	
	#base escura
castelo_sombra_prep_func:
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

castelo_base_sombra_func:
	beq $25 $0 voltar
	
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
	j castelo_base_sombra_func
	
	
	#coluna clara
castelo_coluna_luz_prep_func:
	addi $25 $0 2
	
	ori $9 $0 0xA9DFAF #verde claro luz
	ori $10 $0 0x72987B #verde escuro luz
	
castelo_coluna_luz_func:
	beq $25 $0 voltar
	
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
	j castelo_coluna_luz_func
	
	#coluna sombra
castelo_coluna_sombra_prep_func:
	addi $25 $0 2
	
	ori $9 $0 0x5D956D #verde claro sombra
	ori $10 $0 0x0D6334 #verde escuro sombra
	
castelo_coluna_sombra_func:
	beq $25 $0 voltar
	
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
	j castelo_coluna_sombra_func
	
	
	#topo do castelo
castelo_topo_prep_func:
	addi $25 $0 49
	
	ori $9 $0 0xA7D4B1 #verde claro
	ori $10 $0 0x89B996 #verde escuro
	
castelo_topo_base:
	beq $25 $0 castelo_topo_lateral_prep
	
	sw $10 -6672($20)	#inicio do triagulo em cima
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_base
	
castelo_topo_lateral_prep:
	addi $25 $0 2
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_lateral:
	beq $25 $0 castelo_topo_lateral_esquerda_prep
	
	sw $9 -6672($20)	#esquerda
	sw $9 -6480($20)	#direita
	
	addi $25 $25 -1
	addi $20 $20 -512
	j castelo_topo_lateral
	
castelo_topo_lateral_esquerda_prep:
	addi $25 $0 9
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_lateral_esquerda:
	beq $25 $0 castelo_topo_lateral_direita_prep
	
	sw $9 -7692($20)
	sw $9 -7688($20)
	
	
	addi $25 $25 -1
	addi $20 $20 8
	addi $20 $20 -512
	j castelo_topo_lateral_esquerda


castelo_topo_lateral_direita_prep:
	addi $25 $0 9
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_lateral_direita:
	beq $25 $0 castelo_topo_cima_prep
	
	sw $9 -7508($20)
	sw $9 -7512($20)
	
	addi $25 $25 -1
	addi $20 $20 -8
	addi $20 $20 -512
	j castelo_topo_lateral_direita


castelo_topo_cima_prep:
	addi $25 $0 12
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_cima:
	beq $25 $0 castelo_topo_preencher_prep
	
	sw $9 -11676($20)
	
	addi $25 $25 -1
	addi $20 $20 -4
	j castelo_topo_cima
	
#topo do castelo preencher 1
castelo_topo_preencher_prep:
	addi $25 $0 47
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro
	
castelo_topo_preencher:
	beq $25 $0 castelo_topo_preencher_prep_2
	
	sw $9 -7180($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher
	
#topo do castelo preencher 2
castelo_topo_preencher_prep_2:
	addi $25 $0 43
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_2:
	beq $25 $0 castelo_topo_preencher_prep_3
	
	sw $9 -7684($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_2
	
#topo do castelo preencher 3
castelo_topo_preencher_prep_3:
	addi $25 $0 39
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_3:
	beq $25 $0 castelo_topo_preencher_prep_4
	
	sw $9 -8188($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_3
	
#topo do castelo preencher 4
castelo_topo_preencher_prep_4:
	addi $25 $0 35
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_4:
	beq $25 $0 castelo_topo_preencher_prep_5
	
	sw $9 -8692($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_4
	
#topo do castelo preencher 5
castelo_topo_preencher_prep_5:
	addi $25 $0 31
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_5:
	beq $25 $0 castelo_topo_preencher_prep_6
	
	sw $9 -9196($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_5
	
#topo do castelo preencher 6
castelo_topo_preencher_prep_6:
	addi $25 $0 25
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_6:
	beq $25 $0 castelo_topo_preencher_prep_7
	
	sw $9 -9196($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_6
	
#topo do castelo preencher 7
castelo_topo_preencher_prep_7:
	addi $25 $0 21
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_7:
	beq $25 $0 castelo_topo_preencher_prep_8
	
	sw $9 -9196($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_7

#topo do castelo preencher 8
castelo_topo_preencher_prep_8:
	addi $25 $0 27
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_8:
	beq $25 $0 castelo_topo_preencher_prep_9
	
	sw $9 -9700($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_8
	
#topo do castelo preencher 9
castelo_topo_preencher_prep_9:
	addi $25 $0 23
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_9:
	beq $25 $0 castelo_topo_preencher_prep_10
	
	sw $9 -10204($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_9
	
#topo do castelo preencher 10
castelo_topo_preencher_prep_10:
	addi $25 $0 19
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_10:
	beq $25 $0 castelo_topo_preencher_prep_11
	
	sw $9 -10708($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_10
	
#topo do castelo preencher 11
castelo_topo_preencher_prep_11:
	addi $25 $0 15
	addi $20 $19 280
	
	ori $9 $0 0xA7D4B1 #verde claro

castelo_topo_preencher_11:
	beq $25 $0 castelo_topo_desenho_prep
	
	sw $9 -11212($20)
	
	addi $25 $25 -1
	addi $20 $20 4
	j castelo_topo_preencher_11
	
#desenhos castelo topo

castelo_topo_desenho_prep:
	addi $25 $0 4
	addi $20 $19 280
	addi $20 $20 8
	
	ori $9 $0 0x5D956D #verde claro sombra
	
castelo_topo_desenho:
	beq $25 $0 castelo_topo_desenho_prep_2
	
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
	j castelo_topo_desenho
	
castelo_topo_desenho_prep_2:
	addi $25 $0 2
	addi $20 $19 280
	addi $20 $20 -2560
	addi $20 $20 40
	
	ori $9 $0 0x5D956D #verde claro sombra
	
castelo_topo_desenho_2:
	beq $25 $0 voltar
	
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
	j castelo_topo_desenho_2
	
# função contador moedas

contador_prep: ori $9 $0 0x000000
               addi $25 $8 -7160
               addi $24 $0 7
               addi $23 $0 24
               
contador_laco1: beq $24 $0 letras        
         
contador_laco2: beq $23 $0 fim_laco_contador
                sw $9 0($25)
                
                addi $25 $25 4
                addi $23 $23 -1
                j contador_laco2

fim_laco_contador: addi $24 $24 -1  
                   addi $25 $25 416
                   addi $23 $0 24
                   
                   j contador_laco1              

letras: add $24 $0 $31
        addi $25 $8 -6640
        jal moeda_desenho
        add $31 $0 $24
        j desenho_x
        
moeda_desenho: ori $9 $0 0xffff00
               ori $10 $0 0xffffff
               
               sw $9 0($25)
               sw $9 4($25)
               sw $9 8($25)
               sw $9 508($25)
               sw $9 524($25)
               sw $9 1020($25)
               sw $9 1036($25)
               sw $9 1532($25)
               sw $10 1548($25)
               sw $9 2048($25)
               sw $10 2052($25)
               sw $10 2056($25)
               
               
               jr $31        

desenho_x:  sw $10 20($25)
            sw $10 36($25)
            sw $10 536($25)
            sw $10 544($25)
            sw $10 1052($25)
            sw $10 1560($25)
            sw $10 1568($25)
            sw $10 2068($25)
            sw $10 2084($25)
            
desenho_numero0: sw $10 48($25)
                 sw $10 52($25)
                 sw $10 556($25)
                 sw $10 568($25)
                 sw $10 1068($25)
                 sw $10 1080($25)
                 sw $10 1580($25)
                 sw $10 1592($25)
                 sw $10 2096($25)
                 sw $10 2100($25)
            
desenho_numero1: ori $9 $0 0x000000
                 
                 sw $9 52($25)
                 sw $9 568($25)
                 sw $9 1068($25)
                 sw $9 1080($25)
                 sw $9 1580($25)
                 sw $9 1592($25)
                 
                 sw $10 560($25)
                 sw $10 1072($25)
                 sw $10 1584($25)
                 sw $10 2092($25)
             
                 
desenho_numero2: sw $9 560($25)
                 sw $9 1072($25)

                 sw $10 52($25)
                 sw $10 568($25)
                 sw $10 1076($25)
                 sw $10 2092($25)
                 sw $10 2104($25)
                 
desenho_numero3: sw $9 1584($25) 
                 sw $9 2092($25)
                 sw $9 2104($25)
                 
                 sw $10 1580($25)
                 sw $10 1592($25)
                              
desenho_numero4: sw $9 48($25)
                 sw $9 556($25)
                 sw $9 568($25)
                 sw $9 2096($25)

                 sw $10 560($25)
                 sw $10 564($25)
                 sw $10 1068($25)
                 sw $10 1584($25)
                 sw $10 1588($25)
                

fim_func_contador: jr $31
