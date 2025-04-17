[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/4nHL7_6-)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=18893933&assignment_repo_type=AssignmentRepo)
# CS 164: Programming Assignment 1

[PA1 Specification]: https://drive.google.com/open?id=1oYcJ5iv7Wt8oZNS1bEfswAklbMxDtwqB
[ChocoPy Specification]: https://drive.google.com/file/d/1mrgrUFHMdcqhBYzXHG24VcIiSrymR6wt

Note: Users running Windows should replace the colon (`:`) with a semicolon (`;`) in the classpath argument for all command listed below.

## Getting started

Run the following command to generate and compile your parser, and then run all the provided tests:

    mvn clean package

    java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=s --test --dir src/test/data/pa1/sample/

In the starter code, only one test should pass. Your objective is to build a parser that passes all the provided tests and meets the assignment specifications.

To manually observe the output of your parser when run on a given input ChocoPy program, run the following command (replace the last argument to change the input file):

    java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=s src/test/data/pa1/sample/expr_plus.py

You can check the output produced by the staff-provided reference implementation on the same input file, as follows:

    java -cp "chocopy-ref.jar:target/assignment.jar" chocopy.ChocoPy --pass=r src/test/data/pa1/sample/expr_plus.py

Try this with another input file as well, such as `src/test/data/pa1/sample/coverage.py`, to see what happens when the results disagree.

## Assignment specifications

See the [PA1 specification][] on the course
website for a detailed specification of the assignment.

Refer to the [ChocoPy Specification][] on the CS164 web site
for the specification of the ChocoPy language. 

## Receiving updates to this repository

Add the `upstream` repository remotes (you only need to do this once in your local clone):

    git remote add upstream https://github.com/cs164berkeley/pa1-chocopy-parser.git

To sync with updates upstream:

    git pull upstream master


## Submission writeup

### Membros da Equipe


- Raphael Carvalho da Conceição

- Sara Maia Cavalcante

- Thiago Serra Dias Aguiar


Gostaríamos de agradecer ao Erik Alves de Moura Izidoro, que nos atentou ao fato de que a saída do comando executado com a flag --debug poderia nos ajudar a consertar erros léxicos.

Durante a execução desse trabalho, foram gastas cerca de 73 horas, considerando 3h de trabalho durante as aulas.

### Questões propostas


1) **Que estratégia você usou para emitir tokens INDENT e DEDENT corretamente? Mencione o nome do arquivo e o(s) número(s) da(s) linha(s) para a parte principal da sua solução.**

O lexer implementou três passos principais para emitir INDENTs e DEDENTS: 

Passo 1) Contar os espaços e tabs no início de cada linha lógica para determinar o nível atual de indentação.

Passo 2) Comparar com o nível anterior e, a partir disso, decidir se emite INDENT ou DEDENT

Passo 3) Garantir que, no final do arquivo, para cada INDENT gerado durante o programa, seja gerado um DEDENT

Para implementar isso, utilizamos três estados: **RULES_STATE**, **INDENT_HANDLER** e **DEDENT_HANDLER**. Além disso, usamos uma pilha cujo elemento do topo representa o nível de indentação no nível anterior ao analisado no momento corrente (sendo o inicial o 0) e uma variável spaceCounter que é utilizada para contar espaços em branco de cada linha lógica. Por fim, usamos uma variável booleana auxiliar EOFnotFound para lidar com o passo 3.

Abaixo, são listadas as ações de cada estado:

**RULES_STATE, cuja regra relevante a esse caso se encontra no intervalo de linhas [136, 165]**:  
Ao encontrar uma quebra de linha, verifica o próximo caractere:

Se for detectado o caractere nulo, significa que chegamos ao LineBreak anterior ao EOF.
<blockquote>
    Com isso, caso o topo da pilha seja 0, não há o que fazer em relação ao passo 3, pois significa que todos os INDENTs foram casados.<br><br>
    Caso contrário, damos yypushback(1) para que o LineBreak seja consumido novamente neste estado. Em sequência, emitimos um NEWLINE caso seja a primeira vez que o antecessor imediato do EOF foi achado. Por outro lado, se o EOF já foi descoberto, emitimos um DEDENT caso o topo da pilha seja maior que zero. Por causa do yypushback(1), essa lógica garante que serão emitidos tantos DEDENTs quanto elementos  maiores que 0 existirem no topo da pilha ao fim do programa, de modo que, quando top == 0, o pushback não será executado, esse estado será deixado e o EOF poderá ser consumido pelo EOF rule.
