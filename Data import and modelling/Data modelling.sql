-- CREATING MORE TABLES FOR THE DATA MODEL

-- Create tracker_models table to store information about tracker models while taking care of dependencies

CREATE TABLE Tracker_Models (
    Model_ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Brand_Name VARCHAR(50),
    Device_Type VARCHAR(50),
    Model_Name VARCHAR(100) -- UNIQUE
);

/*
ALTER TABLE tracker_models
ADD UNIQUE (MODEL_NAME);
*/

--------------------------------------------------------------------

INSERT INTO Tracker_Models (Brand_Name, Device_Type, Model_Name)
SELECT DISTINCT
    "Brand Name", "Device Type", "Model Name"
FROM fitness_trackers;

--------------------------------------------------------------------

-- Add model_id column to fitness_trackers table to form relationships in the data model by mapping to tracker_models table

ALTER TABLE fitness_trackers
ADD model_id INT;

UPDATE fitness_trackers AS ft
SET model_id = tm.Model_ID
FROM tracker_models AS tm
WHERE 
    ft."Brand Name" = tm.Brand_Name
    AND ft."Device Type" = tm.Device_Type
    AND ft."Model Name" = tm.Model_Name;


-- To confrim we have the required output
select * from fitness_trackers;


-- Drop redundant columns in fitness_trackers table

ALTER TABLE fitness_trackers
DROP COLUMN "Brand Name", DROP COLUMN "Device Type", DROP COLUMN "Model Name";


SELECT * FROM fitness_trackers;
-- To check Duplicate Model names in trackers_model table

SELECT model_name, count(*)
from Tracker_Models
group by Model_Name
having count(*) > 1;


SELECT Brand_Name, model_name
from Tracker_Models
where Model_Name in ('Band',
'Band 2',
'Band 3',
'Band 4',
'Band 5',
'Band 6',
'Watch');


----------------------------------------------------------------

-- Creating junction table, medical_record_and_trackers, for the many-to-many relationship between medical_records and trackers_model table

SELECT 
    mr.patient_id,
    tm.Model_ID
FROM medical_records mr
JOIN tracker_models tm
ON mr.tracker = tm.Model_Name;



------------------------------------------------


-- Set constraints if not exiting before

ALTER TABLE medical_records

ALTER COLUMN patient_id TYPE varchar(50);

ALTER TABLE medical_records

ALTER COLUMN patient_id SET NOT NULL;

ALTER TABLE medical_records 
ADD CONSTRAINT medical_records_pk PRIMARY KEY (patient_id);


CREATE TABLE medical_record_and_trackers (
    record_tracker_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- Optional unique identifier
    patient_id varchar(50) NOT NULL REFERENCES medical_records (patient_id),
    model_id INT NOT NULL REFERENCES tracker_models (Model_ID)
);



SELECT * FROM medical_records;


INSERT INTO medical_record_and_trackers (patient_id, model_id)
SELECT 
    mr.patient_id,
    tm.Model_ID
FROM medical_records mr
JOIN tracker_models tm
ON mr.tracker = tm.Model_Name;