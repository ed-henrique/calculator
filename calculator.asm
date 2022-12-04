########################################################################################################################
# Aluno: Eduardo Henrique Freire Machado
# Matrícula: 2020001617
# Disciplina: DCC510 - Programação em Baixo Nível
#
# Descrição da atividade:
# Calculadora capaz de realizar soma, subtração, multiplicação e divisão de dois números
# Capaz ainda de obter potência, raiz quadrada e tabuada de um único número
########################################################################################################################

.data

########################################################################################################################
# Mensagens utilizadas durante a execução do programa
########################################################################################################################

start_msg: .asciiz     "0 para sair\n1 para soma\n2 para subtração\n3 para divisão\n4 para multiplicação\n5 para potenciação\n6 para raiz quadrada\n7 para tabuada\n\n"
select_op: .asciiz     "Selecione uma operação: "
first_number: .asciiz  "Primeiro número: "
second_number: .asciiz "Segundo número: "
number_msg: .asciiz    "Digite um número: "
no_op: .asciiz         "Esse código de operação não foi identificado, tente novamente..."
add_op: .asciiz        "O resultado da soma é "
sub_op: .asciiz        "O resultado da subtração é "
div_op: .asciiz        "O resultado da divisão é "
mod_op: .asciiz        "\nO resto da divisão é "
mul_op: .asciiz        "O resultado da multiplicação é "
pot_op: .asciiz        "O resultado da potência é "
sqr_op: .asciiz        "A raiz quadrada é "
tab_op: .asciiz        "Tabuada:\n"
tab_msg1: .asciiz      " X "
tab_msg2: .asciiz      " = "
tab_br: .asciiz        "\n"
leave: .asciiz         "Bye\n"
br: .asciiz            "\n-------------------------------------------------------\n\n"

########################################################################################################################
# Valores numéricos necessários
########################################################################################################################

double_value1: .double 0
double_value2: .double 1
double_value3: .double 10

########################################################################################################################

.text

########################################################################################################################
# Tela inicial (mostrada apenas uma vez por execução do programa)
########################################################################################################################

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, start_msg         # Passa endereço de start_msg (mensagem inicial) para $a0
syscall                   # Executa chamada de sistema

########################################################################################################################
# Função principal (loop infinito até ler o código de operação para finalizar programa)
########################################################################################################################

main:

la $a0, select_op         # Passa endereço de start_msg (mensagem inicial) para $a0
syscall                   # Executa chamada de sistema

li $v0, 5                 # Passa código de ler inteiro para $v0
syscall                   # Executa chamada de sistema

move $t0, $v0             # $t0 = $v0, usado para verificar qual operação foi passada

beq $t0, $zero, exit_fn   # Se $t0 for 0, pule para função exit_fn (finalizar programa)
blt $t0, 1, no_fn         # Se $t0 for menor que 1, pule para função no_fn (Operação não identificada)
bgt $t0, 7, no_fn         # Se $t0 for maior que 4, pule para função no_fn (Operação não identificada)

beq $t0, 1, add_fn        # Se $t0 for 1, pule para função add_fn (soma)
beq $t0, 2, sub_fn        # Se $t0 for 2, pule para função sub_fn (subtração)
beq $t0, 3, div_fn        # Se $t0 for 3, pule para função div_fn (divisão)
beq $t0, 4, mul_fn        # Se $t0 for 4, pule para função mul_fn (multiplicação)
beq $t0, 5, pot_fn        # Se $t0 for 4, pule para função pot_fn (potenciação)
beq $t0, 6, sqr_fn        # Se $t0 for 4, pule para função sqr_fn (radiciação)
beq $t0, 7, tab_fn        # Se $t0 for 4, pule para função tab_fn (tabuada)

########################################################################################################################
# Funções de leitura de números
########################################################################################################################

read_one_number:

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, number_msg        # Passa endereço de first_number (mensagem pedindo primeiro número) para $a0
syscall                   # Executa chamada de sistema

li $v0, 7                 # Passa código de ler double para $v0
syscall                   # Executa chamada de sistema

jr $ra                    # Retorno para onde a função foi chamada

read_two_numbers:

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, first_number      # Passa endereço de first_number (mensagem pedindo primeiro número) para $a0
syscall                   # Executa chamada de sistema

li $v0, 7                 # Passa código de ler double para $v0
syscall                   # Executa chamada de sistema

mov.d $f4, $f0            # $f4 = $f0

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, second_number     # Passa endereço de second_number (mensagem pedindo segundo número) para $a0
syscall                   # Executa chamada de sistema

li $v0, 7                 # Passa código de ler double para $v0
syscall                   # Executa chamada de sistema

mov.d $f2, $f0            # $f2 = $f0
mov.d $f0, $f4            # $f0 = $f4

