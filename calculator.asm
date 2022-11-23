########################################################################################################################
# Aluno: Eduardo Henrique Freire Machado
# Matrícula: 2020001617
# Disciplina: DCC510 - Programação em Baixo Nível
#
# Descrição da atividade:
# Calculadora capaz de realizar soma, subtração, multiplicação e divisão de dois números
# Capaz ainda de obter potência, raiz quadrada e tabuada de um único número
#
# Implementado até agora:
# - Tela inicial mostrando os códigos de operações
# - Soma, subtração, multiplicação e divisão de dois números
# - Função de finalização da execução do programa
########################################################################################################################

.data

########################################################################################################################
# Mensagens utilizadas durante a execução do programa
########################################################################################################################

start_msg: .asciiz "0 para sair\n1 para soma\n2 para subtração\n3 para divisão\n4 para multiplicação\n\n"
select_op: .asciiz "Selecione uma operação: "
first_number: .asciiz "Primeiro número: "
second_number: .asciiz "Segundo número: "
no_op: .asciiz "Esse código de operação não foi identificado, tente novamente..."
add_op: .asciiz "O resultado da soma é "
sub_op: .asciiz "O resultado da subtração é "
div_op: .asciiz "O resultado da divisão é "
mod_op: .asciiz "\nO resto da divisão é "
mul_op: .asciiz "O resultado da multiplicação é "
pot_op: .asciiz "O resultado da potência é "
sqr_op: .asciiz "A raiz quadrada é "
tab_op: .asciiz "Tabuada:\n"
tab_msg1: .asciiz "X"
tab_msg2: .asciiz " = "
tab_br: .asciiz "\n"
leave: .asciiz "Bye\n"
br: .asciiz "\n-------------------------------------------------------\n\n"

########################################################################################################################

.text

########################################################################################################################
# Tela inicial (mostrada apenas uma vez por execução do programa)
########################################################################################################################

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, start_msg         # Passa endereço de start_msg (mensagem inicial) para $a0
syscall                   # Executa chamada de sistema

addi $sp, $sp, -8         # "Aloca" 2 espaços na pilha para uso durante execução do programa

########################################################################################################################
# Função principal (loop infinito até ler o código de operação para finalizar programa)
########################################################################################################################

main:

la $a0, select_op         # Passa endereço de start_msg (mensagem inicial) para $a0
syscall                   # Executa chamada de sistema

li $v0, 5                 # Passa código de ler inteiro para $v0
syscall                   # Executa chamada de sistema

move $t0, $v0             # $t0 = $v0
                          # Usado para verificar qual operação foi passada

beq $t0, $zero, exit_fn   # Se $t0 for 0, pule para função exit_fn (finalizar programa)
blt $t0, 1, no_fn         # Se $t0 for menor que 1, pule para função no_fn (Operação não identificada)
bgt $t0, 4, no_fn         # Se $t0 for maior que 4, pule para função no_fn (Operação não identificada)

beq $t0, 1, add_fn        # Se $t0 for 1, pule para função add_fn (soma)
beq $t0, 2, sub_fn        # Se $t0 for 2, pule para função sub_fn (subtração)
beq $t0, 3, div_fn        # Se $t0 for 3, pule para função div_fn (divisão)
beq $t0, 4, mul_fn        # Se $t0 for 4, pule para função mul_fn (multiplicação)
beq $t0, 5, pot_fn        # Se $t0 for 4, pule para função pot_fn (potenciação)
beq $t0, 6, sqr_fn        # Se $t0 for 4, pule para função sqr_fn (radiciação)

########################################################################################################################
# Ler números
########################################################################################################################

read_two_numbers:

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, first_number      # Passa endereço de first_number (mensagem pedindo primeiro número) para $a0
syscall                   # Executa chamada de sistema

li $v0, 5                 # Passa código de ler inteiro para $v0
syscall                   # Executa chamada de sistema

sw $v0, 0 ($sp)           # Armazena o inteiro lido na posição 0 em relação ao $sp (ponteiro da pilha)

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, second_number     # Passa endereço de second_number (mensagem pedindo segundo número) para $a0
syscall                   # Executa chamada de sistema

li $v0, 5                 # Passa código de ler inteiro para $v0
syscall                   # Executa chamada de sistema

sw $v0, 4 ($sp)           # Armazena o inteiro lido na posição 4 em relação ao $sp (ponteiro da pilha)

########################################################################################################################
# Função de operação desconhecida
########################################################################################################################

no_fn:

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, no_op             # Passa endereço de no_op (mensagem de operação desconhecida) para $a0
syscall                   # Executa chamada de sistema

la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de soma
########################################################################################################################

add_fn:

lw $t1, 0 ($sp)           # Carrega o inteiro na posição 0 em relação ao $sp (ponteiro da pilha) em $t1
lw $t2, 4 ($sp)           # Carrega o inteiro na posição 4 em relação ao $sp (ponteiro da pilha) em $t2

