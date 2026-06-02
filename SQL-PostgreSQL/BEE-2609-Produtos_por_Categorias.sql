--

SELECT c.name, sum(p.amount)
FROM categories c
INNER JOIN products p ON c.id = p.id_categories
GROUP BY c.name
ORDER BY c.name ASC;
