
CREATE TRIGGER Bill_Amount on Bill
INSTEAD OF INSERT, UPDATE
AS
BEGIN
  INSERT INTO Bill
       SELECT  amount,(amount*0.0625), billDate, diagnosisId ,consultationId
       FROM inserted
END
GO