--- les contrats jeune conducteur depuis plus de 2ans chez GE---
SELECT ContractInsuranceId, ContractId, StartDate, EndDate
FROM ContractInsurance
WHERE InsuranceId = 12
  AND EndDate >= '9999-12-31 23:59:59.9999999'
  AND DATEADD(YEAR, 2, StartDate) <= GETDATE();



    DECLARE @today datetime2 = CAST(GETDATE() AS date);

BEGIN TRAN;

--Sélection des lignes concernées
SELECT ContractInsuranceId, ContractId
INTO #Acorriger 
FROM ContractInsurance
WHERE InsuranceId = 12                         
  AND EndDate >= '9999-12-31 23:59:59.9999999'                 
  AND DATEADD(YEAR, 2, StartDate) <= @today;    

--fin du contrat jeune conducteur = aujourd'hui
UPDATE ci
SET EndDate = @today,
    ModificationDate = Getdate(),
    ModifierId = 197,
    ModifierName = 'Wilfried',
    ModifierType = 1
FROM ContractInsurance ci
JOIN #Acorriger Ac ON Ac.ContractInsuranceId = ci.ContractInsuranceId;

--assurance standard chez provider 1 (id 9) 
INSERT INTO ContractInsurance
    (ContractId, InsuranceId, StartDate, EndDate, CreationDate, CreatorId, CreatorName, CreatorType)
SELECT ContractId, 9, @today, '9999-12-31 23:59:59.9999999', getdate(), 197, 'Wilfried', 1
FROM #Acorriger;

--vérif
SELECT COUNT(*) AS contrats_traites FROM #Acorriger

SELECT ci.*
FROM ContractInsurance ci
JOIN #Acorriger Ac ON Ac.ContractId = ci.ContractId
ORDER BY ci.ContractId, ci.StartDate;


--COMMIT;

ROLLBACK;

DROP TABLE #Acorriger;
