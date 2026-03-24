SHOW TABLES;
RENAME TABLE `ae_weekly_summary.csv` TO `wait_times`;

select * 
from wait_times
limit 100;

SELECT 
    SUM(CASE WHEN WeekEndingDate IS NULL THEN 1 END) AS WeekEndingDate_nulls,
    SUM(CASE WHEN Country IS NULL THEN 1 END) AS Country_nulls,
    SUM(CASE WHEN HBT IS NULL THEN 1 END) AS HBT_nulls,
    SUM(CASE WHEN TreatmentLocation IS NULL THEN 1 END) AS TreatmentLocation_nulls,
    SUM(CASE WHEN DepartmentType IS NULL THEN 1 END) AS DepartmentType_nulls,
    SUM(CASE WHEN AttendanceCategory IS NULL THEN 1 END) AS AttendanceCategory_nulls,
    SUM(CASE WHEN NumberOfAttendancesEpisode IS NULL THEN 1 END) AS Attendances_nulls,
    SUM(CASE WHEN NumberWithin4HoursEpisode IS NULL THEN 1 END) AS Within4_nulls,
    SUM(CASE WHEN NumberOver4HoursEpisode IS NULL THEN 1 END) AS Over4_nulls,
    SUM(CASE WHEN PercentageWithin4HoursEpisode IS NULL THEN 1 END) AS Perc_Within4_nulls,
    SUM(CASE WHEN NumberOver8HoursEpisode IS NULL THEN 1 END) AS Over8_nulls,
    SUM(CASE WHEN PercentageOver8HoursEpisode IS NULL THEN 1 END) AS Perc_Over8_nulls,
    SUM(CASE WHEN NumberOver12HoursEpisode IS NULL THEN 1 END) AS Over12_nulls,
    SUM(CASE WHEN PercentageOver12HoursEpisode IS NULL THEN 1 END) AS Perc_Over12_nulls
FROM wait_times;

#checking for blanks values 
SELECT
    SUM(CASE WHEN TRIM(Country) = '' THEN 1 END) AS Country_blanks,
    SUM(CASE WHEN TRIM(HBT) = '' THEN 1 END) AS HBT_blanks,
    SUM(CASE WHEN TRIM(TreatmentLocation) = '' THEN 1 END) AS TreatmentLocation_blanks,
    SUM(CASE WHEN TRIM(DepartmentType) = '' THEN 1 END) AS DepartmentType_blanks,
    SUM(CASE WHEN TRIM(AttendanceCategory) = '' THEN 1 END) AS AttendanceCategory_blanks
FROM wait_times;

#changing the date format 

ALTER TABLE wait_times
ADD COLUMN WeekEndingDate_conv DATE;

UPDATE wait_times
SET WeekEndingDate_conv = STR_TO_DATE(WeekEndingDate, '%Y%m%d');

SELECT WeekEndingDate, WeekEndingDate_conv
FROM wait_times
LIMIT 20;

#lets change the replace the old column 

ALTER TABLE wait_times
DROP COLUMN WeekEndingDate;

