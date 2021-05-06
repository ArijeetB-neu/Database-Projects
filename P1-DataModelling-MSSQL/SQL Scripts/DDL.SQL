/*
Created: 4/11/2019
Modified: 4/18/2019
Model: Microsoft SQL Server 2017
Database: MS SQL Server 2017
*/


-- Create tables section -------------------------------------------------

-- Table Bill

CREATE TABLE [Bill]
(
 [billId] Int NOT NULL IDENTITY (1001,1),
 [amount] Float NOT NULL,
 [tax] float Null,
 [billDate] Datetime NULL,
 [diagnosisId] Int NULL,
 [consultationId] Int NOT NULL
)
go

-- ALTER TABLE Bill ALTER COLUMN [diagnosisId] Int NULL
-- Create indexes for table Bill

CREATE INDEX [IX_Relationship24] ON [Bill] ([diagnosisId])
go

CREATE INDEX [IX_Relationship25] ON [Bill] ([consultationId])
go

-- Add keys for table Bill

ALTER TABLE [Bill] ADD CONSTRAINT [PK_Bill] PRIMARY KEY ([billId])
go

-- Table diagnosis

CREATE TABLE [diagnosis]
(
 [diagnosisId] Int NOT NULL IDENTITY (101,1),
 [testDate] Datetime NULL,
 [testType] Int NOT NULL,
 [result] Varchar(45) NULL,
 [labAssistantId] Int NOT NULL,
 [consultationId] Int NOT NULL
)
go

-- Create indexes for table diagnosis

CREATE INDEX [IX_Relationship13] ON [diagnosis] ([labAssistantId])
go

CREATE INDEX [IX_Relationship26] ON [diagnosis] ([testType])
go

CREATE INDEX [IX_Relationship1] ON [diagnosis] ([consultationId])
go

-- Add keys for table diagnosis

ALTER TABLE [diagnosis] ADD CONSTRAINT [PK_diagnosis] PRIMARY KEY ([diagnosisId])
go

-- Table hospital

CREATE TABLE [hospital]
(
 [hospitalId] Int NOT NULL IDENTITY (1,1),
 [hospitalName] Varchar(45) NULL,
 [Address] Varchar(45) NULL,
 [City] Varchar(30) NULL,
 [ContactNo] BigInt NULL
)
go

-- Add keys for table hospital

ALTER TABLE [hospital] ADD CONSTRAINT [PK_hospital] PRIMARY KEY ([hospitalId])
go

-- Table ngo

CREATE TABLE [ngo]
(
 [ngoId] Int NOT NULL IDENTITY (1,1),
 [ngoName] Varchar(45) NULL,
 [Address] Varchar(45) NULL,
 [City] Varchar(30) NULL,
 [ContactNo] BigInt NULL
)
go


-- Add keys for table ngo

ALTER TABLE [ngo] ADD CONSTRAINT [PK_ngo] PRIMARY KEY ([ngoId])
go

-- Table consultation

CREATE TABLE [consultation]
(
 [consultationId] Int NOT NULL IDENTITY(10001,1),
 [consultationDate] Datetime NULL,
 [diseaseType] Int NOT NULL,
 [patientId] Int NOT NULL,
 [doctorId] Int NOT NULL
)
go

-- Create indexes for table consultation

CREATE INDEX [IX_Relationship8] ON [consultation] ([patientId])
go

CREATE INDEX [IX_Relationship9] ON [consultation] ([doctorId])
go

CREATE INDEX [IX_Relationship27] ON [consultation] ([diseaseType])
go

-- Add keys for table consultation

ALTER TABLE [consultation] ADD CONSTRAINT [PK_consultation] PRIMARY KEY ([consultationId])
go

-- Table diseaseType

CREATE TABLE [diseaseType]
(
 [diseaseId] Int NOT NULL IDENTITY (1,1),
 [diseaseName] Varchar(55) NULL
)
go

-- Add keys for table diseaseType

ALTER TABLE [diseaseType] ADD CONSTRAINT [PK_diseaseType] PRIMARY KEY ([diseaseId])
go

