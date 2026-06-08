--

select p.name, pv.name, p.price 
from products p
inner join providers pv on p.id_providers = pv.id 
inner join categories c on p.id_categories  = c.id 
where p.price > 1000 and c."name" = 'Super Luxury';
    