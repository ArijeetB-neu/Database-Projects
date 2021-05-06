Create View [People] 
AS
Select e.empFName +' '+ e.empLName AS [Name], e.[Address],
e.City,e.ContactNo,e.Dob,e.empSSN AS SSN
From employee e join doctor d
ON e.empId=d.empId 
Union 
Select p.patientFName +' '+ p.patientLName AS [Name], p.patientAddress,
p.City,p.contactNo,p.patientDob,patientSSN
From patient p



Select * From [User Views Doctor]
Select * From People



Create View [User Views Consultation History] 
AS
Select c.consultationId, e.empFName +' '+ e.empLName AS DoctorName, 
p.patientFName +' '+ p.patientLName AS PatientName, t.diseaseName AS Disease,
test.testName, pc.medName AS Prescription
From consultation c Left join doctor d  
ON c.doctorId = d.doctorId Left join employee e
ON e.empId=d.empId Left join patient p
ON c.patientId = p.patientId Left join diseaseType t
ON c.diseaseType = t.diseaseId Left Join prescription pc
ON c.consultationId = pc.consultationId Left JOIN diagnosis di 
ON c.consultationId = di.consultationId Left JOIN testType test
ON di.testType = test.testId;

SELECT * FROM [User Views Consultation History]
