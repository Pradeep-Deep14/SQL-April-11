SELECT * FROM SALARIES

--Write an SQL query to calculate the difference 
--between the highest salaries 
--in the marketing and engineering department. 
--Output the absolute difference in salaries.


SELECT
ABS(MAX(CASE WHEN DEPARTMENT='Marketing' THEN SALARY END)-
MAX(CASE WHEN DEPARTMENT='Engineering'THEN SALARY END))AS SALARY_DIFFERENCE
FROM SALARIES


--CTE--
--MAX SALARY DIFFERENCE FROM TWO DEPARTMENTS USING CTE

WITH CTE AS
(SELECT *,
DENSE_RANK()OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC)AS DRNK
FROM SALARIES)
SELECT 
    MAX(CASE WHEN DEPARTMENT = 'Marketing' THEN SALARY END) AS Marketing_Salary,
    MAX(CASE WHEN DEPARTMENT = 'Engineering' THEN SALARY END) AS Engineering_Salary,
    ABS(MAX(CASE WHEN DEPARTMENT = 'Marketing' THEN SALARY END) - MAX(CASE WHEN DEPARTMENT = 'Engineering' THEN SALARY END)) AS Salary_Difference
FROM CTE
WHERE DRNK = 1;