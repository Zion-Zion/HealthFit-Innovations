-- Query 3

-- Count of patients per fitness tracker brand

-- CREATE INDEX idx_brand_name ON tracker_models (brand_name);
-- CREATE INDEX idx_model_id_medical_record_and_trackers ON medical_record_and_trackers (model_id);


SELECT tm.brand_name, COUNT(DISTINCT mrt.patient_id) AS Patient_Count
FROM medical_record_and_trackers mrt
JOIN tracker_models tm ON mrt.model_id = tm.model_id
GROUP BY tm.brand_name
ORDER BY Patient_Count DESC;
