#since it is a big file I need to import with text then switch it
CREATE TABLE `Bank_Marketing` (
    age             TEXT,
    job             TEXT,
    marital         TEXT,
    education       TEXT,
    `default`       TEXT,
    housing         TEXT,
    loan            TEXT,
    contact         TEXT,
    month           TEXT,
    day_of_week     TEXT,
    duration        TEXT,
    campaign        TEXT,
    pdays           TEXT,
    previous        TEXT,
    poutcome        TEXT,
    emp_var_rate    TEXT,
    cons_price_idx  TEXT,
    cons_conf_idx   TEXT,
    euribor3m       TEXT,
    nr_employed     TEXT,
    y               TEXT
);
 
 #grabbing the data 
 
SET sql_mode = '';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bank-additional-full.csv'
INTO TABLE `Bank_Marketing`
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

ALTER TABLE `Bank_Marketing`
    MODIFY COLUMN age              INT,
    MODIFY COLUMN job              TEXT,
    MODIFY COLUMN marital          TEXT,
    MODIFY COLUMN education        TEXT,
    MODIFY COLUMN `default`        TEXT,
    MODIFY COLUMN housing          TEXT,
    MODIFY COLUMN loan             TEXT,
    MODIFY COLUMN contact          TEXT,
    MODIFY COLUMN month            TEXT,
    MODIFY COLUMN day_of_week      TEXT,
    MODIFY COLUMN duration         INT,
    MODIFY COLUMN campaign         INT,
    MODIFY COLUMN pdays            INT,
    MODIFY COLUMN previous         INT,
    MODIFY COLUMN poutcome         TEXT,
    MODIFY COLUMN emp_var_rate     FLOAT,
    MODIFY COLUMN cons_price_idx   FLOAT,
    MODIFY COLUMN cons_conf_idx    FLOAT,
    MODIFY COLUMN euribor3m        FLOAT,
    MODIFY COLUMN nr_employed      FLOAT,
    MODIFY COLUMN y                TEXT;
    
#churn rate metirc
select
	count(*) as total_customers,
    round(avg(case when y = "no"
    then 1.0 else 0.0 end) * 100, 2) as churn_rate_pct
    from bank_marketing;

#creating a risk flag 
ALTER TABLE `Bank_Marketing`
ADD COLUMN risk_tier TEXT;

UPDATE `Bank_Marketing`
SET risk_tier = CASE
    WHEN campaign >= 5 AND pdays = 999 
         AND housing = 'yes' THEN 'HIGH RISK'
    WHEN campaign >= 3 AND pdays = 999 THEN 'MEDIUM RISK'
    ELSE 'LOW RISK'
END;

SELECT risk_tier, COUNT(*) 
FROM `Bank_Marketing` 
GROUP BY risk_tier;

#Campaign effectiveness
select 
	case 
		when campaign = 1 then "1 contact"
		when campaign = 2 then "2 contact"
		when campaign = 3 then "3 contact"
		when campaign between 4 and 6 then "4-6 contacts"
        else "7+ contacts"
	end as contact_band,
    count(*) as total_customers, 
    sum(case when y = "no" then 1 else 0 end) as churned,
    round(avg(case when y = "no" then 1.0 else 0.0 end) * 100,2) as churn_rate_pct
from `bank_marketing`
GROUP BY contact_band
ORDER BY churn_rate_pct DESC;

#from running this query, it shows the higher the contact the high the chrun rate. as well as the lower the contact the lower the churn rate.alter

#----Churn rate vs employment variation rate
SELECT
    ROUND(emp_var_rate, 1) AS emp_var_rate,
    COUNT(*) AS total_customers,
    ROUND(AVG(CASE WHEN y = 'no' THEN 1.0 ELSE 0.0 END) * 100, 2) AS churn_rate_pct
FROM `Bank_Marketing`
GROUP BY ROUND(emp_var_rate, 1)
ORDER BY emp_var_rate;

#churn rate by consumer confidence band
SELECT
    CASE
        WHEN cons_conf_idx < -50 THEN 'Very Low (below -50)'
        WHEN cons_conf_idx < -40 THEN 'Low (-50 to -40)'
        WHEN cons_conf_idx < -30 THEN 'Medium (-40 to -30)'
        ELSE 'High (above -30)'
    END AS confidence_band,
    COUNT(*) AS total_customers,
    ROUND(AVG(CASE WHEN y = 'no' THEN 1.0 ELSE 0.0 END) * 100, 2) AS churn_rate_pct
FROM `Bank_Marketing`
GROUP BY confidence_band
ORDER BY churn_rate_pct DESC;

#exporting to excel 
SELECT
    age,
    job,
    marital,
    education,
    `default`        AS credit_default,
    housing          AS housing_loan,
    loan             AS personal_loan,
    contact          AS contact_method,
    month,
    day_of_week,
    campaign         AS num_contacts,
    pdays            AS days_since_last_contact,
    previous         AS prev_contacts,
    poutcome         AS prev_campaign_outcome,
    emp_var_rate,
    cons_price_idx,
    cons_conf_idx,
    euribor3m,
    nr_employed,
    y                AS subscribed,
    CASE WHEN y = 'no' THEN 1 ELSE 0 END AS churned_flag,
    CASE
        WHEN campaign >= 5 AND pdays = 999
             AND housing = 'yes' THEN 'HIGH'
        WHEN campaign >= 3 AND pdays = 999 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS risk_tier,
    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        WHEN age < 65 THEN '55-64'
        ELSE '65+'
    END AS age_band
    FROM `Bank_Marketing`;
    
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/churn_export.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
FROM `Bank_Marketing`;



