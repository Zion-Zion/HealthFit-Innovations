-- Create a temporary table to store filtered rows
WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY "Brand Name", "Device Type", "Model Name", "Color", 
                              "Selling Price", "Original Price", "Display", "Rating (Out of 5)", 
                              "Strap Material", "Average Battery Life (in days)", "Reviews" 
                              ORDER BY "Selling Price") AS rn
    FROM fitness_trackers
			)

SELECT "Brand Name", "Device Type", "Model Name", "Color",
		"Selling Price", "Original Price", "Display", "Rating (Out of 5)",
		"Strap Material", "Average Battery Life (in days)", "Reviews" 
INTO temp_fitness_trackers -- Create a temporary table
FROM CTE
WHERE rn = 1;


-- Delete all rows from the original table
TRUNCATE TABLE fitness_trackers;

-- Insert filtered data back into the original table
INSERT INTO fitness_trackers
SELECT * FROM temp_fitness_trackers;

-- Drop the temporary table
DROP TABLE temp_fitness_trackers;




-- Replace other duplicates of categorical variables in fitness_trackers table with averages of numerical columns

SELECT 
    "Brand Name",
    "Device Type",
    "Model Name",
    "Color",
	AVG("Selling Price") AS Avg_Selling_Price,
    AVG("Original Price") AS Avg_Original_Price,
    "Display",
	AVG("Rating (Out of 5)") AS Avg_Rating,
    "Strap Material",
	AVG("Average Battery Life (in days)") AS Avg_Battery_Life,
    AVG("Reviews") AS Avg_Reviews
INTO temp_fitness_trackers
FROM fitness_trackers
GROUP BY 
    "Brand Name",
    "Device Type",
    "Model Name",
    "Color",
    "Display",
    "Strap Material";


-- Remove rows from original table
DELETE FROM fitness_trackers;


-- Insert aggregated data into original table
INSERT INTO fitness_trackers
SELECT * FROM temp_fitness_trackers;


DROP TABLE temp_fitness_trackers;


SELECT * FROM fitness_trackers