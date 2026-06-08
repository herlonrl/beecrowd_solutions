--

select c.name 
from customers as c 
where exists (
    select id_customers 
    from legal_person 
    where id_customers = c.id);