-- Table testType

CREATE TABLE [testType]
(
 [testId] Int NOT NULL IDENTITY (1,1),
 [testName] Varchar(45) NULL
)
go

-- Add keys for table testType

ALTER TABLE [testType] ADD CONSTRAINT [PK_testType] PRIMARY KEY ([testId])
go

-- Table labAssistant

CREATE TABLE [labAssistant]
(
 [labAssistantId] Int NOT NULL IDENTITY (1,1),
 [empId] Int NOT NULL,
 [workingHours] Varchar(55) NULL
)
go

-- Create indexes for table labAssistant

CREATE INDEX [IX_Relationship23] ON [labAssistant] ([empId])
go

-- Add keys for table labAssistant

ALTER TABLE [labAssistant] ADD CONSTRAINT [PK_labAssistant] PRIMARY KEY ([labAssistantId])
go

-- Table pharmacy

CREATE TABLE [pharmacy]
(
 [pharmacyId] Int NOT NULL IDENTITY (1,1),
 [pharmacyName] Varchar(45) NULL,
 [Address] Varchar(45) NULL,
 [City] Varchar(30) NULL,
 [ContactNo] BigInt NULL
)
go

-- Add keys for table pharmacy

ALTER TABLE [pharmacy] ADD CONSTRAINT [PK_pharmacy] PRIMARY KEY ([pharmacyId])
go

-- Table prescription

CREATE TABLE [prescription]
(
 [prescriptionId] Int NOT NULL IDENTITY(15001,1),
 [medName] Varchar(45) NULL,
 [medPower] Float NULL,
 [medQuantity] Int NULL,
 [medFrequency] Varchar(20) NULL,
 [pharmacyId] Int NOT NULL,
 [consultationId] Int NOT NULL
)
go

-- Create indexes for table prescription

CREATE INDEX [IX_Relationship16] ON [prescription] ([pharmacyId])
go

CREATE INDEX [IX_Relationship2] ON [prescription] ([consultationId])
go

-- Add keys for table prescription

ALTER TABLE [prescription] ADD CONSTRAINT [PK_prescription] PRIMARY KEY ([prescriptionId])
go

-- Table doctor

CREATE TABLE [doctor]
(
 [doctorId] Int NOT NULL IDENTITY(1,1),
 [empId] Int NOT NULL,
 [specialization] Int NOT NULL,
 [visitingHours] Varchar(55) NULL
)
go

-- Create indexes for table doctor

CREATE INDEX [IX_Relationship22] ON [doctor] ([empId])
go

CREATE INDEX [IX_Relationship4] ON [doctor] ([specialization])
go

-- Add keys for table doctor

ALTER TABLE [doctor] ADD CONSTRAINT [PK_doctor] PRIMARY KEY ([doctorId])
go

-- Table employee

