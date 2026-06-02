--

SELECT p2.name, p1.name, c1.name
FROM products p2
INNER JOIN providers p1 ON p2.id_providers = p1.id
INNER JOIN categories c1 ON p2.id_categories = c1.id
WHERE p1.name = 'Sansul SA' AND c1.name = 'Imported';


