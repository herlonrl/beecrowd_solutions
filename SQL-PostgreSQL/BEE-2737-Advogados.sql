--

(SELECT name, customers_number
 FROM lawyers
 ORDER BY customers_number DESC
 LIMIT 1)
UNION ALL
(SELECT name, customers_number
 FROM lawyers
 ORDER BY customers_number ASC
 LIMIT 1)
UNION ALL
SELECT 'Average', CAST(AVG(customers_number) AS INTEGER)
FROM lawyers;

