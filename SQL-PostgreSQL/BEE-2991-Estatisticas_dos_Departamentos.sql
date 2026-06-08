--

WITH salarios_individuais AS (
    SELECT e.matr,e.lotacao AS cod_dep,e.lotacao_div AS cod_divisao,
        (
            COALESCE((SELECT SUM(v.valor) FROM emp_venc ev INNER JOIN vencimento v ON ev.cod_venc = v.cod_venc WHERE ev.matr = e.matr), 0) -
            COALESCE((SELECT SUM(d.valor) FROM emp_desc ed INNER JOIN desconto d ON ed.cod_desc = d.cod_desc WHERE ed.matr = e.matr), 0)
        ) AS salario_liquido
    FROM empregado e
)
SELECT dep.nome AS "Nome Departamento", COUNT(*) AS "Numero de Empregados",
    CASE 
        WHEN AVG(si.salario_liquido) = 0 THEN '0' 
        ELSE TRIM(TO_CHAR(ROUND(AVG(si.salario_liquido), 2), '99999999D99'))
    END AS "Media Salarial",
    CASE 
        WHEN MAX(si.salario_liquido) = 0 THEN '0' 
        ELSE TRIM(TO_CHAR(ROUND(MAX(si.salario_liquido), 2), '99999999D99'))
    END AS "Maior Salario",
    CASE 
        WHEN MIN(si.salario_liquido) = 0 THEN '0' 
        ELSE TRIM(TO_CHAR(ROUND(MIN(si.salario_liquido), 2), '99999999D99'))
    END AS "Menor Salario"
FROM divisao div
INNER JOIN departamento dep ON div.cod_dep = dep.cod_dep
INNER JOIN salarios_individuais si 
    ON dep.cod_dep = si.cod_dep AND div.cod_divisao = si.cod_divisao
GROUP BY div.cod_dep, dep.nome
ORDER BY AVG(si.salario_liquido) DESC;

/*
    A consulta utiliza uma CTE (Common Table Expression) chamada "salarios_individuais" para calcular o salário líquido de cada empregado, considerando seus vencimentos e descontos. 
    Em seguida, a consulta principal agrupa os resultados por departamento e calcula o número de empregados, a média salarial, o maior salário e o menor salário para cada departamento. 
    Os valores salariais são formatados para exibir duas casas decimais e, caso sejam zero, são exibidos como '0'. 
    Os resultados são ordenados pela média salarial em ordem decrescente.
*/
