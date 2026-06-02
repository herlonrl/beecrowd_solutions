--

SELECT p.name, p2.name 
FROM products p 
INNER JOIN providers p2 ON p.id_providers = p2.id
WHERE p2.name = 'Ajax SA';
