--

SELECT c.name
FROM customers as c
WHERE EXISTS (
    SELECT id_customers 
    FROM legal_person 
    WHERE id_customers = c.id);

