SET GLOBAL net_read_timeout = 3600;
SET GLOBAL net_write_timeout = 3600;
SET GLOBAL wait_timeout = 3600;
SET GLOBAL interactive_timeout = 3600;
SET GLOBAL max_allowed_packet = 1073741824;

#FIXING THE DATA TYPES

SET sql_mode = '';
ALTER TABLE `physician_table`
    MODIFY Rndrng_NPI VARCHAR(15),
    MODIFY Rndrng_Prvdr_Last_Org_Name VARCHAR(255),
    MODIFY Rndrng_Prvdr_First_Name VARCHAR(255),
    MODIFY Rndrng_Prvdr_MI VARCHAR(10),
    MODIFY Rndrng_Prvdr_Crdntls VARCHAR(50),
    MODIFY Rndrng_Prvdr_Ent_Cd VARCHAR(10),
    MODIFY Rndrng_Prvdr_St1 VARCHAR(255),
    MODIFY Rndrng_Prvdr_St2 VARCHAR(255),
    MODIFY Rndrng_Prvdr_City VARCHAR(100),
    MODIFY Rndrng_Prvdr_State_Abrvtn VARCHAR(255),
    MODIFY Rndrng_Prvdr_State_FIPS VARCHAR(255),
    MODIFY Rndrng_Prvdr_Zip5 VARCHAR(255),
    MODIFY Rndrng_Prvdr_RUCA VARCHAR(255),
    MODIFY Rndrng_Prvdr_RUCA_Desc LONGTEXT,
    MODIFY Rndrng_Prvdr_Cntry VARCHAR(255),
    MODIFY Rndrng_Prvdr_Type VARCHAR(255),
    MODIFY Rndrng_Prvdr_Mdcr_Prtcptg_Ind VARCHAR(255),
    MODIFY HCPCS_Cd VARCHAR(255),
    MODIFY HCPCS_Desc LONGTEXT,
    MODIFY HCPCS_Drug_Ind VARCHAR(255),
    MODIFY Place_Of_Srvc VARCHAR(255),
    MODIFY Tot_Benes INT,
    MODIFY Tot_Srvcs DECIMAL(15,2),
    MODIFY Tot_Bene_Day_Srvcs DECIMAL(15,2),
    MODIFY Avg_Sbmtd_Chrg DECIMAL(15,2),
    MODIFY Avg_Mdcr_Alowd_Amt DECIMAL(15,2),
    MODIFY Avg_Mdcr_Pymt_Amt DECIMAL(15,2),
    MODIFY Avg_Mdcr_Stdzd_Amt DECIMAL(15,2);
    
    -- Strip $ signs from all money columns
UPDATE `physician_table` SET 
    Avg_Sbmtd_Chrg = REPLACE(Avg_Sbmtd_Chrg, '$', ''),
    Avg_Mdcr_Alowd_Amt = REPLACE(Avg_Mdcr_Alowd_Amt, '$', ''),
    Avg_Mdcr_Pymt_Amt = REPLACE(Avg_Mdcr_Pymt_Amt, '$', ''),
    Avg_Mdcr_Stdzd_Amt = REPLACE(Avg_Mdcr_Stdzd_Amt, '$', '');
    
    DROP TABLE IF EXISTS `physician_table`;
    
    CREATE TABLE `physician_table` (
    Rndrng_NPI VARCHAR(255),
    Rndrng_Prvdr_Last_Org_Name VARCHAR(255),
    Rndrng_Prvdr_First_Name VARCHAR(255),
    Rndrng_Prvdr_MI VARCHAR(255),
    Rndrng_Prvdr_Crdntls VARCHAR(255),
    Rndrng_Prvdr_Ent_Cd VARCHAR(255),
    Rndrng_Prvdr_St1 VARCHAR(255),
    Rndrng_Prvdr_St2 VARCHAR(255),
    Rndrng_Prvdr_City VARCHAR(255),
    Rndrng_Prvdr_State_Abrvtn VARCHAR(255),
    Rndrng_Prvdr_State_FIPS VARCHAR(255),
    Rndrng_Prvdr_Zip5 VARCHAR(255),
    Rndrng_Prvdr_RUCA VARCHAR(255),
    Rndrng_Prvdr_RUCA_Desc LONGTEXT,
    Rndrng_Prvdr_Cntry VARCHAR(255),
    Rndrng_Prvdr_Type VARCHAR(255),
    Rndrng_Prvdr_Mdcr_Prtcptg_Ind VARCHAR(255),
    HCPCS_Cd VARCHAR(255),
    HCPCS_Desc LONGTEXT,
    HCPCS_Drug_Ind VARCHAR(255),
    Place_Of_Srvc VARCHAR(255),
    Tot_Benes VARCHAR(255),
    Tot_Srvcs VARCHAR(255),
    Tot_Bene_Day_Srvcs VARCHAR(255),
    Avg_Sbmtd_Chrg VARCHAR(255),
    Avg_Mdcr_Alowd_Amt VARCHAR(255),
    Avg_Mdcr_Pymt_Amt VARCHAR(255),
    Avg_Mdcr_Stdzd_Amt VARCHAR(255)
);

