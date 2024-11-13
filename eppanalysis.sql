Create database EPPAnalysis;

Use EPPAnalysis;

SELECT 
    *
FROM
    eppanalysis;
    
CREATE TABLE eppanalysis (
    Employee_ID INT PRIMARY KEY,
    Department VARCHAR(50),
    Gender ENUM('Male', 'Female', 'Other'),
    Age INT,
    Job_Title VARCHAR(100),
    Hire_Date DATE,
    Years_At_Company DECIMAL(4,2),
    Education_Level VARCHAR(50),
    Performance_Score DECIMAL(3,2),
    Monthly_Salary DECIMAL(10,2),
    Work_Hours_Per_Week INT,
    Projects_Handled INT,
    Overtime_Hours DECIMAL(4,2),
    Sick_Days INT,
    Remote_Work_Frequency ENUM('Never', 'Rarely', 'Sometimes', 'Often', 'Always'),
    Team_Size INT,
    Training_Hours INT,
    Promotions INT,
    Employee_Satisfaction_Score DECIMAL(3,2),
    Resigned BOOLEAN
);
    

-- What is the distribution of employees across departments?

SELECT 
    Department, COUNT(Employee_ID) AS Total_Employees
FROM
    eppanalysis
GROUP BY Department;


-- What is the age distribution of employees?

SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and above'
    END AS Age_Group,
    COUNT(Employee_ID) AS Total_Employees
FROM eppanalysis
GROUP BY Age_Group
ORDER BY Age_Group;


-- Does education level affect performance?

SELECT 
    Education_Level,
    ROUND(AVG(performance_Score), 1) AS Avg_Performance_Score
FROM
    eppanalysis
GROUP BY Education_Level
ORDER BY Avg_Performance_Score DESC;


-- How does the average performance score vary by department?

SELECT 
    Department,
    ROUND(AVG(Performance_Score), 1) AS Avg_Performance_Score
FROM
    eppanalysis
GROUP BY Department
ORDER BY Avg_Performance_Score DESC;


-- Is there a connection between the number of work hours per week and performance scores?

SELECT 
    Work_Hours_Per_Week,
    ROUND(AVG(Performance_Score), 1) AS Avg_Performance_Score
FROM
    eppanalysis
GROUP BY Work_Hours_Per_Week
ORDER BY Work_Hours_Per_Week;


-- How do training hours affect performance scores?

SELECT 
    CASE
        WHEN Training_Hours < 10 THEN 'Low (0-10)'
        WHEN Training_Hours BETWEEN 10 AND 20 THEN 'Medium (10-20)'
        ELSE 'High (20+)'
    END AS Training_Level,
    Round(AVG(Performance_Score),1) AS Avg_Performance_Score
FROM
    eppanalysis
GROUP BY Training_Level
ORDER BY Training_Level;


-- What is the average salary across different departments?

SELECT 
    Department,
    CONCAT('$', ROUND(AVG(Monthly_Salary), 0)) AS Avg_Salary
FROM
    eppanalysis
GROUP BY Department
ORDER BY Avg_Salary DESC;


-- How does employee satisfaction vary by department?

SELECT 
    Department,
    Round(AVG(Employee_Satisfaction_Score),1) AS Avg_Employee_Satisfaction_Score
FROM
    eppanalysis
GROUP BY Department
ORDER BY Avg_Employee_Satisfaction_Score DESC;


-- Which departments have the highest and lowest resignation rates?

SELECT Department, 
       COUNT(CASE WHEN Resigned = 'TRUE' THEN 1 END) AS Resignations,
       COUNT(Employee_ID) AS Total_Employees,
       ROUND((COUNT(CASE WHEN Resigned = 'TRUE' THEN 1 END) / COUNT(Employee_ID)) * 100, 1) AS Resignation_Rate
FROM eppanalysis
GROUP BY Department
ORDER BY Resignation_Rate DESC;


-- Which departments have the highest average overtime hours?

SELECT 
    Department,
    ROUND(AVG(Overtime_Hours), 0) AS Avg_Overtime_Hours
FROM
    eppanalysis
GROUP BY Department
ORDER BY Avg_Overtime_Hours DESC;


-- What is the average number of projects handled per employee in each department?

SELECT 
    Department, Round(AVG(Projects_Handled),0) AS Avg_Projects_Handled
FROM
    eppanalysis
GROUP BY Department
ORDER BY Avg_Projects_Handled DESC;



















