.text

main:
  lui $8 0x1001
  ori $9 $0 0x9C73B9 #roxo solo
  ori $10 $0 0x673F84 #roxo linha solo
  ori $11 $0 0x1F001F #roxo escuro fundo
  ori $12 $0 0x48214F #roxo linha fundo
  ori $13 $0 0xffffff #branco
  ori $14 $0 0
  ori $15 $0 0xFFFFFF #branco
  
fundo_prep:
	addi $25 $0 8192
	addi $24 $0 1024
	addi $23 $0 13
	
fundo_draw:
	beq $25 $0 fim
	
	sw $11 0($8)
	jal teste_height
	
	addi $8 $8 4
	addi $25 $25 -1
	addi $24 $24 -1
	j fundo_draw

fim:
  addi $2 $0 10
  syscall

#----------------------func-----------------------

teste_height:
	beq $24 $0 height_draw
	
	jr $31

height_draw:
	addi $24 $0 128
	addi $23 $23 2
	add $31 $0 $20
		
height_draw_l1:
	beq $24 $0 height_fim
	
	sw $12 0($8)
	jal brick_test
	
	addi $8 $8 4
	addi $24 $24 -1
	addi $23 $23 -1
	
	j height_draw_l1
	
height_fim:
	addi $24 $0 1024
	addi $23 $0 15
	
	jr $20
	
	
brick_test:
	beq $23 $0 brick_draw
	
	jr $31
	
brick_draw:
	sw $13 -512($8)
	sw $13 -1024($8)
	sw $13 -1536($8)
	sw $13 -2048($8)
	sw $13 -2560($8)
	sw $13 -3072($8)
	sw $13 -3584($8)
	sw $13 -4096($8)
	
	addi $23 $0 15
	jr $31