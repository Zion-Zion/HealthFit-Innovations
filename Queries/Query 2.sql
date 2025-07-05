-- Query 2

-- Patient who have not used a fitness tracker

-- CREATE INDEX idx_patient_id_medical_records ON medical_records (patient_id);
-- CREATE INDEX idx_patient_id_medical_record_and_trackers ON medical_record_and_trackers (patient_id);


SELECT mr.patient_id, mr.name
FROM medical_records mr
LEFT JOIN medical_record_and_trackers mrt ON mr.patient_id = mrt.patient_id
WHERE mrt.patient_id IS NULL;
