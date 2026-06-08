--

select p.name, p2.name from products p
inner join providers p2 on p.id_providers = p2.id
and p.id_categories = 6;

