-- DROP TABLE IF EXISTS medical_records;

CREATE TABLE medical_records (
    patient_id	VARCHAR(50)  NOT NULL,
    name	VARCHAR(30) NOT NULL,
    date_of_birth	DATE NOT NULL,
    gender	VARCHAR(1) NOT NULL,
    medical_conditions	VARCHAR(8) NOT NULL,
    medications	VARCHAR(3) NOT NULL,
    allergies	VARCHAR(20) NOT NULL,
    last_appointment_date	DATE NOT NULL,
    Tracker	VARCHAR(60) NOT NULL
	);


COPY medical_records FROM 'C:\Users\Public\Medical_records.csv' DELIMITER ',' CSV header;

SELECT * FROM medical_records;