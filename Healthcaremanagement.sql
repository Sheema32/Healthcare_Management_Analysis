CREATE DATABASE HEALTHCARE_ANALYSIS;
USE HEALTHCARE_ANALYSIS;

Select PatientID, COUNT(*) AS COUNT
FROM patienthealth
GROUP BY PatientID
Having COUNT(*) > 1;

SELECT * FROM appointment;
DESCRIBE  appointment;
SELECT COUNT(*) FROM appointment;
ALTER TABLE appointment
CHANGE COLUMN ï»¿AppointmentID AppointmentID int; 

UPDATE appointment
SET Time = SUBSTRING_INDEX(SUBSTRING_INDEX(Time, 'T', -1), '.', 1)
WHERE Time LIKE '%T%:%:%';

UPDATE appointment
SET Time = NULL
WHERE Time NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$';
DELETE FROM appointment
WHERE Time NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$';
ALTER TABLE appointment
MODIFY COLUMN `Time` TIME;


SELECT * 
FROM Appointment
WHERE Date IS NULL OR Time IS NULL OR PatientID IS NULL OR DoctorID IS NULL;

WITH HEALTHAPPOINTMENTS AS (
    SELECT AppointmentID, Date, Time, PatientID, DoctorID,
           ROW_NUMBER() OVER (PARTITION BY AppointmentID ORDER BY AppointmentID) AS RowNum
    FROM Appointment
)
DELETE FROM Appointment
WHERE AppointmentID IN ( 
  SELECT AppointmentID FROM HEALTHAPPOINTMENTS WHERE RowNum > 1
);

SELECT COUNT(*) FROM appointment;
SELECT * FROM Appointment;





