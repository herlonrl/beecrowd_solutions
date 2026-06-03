--

SELECT pr.name, ca.name
FROM products pr
INNER JOIN categories ca ON ca.id = pr.id_categories
WHERE pr.amount > 100
AND pr.id_categories IN (1, 2, 3, 6, 9);

