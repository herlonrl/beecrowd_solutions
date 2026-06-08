--

select c.name, sum(p.amount) 
from categories c
inner join products p  on c.id = p.id_categories
group by c.name 
order by c.name asc ;