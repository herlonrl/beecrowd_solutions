--

select c.name, o.id  
from customers c 
inner join orders o on c.id = o.id_customers 
where o.orders_date < '07/01/2016';