#
UPDATE wait_times
SET 
    Country = CONCAT(UCASE(LEFT(TRIM(Country),1)), LCASE(SUBSTRING(TRIM(Country),2))),
    HBT = CONCAT(UCASE(LEFT(TRIM(HBT),1)), LCASE(SUBSTRING(TRIM(HBT),2))),
    TreatmentLocation = CONCAT(UCASE(LEFT(TRIM(TreatmentLocation),1)), LCASE(SUBSTRING(TRIM(TreatmentLocation),2))),
    DepartmentType = CONCAT(UCASE(LEFT(TRIM(DepartmentType),1)), LCASE(SUBSTRING(TRIM(DepartmentType),2))),
    AttendanceCategory = CONCAT(UCASE(LEFT(TRIM(AttendanceCategory),1)), LCASE(SUBSTRING(TRIM(AttendanceCategory),2)));
    
    SELECT 
    SUM(CASE WHEN WeekEndingDate_conv IS NULL THEN 1 END) AS WeekEndingDate_nulls,
    SUM(CASE WHEN Country IS NULL THEN 1 END) AS Country_nulls,
    SUM(CASE WHEN HBT IS NULL THEN 1 END) AS HBT_nulls,
    SUM(CASE WHEN TreatmentLocation IS NULL THEN 1 END) AS TreatmentLocation_nulls,
    SUM(CASE WHEN DepartmentType IS NULL THEN 1 END) AS DepartmentType_nulls,
    SUM(CASE WHEN AttendanceCategory IS NULL THEN 1 END) AS AttendanceCategory_nulls,
    SUM(CASE WHEN NumberOfAttendancesEpisode IS NULL THEN 1 END) AS NumberOfAttendancesEpisode_nulls,
    SUM(CASE WHEN NumberWithin4HoursEpisode IS NULL THEN 1 END) AS NumberWithin4HoursEpisode_nulls,
    SUM(CASE WHEN NumberOver4HoursEpisode IS NULL THEN 1 END) AS NumberOver4HoursEpisode_nulls,
    SUM(CASE WHEN PercentageWithin4HoursEpisode IS NULL THEN 1 END) AS PercentageWithin4HoursEpisode_nulls,
    SUM(CASE WHEN NumberOver8HoursEpisode IS NULL THEN 1 END) AS NumberOver8HoursEpisode_nulls,
    SUM(CASE WHEN PercentageOver8HoursEpisode IS NULL THEN 1 END) AS PercentageOver8HoursEpisode_nulls,
    SUM(CASE WHEN NumberOver12HoursEpisode IS NULL THEN 1 END) AS NumberOver12HoursEpisode_nulls,
    SUM(CASE WHEN PercentageOver12HoursEpisode IS NULL THEN 1 END) AS PercentageOver12HoursEpisode_nulls,
    SUM(CASE WHEN WeekEndingDate_conv IS NULL THEN 1 END) AS WeekEndingDate_conv_nulls
FROM wait_times;

#check for dupes 
SELECT 
    WeekEndingDate_conv,
    TreatmentLocation,
    AttendanceCategory,
    COUNT(*) AS row_count
FROM wait_times
GROUP BY 
    WeekEndingDate_conv,
    TreatmentLocation,
    AttendanceCategory
HAVING COUNT(*) > 1;

#adding primay keys 

DESCRIBE wait_times;

SELECT 
    WeekEndingDate_conv,
    Country,
    HBT,
    TreatmentLocation,
    DepartmentType,
    AttendanceCategory,
    NumberOfAttendancesEpisode,
    NumberWithin4HoursEpisode,
    NumberOver4HoursEpisode,
    PercentageWithin4HoursEpisode,
    NumberOver8HoursEpisode,
    PercentageOver8HoursEpisode,
    NumberOver12HoursEpisode,
    PercentageOver12HoursEpisode,
    COUNT(*) AS row_count
FROM wait_times
GROUP BY
    WeekEndingDate_conv,
    Country,
    HBT,
    TreatmentLocation,
    DepartmentType,
    AttendanceCategory,
    NumberOfAttendancesEpisode,
    NumberWithin4HoursEpisode,
    NumberOver4HoursEpisode,
    PercentageWithin4HoursEpisode,
    NumberOver8HoursEpisode,
    PercentageOver8HoursEpisode,
    NumberOver12HoursEpisode,
    PercentageOver12HoursEpisode
HAVING row_count > 1;

#checking for negatove number 

SELECT *
FROM wait_times
WHERE NumberOfAttendancesEpisode < 0
   OR NumberWithin4HoursEpisode < 0
   OR NumberOver4HoursEpisode < 0
   OR NumberOver8HoursEpisode < 0
   OR NumberOver12HoursEpisode < 0;

SELECT *
FROM wait_times
WHERE PercentageWithin4HoursEpisode NOT BETWEEN 0 AND 100
   OR PercentageOver4HoursEpisode NOT BETWEEN 0 AND 100
   OR PercentageOver8HoursEpisode NOT BETWEEN 0 AND 100
   OR PercentageOver12HoursEpisode NOT BETWEEN 0 AND 100;

SELECT *
FROM wait_times
WHERE TRIM(Country) = ''
   OR TRIM(HBT) = ''
   OR TRIM(TreatmentLocation) = ''
   OR TRIM(DepartmentType) = ''
   OR TRIM(AttendanceCategory) = '';
   
   SELECT *
FROM wait_times
WHERE WeekEndingDate_conv IS NULL
   OR WeekEndingDate_conv = '';



