CREATE TABLE [employee]
(
 [empId] Int NOT NULL IDENTITY(120001,1),
 [empFName] Varchar(45) NULL,
 [empLName] Varchar(45) NULL,
 [Address] Varchar(55) NULL,
 [City] Varchar(45) NULL,
 [ContactNo] BigInt NULL ,
 [Dob] Date NULL,
 [empSSN] BigInt NOT NULL,
 [hospitalId] Int NOT NULL,
 CONSTRAINT check_age CHECK (Dob >= '1954-01-01' AND Dob <= '1998-04-19'),
 CONSTRAINT chk_phone CHECK (ContactNo like '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
go

--alter table employee
--add CONSTRAINT chk_phone CHECK (ContactNo like '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

--alter table employee
-- add CONSTRAINT check_age CHECK (Dob >= '1954-01-01' AND Dob <= '1998-04-19');


select * from Bill
select * from consultation

-- Create indexes for table employee

CREATE INDEX [IX_Relationship20] ON [employee] ([hospitalId])
go

-- Add keys for table employee

ALTER TABLE [employee] ADD CONSTRAINT [pk_employee] PRIMARY KEY ([empId])
go

ALTER TABLE [employee] ADD CONSTRAINT [empSSN] UNIQUE ([empSSN])
go

-- Table patient

CREATE TABLE [patient]
(
 [patientId] Int NOT NULL IDENTITY(1,1),
 [patientFName] Varchar(45) NULL,
 [patientLName] Varchar(45) NULL,
 [Gender] Varchar(6) NULL,
 [patientDob] Date NULL,
 [patientAddress] Varchar(55) NULL,
 [City] Varchar(45) NULL,
 [contactNo] BigInt NULL,
 [patientSSN] BigInt NULL,
 [patientIncome($)] Float NULL,
 [patientCreatedOn] Datetime NULL,
 [ngoId] Int NULL,
 [hospitalId] Int NOT NULL
)
go

-- Create indexes for table patient

CREATE INDEX [IX_Relationship1] ON [patient] ([ngoId])
go

CREATE INDEX [IX_Relationship2] ON [patient] ([hospitalId])
go

-- Add keys for table patient

ALTER TABLE [patient] ADD CONSTRAINT [PK_patient] PRIMARY KEY NONCLUSTERED ([patientId])
go

ALTER TABLE patient ADD CONSTRAINT DF_patient DEFAULT GETDATE() FOR patientCreatedOn
go

-- Table docSpecialization

CREATE TABLE [docSpecialization]
(
 [docSpecializationId] Int NOT NULL IDENTITY(1,1),
 [specializationName] Varchar(45) NULL
)
go

-- Add keys for table docSpecialization

ALTER TABLE [docSpecialization] ADD CONSTRAINT [PK_docSpecialization] PRIMARY KEY ([docSpecializationId])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [consultation] ADD CONSTRAINT [is for] FOREIGN KEY ([diseaseType]) REFERENCES [diseaseType] ([diseaseId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [diagnosis] ADD CONSTRAINT [consist] FOREIGN KEY ([testType]) REFERENCES [testType] ([testId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Bill] ADD CONSTRAINT [generates] FOREIGN KEY ([consultationId]) REFERENCES [consultation] ([consultationId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [Bill] ADD CONSTRAINT [creates] FOREIGN KEY ([diagnosisId]) REFERENCES [diagnosis] ([diagnosisId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [labAssistant] ADD CONSTRAINT [can be] FOREIGN KEY ([empId]) REFERENCES [employee] ([empId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [doctor] ADD CONSTRAINT [is a] FOREIGN KEY ([empId]) REFERENCES [employee] ([empId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [employee] ADD CONSTRAINT [consists] FOREIGN KEY ([hospitalId]) REFERENCES [hospital] ([hospitalId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [prescription] ADD CONSTRAINT [gets] FOREIGN KEY ([pharmacyId]) REFERENCES [pharmacy] ([pharmacyId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [diagnosis] ADD CONSTRAINT [conducts] FOREIGN KEY ([labAssistantId]) REFERENCES [labAssistant] ([labAssistantId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [consultation] ADD CONSTRAINT [views] FOREIGN KEY ([doctorId]) REFERENCES [doctor] ([doctorId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [consultation] ADD CONSTRAINT [makes] FOREIGN KEY ([patientId]) REFERENCES [patient] ([patientId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [patient] ADD CONSTRAINT [has] FOREIGN KEY ([hospitalId]) REFERENCES [hospital] ([hospitalId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [patient] ADD CONSTRAINT [provides] FOREIGN KEY ([ngoId]) REFERENCES [ngo] ([ngoId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [diagnosis] ADD CONSTRAINT [may require] FOREIGN KEY ([consultationId]) REFERENCES [consultation] ([consultationId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [prescription] ADD CONSTRAINT [may prescribe] FOREIGN KEY ([consultationId]) REFERENCES [consultation] ([consultationId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go


ALTER TABLE [doctor] ADD CONSTRAINT [has a] FOREIGN KEY ([specialization]) REFERENCES [docSpecialization] ([docSpecializationId]) ON UPDATE NO ACTION ON DELETE NO ACTION
go




