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
  addi $24 $0 2580
  addi $23 $0 2294
  addi $22 $0 2022
  addi $21 $0 1338
  addi $20 $0 735

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
  addi $25 $0 2176
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
  addi $25 $0 171
  addi $23 $0 81

grama: 
  beq $25 $0 cachoeira_prep
  sw $14 0($8)
  sw $14 4($8)
  sw $13 8($8)
  jal placa_verif

  addi $8 $8 12
  addi $25 $25 -1
  addi $23 $23 -1
  j grama

cachoeira_prep: addi $8 $8 -1908
                addi $25 $0 2
                addi $20 $0 0 #variavel escolha tipo de cachoeira
                
cachoeira_grama: beq $25 $0 solo_prep
                 jal desenho_cachoeira
                 addi $25 $25 -1
                 addi $8 $8 416
                 j cachoeira_grama

solo_prep: 
  addi $25 $25 8
  addi $8 $8 -656

  addi $20 $0 1 #variavel escolha tipo de cachoeira

solo_laco1:
  beq $25 $0 ponte_prep
  addi $24 $0 53
  add $22 $0 $24
  addi $21 $24 -18

  
  addi $8 $8 512
  addi $25 $25 -1

solo_laco2:
  beq $24 $0 solo_laco1

  beq $21 $24 cachoeira_solo
  jal solo
  
  addi $24 $24 -1
  addi $8 $8 8
  j solo_laco2

cachoeira_solo: 
                jal desenho_cachoeira
                addi $8 $8 -512
                addi $24 $24 -1
                add $22 $0 $24
                j solo_laco2
                

ponte_prep: addi $8 $8 -9072
            jal ponte_func
            addi $8 $8 524
            jal ponte_func
            addi $8 $8 524
            jal ponte_func
            addi $8 $8 12
            jal ponte_func
            addi $8 $8 12
            jal ponte_func
            addi $8 $8 12
            jal ponte_func
            addi $8 $8 -500
            jal ponte_func
            addi $8 $8 -500
            jal ponte_func

peixe_prep: addi $8 $8 4536
            addi $25 $0 20
                  

peixe_laco1: beq $25 $0 fim
             jal func_peixe
             addi $8 $8 52
             jal func_peixe
             
             addi $25 $25 -1
             addi $8 $8 -564
             j peixe_laco1



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

  sw $12 -512($8)
  sw $12 -1024($8)
  sw $10 -1536($8)
  sw $10 -2052($8)
  sw $10 -2044($8)
  sw $9 -2048($8)
  sw $10 -2560($8)


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
  
#função ondas
      
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
  
# função desenho_cachoeira
  
desenho_cachoeira: 
                   addi $18 $0 2
                   addi $8 $8 -416
                      
laco1_cachoeira: beq $18 $0 fim_func_cachoeira
                 addi $18 $18 -1
                 addi $8 $8 416 
                 addi $19 $0 8
                 beq $20 $0 laco1_cachoeira_grama
                 addi $19 $0 12
                  
laco2_cachoeira: beq $19 $0 laco1_cachoeira
                 sw $10 0($8)
                 sw $10 32768($8)
                 
                 sw $9 4($8)
                 sw $9 32772($8)
                 
                 addi $8 $8 8
                 addi $19 $19 -1
                 j laco2_cachoeira
                 
laco1_cachoeira_grama: beq $19 $0 laco2_cachoeira_grama_prep
                       beq $18 $0 fim_func_cachoeira
                       
                      sw $15 0($8)
                      sw $15 32768($8)
                      
                      sw $9 4($8)
                      sw $9 32772($8)
                      
                      sw $10 8($8)
                      sw $10 32776($8)
                      
                      addi $8 $8 12
                      addi $19 $19 -1
                      j laco1_cachoeira_grama
                     
laco2_cachoeira_grama_prep: addi $18 $18 -1
                            addi $8 $8 416 
                            addi $19 $0 8    
                            
laco2_cachoeira_grama: beq $19 $0 laco1_cachoeira
                       
                      sw $10 0($8)
                      sw $10 32768($8)
                      
                      sw $15 4($8)
                      sw $15 32772($8)
                      
                      sw $9 8($8)
                      sw $9 32776($8)
                      
                      addi $8 $8 12
                      addi $19 $19 -1
                      j laco2_cachoeira_grama            
                 
