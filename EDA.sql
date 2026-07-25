select * from walmart;

select count(*) from walmart;

select 
	payment_method,
    count(*)
from walmart
GROUP by payment_method;


SELECT COUNT(DISTINCT BRANCH)
FROM WALMART;

select max(quantity) from walmart;

select min(quantity) from walmart;





