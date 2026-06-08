--

(SELECT city_name, population
    FROM cities
    ORDER BY population DESC
    LIMIT 1 OFFSET 1)
UNION
(SELECT city_name, population
    FROM cities
    ORDER BY population ASC
    LIMIT 1 OFFSET 1)
ORDER BY city_name DESC;
