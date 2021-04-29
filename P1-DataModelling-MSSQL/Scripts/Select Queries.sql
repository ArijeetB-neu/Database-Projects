SELECT * FROM hospital
SELECT * FROM ngo
SELECT * FROM pharmacy
SELECT * FROM doctor
SELECT * FROM patient
SELECT * FROM employee
SELECT * FROM labAssistant
SELECT * FROM consultation
SELECT * FROM diagnosis
SELECT * FROM prescription
SELECT * FROM Bill
SELECT * FROM docSpecialization
SELECT * FROM testType
SELECT * FROM diseaseType
------------Stored Procedure-----------
EXEC SelectPatientBasedOnCityIncome 1000, 'Pittsburgh'
-------------
DECLARE @count INT;
 
EXEC NoOfConsultation
    @doctorId = 2,
    @ConsultationCount = @count OUTPUT;
 
SELECT @count AS 'Number of consultations found';
--------------
EXEC SelectPatientBillDetails 'Schroeder', '1932-09-07'
-------------
 Select * From Patient
 EXEC UpdatePatientAddress '360 Huntington Ave', 'Boston', 31136734

----------Views------------
Select * From [User Views Doctor]
Select * From [User Views Consultation History] 
Select * From People
Order by City

--------Function-------------
SELECT dbo.GetPrescribedMedicine ('Barber', 'Ferrell')