fim_func_cachoeira: jr $31  

#função ponte_des para desenhar ponte  

ponte_func: ori $11 $0 0x250000 #marrom escuro  
            ori $12 $0 0x6A1B00 #marrom claro  
  
ponte_des: sw $11 0($8)
	   sw $11 32768($8)

           sw $12 4($8)
           sw $12 32772($8)
           
           sw $11 -508($8)
           sw $11 32260($8)
           
           sw $11 516($8)
           sw $11 33284($8)
           
           sw $11 8($8)
           sw $11 32776($8)
           
           jr $31
           
           
#função placa no final

placa_verif:
	beq $23 $0 placa_draw
	
	jr $31
	
placa_draw:
	ori $23 $0 0x919493 #cinza moldura placa
	ori $22 $0 0xF4FF2F #amarelo fundo placa
	ori $21 $0 0xFF0000 #vermelho jaqueta / vermelho nariz
	ori $20 $0 0xFFB797 #pele
	ori $19 $0 0x4F0005 #marrom barba
	ori $18 $0 0x2A72F4 #azul olhos
	
	#moldura
	sw $23 0($8)
	sw $23 32768($8)
	
	sw $23 -512($8)
	sw $23 32256($8)
	
	sw $23 -1024($8)
	sw $23 31744($8)
	
	sw $23 -1536($8)
	sw $23 31232($8)
	
	sw $23 -2048($8)
	sw $23 30720($8)
	
	#-4
	sw $23 -2044($8)
	sw $23 30724($8)
	
	sw $23 -2040($8)
	sw $23 30728($8)
	
	sw $23 -2036($8)
	sw $23 30732($8)
	
	sw $23 -2032($8)
	sw $23 30736($8)
	
	sw $23 -2028($8)
	sw $23 30740($8)
	
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
	sw $19 -4596($8)
	sw $19 -4592($8)
	sw $19 -4620($8)
	sw $19 -4624($8)
	
	
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
      
              
peixe: sw $11 -1024($8)
       sw $12 -512($8)
       sw $11 -508($8)
       sw $11 0($8)
       sw $11 4($8)
       sw $11 8($8)
       sw $12 512($8)
       sw $11 516($8)
       sw $13 520($8)
       sw $11 524($8)
       sw $11 1024($8)
       sw $11 1028($8)
       sw $11 1032($8)
       sw $11 1036($8)
       sw $11 1536($8)
       sw $11 1540($8)
       sw $11 1544($8)
       sw $11 2048($8)
       sw $11 2052($8)
       
       #corpo peixe animacao
       
       lw $15 35332($8)
       sw $15 2564($8)
       
       lw $15 34824($8)
       sw $15 2056($8)
       
       lw $15 34316($8)
       sw $15 1548($8)
       
       #parte baixo peixe
       
       sw $14 -516($8)
       sw $14 -4($8)
       sw $14 -8($8)
       sw $14 504($8)
       sw $14 508($8)
       sw $14 1016($8)
       sw $14 1020($8)
       sw $14 1532($8)

       #parte baixo peixe animacao
       
       lw $15 34296($8)
       sw $15 1528($8)
       
       lw $15 34812($8)
       sw $15 2044($8)
       
       
       #rabo
       
       sw $12 2560($8)
       sw $12 3068($8)
       sw $12 3072($8)
       sw $12 3076($8)
       sw $12 3580($8)
       sw $12 3588($8)
       sw $12 4092($8)
       sw $12 4100($8)
       
       
       # rabo animacao
       
       lw $15 36352($8)
       sw $15 3584($8)
       
       lw $15 37372($8)
       sw $15 4604($8)
       
       lw $15 37380($8)
       sw $15 4612($8)
       
       #cabinho cabeça
       
       sw $14 1040($8)
       sw $14 1044($8)
       sw $14 1556($8)
       sw $14 1560($8)
       
       #cabinho cabeca animacao
       
       lw $15 34320($8)
       sw $15 1552($8)
       
       lw $15 34836($8)
       sw $15 2068($8)
       
       lw $15 34840($8)
       sw $15 2072($8)
       
       jr $31