.text
fimScr:
      lui $8, 0x1001
      ori $20, 0xffffff
      addi $10, $0, 512
      lui $21, 0xffff
      addi $25, $0, 32
      addi $10, $0, 4
      addi $11, $0, 'a'
      addi $12, $0, 'd'
      addi $13, $0, 's'
      addi $14, $0, 'w'
for2:      
     
      sw $20, 0($8)
      jal timer      
      lw $9, 2048($8)
      sw $9, 0($8)
      add $8, $8, $10


      lw $22, 0($21)
      beq $22, $0, cont
      lw $23, 4($21)
      beq $23, $25, fim
      beq $23, $11, esq
      beq $23, $12, dir
      beq $23, $13, baixo
      beq $23, $14, cima
     
     
      j cont
esq:  addi $10, $0, -4      
      j cont
     
dir:  addi $10, $0, 4
      j cont  
     
baixo:  addi $10, $0, +128
      j cont
     
cima:  addi $10, $0, -128
      j cont                          
                 
     
cont: j for2
fim:  addi $2, $0, 10
      syscall    
#====================================================================
# função Timer

timer: sw $16, 0($29)
       addi $29, $29, -4
       addi $16, $0, 100000
forT:  beq $16, $0, fimT
       nop
       nop
       addi $16, $16, -1      
       j forT                  
fimT:  addi $29, $29, 4                                                    
       lw $16, 0($29)          
       jr $31