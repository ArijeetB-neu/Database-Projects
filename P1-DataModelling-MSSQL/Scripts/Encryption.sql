use hospital
Alter TABLE patient ADD column [patientSSN_encrypted] 

--TDE Transparent Data Encryption

Create Master Key
Encryption By Password = 'hospital'

-- step2
--Certificate
CREATE CERTIFICATE PatientSSN
WITH SUBJECT= 'PATIENT SSN'
-- step3
CREATE Symmetric Key PatientSSN_SM
With Algorithm = AES_256
ENCRYPTION BY CERTIFICATE PatientSSN

Select * from employee
-------------------------------------
--Encrypting SSN--

Open Symmetric Key [PatientSSN_SM]
 DECRYPTION BY CERTIFICATE [PatientSSN]
 
UPDATE patient  
SET patientSSN_encrypted = EncryptByKey(Key_GUID('PatientSSN_SM')  
    , CONVERT( varbinary  
    , patientSSN));

Select *, 
convert( Bigint, ([patientSSN])) AS DecryptedSSN
 from patient