#adding the data 

SET sql_mode = '';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Medicare_Physician_Other_Practitioners_by_Provider_and_Service_2023.csv'
INTO TABLE `physician_table`
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

UPDATE `physician_table` SET 
    Avg_Sbmtd_Chrg = REPLACE(REPLACE(Avg_Sbmtd_Chrg, '$', ''), ',', ''),
    Avg_Mdcr_Alowd_Amt = REPLACE(REPLACE(Avg_Mdcr_Alowd_Amt, '$', ''), ',', ''),
    Avg_Mdcr_Pymt_Amt = REPLACE(REPLACE(Avg_Mdcr_Pymt_Amt, '$', ''), ',', ''),
    Avg_Mdcr_Stdzd_Amt = REPLACE(REPLACE(Avg_Mdcr_Stdzd_Amt, '$', ''), ',', '');
    
    SET sql_mode = '';

ALTER TABLE `physician_table`
    MODIFY Rndrng_NPI VARCHAR(15),
    MODIFY Rndrng_Prvdr_Last_Org_Name VARCHAR(255),
    MODIFY Rndrng_Prvdr_First_Name VARCHAR(255),
    MODIFY Rndrng_Prvdr_MI VARCHAR(10),
    MODIFY Rndrng_Prvdr_Crdntls VARCHAR(50),
    MODIFY Rndrng_Prvdr_Ent_Cd VARCHAR(10),
    MODIFY Rndrng_Prvdr_St1 VARCHAR(255),
    MODIFY Rndrng_Prvdr_St2 VARCHAR(255),
    MODIFY Rndrng_Prvdr_City VARCHAR(100),
    MODIFY Rndrng_Prvdr_State_Abrvtn VARCHAR(255),
    MODIFY Rndrng_Prvdr_State_FIPS VARCHAR(255),
    MODIFY Rndrng_Prvdr_Zip5 VARCHAR(255),
    MODIFY Rndrng_Prvdr_RUCA VARCHAR(255),
    MODIFY Rndrng_Prvdr_RUCA_Desc LONGTEXT,
    MODIFY Rndrng_Prvdr_Cntry VARCHAR(255),
    MODIFY Rndrng_Prvdr_Type VARCHAR(255),
    MODIFY Rndrng_Prvdr_Mdcr_Prtcptg_Ind VARCHAR(255),
    MODIFY HCPCS_Cd VARCHAR(255),
    MODIFY HCPCS_Desc LONGTEXT,
    MODIFY HCPCS_Drug_Ind VARCHAR(255),
    MODIFY Place_Of_Srvc VARCHAR(255),
    MODIFY Tot_Benes INT,
    MODIFY Tot_Srvcs DECIMAL(15,2),
    MODIFY Tot_Bene_Day_Srvcs DECIMAL(15,2),
    MODIFY Avg_Sbmtd_Chrg DECIMAL(15,2),
    MODIFY Avg_Mdcr_Alowd_Amt DECIMAL(15,2),
    MODIFY Avg_Mdcr_Pymt_Amt DECIMAL(15,2),
    MODIFY Avg_Mdcr_Stdzd_Amt DECIMAL(15,2);
    
    # Adding the other data set 
    
    CREATE TABLE `prescribers_table` (
    Prscrbr_NPI TEXT,
    Prscrbr_Last_Org_Name TEXT,
    Prscrbr_First_Name TEXT,
    Prscrbr_City TEXT,
    Prscrbr_State_Abrvtn TEXT,
    Prscrbr_State_FIPS TEXT,
    Prscrbr_Type TEXT,
    Prscrbr_Type_Src TEXT,
    Brnd_Name TEXT,
    Gnrc_Name TEXT,
    Tot_Clms TEXT,
    Tot_30day_Fills TEXT,
    Tot_Day_Suply TEXT,
    Tot_Drug_Cst TEXT,
    Tot_Benes TEXT,
    GE65_Sprsn_Flag TEXT,
    GE65_Tot_Clms TEXT,
    GE65_Tot_30day_Fills TEXT,
    GE65_Tot_Drug_Cst TEXT,
    GE65_Tot_Day_Suply TEXT,
    GE65_Bene_Sprsn_Flag TEXT,
    GE65_Tot_Benes TEXT
);

