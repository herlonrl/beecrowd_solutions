--

SELECT d.nome AS "Departamento", e.nome AS "Empregado", 
    CASE WHEN COALESCE(SUM(v.valor), 0) = 0 THEN 0 ELSE ROUND(COALESCE(SUM(v.valor), 0), 2) END AS "Salario Bruto", 
    CASE WHEN COALESCE(desc_table.val_desc, 0) = 0 THEN 0 ELSE ROUND(COALESCE(desc_table.val_desc, 0), 2) END AS "Total Desconto", 
    CASE WHEN (COALESCE(SUM(v.valor), 0) - COALESCE(desc_table.val_desc, 0)) = 0 THEN 0 ELSE ROUND(COALESCE(SUM(v.valor), 0) - COALESCE(desc_table.val_desc, 0), 2) END AS "Salario Linquido"
FROM empregado e
JOIN departamento d ON e.lotacao = d.cod_dep
LEFT JOIN emp_venc ev ON e.matr = ev.matr
LEFT JOIN vencimento v ON ev.cod_venc = v.cod_venc
LEFT JOIN (
    SELECT ed.matr, SUM(des.valor) AS val_desc 
    FROM emp_desc ed
    JOIN desconto des ON ed.cod_desc = des.cod_desc 
    GROUP BY ed.matr
) AS desc_table ON e.matr = desc_table.matr
GROUP BY d.nome, e.nome, desc_table.val_desc
ORDER BY (COALESCE(SUM(v.valor), 0) - COALESCE(desc_table.val_desc, 0)) DESC, e.nome DESC;

