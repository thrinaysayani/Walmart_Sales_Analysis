

-- BUSINESS PROBLEMS 


-- Q1) Find different payment methods, number of transactions, and quantity sold by payment method

SELECT * FROM walmart;

SELECT 
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;


-- Q2) Identify the highest-rated category in each branch, Display the branch, category, and avg rating

SELECT * FROM WALMART;


SELECT branch, category, avg_rating,Top_categories
FROM (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS Top_categories
    FROM walmart
    GROUP BY branch, category
) AS ranked
WHERE Top_categories = 1;


-- Q3) Identify the busiest day for each branch based on the number of transactions

select*from walmart;

SELECT branch, day_name, no_transactions
FROM (
    SELECT 
        branch,
        DAYNAME(STR_TO_DATE(date, '%d/%m/%Y')) AS day_name,
        COUNT(*) AS no_transactions,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS ranking
    FROM walmart
    GROUP BY branch, day_name
) AS ranked
WHERE ranking = 1;

select * 
from(
	select 
		branch,
		dayname(str_to_date(date, '%d/%m/%y')) as day_name,
		count(*) as no_of_transactions,
		rank() over(partition by branch order by count(*) desc) as ranking
	from walmart
	group by branch,day_name
	order by branch,no_of_transactions desc
) as ranked 
where ranking = 1;


-- Q4) Calculate the total quantity of items sold per payment method

SELECT 
    payment_method,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;




-- Q5: Determine the average, minimum, and maximum rating of categories for each city

SELECT 
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;


-- Q6: Calculate the total profit for each category

select * from walmart;

SELECT 
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;

SELECT 
    category,
    SUM(total_price * profit_margin) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;


-- Q7: Determine the most common payment method for each branch

select branch,payment_method as preffered_payment_method
from
(
    SELECT 
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS ranking
    FROM walmart
    GROUP BY branch, payment_method
) as ranked 
WHERE ranking = 1;



-- Q8: Categorize sales into Morning, Afternoon, and Evening shifts

select * from walmart;

SELECT
    branch,
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS num_invoices
FROM walmart
GROUP BY branch, shift
ORDER BY branch, num_invoices DESC;



