SET sql_mode = '';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/MUP_DPR_RY25_P04_V10_DY23_NPIBN.csv'
INTO TABLE `prescribers_table`
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
    
ALTER TABLE `prescribers_table`
    MODIFY Prscrbr_NPI VARCHAR(15),
    MODIFY Prscrbr_Last_Org_Name VARCHAR(255),
    MODIFY Prscrbr_First_Name VARCHAR(255),
    MODIFY Prscrbr_City VARCHAR(100),
    MODIFY Prscrbr_State_Abrvtn VARCHAR(255),
    MODIFY Prscrbr_State_FIPS VARCHAR(255),
    MODIFY Prscrbr_Type VARCHAR(255),
    MODIFY Prscrbr_Type_Src VARCHAR(255),
    MODIFY Brnd_Name VARCHAR(255),
    MODIFY Gnrc_Name VARCHAR(255),
    MODIFY Tot_Clms INT,
    MODIFY Tot_30day_Fills DECIMAL(15,2),
    MODIFY Tot_Day_Suply INT,
    MODIFY Tot_Drug_Cst DECIMAL(15,2),
    MODIFY Tot_Benes INT,
    MODIFY GE65_Sprsn_Flag VARCHAR(5),
    MODIFY GE65_Tot_Clms INT,
    MODIFY GE65_Tot_30day_Fills DECIMAL(15,2),
    MODIFY GE65_Tot_Drug_Cst DECIMAL(15,2),
    MODIFY GE65_Tot_Day_Suply INT,
    MODIFY GE65_Bene_Sprsn_Flag VARCHAR(5),
    MODIFY GE65_Tot_Benes INT;
    
ALTER TABLE `prescribers_table`
    ADD INDEX idx_npi (Prscrbr_NPI),
    ADD INDEX idx_state (Prscrbr_State_Abrvtn),
    ADD INDEX idx_drug (Gnrc_Name(255));
    
#Provider Aggregation 

CREATE VIEW part_b_provider_summary AS
SELECT
    Rndrng_NPI,
    Rndrng_Prvdr_Last_Org_Name,
    Rndrng_Prvdr_First_Name,
    Rndrng_Prvdr_Type,
    Rndrng_Prvdr_State_Abrvtn,
    Rndrng_Prvdr_City,

    -- Volume metrics
    COUNT(DISTINCT HCPCS_Cd)                          AS unique_procedures,
    SUM(Tot_Benes)                                     AS total_benes,
    SUM(Tot_Srvcs)                                     AS total_services,

    -- Payment metrics
    SUM(Avg_Mdcr_Pymt_Amt * Tot_Srvcs)                AS total_medicare_payment,
    SUM(Avg_Sbmtd_Chrg * Tot_Srvcs)                   AS total_submitted_charges,

    -- Fraud indicators
    ROUND(SUM(Tot_Srvcs) / NULLIF(SUM(Tot_Benes), 0), 2)            AS services_per_bene,
    ROUND(SUM(Avg_Mdcr_Pymt_Amt * Tot_Srvcs) / NULLIF(SUM(Tot_Srvcs), 0), 2) AS avg_payment_per_service,
    ROUND(SUM(Avg_Sbmtd_Chrg * Tot_Srvcs) / NULLIF(SUM(Avg_Mdcr_Pymt_Amt * Tot_Srvcs), 0), 2) AS charge_to_payment_ratio

