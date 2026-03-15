select * from employee

-- Which departments have the highest employee attrition rate compared to their total employee count?
Select department, COUNT(*) as total_employee, COUNT(*) filter (where attrition = 'Yes') as attrition_count,
ROUND(COUNT(*) Filter (where attrition='Yes')*100/COUNT(*)::numeric, 2) as attrition_rate from employee
group by department order by attrition_rate desc ;

-- What employee attributes (age group, salary level, overtime status, and job satisfaction) 
-- are most common among employees who leave the company?
Select age_group, salary_band, over_time, job_satisfaction, COUNT(*) as attrition_count,
ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER() :: numeric,2) as total_attrition_pct from employee
where attrition = 'Yes' 
group by age_group, salary_band, over_time, job_satisfaction
order by attrition_count desc ;

-- Are employees with lower monthly income more likely to leave the company compared to employees with higher salaries?
Select age_group, salary_band, COUNT(*) as total_employee, 
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count from employee
group by age_group, salary_band ;

-- Do employees who work overtime show a higher attrition rate compared to employees who do not work overtime?
Select over_time, COUNT(*) as total_employee, SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count
from employee group by over_time ;

-- How does work-life balance rating influence employee attrition within the organization?
Select work_life_balance, COUNT(*) as total_employee, SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count
from employee group by work_life_balance
order by work_life_balance desc ;

-- Which job roles have the highest attrition rates within the company?
Select job_role, COUNT(*) as total_employee, SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count,
ROUND(COUNT(*) FILTER (Where attrition = 'Yes')*100/COUNT(*), 2) as attrition_rate
from employee group by job_role
order by attrition_rate desc ;

-- Are employees with fewer years at the company more likely to leave compared to employees with longer tenure?
Select years_at_company, COUNT(*) as total_employee, SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count,
ROUND(COUNT(*) FILTER (Where attrition = 'Yes')*100/COUNT(*), 2) as attrition_rate
from employee group by years_at_company order by attrition_rate desc ;

-- Do employees who have not received promotions for several years show higher attrition rates?
Select years_since_last_promotion, COUNT(*) as total_employee, 
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count from employee
group by years_since_last_promotion order by attrition_count desc ;

-- Does the number of training programs attended by employees impact their performance ratings?
Select training_times_last_year, ROUND(AVG(performance_rating),2) as avg_performance
from employee group by training_times_last_year order by avg_performance desc ;

-- Do employees with lower manager relationship ratings experience higher attrition rates?
Select relationship_satisfaction, COUNT(*) as total_employee, 
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count,
ROUND(COUNT(*) FILTER (Where attrition = 'Yes')*100/COUNT(*), 2) as attrition_rate
from employee group by relationship_satisfaction 
order by attrition_rate desc

-- Are employees who live farther from the workplace more likely to leave the company?
Select distance_from_home, COUNT(*) as total_employee, 
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count,
ROUND(COUNT(*) FILTER (Where attrition = 'Yes')*100/COUNT(*), 2) as attrition_rate
from employee group by distance_from_home
order by distance_from_home desc ;

-- Is there a difference in attrition rates between male and female employees?
Select gender, COUNT(*) as total_employee, SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) as attrition_count,
ROUND(COUNT(*) FILTER (Where attrition = 'Yes')*100/COUNT(*), 2) as attrition_rate from employee
group by gender order by attrition_rate desc ;

-- How are employee performance ratings distributed across different departments?
Select department, ROUND(AVG(performance_rating),2) as avg_performance from employee
group by department order by avg_performance desc ;

-- Are high-performing employees leaving the company at a significant rate, and which departments are most affected?
Select department, COUNT(*) as high_performers_left from employee 
where performance_rating = 4 and attrition = 'Yes' 
group by department order by high_performers_left desc ;

-- Which departments show both low job satisfaction and high overtime, indicating potential future attrition risk?
Select department, COUNT(*) as risky_employees from employee
where job_satisfaction <= 2 and over_time = 'yes'
group by department order by risky_employees desc ;