</blockquote>
Caso contrário, se o próximo caractere não for o nulo, muda para o estado de INDENT_HANDLER para contar os espaços da próxima linha.

<br>

**INDENT_HANDLER, cujas regras relevantes a esse caso se encontram no intervalo de linhas [255, 289]**: 
Conta a quantidade de espaços na linha atual, incrementando a variável spaceCounter em uma unidade ao ler um " " e em 8 unidades ao ler um \t.
Ao perceber um caractere que não é whiteSpace, 
<blockquote>
Se a quantidade de espaços for maior que o topo da pilha, significa que estamos em um novo nível, logo emite-se um INDENT e atualiza-se o topo da pilha.
Se for igual, não emite tokens.
E, por fim, se for menor, transiciona para o DEDENT_HANDLER.
</blockquote>

**DEDENT_HANDLER, cuja regra relevante a esse caso se encontra no intervalo de linhas [291, 308]**:

Desempilha níveis do topo da pilha até encontrar um igual ao atual.
Para cada nível removido, emite um DEDENT, fechando o bloco.
Se a quantidade de espaços nesta linha for inconsistente, ou seja, o spaceCounter não casa com o nível no topo da pilha, emite um INDENT_ERROR.


2) **Como sua solução ao item 1. se relaciona ao descrito na seção 3.1 do manual de referência de ChocoPy? (Arquivo chocopy_language_reference.pdf.)**

No programa de forma geral, detectamos o final de linhas físicas para Unix, Windows e Mac por meio de um regex que aceita a união dos caracteres que representam quebra de linha em cada sistema. Como especificado, linhas vazias são ignoradas pelo padrão {WhiteSpace}*{LineBreak} no **INDENT_HANDLER**, enquanto linhas lógicas não.
Encontramos uma linha lógica quando a entrada casa apenas com {WhiteSpace}, já que, visto que o jflex dá match com o maior padrão encontrado, se demos match em apenas um {WhiteSpace}, há algo "útil" após ele, então podemos incrementar o spaceCounter que será utilizado no processo de indentação. Essa contagem de espaços é feita de forma que o " " incrementa spaceCounter em uma unidade e \t em 8 unidades, conforme especificado. Em relação à indentação, utilizamos uma pilha inicializada com 0 que mantém níveis de indentação estritamente crescentes. O estado **INDENT_HANDLER** compara o spaceCounter com o topo da pilha: se maior, empilha o novo nível e emite um INDENT; se igual, não faz nada; se menor, transita para o estado **DEDENT_HANDLER**, que desempilha os níveis excedentes emitindo um DEDENT para cada um até encontrar o nível correspondente. No final do arquivo, o **RULES_STATE** garante que todos os níveis restantes na pilha (acima de zero) sejam desempilhados com a emissão dos DEDENTs necessários, usando yypushback(1) para reprocessar a quebra de linha final enquanto houver níveis para fechar. A detecção de erros de indentação é feita quando uma linha não alinhada é encontrada durante o processo de dedentação, emitindo um INDENTATION_ERROR. 


3) **Qual foi a característica mais difícil da linguagem (não incluindo identação) neste projeto? Por que foi um desafio? Mencione o nome do arquivo e o(s) número(s) da(s) linha(s) para a parte principal de a sua solução.**

O fato de o elif ser um exemplo de açúcar sintático, fez com que fosse necessário que construíssemos mais regras que tratassem todos os casos do IF e também uma função que nos permitisse inserir estruturas IF-ELSE no "else mais interno" de uma estrutura IF-ELIF-ELSE. Pensar nessa recursão foi um desafio, pois precisávamos construir um algoritmo consistente com a estrutura aninhada dos if statements. A solução para essa dificuldade enfrentada se encontra no intervalo de linhas [144, 155] e na linha 451.
