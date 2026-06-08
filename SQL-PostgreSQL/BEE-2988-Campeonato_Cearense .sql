--

SELECT 
    t.name,
    COUNT(res.team_id) AS matches,
    SUM(res.win) AS victories,
    SUM(res.loss) AS defeats,
    SUM(res.draw) AS draws,
    SUM((res.win * 3) + res.draw) AS score
FROM teams t
JOIN (
    SELECT team_1 AS team_id,
        CASE WHEN team_1_goals > team_2_goals THEN 1 ELSE 0 END AS win,
        CASE WHEN team_1_goals < team_2_goals THEN 1 ELSE 0 END AS loss,
        CASE WHEN team_1_goals = team_2_goals THEN 1 ELSE 0 END AS draw
    FROM matches
    UNION ALL
    SELECT team_2 AS team_id,
        CASE WHEN team_2_goals > team_1_goals THEN 1 ELSE 0 END AS win,
        CASE WHEN team_2_goals < team_1_goals THEN 1 ELSE 0 END AS loss,
        CASE WHEN team_2_goals = team_1_goals THEN 1 ELSE 0 END AS draw
    FROM matches
) AS res ON t.id = res.team_id
GROUP BY t.name
ORDER BY score DESC, t.name ASC;

/* 
    A consulta seleciona o nome de cada time, o número total de partidas jogadas, vitórias, derrotas, empates e a pontuação total (3 pontos por vitória e 1 ponto por empate). 
    Ela utiliza uma subconsulta para calcular as vitórias, derrotas e empates para cada time com base nos resultados das partidas. 
    Os resultados são agrupados pelo nome do time e ordenados pela pontuação em ordem decrescente e, em caso de empate na pontuação, pelo nome do time em ordem alfabética.
*/ 
