-- Query 1

-- Count of patients by age group

-- CREATE INDEX idx_age ON medical_records (date_of_birth);


SELECT 
    CASE 
        WHEN DATE_PART('year', AGE(date_of_birth)) BETWEEN 0 AND 18 THEN '0-18'
        WHEN DATE_PART('year', AGE(date_of_birth)) BETWEEN 19 AND 35 THEN '19-35'
        WHEN DATE_PART('year', AGE(date_of_birth)) BETWEEN 36 AND 50 THEN '36-50'
        WHEN DATE_PART('year', AGE(date_of_birth)) > 50 THEN '51+'
    END AS Age_Group,
    COUNT(patient_id) AS Patient_Count
FROM medical_records
GROUP BY Age_Group
ORDER BY Patient_Count DESC;