FROM `physician_table`
GROUP BY
    Rndrng_NPI,
    Rndrng_Prvdr_Last_Org_Name,
    Rndrng_Prvdr_First_Name,
    Rndrng_Prvdr_Type,
    Rndrng_Prvdr_State_Abrvtn,
    Rndrng_Prvdr_City;

# Part D
CREATE VIEW part_d_provider_summary AS
SELECT
    Prscrbr_NPI,
    Prscrbr_Last_Org_Name,
    Prscrbr_First_Name,
    Prscrbr_Type,
    Prscrbr_State_Abrvtn,
    Prscrbr_City,

    -- Volume metrics
    COUNT(DISTINCT Gnrc_Name)                          AS unique_drugs,
    SUM(Tot_Benes)                                     AS total_benes,
    SUM(Tot_Clms)                                      AS total_claims,
    SUM(Tot_30day_Fills)                               AS total_30day_fills,
    SUM(Tot_Day_Suply)                                 AS total_day_supply,
    SUM(Tot_Drug_Cst)                                  AS total_drug_cost,

    -- Fraud indicators
    ROUND(SUM(Tot_Drug_Cst) / NULLIF(SUM(Tot_Benes), 0), 2)         AS drug_cost_per_bene,
    ROUND(SUM(Tot_Drug_Cst) / NULLIF(SUM(Tot_Clms), 0), 2)          AS drug_cost_per_claim,
    ROUND(SUM(Tot_Clms) / NULLIF(SUM(Tot_Benes), 0), 2)             AS claims_per_bene,
    ROUND(SUM(Tot_Day_Suply) / NULLIF(SUM(Tot_Clms), 0), 2)         AS avg_day_supply_per_claim

FROM `prescribers_table`
GROUP BY
    Prscrbr_NPI,
    Prscrbr_Last_Org_Name,
    Prscrbr_First_Name,
    Prscrbr_Type,
    Prscrbr_State_Abrvtn,
    Prscrbr_City;
    
#Peer Group bench marks 
CREATE VIEW part_b_peer_benchmarks AS
SELECT
    Rndrng_Prvdr_Type,
    Rndrng_Prvdr_State_Abrvtn,

    COUNT(*)                                           AS peer_count,
    ROUND(AVG(services_per_bene), 2)                   AS avg_services_per_bene,
    ROUND(STD(services_per_bene), 2)                   AS std_services_per_bene,
    ROUND(AVG(avg_payment_per_service), 2)             AS avg_payment_per_service,
    ROUND(STD(avg_payment_per_service), 2)             AS std_payment_per_service,
    ROUND(AVG(charge_to_payment_ratio), 2)             AS avg_charge_to_payment_ratio,
    ROUND(STD(charge_to_payment_ratio), 2)             AS std_charge_to_payment_ratio

FROM part_b_provider_summary
GROUP BY
    Rndrng_Prvdr_Type,
    Rndrng_Prvdr_State_Abrvtn;

#z score cal 

CREATE VIEW part_b_zscore AS
SELECT
    p.*,
    b.peer_count,

    -- Z-Scores
    ROUND((p.services_per_bene - b.avg_services_per_bene) / NULLIF(b.std_services_per_bene, 0), 2)          AS z_services_per_bene,
    ROUND((p.avg_payment_per_service - b.avg_payment_per_service) / NULLIF(b.std_payment_per_service, 0), 2) AS z_payment_per_service,
    ROUND((p.charge_to_payment_ratio - b.avg_charge_to_payment_ratio) / NULLIF(b.std_charge_to_payment_ratio, 0), 2) AS z_charge_to_payment,

    -- Risk flags (1 = flagged)
    IF((p.services_per_bene - b.avg_services_per_bene) / NULLIF(b.std_services_per_bene, 0) >= 3, 1, 0)          AS flag_high_services,
    IF((p.avg_payment_per_service - b.avg_payment_per_service) / NULLIF(b.std_payment_per_service, 0) >= 3, 1, 0) AS flag_high_payment,
    IF((p.charge_to_payment_ratio - b.avg_charge_to_payment_ratio) / NULLIF(b.std_charge_to_payment_ratio, 0) >= 3, 1, 0) AS flag_high_charge_ratio

