--

WITH tsalario AS (
    SELECT emp.matr, emp.lotacao_div,
        COALESCE(SUM(v.valor), 0) AS salario
    FROM empregado emp
    LEFT JOIN emp_venc ON emp.matr = emp_venc.matr
    LEFT JOIN vencimento v ON emp_venc.cod_venc = v.cod_venc
    GROUP BY emp.matr, emp.lotacao_div
),
tdescontos AS (
    SELECT emp.matr, 
        COALESCE(SUM(desconto.valor), 0) AS descontos
    FROM empregado emp
    LEFT JOIN emp_desc ON emp.matr = emp_desc.matr
    LEFT JOIN desconto ON emp_desc.cod_desc = desconto.cod_desc
    GROUP BY emp.matr
),
medias_divisao AS (
    SELECT dep.nome AS departamento, div.nome AS divisao,
        ROUND(AVG(s.salario - d.descontos), 2) AS media,
        ROW_NUMBER() OVER(
            PARTITION BY dep.cod_dep 
            ORDER BY AVG(s.salario - d.descontos) DESC
        ) AS ranking
    FROM divisao div
    INNER JOIN departamento dep ON div.cod_dep = dep.cod_dep
    INNER JOIN tsalario s ON div.cod_divisao = s.lotacao_div
    INNER JOIN tdescontos d ON s.matr = d.matr
    GROUP BY dep.cod_dep, dep.nome, div.cod_divisao, div.nome
)
SELECT departamento, divisao, media
FROM medias_divisao
WHERE ranking = 1
ORDER BY media DESC;

/*
    A consulta utiliza Common Table Expressions (CTEs) para calcular o salário líquido de cada empregado, considerando seus vencimentos e descontos. 
    Em seguida, ela calcula a média salarial para cada divisão dentro de cada departamento e classifica as divisões com base nessa média. 
    Por fim, a consulta seleciona apenas a divisão com a maior média salarial para cada departamento e ordena os resultados pela média em ordem decrescente.
*/
