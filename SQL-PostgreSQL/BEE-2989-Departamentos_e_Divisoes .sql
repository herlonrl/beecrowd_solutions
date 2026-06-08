--

SELECT 
    dep.nome AS "Departamento",
    div.nome AS "Divisao",
    ROUND(AVG(salario_liquido.total), 2) AS "Media",
    ROUND(MAX(salario_liquido.total), 2) AS "Maior"
FROM 
    empregado emp
JOIN departamento dep ON emp.lotacao = dep.cod_dep
JOIN divisao div ON emp.lotacao_div = div.cod_divisao
JOIN (
-- Subquery que calcula o salário líquido real de cada empregado
    SELECT e.matr,(COALESCE(venc.total_venc, 0) - COALESCE(desc_tab.total_desc, 0)) AS total
    FROM empregado e
    LEFT JOIN (
        SELECT ev.matr, SUM(v.valor) AS total_venc
        FROM emp_venc ev
        JOIN vencimento v ON ev.cod_venc = v.cod_venc
        GROUP BY ev.matr
    ) venc ON e.matr = venc.matr
    LEFT JOIN (
        SELECT ed.matr, SUM(d.valor) AS total_desc
        FROM emp_desc ed
        JOIN desconto d ON ed.cod_desc = d.cod_desc
        GROUP BY ed.matr
    ) desc_tab ON e.matr = desc_tab.matr
) salario_liquido ON emp.matr = salario_liquido.matr
GROUP BY dep.nome, div.nome
ORDER BY "Media" DESC;

/*
    A consulta seleciona o nome do departamento, o nome da divisão, a média e o maior salário líquido dos empregados em cada departamento e divisão. 
    Ela utiliza uma subconsulta para calcular o salário líquido real de cada empregado, considerando os vencimentos e descontos associados a cada um. 
    Os resultados são agrupados pelo nome do departamento e da divisão, e ordenados pela média do salário líquido em ordem decrescente.
*/ 

