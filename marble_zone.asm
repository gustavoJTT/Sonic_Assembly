.text

main:
  lui $8 0x1001
  ori $9 $0 0x9C73B9 #roxo solo
  ori $10 $0 0x673F84 #roxo linha solo
  ori $11 $0 0x1F001F #roxo escuro fundo
  ori $12 $0 0x48214F #roxo linha fundo
  ori $13 $0 0
  ori $14 $0 0
  ori $15 $0 0xFFFFFF #branco
  
fundo_prep:
	addi $25 $0 8192
	
fundo_draw:
	beq $25 $0 linha_prep
	
	sw $11 0($8)
	
	addi $8 $8 4
	addi $25 $25 -1
	j fundo_draw
	
linha_prep:
	addi $8 $0 0
	lui $8 0x1001
	addi $25 $0 16
	
	addi $24 $0 1024 #altura tijolo
	addi $23 $0 75	#largura tijolo
	
linha_draw:
	beq $25 $0 fim
	
	jal teste_height
	jal teste_width
	
	addi $8 $8 4
	addi $24 $24 -1
	addi $23 $23 -1
	j linha_draw
		
fim:
  addi $2 $0 10
  syscall

#----------------------func-----------------------

teste_height:
	beq $24 $0 height_draw
	
	jr $31

height_draw:
	addi $24 $0 128
	add $22 $8 $0
		
height_draw_l1:
	beq $24 $0 height_fim
	
	sw $12 0($22)
	
	addi $22 $22 4
	addi $24 $24 -1
	j height_draw_l1
	
height_fim:
	addi $24 $0 1024
	jr $31
	
	
	
	
	
teste_width:
	beq $23 $0 width_draw
	
	jr $31
	
width_draw:
	sw $12 -512($8)
	sw $12 -1024($8)
	sw $12 -1536($8)
	
	addi $23 $0 75
	jr $31