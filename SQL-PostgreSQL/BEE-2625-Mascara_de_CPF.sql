--

SELECT 
    regexp_replace(cpf, '(\d{3})(\d{3})(\d{3})(\d{2})', '\1.\2.\3-\4') AS CPF
FROM natural_person np ;

/* --
regexp_replace(...): É a função que procura por um padrão de texto e o substitui por outro.
cpf: É a coluna do banco de dados que está sendo avaliada.
'(\d{3})(\d{3})(\d{3})(\d{2})': É a regra (Expressão Regular) que divide os 11 números em 4 grupos:
    \d: representa qualquer dígito (número).
    \(\{3\}\) ou \(\{2\}\): indica exatamente a quantidade de números esperada naquele grupo.
    Os parênteses \(()\) servem para "guardar" cada grupo.
'\1.\2.\3-\4': É o formato de saída. Ele pega o Grupo 1, adiciona um ponto, pega o Grupo 2, adiciona um ponto,
 pega o Grupo 3, adiciona um traço e pega o Grupo 4.

*/
