--

select p.name 
from products p
inner join providers p2 on p2.id = p.id_providers
where p2.name like 'P%' AND p.amount > 10 and p.amount < 20;

