.data
	v: .word 1, 1, 1, 1, 1, 1, 1, 1
.text
	lui $t0, 0x1001 # seta na posicao
	ori $t1, $t1, 0 # int i = 0
	ori $t2, $t2, 0 # Local da memoria do vetor
	ori $t3, $t3, 0 # 1 == (i > n) || 0 == (i < n)
	ori $t4, $t4, 0 # n, n sempre vai ser um num par [0,2,4,6,...]
	ori $t5, $t5, 0 # Variavel temporaria 
	ori $t6, $t6, 0 # Variavel temporaria
	ori $t7, $t7, 0 # Variavel temporaria 
	la  $s0, v      # vetor[8]
		 
	for: beq  $t1,8,fim # for(;i<8;)
		sll $t2,$t1,2 
		add $t2,$t2,$s0	# vetor[i]
		fortu: slt $t3,$t4,$t1 
			beq $t3,1,menor
				j maior
				menor:  #menor
					add $t4,$t4,2 # n = n + 2
					j fortu
				maior:
					beq $t4,$t1,par #if(n == i)
						j impar
						par:    #par
							add $t5,$t1,$t1 # var = i * 2
							sw $t5,0($t2)	# vetor[i] = var
							j quit		
						impar:  #impar		
							sub $t5,$t1,1   # j = i - 1
							sll $t5,$t5,2 	#
							add $t5,$t5,$s0 # vetor[j]
							lw  $t5,0($t5)	# carrega vetor[j]
							lw  $t6,0($t2)  # carrega vetor[i]
							add $t7,$t5,$t6	# k = vetor[i] + vetor[j]
							sw  $t7,0($t2)	# Guarda vetor[i] = k
							j quit
					j fortu
		quit:	
		addi $t1,$t1,1 # i++
	j for
	fim: