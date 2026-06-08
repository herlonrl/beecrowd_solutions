--

select c.name, c.investment, 
	ceiling(c.investment / avg(distinct o.profit)) as mont_of_payback, 
	sum(o.profit) - c.investment as return 
from clients c
join operations o on c.id = o.client_id
where o.month in (1, 2, 3)
group by c.id, c.name , c.investment
having sum(o.profit) >= c.investment
order by return desc;