FROM part_b_provider_summary p
JOIN part_b_peer_benchmarks b
    ON p.Rndrng_Prvdr_Type = b.Rndrng_Prvdr_Type
    AND p.Rndrng_Prvdr_State_Abrvtn = b.Rndrng_Prvdr_State_Abrvtn;
    
CREATE VIEW part_d_zscore AS
SELECT
    p.*,
    b.peer_count,
    ROUND((p.drug_cost_per_bene - b.avg_drug_cost_per_bene) / NULLIF(b.std_drug_cost_per_bene, 0), 2)        AS z_drug_cost_per_bene,
    ROUND((p.claims_per_bene - b.avg_claims_per_bene) / NULLIF(b.std_claims_per_bene, 0), 2)                 AS z_claims_per_bene,
    ROUND((p.drug_cost_per_claim - b.avg_drug_cost_per_claim) / NULLIF(b.std_drug_cost_per_claim, 0), 2)     AS z_drug_cost_per_claim,
    IF((p.drug_cost_per_bene - b.avg_drug_cost_per_bene) / NULLIF(b.std_drug_cost_per_bene, 0) >= 3, 1, 0)   AS flag_high_drug_cost,
    IF((p.claims_per_bene - b.avg_claims_per_bene) / NULLIF(b.std_claims_per_bene, 0) >= 3, 1, 0)            AS flag_high_claims,
    IF((p.drug_cost_per_claim - b.avg_drug_cost_per_claim) / NULLIF(b.std_drug_cost_per_claim, 0) >= 3, 1, 0) AS flag_high_cost_per_claim
FROM part_d_provider_summary p
JOIN part_d_peer_benchmarks b
    ON p.Prscrbr_Type = b.Prscrbr_Type
    AND p.Prscrbr_State_Abrvtn = b.Prscrbr_State_Abrvtn;

CREATE VIEW part_d_peer_benchmarks AS
SELECT
    Prscrbr_Type,
    Prscrbr_State_Abrvtn,
    COUNT(*)                                           AS peer_count,
    ROUND(AVG(drug_cost_per_bene), 2)                  AS avg_drug_cost_per_bene,
    ROUND(STD(drug_cost_per_bene), 2)                  AS std_drug_cost_per_bene,
    ROUND(AVG(claims_per_bene), 2)                     AS avg_claims_per_bene,
    ROUND(STD(claims_per_bene), 2)                     AS std_claims_per_bene,
    ROUND(AVG(drug_cost_per_claim), 2)                 AS avg_drug_cost_per_claim,
    ROUND(STD(drug_cost_per_claim), 2)                 AS std_drug_cost_per_claim
FROM part_d_provider_summary
GROUP BY Prscrbr_Type, Prscrbr_State_Abrvtn;

CREATE VIEW part_d_zscore AS
SELECT
    p.*,
    b.peer_count,
    ROUND((p.drug_cost_per_bene - b.avg_drug_cost_per_bene) / NULLIF(b.std_drug_cost_per_bene, 0), 2)         AS z_drug_cost_per_bene,
    ROUND((p.claims_per_bene - b.avg_claims_per_bene) / NULLIF(b.std_claims_per_bene, 0), 2)                  AS z_claims_per_bene,
    ROUND((p.drug_cost_per_claim - b.avg_drug_cost_per_claim) / NULLIF(b.std_drug_cost_per_claim, 0), 2)      AS z_drug_cost_per_claim,
    IF((p.drug_cost_per_bene - b.avg_drug_cost_per_bene) / NULLIF(b.std_drug_cost_per_bene, 0) >= 3, 1, 0)    AS flag_high_drug_cost,
    IF((p.claims_per_bene - b.avg_claims_per_bene) / NULLIF(b.std_claims_per_bene, 0) >= 3, 1, 0)             AS flag_high_claims,
    IF((p.drug_cost_per_claim - b.avg_drug_cost_per_claim) / NULLIF(b.std_drug_cost_per_claim, 0) >= 3, 1, 0) AS flag_high_cost_per_claim
FROM part_d_provider_summary p
JOIN part_d_peer_benchmarks b
    ON p.Prscrbr_Type = b.Prscrbr_Type
    AND p.Prscrbr_State_Abrvtn = b.Prscrbr_State_Abrvtn;
   
