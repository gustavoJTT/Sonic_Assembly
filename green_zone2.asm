.text

main:
	lui $8 0x1001
	ori $9 $0 0x1D009F #azul ceu
	ori $10 $0 0x0082E0 #azul mar
	ori $11 $0 0x250000 #marrom escuro
	ori $12 $0 0x6A1B00 #marrom claro
	ori $13 $0 0x62FF36 #verde claro
	ori $14 $0 0x00AD2B #verde escuro
	
	#addi $25 $0 8192 #mÃ¡ximo da tela
	
	addi $25 $0 3328
	
ceu:
	beq $25 $0 montanhas_prep
	
	sw $9 0($8)
	
	addi $8 $8 4
	addi $25 $25 -1
	j ceu

montanhas_prep: addi $22 $0 11

montanha1_prep: beq  $22 $0 mar_prep
                addi $22 $22 -1
                addi $24 $0 7 #$24 > altura montanha 
                addi $23 $0 1

montanha1: jal criar_montanha

montanha2_prep: addi $24 $0 5
                addi $23 $0 1 
 
montanha2: jal criar_montanha
           #sw $10 4($8)
          # addi $8 $8 4
           j montanha1_prep

mar_prep: 
	addi $25 $0 2006
	
mar:   
	beq $25 $0 grama_prep
	
	sw $10 0($8)
	
	addi $8 $8 4
	addi $25 $25 -1
	j mar 



grama_prep: 
  addi $25 $0 142
  addi $23 $0 10

grama: 
	beq $25 $0 solo_prep
	jal flor_verif
  sw $14 0($8)
  sw $14 4($8)
  sw $13 8($8)
       
  addi $8 $8 12
  addi $25 $25 -1
  addi $23 $23 -1
  j grama




solo_prep: 
	addi $25 $25 9
  addi $8 $8 -512
           

solo_laco1:
	beq $25 $0 fim
  addi $24 $0 64
           
  addi $8 $8 512
  addi $25 $25 -1

solo_laco2:
	beq $24 $0 solo_laco1
           
  jal solo
           
  addi $24 $24 -1
  addi $8 $8 8
  j solo_laco2




	
fim:
	addi $2 $0 10
  syscall

#----------------------func-----------------------

#função solo para prencher o solo de jeito alternado

solo: 
	lw $23 -4($8)
	addi $22 $0 64
  beq $22 $24 escolha_solo
      
  beq $23 $12 marr_esc
  j marr_claro

	
escolha_solo: 
	bne $23 $12 marr_esc 
    
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

criar_montanha: addi $21 $0 0
                addi $20 $0 1
                addi $19 $0 0
                addi $24 $24 2
                addi $8 $8 512

montanha_subindo: beq $24 $23 montanha_descendo_prep

montanha_subindo2: beq $21 $23 fim_montanha_subindo
                   sw $11 -512($8)
                   addi $21 $21 1 
                   addi $8 $8 -512
                   addi $19 $19 512
                   j montanha_subindo2
                   
fim_montanha_subindo: addi $23 $23 2
                      addi $21 $0 0
                      add $8 $8 $19
                      addi $19 $0 0
                      addi $8 $8 4
                      j montanha_subindo

montanha_descendo_prep: addi $23 $23 -2

montanha_descendo: beq $23 $20 fim_func_montanhas
                   addi $23 $23 -2
                   
 
montanha_descendo2: beq $21 $23 fim_montanha_descendo
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


fim_func_montanhas: addi $8 $8 -512
                    jr $31
                    
                    
flor_verif:
	beq $23 $0 flor_draw
	
	jr $31
	
flor_draw:
	addi $9 $0 0
	ori $9 $0 0x442305 #marrom meio flor
	ori $10 $0 0xF7D10F #cor flor
	
	sw $12 -512($8)
	sw $12 -1024($8)
	sw $10 -1536($8)
	sw $10 -2052($8)
	sw $10 -2044($8)
	sw $9 -2048($8)
	sw $10 -2560($8)
	
	addi $23 $0 10
	jr $31
