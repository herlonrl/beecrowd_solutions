--

select pr.name, ca.name 
from products pr
inner join categories ca on ca.id = pr.id_categories
where pr.amount > 100 
and pr.id_categories in (1,2,3,6,9);