#creating the table 
CREATE VIEW fraud_risk_scores AS
SELECT
    b.Rndrng_NPI                                       AS NPI,
    b.Rndrng_Prvdr_Last_Org_Name                       AS Last_Name,
    b.Rndrng_Prvdr_First_Name                          AS First_Name,
    b.Rndrng_Prvdr_Type                                AS Provider_Type,
    b.Rndrng_Prvdr_State_Abrvtn                        AS State,
    b.Rndrng_Prvdr_City                                AS City,
    b.total_benes                                      AS Part_B_Benes,
    b.total_services                                   AS Total_Services,
    b.total_medicare_payment                           AS Total_Medicare_Payment,
    b.services_per_bene,
    b.avg_payment_per_service,
    b.z_services_per_bene,
    b.z_payment_per_service,
    b.z_charge_to_payment,
    d.total_drug_cost                                  AS Total_Drug_Cost,
    d.drug_cost_per_bene,
    d.claims_per_bene,
    d.z_drug_cost_per_bene,
    d.z_claims_per_bene,

    -- Total flags
    (b.flag_high_services + b.flag_high_payment + b.flag_high_charge_ratio
     + IFNULL(d.flag_high_drug_cost, 0)
     + IFNULL(d.flag_high_claims, 0)
     + IFNULL(d.flag_high_cost_per_claim, 0))          AS total_flags,

    -- Risk score 0-100
    LEAST(100, ROUND(
        (ABS(IFNULL(b.z_services_per_bene, 0)) * 15) +
        (ABS(IFNULL(b.z_payment_per_service, 0)) * 15) +
        (ABS(IFNULL(b.z_charge_to_payment, 0)) * 10) +
        (ABS(IFNULL(d.z_drug_cost_per_bene, 0)) * 20) +
        (ABS(IFNULL(d.z_claims_per_bene, 0)) * 20) +
        (ABS(IFNULL(d.z_drug_cost_per_claim, 0)) * 20)
    , 0))                                              AS fraud_risk_score,

    -- Risk tier
    CASE
        WHEN LEAST(100, ROUND(
            (ABS(IFNULL(b.z_services_per_bene, 0)) * 15) +
            (ABS(IFNULL(b.z_payment_per_service, 0)) * 15) +
            (ABS(IFNULL(b.z_charge_to_payment, 0)) * 10) +
            (ABS(IFNULL(d.z_drug_cost_per_bene, 0)) * 20) +
            (ABS(IFNULL(d.z_claims_per_bene, 0)) * 20) +
            (ABS(IFNULL(d.z_drug_cost_per_claim, 0)) * 20)
        , 0)) >= 70 THEN 'High'
        WHEN LEAST(100, ROUND(
            (ABS(IFNULL(b.z_services_per_bene, 0)) * 15) +
            (ABS(IFNULL(b.z_payment_per_service, 0)) * 15) +
            (ABS(IFNULL(b.z_charge_to_payment, 0)) * 10) +
            (ABS(IFNULL(d.z_drug_cost_per_bene, 0)) * 20) +
            (ABS(IFNULL(d.z_claims_per_bene, 0)) * 20) +
            (ABS(IFNULL(d.z_drug_cost_per_claim, 0)) * 20)
        , 0)) >= 40 THEN 'Medium'
        ELSE 'Low'
    END                                                AS risk_tier

FROM part_b_zscore b
LEFT JOIN part_d_zscore d ON b.Rndrng_NPI = d.Prscrbr_NPI;

#Verify the work 

-- Preview top high risk providers
SELECT * FROM fraud_risk_scores
WHERE risk_tier = 'High'
ORDER BY fraud_risk_score DESC
LIMIT 20;

-- Count providers by risk tier
SELECT 
    risk_tier,
    COUNT(*) AS provider_count,
    ROUND(AVG(fraud_risk_score), 2) AS avg_risk_score,
    ROUND(MAX(fraud_risk_score), 2) AS max_risk_score
FROM fraud_risk_scores
GROUP BY risk_tier
ORDER BY avg_risk_score DESC;

SELECT 
    fraud_risk_score,
    COUNT(*) AS provider_count
FROM fraud_risk_scores
GROUP BY fraud_risk_score
ORDER BY fraud_risk_score DESC
LIMIT 20;

#Creating a new fruad risk score

DROP VIEW IF EXISTS fraud_risk_scores;

