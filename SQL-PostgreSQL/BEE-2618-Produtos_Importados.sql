--

select p2.name, p1.name, c1.name 
from products p2
inner join providers p1 on p2.id_providers = p1.id
inner join categories c1 on p2.id_categories = c1.id
where p1.name = 'Sansul SA'and c1.name = 'Imported';


