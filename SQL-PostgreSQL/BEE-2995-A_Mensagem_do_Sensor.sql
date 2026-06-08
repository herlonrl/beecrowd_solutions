--

select temperature, count(mark) as number_of_records 
from records
group by mark, temperature
order by mark;

