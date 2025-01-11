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
	

######## função lava

lava_draw_func:
	ori $10 $0 0xFF0000 #vermelho lava
	ori $11 $0 0xFF8A00 #laranja lava
	ori $12 $0 0xF9FC2B #amarelo lava
	
	sw $10 0($8)
	add $24 $0 $8
	addi $23 $25 -6
	addi $8 $8 -20612
	
lava_laco_start: beq $25 $23 lava_draw_laco_prep
                 addi $8 $8 416
                 addi $22 $0 8
                       
lava_laco2_start:     beq $22 $0 lava_laco3_start_prep
                      sw $10 0($8)
                      sw $11 4($8)
                      sw $12 8($8)
                      addi $8 $8 12
                      addi $22 $22 -1
                      j lava_laco2_start

lava_laco3_start_prep: addi $8 $8 416
                       addi $22 $0 8
                       addi $25 $25 -2
                       
lava_laco3_start:     beq $22 $0 lava_laco_start
		      sw $12 0($8)
                      sw $10 4($8)                       
                      sw $11 8($8)
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
	             sw $10 8($8)
	             sw $10 12($8)
	             
	             beq $23 $0 lava_draw_laco1
	             
	             sw $11 16($8)
	             sw $11 20($8)
	             sw $11 24($8)
	             sw $12 28($8)
	             sw $12 32($8)
	             sw $12 36($8)
	             
	             addi $8 $8 40
	             addi $23 $23 -1
	             j lava_draw_laco2
	
fim_func_lava: add $8 $0 $24
               jr $31