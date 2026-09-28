USE `chronic_disease_indicators`;
SELECT YearStart, LocationDesc, Question, DataValue, ResponseID
FROM `chronic_disease_indicators` 
WHERE Topic = 'Cardiovascular Disease' AND DataValue IS NOT NULL 
LIMIT 30;
ALTER TABLE `chronic_disease_indicators`
MODIFY COLUMN YearStart INT,
MODIFY COLUMN LocationAbbr VARCHAR(10),
MODIFY COLUMN Topic VARCHAR(255);

USE `chronic_disease_indicators`;

-- 1. Safely turn any empty or invalid text entries into true database NULLs
UPDATE `chronic_disease_indicators`
SET `YearStart` = NULL
WHERE `YearStart` = '' OR `YearStart` REGEXP '[^0-9]';

-- 2. Modify the structural column data types for faster indexing
ALTER TABLE `chronic_disease_indicators` 
MODIFY COLUMN `YearStart` INT,
MODIFY COLUMN `LocationAbbr` VARCHAR(10),
MODIFY COLUMN `Topic` VARCHAR(255);

USE `chronic_disease_indicators`;

-- Select core tracking columns for conditions, filtering out missing metrics
SELECT 
    `YearStart` AS `Year`, 
    `LocationDesc` AS `State`, 
    `Topic` AS `Condition`, 
    `Question` AS `Specific_Metric`, 
    `DataValue` AS `Prevalence_Rate`, 
    `ResponseID`
FROM `chronic_disease_indicators` 
WHERE `Topic` IN ('Cardiovascular Disease', 'Diabetes') 
  AND `DataValue` IS NOT NULL 
ORDER BY `LocationDesc`, `YearStart`
LIMIT 30;

