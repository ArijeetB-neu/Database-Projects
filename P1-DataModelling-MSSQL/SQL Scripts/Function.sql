Create Function GetPrescribedMedicine ( @PatientLName varchar(40), @docLName varchar(40))
RETURNS varchar(50)

BEGIN
 DECLARE @medicine varchar(55) 
  Select  @medicine = 
    pc.medName
 
  From patient p JOIN consultation c
  On p.patientId = c.patientId JOIN doctor d
  ON c.doctorId = d.doctorId JOIN prescription pc
  ON c.consultationId = pc.consultationId JOin employee e
  ON d.empId = e.empId
  Where p.patientLName = @PatientLName AND e.empLName = @docLName 

  Return @medicine
END

SELECT dbo.GetPrescribedMedicine ('Barber', 'Ferrell')
