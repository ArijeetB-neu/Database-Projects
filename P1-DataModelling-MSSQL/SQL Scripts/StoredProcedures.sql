CREATE PROCEDURE SelectPatientBasedOnCityIncome  @patientIncome float, @City varchar (30)
AS
BEGIN
/* Code GOES here */

  SELECT * FROM PATIENT 
  WHERE City = @City AND [patientIncome($)] < @patientIncome

END

EXEC SelectPatientBasedOnCityIncome 10000.00, 'Boston'

 CREATE PROCEDURE UpdatePatientAddress @Address varchar(50), @City varchar(40), @patientSSN bigint
 AS
 BEGIN
 /* Code GOES here */

  UPDATE patient
  SET patientAddress= @Address, City= @City 
  WHERE patientSSN= @patientSSN;

 END

 EXEC UpdatePatientAddress '360 Huntington Ave', 'Boston', 31136734

Drop PROCEDURE SelectPatientBillDetails

CREATE PROCEDURE SelectPatientBillDetails  @patientLName varchar(40), @Dob date
AS
BEGIN
/* Code GOES here */

  SELECT p.patientId, p.patientFName +' '+ p.patientLName AS PatientName, e.empFName +' '+ e.empLName AS Doctor,
   b.billdate, b.amount, b.tax, (b.amount+b.tax) AS Total

  FROM PATIENT p Join consultation c
  On p.patientId = c.patientId Join Bill b
  On c.consultationId = b.consultationId Join doctor d
  On c.doctorId = d.doctorId Join employee e
  On d.empId = e.empId
 --where p.patientFName = 'Tyrell'
  Where p.patientLName = @patientLName And p.patientDob = @Dob;
END

-- DROP PROCEDURE SelectPatientBillDetails;  

EXEC SelectPatientBillDetails 'Schroeder', '1932-09-07'

 CREATE PROCEDURE NoOfConsultation @doctorId int, @ConsultationCount int OUTPUT
 AS
 BEGIN
 /* Code GOES here */

  SELECT d.doctorId , e.empFName +' '+ e.empLName AS Doctor, c.consultationId
  From doctor d Join Employee e
  On d.empId = e.empId Join consultation c
  ON c.doctorId = d.doctorId
  Where d.doctorId = @doctorId;

  SELECT @ConsultationCount = @@ROWCOUNT;
 END



DECLARE @count INT;
 
EXEC NoOfConsultation
    @doctorId = 2,
    @ConsultationCount = @count OUTPUT;
 
SELECT @count AS 'Number of consultations found';