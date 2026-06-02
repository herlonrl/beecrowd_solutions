--

SELECT AVG(price)::NUMERIC(10,2) as price 
FROM products;


/* ::NUMERERIC(10,2) Faz um cast (conversão de tipo) do resultado da média para o tipo 
NUMERIC com precisão de até 10 dígitos no total e 2 casas decimais.
Isso é útil para garantir que o resultado seja formatado corretamente como um número 
decimal com duas casas decimais, o que é comum para valores monetários. */