jr $ra                    # Retorno para onde a função foi chamada

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

jal read_two_numbers      # Pula para função de leitura de dois números

add.d $f4, $f2, $f0       # $f4 = $f2 + $f0

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, add_op            # Passa endereço de add_op (mensagem de resultado da soma) para $a0
syscall                   # Executa chamada de sistema

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f4           # $f12 = $f4
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de subtração
########################################################################################################################

sub_fn:

jal read_two_numbers      # Pula para função de leitura de dois números

sub.d $f4, $f0, $f2       # $f4 = $f0 - $f2

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, sub_op            # Passa endereço de sub_op (mensagem de resultado da subtração) para $a0
syscall                   # Executa chamada de sistema

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f4           # $f12 = $f4
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de divisão
########################################################################################################################

div_fn:

jal read_two_numbers      # Pula para função de leitura de dois números

div.d $f4, $f0, $f2       # $f4 = $f0 / $f2

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, div_op            # Passa endereço de div_op (mensagem de resultado da divisão) para $a0
syscall                   # Executa chamada de sistema

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f4           # $f12 = $f4
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de multiplicação
########################################################################################################################

mul_fn:

jal read_two_numbers      # Pula para função de leitura de dois números

mul.d $f4, $f0, $f2       # $f4 = $f0 * $f2

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, mul_op            # Passa endereço de mul_op (mensagem de resultado da multiplicação) para $a0
syscall                   # Executa chamada de sistema

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f4           # $f12 = $f4
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de potenciação
########################################################################################################################

pot_fn:

jal read_two_numbers      # Pula para função de leitura de dois números
l.d $f4, double_value2    # $f4 = 1
l.d $f6, double_value2    # $f6 = 1
l.d $f8, double_value1    # $f8 = 0

c.eq.d $f2, $f8           # Se $f2 == $f8 a flag será true
bc1t zero_case            # Verifica se a flag é true, e caso seja pula para zero_case

pot_loop:

mul.d $f4, $f4, $f0       # $f4 = $f4 * $f0
sub.d $f2, $f2, $f6       # $f2 = $f2 - $f6

c.lt.d $f8, $f2           # Se $f8 < $f2 a flag será true
bc1t pot_loop             # Verifica se a flag é true, e caso seja pula para pot_loop

zero_case:

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, pot_op            # Passa endereço de pot_op (mensagem de resultado da potenciação) para $a0
syscall                   # Executa chamada de sistema

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f4           # $f12 = $f4
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de raiz quadrada
########################################################################################################################

sqr_fn:

jal read_one_number       # Pula para função de leitura de um número

sqrt.d $f2, $f0           # $f2 receberá a raiz quadrada de $f0

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, sqr_op            # Passa endereço de sqr_op (mensagem de resultado da raiz quadrada) para $a0
syscall                   # Executa chamada de sistema

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f2           # $f12 = $f2
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de tabuada
########################################################################################################################

tab_fn:

jal read_one_number       # Pula para função de leitura de um número

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, tab_op            # Passa endereço de tab_op (mensagem de resultado da tabuada) para $a0
syscall                   # Executa chamada de sistema

l.d $f2, double_value1    # $f2 = 0
l.d $f4, double_value2    # $f4 = 1
l.d $f6, double_value3    # $f6 = 10

tab_loop:

add.d $f2, $f2, $f4       # $f2 = $f2 + $f4

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f0           # $f12 = $f0
syscall                   # Executa chamada de sistema

mul.d $f8, $f0, $f2       # $f8 = $f0 * $f2

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, tab_msg1          # Passa endereço de tab_msg1 (mensagem de tabuada) para $a0
syscall                   # Executa chamada de sistema

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f2           # $f12 = $f2
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, tab_msg2          # Passa endereço de tab_msg2 (mensagem de resultado da tabuada) para $a0
syscall                   # Executa chamada de sistema

li $v0, 3                 # Passa código de imprimir double para $v0
mov.d $f12, $f8           # $f12 = $f8
syscall                   # Executa chamada de sistema

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, tab_br            # Passa endereço de tab_br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

c.lt.d $f2, $f6           # Se $f2 == $f6 a flag será true
bc1t tab_loop             # Verifica se a flag é true, e caso seja pula para tab_loop

li $v0, 4                 # Passa código de imprimir string para $v0
la $a0, br                # Passa endereço de br (mensagem de quebra de linha) para $a0
syscall                   # Executa chamada de sistema

j main                    # Voltar para função main

########################################################################################################################
# Função de finalizar execução do programa
########################################################################################################################

exit_fn:

li $v0, 10                # Passa código de finalizar execução do programa para $v0
syscall                   # Executa chamada de sistema
