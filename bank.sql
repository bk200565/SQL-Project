-- 1 Find the total customer
select count(*) from bank;

--  2 Target variable y of distribution
SELECT y, COUNT(*) AS total,ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM bank), 2) AS percentage
FROM bank
GROUP BY y;

-- 3 Job-wise subscription success rate 
SELECT job,
       COUNT(*) AS total_contacts,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS total_subscribed,
       ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate
FROM bank
GROUP BY job
ORDER BY subscription_rate DESC;

--  4 Marital status vs subscription
SELECT marital,
       COUNT(*) AS total,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
       ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate
FROM bank
GROUP BY marital;

-- 5 Education level vs success rate
SELECT education,
       COUNT(*) AS total,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
       ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate
FROM bank
GROUP BY education;

-- 6 Contact method effectiveness
SELECT contact,
       COUNT(*) AS total,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
       ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate
FROM bank
GROUP BY contact;
 
-- 7 Month-wise trend analysis
SELECT month,
       COUNT(*) AS total_calls,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS successful_calls,
       ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS success_rate
FROM bank
GROUP BY month
ORDER BY FIELD(month, 'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec') desc;

-- 8 Housing loan vs subscription
select housing, count(*) as total,
sum(CASE WHEN  y= 'yes' THEN 1 ELSE 0 END) AS subscribed,
ROUND(1000.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS subscription_Rate
FROM bank
GROUP BY housing;

-- 9 Age group vs subscription
SELECT 
  CASE 
    WHEN age < 30 THEN '<30'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
    WHEN age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS total,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
  ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS subscription_rate
FROM bank
GROUP BY age_group
ORDER BY age_group;

--  10 poutcome (previous outcome) of the subscription rate  
SELECT poutcome,COUNT(*) AS total,
SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)AS subscribed,
ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS success_rate
from bank 
group by poutcome;

-- 11 Campaign effect — how many contacts before success
SELECT campaign,count(*) as total,
SUM(CASE WHEN Y = 'yes' THEN 1 ELSE 0 END)AS subscribed
FROM bank
GROUP BY campaign
order by campaign;

-- 12 pdays (days since last contact) impact
SELECT 
  CASE 
    WHEN pdays = 999 THEN 'Never contacted before'
    WHEN pdays BETWEEN 1 AND 7 THEN '1-7 days'
    WHEN pdays BETWEEN 8 AND 30 THEN '8-30 days'
    WHEN pdays > 30 THEN '31+ days'
  END AS contact_gap,
  COUNT(*) AS total,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed
FROM bank
GROUP BY contact_gap;
--  13 Combination: education + job
SELECT education, job,
       COUNT(*) AS total,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
       ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS success_rate
FROM bank
GROUP BY education, job
ORDER BY success_rate DESC;

-- 14 Clients with both housing and personal loan — subscription impact 
SELECT 
  COUNT(*) AS total,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed
FROM bank
WHERE housing = 'yes' AND loan = 'yes';

 -- 15 Average duration of successful vs unsuccessful calls
 SELECT y,
       COUNT(*) AS total_calls,
       ROUND(AVG(duration), 2) AS avg_duration_seconds
FROM bank
GROUP BY y;

-- 16 Education level vs average call duration (subscribed only)
SELECT education,
       COUNT(*) AS total_subscribed,
       ROUND(AVG(duration), 2) AS avg_duration
FROM bank
WHERE y = 'yes'
GROUP BY education
ORDER BY avg_duration DESC;

 -- 17 Previous contacts vs success rate-- 
 SELECT previous,
       COUNT(*) AS total_clients,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
       ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS success_rate
FROM bank
GROUP BY previous
ORDER BY previous;

-- 18 Emp_var_rate (employment variation rate) vs subscription
SELECT `emp.var.rate`,
       COUNT(*) AS total,
       SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed,
       ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS subscription_rate
FROM bank
GROUP BY `emp.var.rate`
ORDER BY `emp.var.rate`;
 