add $t0, $t1, $t2         # $t0 = $t1 + $t2

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, add_op            # Passa endereço de add_op (mensagem de resultado da soma) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
move $a0, $t0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de subtração
########################################################################################################################

sub_fn:

lw $t1, 0 ($sp)           # Carrega o inteiro na posição 0 em relação ao $sp (ponteiro da pilha) em $t1
lw $t2, 4 ($sp)           # Carrega o inteiro na posição 4 em relação ao $sp (ponteiro da pilha) em $t2

sub $t0, $t1, $t2         # $t0 = $t1 - $t2

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, sub_op            # Passa endereço de sub_op (mensagem de resultado da subtração) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
move $a0, $t0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de divisão
########################################################################################################################

div_fn:

lw $t1, 0 ($sp)           # Carrega o inteiro na posição 0 em relação ao $sp (ponteiro da pilha) em $t1
lw $t2, 4 ($sp)           # Carrega o inteiro na posição 4 em relação ao $sp (ponteiro da pilha) em $t2

div $t1, $t2              # $t1 / $t2, resultado vai para LO e resto para HI

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, div_op            # Passa endereço de div_op (mensagem de resultado da divisão) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
mflo $a0                  # Carrega o resultado da divisão, armazenado no registrado especial LO, em $a0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, mod_op            # Passa endereço de mod_op (mensagem de resto da divisão) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
mfhi $a0                  # Carrega o resto da divisão, armazenado no registrado especial HI, em $a0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de multiplicação
########################################################################################################################

mul_fn:

lw $t1, 0 ($sp)           # Carrega o inteiro na posição 0 em relação ao $sp (ponteiro da pilha) em $t1
lw $t2, 4 ($sp)           # Carrega o inteiro na posição 4 em relação ao $sp (ponteiro da pilha) em $t2

mult $t1, $t2             # $t1 * $t2, resultado vai para LO e overflow para HI

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, mul_op            # Passa endereço de mul_op (mensagem de resultado da multiplicação) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
mflo $a0                  # Carrega o resultado da multiplicação, armazenado no registrado especial LO, em $a0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de potenciação
########################################################################################################################

pot_fn:

lw $t1, 0 ($sp)           # Carrega o inteiro na posição 0 em relação ao $sp (ponteiro da pilha) em $t1
lw $t2, 4 ($sp)           # Carrega o inteiro na posição 4 em relação ao $sp (ponteiro da pilha) em $t2

pot_loop:

mult $t3, $t1             # $t1 * $t2, resultado vai para LO e overflow para HI
mflo $t5                  # Carrega o resultado da multiplicação, armazenado no registrado especial LO, em $t1
move $t3, $t5
subi $t2, $t2, 1
bgt $t2, 1, pot_loop

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, pot_op            # Passa endereço de pot_op (mensagem de resultado da potenciação) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
mflo $a0                  # Carrega o resultado da multiplicação, armazenado no registrado especial LO, em $a0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de raiz quadrada
########################################################################################################################

sqr_loop:



sqr_fn:

lw $t1, 0 ($sp)           # Carrega o inteiro na posição 0 em relação ao $sp (ponteiro da pilha) em $t1

move $t2, $t1

mult $t1, $t2             # $t1 * $t2, resultado vai para LO e overflow para HI

post_loop:

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, mul_op            # Passa endereço de mul_op (mensagem de resultado da multiplicação) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
mflo $a0                  # Carrega o resultado da multiplicação, armazenado no registrado especial LO, em $a0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de tabuada
########################################################################################################################

tab_fn:

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, tab_op            # Passa endereço de mul_op (mensagem de resultado da multiplicação) para $a0
syscall                   # Executa chamada de sistema

tab_loop:

lw $t1, 0 ($sp)           # Carrega o inteiro na posição 0 em relação ao $sp (ponteiro da pilha) em $t1

li $t2, 1                 # Inicia $t2 (contador) com o valor 1

mult $t1, $t2             # $t1 * $t2, resultado vai para LO e overflow para HI

li $v0, 1                 # Passa código de imprimir inteiro para $v0
move $a0, $t1             # Carrega o valor de $t1 (valor passado para a função) em $a0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, tab_msg1          # Passa endereço de tab_msg1 (mensagem de tabuada) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
move $a0, $t2             # Carrega o valor de $t2 (contador) para $a0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, tab_msg2          # Passa endereço de tab_msg2 (mensagem de resultado da tabuada) para $a0
syscall                   # Executa chamada de sistema

li $v0, 1                 # Passa código de imprimir inteiro para $v0
mflo $a0                  # Carrega o resultado da multiplicação, armazenado no registrado especial LO, em $a0
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, tab_br            # Passa endereço de tab_br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

ble $t2, 10, tab_loop     # Verifica se o contador já chegou a 10

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de finalizar execução do programa
########################################################################################################################

exit_fn:

addi $sp, $sp, 8          # "Libera" 2 espaços na pilha, retornando o $sp (ponteiro da pilha) para seu valor original

li $v0, 10                # Passa código de finalizar execução do programa para $v0
syscall                   # Executa chamada de sistema
