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
	
	addi $8 $8 4
	addi $25 $25 -1
	j fundo_draw


tijolo_fundo_prep:
	addi $8 $0 0
	lui $8 0x1001
	addi $25 $0 4481 #4504
	addi $24 $0 896
	
tijolo_fundo_draw:
	beq $25 $0 janelas_prep
	
	jal teste_height
	
	addi $8 $8 4
	addi $24 $24 -1
	addi $25 $25 -1
	addi $22 $0 -1
	j tijolo_fundo_draw

#desenhar janelas

janelas_prep: addi $25 $25 3
              add $24 $0 $8
              addi $8 $8 -17320
            
janelas_laco: beq $25 $0 solo_prep
              jal janelas_func
              
              addi $8 $8 -1880
              addi $25 $25 -1
              j janelas_laco


	#desenhar solo
solo_prep:
        add $8 $0 $24
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
	beq $25 $0 fim
	
	jal teste_height_solo
	
	addi $8 $8 -4
	addi $24 $24 -1
	addi $25 $25 -1
	j tijolo_solo_draw

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
	sw $10 -1024($8)
	sw $10 -1536($8)
	sw $10 -2048($8)
	sw $10 -2560($8)
	sw $10 -3072($8)
	sw $10 -3584($8)
	sw $10 -4096($8)
	
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
	
############### função janelas ############

janelas_func: ori $9 $0 0xAF7B1F #amarelo cornice
              ori $10 $0 0x000066 #azul dentro janela
              ori $11 $0 0x4F4F4F #cinza grade
              ori $12 $0 0xFFFFFF #branco
              
              addi $24 $0 5
              addi $23 $0 0 #contagem azul
              addi $22 $0 0
              addi $21 $0 -8
              sw $9 0($8)
              addi $8 $8 -4
              
janelas_borda1: beq $24 $0 janelas_grade_prep
                     add $8 $8 512
                     sw $9 0($8)
                     addi $8 $8 4
                     
janelas_ceu1: beq $23 $22 janelas_grade_meio
              sw $10 0($8)
              
              addi $8 $8 4
              addi $22 $22 1
              j janelas_ceu1

janelas_grade_meio: sw $11 0($8)
                    addi $8 $8 4
                    addi $21 $21 -8

                    
janelas_ceu2: beq $0 $22 janelas_borda2
              sw $10 0($8)
              
              addi $8 $8 4
              addi $22 $22 -1
              j janelas_ceu2                                      

janelas_borda2: sw $9 0($8)
                addi $8 $8 4  
                
                addi $24 $24 -1
                addi $23 $23 1
                add $8 $8 $21
                j janelas_borda1 

janelas_grade_prep: addi $24 $0 3
                    addi $8 $8 4
                                                          
janelas_grade_laco: beq $24 $0 janelas_borda_baixo
                    addi $8 $8 512
                    addi $24 $24 -1
                    addi $23 $0 6
                    
                    sw $9 0($8)
                    sw $11 4($8)
                    sw $11 8($8)
                    sw $11 12($8)
                    sw $11 16($8)
                    sw $11 20($8)
                    sw $11 24($8)
                    sw $11 28($8)
                    sw $11 32($8)
                    sw $11 36($8)
                    sw $9 40($8)

janelas_laco_func: beq $23 $0 janelas_grade_laco

              addi $8 $8 512
              sw $9 0($8)
              sw $10 4($8)
              sw $10 8($8)
              sw $10 12($8)
              sw $10 16($8)
              sw $11 20($8)
              sw $10 24($8)
              sw $10 28($8)
              sw $10 32($8)
              sw $10 36($8)
              sw $9 40($8)
              
              addi $23 $23 -1
              j janelas_laco_func

                                        
janelas_borda_baixo: addi $8 $8 512
                     sw $9 0($8)  
                     sw $9 4($8)
             	     sw $9 8($8)
	             sw $9 12($8)
        	     sw $9 16($8)
          	     sw $9 20($8)
        	     sw $9 24($8)
                     sw $9 28($8)
	             sw $9 32($8)
        	     sw $9 36($8)
	             sw $9 40($8)

janela_estrelas: addi $8 $8 -11760
                 sw $12 0($8)
                 sw $12 2064($8)
                 sw $12 3064($8)
                 sw $12 5140($8)
                 sw $12 9724($8)
                 sw $12 10764($8) 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
fim_func_janelas: jr $31









