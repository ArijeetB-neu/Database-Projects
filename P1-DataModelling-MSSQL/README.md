# Data Modeling with MSSQL

## Overview

This project proposal focuses on helping an NGO to provide services offered by Primary health centers for underprivileged people. We propose to design a database in which NGO provides medical benefits to underprivileged people by providing an application wherein our NGO agency can login and can access the data provided by hospitals. Our strategy is to provide convenient medical platform for those who cannot afford a high quality medical care or are not able to access proper medical treatment.

### The objective of the project are-
 Creating the Hospital NGO services database and then using various MSSQL functionality like Functions, Stored Procedures, select queries to keep track of records like medicines prescribed by doctor, list of doctors working in different hospitals etc. We have also implemented Triggers and Encryption on the database to add more functionality to the database.

## Entities
- NGO - contains details of any given NGO
- hospital - hospital entity contains the details of all the hospitals we have in the database
- patient - patient table holds the record of all the patients from different hospitals we have
- employee - employee table has the record of all the employed people from the hospital. It is the supertype for doctor and labAssistant subtypes, i.e. the two types of employed persons working in the hospital
- doctor - doctor entity is the subtype for employee table
- labAssistant - labAssistant table is the subtype for employee table
- diagnosis - diagnosis entity captures the diagnosis details if diagnosis is required after consultation.
- testType - testType table is connected to diagnosis entity which captures the different types of tests that can be performed
- docSpecialization - docSpecialization table table gives us the specialization of all the doctor specialization available in the database
- consultation - this table captures the doctor - patient consultation and based on the consultation the doctor decides if there will be future diagnosis or not.
- diseaseType - diseaseType table is connected to consultation table which captures the types of diseases that a patient can possibly have
- prescription - prescription table is connected to diseaseType table and it captures the prescription assigned to the patient after consultation.
- pharmacy - pharmacy entity is connected to prescription table and each prescriptionId has a single medicine details which the patient gets from the pharmacy entity
- Bill - finally, bill entity generates the bill amount to be paid which is paid by the NGO if the patientIncome attribute from the patient table qualifies the patient to be covered by the NGO
