-- DROP TABLE IF EXISTS fitness_trackers;

CREATE TABLE fitness_trackers (
    "Brand Name"	VARCHAR(50) NOT NULL,
    "Device Type"	VARCHAR(50) NOT NULL,
    "Model Name"	VARCHAR(100) NOT NULL,
    "Color"	VARCHAR(60) NOT NULL,
    "Selling Price"	TEXT,
    "Original Price" TEXT,
    "Display"	VARCHAR(20) NOT NULL,
    "Rating (Out of 5)"	NUMERIC(3, 1),
    "Strap Material"	VARCHAR(30) NOT NULL,
    "Average Battery Life (in days)"	INT NOT NULL,
    "Reviews" TEXT
);

-- PostgreSQL's COPY  does not support .xlsx files, so the file was first converted into a .csv file before importing

COPY fitness_trackers FROM 'C:\Users\Public\Fitness_trackers.csv' DELIMITER ',' CSV header;

UPDATE fitness_trackers -- to fix the issue of commas separating digits greater than 999
SET "Selling Price" = REPLACE("Selling Price", ',', '')::INT,
    "Original Price" = REPLACE("Original Price", ',', '')::INT,
	"Reviews" = REPLACE("Reviews", ',', '')::INT;

ALTER TABLE fitness_trackers
ALTER COLUMN "Selling Price" TYPE INT USING "Selling Price"::INT,
ALTER COLUMN "Original Price" TYPE INT USING "Original Price"::INT,
ALTER COLUMN "Reviews" TYPE INT USING "Reviews"::INT;

SELECT * FROM fitness_trackers;