CREATE VIEW fraud_risk_scores AS
SELECT
    b.Rndrng_NPI                                       AS NPI,
    b.Rndrng_Prvdr_Last_Org_Name                       AS Last_Name,
    b.Rndrng_Prvdr_First_Name                          AS First_Name,
    b.Rndrng_Prvdr_Type                                AS Provider_Type,
    b.Rndrng_Prvdr_State_Abrvtn                        AS State,
    b.Rndrng_Prvdr_City                                AS City,
    b.total_benes                                      AS Part_B_Benes,
    b.total_services                                   AS Total_Services,
    b.total_medicare_payment                           AS Total_Medicare_Payment,
    b.services_per_bene,
    b.avg_payment_per_service,
    b.z_services_per_bene,
    b.z_payment_per_service,
    b.z_charge_to_payment,
    d.total_drug_cost                                  AS Total_Drug_Cost,
    d.drug_cost_per_bene,
    d.claims_per_bene,
    d.z_drug_cost_per_bene,
    d.z_claims_per_bene,

    (b.flag_high_services + b.flag_high_payment + b.flag_high_charge_ratio
     + IFNULL(d.flag_high_drug_cost, 0)
     + IFNULL(d.flag_high_claims, 0)
     + IFNULL(d.flag_high_cost_per_claim, 0))          AS total_flags,

    -- Redesigned score: use raw Z-scores capped at 5 per metric
    -- This prevents a single extreme outlier from maxing the score
    LEAST(100, ROUND(
        (LEAST(5, ABS(IFNULL(b.z_services_per_bene, 0)))   / 5 * 20) +
        (LEAST(5, ABS(IFNULL(b.z_payment_per_service, 0)))  / 5 * 20) +
        (LEAST(5, ABS(IFNULL(b.z_charge_to_payment, 0)))    / 5 * 10) +
        (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_bene, 0)))   / 5 * 20) +
        (LEAST(5, ABS(IFNULL(d.z_claims_per_bene, 0)))      / 5 * 20) +
        (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_claim, 0)))  / 5 * 10)
    , 1))                                              AS fraud_risk_score,

    -- Updated risk tiers based on new scoring
    CASE
        WHEN LEAST(100, ROUND(
            (LEAST(5, ABS(IFNULL(b.z_services_per_bene, 0)))   / 5 * 20) +
            (LEAST(5, ABS(IFNULL(b.z_payment_per_service, 0)))  / 5 * 20) +
            (LEAST(5, ABS(IFNULL(b.z_charge_to_payment, 0)))    / 5 * 10) +
            (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_bene, 0)))   / 5 * 20) +
            (LEAST(5, ABS(IFNULL(d.z_claims_per_bene, 0)))      / 5 * 20) +
            (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_claim, 0)))  / 5 * 10)
        , 1)) >= 60 THEN 'High'
        WHEN LEAST(100, ROUND(
            (LEAST(5, ABS(IFNULL(b.z_services_per_bene, 0)))   / 5 * 20) +
            (LEAST(5, ABS(IFNULL(b.z_payment_per_service, 0)))  / 5 * 20) +
            (LEAST(5, ABS(IFNULL(b.z_charge_to_payment, 0)))    / 5 * 10) +
            (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_bene, 0)))   / 5 * 20) +
            (LEAST(5, ABS(IFNULL(d.z_claims_per_bene, 0)))      / 5 * 20) +
            (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_claim, 0)))  / 5 * 10)
        , 1)) >= 30 THEN 'Medium'
        ELSE 'Low'
    END                                                AS risk_tier

FROM part_b_zscore b
LEFT JOIN part_d_zscore d ON b.Rndrng_NPI = d.Prscrbr_NPI;

SELECT 
    risk_tier,
    COUNT(*) AS provider_count,
    MIN(fraud_risk_score) AS min_score,
    MAX(fraud_risk_score) AS max_score,
    ROUND(AVG(fraud_risk_score), 1) AS avg_score
FROM fraud_risk_scores
GROUP BY risk_tier
ORDER BY max_score DESC;

SELECT 
    NPI,
    Last_Name,
    First_Name,
    Provider_Type,
    State,
    fraud_risk_score,
    risk_tier,
    total_flags,
    services_per_bene,
    avg_payment_per_service,
    drug_cost_per_bene,
    claims_per_bene
