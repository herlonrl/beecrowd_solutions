--

SELECT p.name
FROM products p
INNER JOIN providers p2 ON p2.id = p.id_providers
WHERE p2.name LIKE 'P%' AND p.amount > 10 AND p.amount < 20;

