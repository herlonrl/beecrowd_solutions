--

select emp.cpf, emp.enome, dep.dnome 
from empregados emp
inner join departamentos dep on emp.dnumero = dep.dnumero
where emp.cpf_supervisor is null 
order by emp.cpf;
