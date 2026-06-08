--

-- CTE 1: Consolida o total de vencimentos por matrícula
WITH TotalVencimentos AS (
    SELECT ev.matr, COALESCE(SUM(v.valor), 0) AS total_venc
    FROM emp_venc ev
    INNER JOIN vencimento v ON ev.cod_venc = v.cod_venc
    GROUP BY ev.matr
),

-- CTE 2: Consolida o total de descontos por matrícula
TotalDescontos AS (
    SELECT ed.matr, COALESCE(SUM(d.valor), 0) AS total_desc
    FROM emp_desc ed
    INNER JOIN desconto d ON ed.cod_desc = d.cod_desc
    GROUP BY ed.matr
),

-- CTE 3: Une as tabelas anteriores para calcular o salário líquido por funcionário
SalarioEmpregados AS (
    SELECT e.nome, e.matr, e.lotacao_div,
        ROUND(COALESCE(v.total_venc, 0) - COALESCE(d.total_desc, 0), 2) AS salario
    FROM empregado e
    LEFT JOIN TotalVencimentos v ON e.matr = v.matr
    LEFT JOIN TotalDescontos d ON e.matr = d.matr
),

-- CTE 4: Calcula a média salarial real de cada uma das divisões
MediaDivisao AS (
    SELECT lotacao_div, AVG(salario) AS media_salario
    FROM SalarioEmpregados
    GROUP BY lotacao_div
)

-- Consulta Final: Aplica o filtro da média, a trava dos 8000.00 e ordena
SELECT se.nome, se.salario
FROM SalarioEmpregados se
INNER JOIN MediaDivisao md ON se.lotacao_div = md.lotacao_div
WHERE se.salario > md.media_salario  -- Ganham mais que a média da divisão
  AND se.salario >= 8000.00          -- Ganham 8000.00 ou mais
ORDER BY se.lotacao_div ASC, se.nome ASC; -- Ordenação exigida e desempate por nome

