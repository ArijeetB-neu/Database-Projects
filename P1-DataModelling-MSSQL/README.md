# Data Modeling with MSSQL

## Overview

This project proposal focuses on helping an NGO to provide services offered by Primary health centers for underprivileged people. We propose to design a database in which NGO provides medical benefits to underprivileged people by providing an application wherein our NGO agency can login and can access the data provided by hospitals. Our strategy is to provide convenient medical platform for those who cannot afford a high quality medical care or are not able to access proper medical treatment.

### The objective of the project are-
1)Showcase various MSSQL functionality like Functions, Stored Procedures, Views, Triggers in practical setting
2)Setting up the data into Power BI and analyze the data with visualization

## Entities/tables
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

## Files
1) Hospital NGO Services DataBase.pptx - presentation showcasing the ER diagram, different SQL scripts, data visualization with Power BI
2) SQL Scripts
- DDL.sql - this script creates all the needed tables and defines the database. It defines constraints like primary keys and foreign keys, adds index on tables for query optimization
- Insert Query.sql - this script inserts data into all of the tables defined in the above script
- Function.sql - this script creates a function to get details of the medicines prescribed to a patient by a given doctor
- StoredProcedures.sql - this script creates 3 stored procedures to show different details of patients and update patients information
- Views.sql - this script creates a temporary table called People to show details of every person in the DataBase
- Triggers.ql - this script creates an instead of trigger to automatically calculate taxes on medicines based on the total amount to be paid
- Select Queries - this script runs all the Functions, StoredProcedures, Views