FROM fraud_risk_scores
WHERE risk_tier = 'High'
ORDER BY fraud_risk_score DESC
LIMIT 20;

# removing outilters 

DROP VIEW IF EXISTS fraud_risk_scores;
CREATE VIEW fraud_risk_scores AS
SELECT
    b.Rndrng_NPI                                       AS NPI,
    b.Rndrng_Prvdr_Last_Org_Name                       AS Last_Name,
    b.Rndrng_Prvdr_First_Name                          AS First_Name,
    b.Rndrng_Prvdr_Type                                AS Provider_Type,
    b.Rndrng_Prvdr_State_Abrvtn                        AS State,
    b.Rndrng_Prvdr_City                                AS City,
    b.total_benes                                      AS Part_B_Benes,
    b.total_services                                   AS Total_Services,
    b.total_medicare_payment                           AS Total_Medicare_Payment,
    b.services_per_bene,
    b.avg_payment_per_service,
    b.z_services_per_bene,
    b.z_payment_per_service,
    b.z_charge_to_payment,
    d.total_drug_cost                                  AS Total_Drug_Cost,
    d.drug_cost_per_bene,
    d.claims_per_bene,
    d.z_drug_cost_per_bene,
    d.z_claims_per_bene,

    (b.flag_high_services + b.flag_high_payment + b.flag_high_charge_ratio
     + IFNULL(d.flag_high_drug_cost, 0)
     + IFNULL(d.flag_high_claims, 0)
     + IFNULL(d.flag_high_cost_per_claim, 0))          AS total_flags,

    LEAST(100, ROUND(
        (LEAST(5, ABS(IFNULL(b.z_services_per_bene, 0)))   / 5 * 20) +
        (LEAST(5, ABS(IFNULL(b.z_payment_per_service, 0)))  / 5 * 20) +
        (LEAST(5, ABS(IFNULL(b.z_charge_to_payment, 0)))    / 5 * 10) +
        (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_bene, 0)))   / 5 * 20) +
        (LEAST(5, ABS(IFNULL(d.z_claims_per_bene, 0)))      / 5 * 20) +
        (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_claim, 0)))  / 5 * 10)
    , 1))                                              AS fraud_risk_score,

    CASE
        WHEN LEAST(100, ROUND(
            (LEAST(5, ABS(IFNULL(b.z_services_per_bene, 0)))   / 5 * 20) +
            (LEAST(5, ABS(IFNULL(b.z_payment_per_service, 0)))  / 5 * 20) +
            (LEAST(5, ABS(IFNULL(b.z_charge_to_payment, 0)))    / 5 * 10) +
            (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_bene, 0)))   / 5 * 20) +
            (LEAST(5, ABS(IFNULL(d.z_claims_per_bene, 0)))      / 5 * 20) +
            (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_claim, 0)))  / 5 * 10)
        , 1)) >= 60 THEN 'High'
        WHEN LEAST(100, ROUND(
            (LEAST(5, ABS(IFNULL(b.z_services_per_bene, 0)))   / 5 * 20) +
            (LEAST(5, ABS(IFNULL(b.z_payment_per_service, 0)))  / 5 * 20) +
            (LEAST(5, ABS(IFNULL(b.z_charge_to_payment, 0)))    / 5 * 10) +
            (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_bene, 0)))   / 5 * 20) +
            (LEAST(5, ABS(IFNULL(d.z_claims_per_bene, 0)))      / 5 * 20) +
            (LEAST(5, ABS(IFNULL(d.z_drug_cost_per_claim, 0)))  / 5 * 10)
        , 1)) >= 30 THEN 'Medium'
        ELSE 'Low'
    END                                                AS risk_tier

FROM part_b_zscore b
LEFT JOIN part_d_zscore d ON b.Rndrng_NPI = d.Prscrbr_NPI

-- Filter to 50 US states only
WHERE b.Rndrng_Prvdr_State_Abrvtn IN (
    'AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA',
    'HI','ID','IL','IN','IA','KS','KY','LA','ME','MD',
    'MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ',
    'NM','NY','NC','ND','OH','OK','OR','PA','RI','SC',
    'SD','TN','TX','UT','VT','VA','WA','WV','WI','WY',
    'DC'
);

