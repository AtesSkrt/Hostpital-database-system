USE master;
GO

USE Hospital_Ates;
GO


CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY IDENTITY,
    ProviderName VARCHAR(50),
    PolicyNumber VARCHAR(50)
);

CREATE TABLE Patient (
    PatientID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100),
    DateOfBirth DATE,
    InsuranceID INT FOREIGN KEY REFERENCES Insurance(InsuranceID)
);

CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50) NOT NULL,
    Specialization VARCHAR(50),
    Department VARCHAR(50)
);

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY IDENTITY,
    PatientID INT FOREIGN KEY REFERENCES Patient(PatientID),
    DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID),
    DateTime DATETIME NOT NULL,
    Reason VARCHAR(200)
);

CREATE TABLE Treatment (
    TreatmentID INT PRIMARY KEY IDENTITY,
    AppointmentID INT FOREIGN KEY REFERENCES Appointment(AppointmentID),
    Diagnosis VARCHAR(200),
    Procedures VARCHAR(200),
    Medications VARCHAR(200)
);


USE Hospital_Ates;
GO

INSERT INTO Patient (Name, Address, DateOfBirth, InsuranceID)
VALUES ('John Doe', '100 Oak St. Anytown, CA 12345', '1985-07-14', 1);
--Other values added manually into the table


INSERT INTO Doctor (Name, Specialization, Department)
VALUES ('Dr. John Smith', 'Cardiology', 'Cardiology');
--Other values added manually into the table



INSERT INTO Insurance (ProviderName, PolicyNumber)
VALUES ('ABC Insurance', '1234567890');
--Other values added manually into the table


INSERT INTO Appointment (PatientID, DoctorID, DateTime, Reason)
VALUES ((SELECT PatientID FROM Patient WHERE Name = 'patient number 5'), -- patient 5 is not added for now, but imagine his name is patient number 5.
        (SELECT DoctorID FROM Doctor WHERE Name = 'Dr. John Smith'), 
        '2024-05-22 10:00:00 AM', 'Chest pain');
		--other values added manually into the table.

INSERT INTO Treatment (AppointmentID, Diagnosis, Procedures, Medications)
VALUES ((SELECT AppointmentID FROM Appointment WHERE Reason = 'Chest pain'), 
  'Chest pain (to be determined)', '(To be determined)', 'Pain medication');
--Other values added manually into the table
