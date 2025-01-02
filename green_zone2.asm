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
  
solo_prep: 
  addi $25 $25 32
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