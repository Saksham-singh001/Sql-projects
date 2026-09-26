-- Hospital Management System Project
-- PostgreSQL
-- Based on the structure of the user's Library Management project,
-- but redesigned for a Hospital Management System.

-- =========================================================
-- 1. CREATE DEPARTMENT TABLE
-- =========================================================

DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS prescriptions;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments(
    department_id varchar(10) PRIMARY KEY,
    department_name varchar(50),
    department_location varchar(55),
    contact_no varchar(25)
);

SELECT * FROM departments;


-- =========================================================
-- 2. CREATE EMPLOYEES TABLE
-- =========================================================

CREATE TABLE employees(
    emp_id varchar(10) PRIMARY KEY,
    emp_name varchar(50),
    position varchar(25),
    salary int,
    department_id varchar(10) -- FK
);

SELECT * FROM employees;


-- =========================================================
-- 3. CREATE DOCTORS TABLE
-- =========================================================

CREATE TABLE doctors(
    doctor_id varchar(10) PRIMARY KEY,
    doctor_name varchar(50),
    specialization varchar(50),
    consultation_fee numeric(10,2),
    status varchar(15),
    department_id varchar(10) -- FK
);

SELECT * FROM doctors;


-- =========================================================
-- 4. CREATE PATIENTS TABLE
-- =========================================================

CREATE TABLE patients(
    patient_id varchar(10) PRIMARY KEY,
    patient_name varchar(50),
    patient_address varchar(75),
    phone varchar(25),
    date_of_birth date,
    gender varchar(10)
);

SELECT * FROM patients;


-- =========================================================
-- 5. CREATE APPOINTMENTS TABLE
-- =========================================================

CREATE TABLE appointments(
    appointment_id varchar(10) PRIMARY KEY,
    patient_id varchar(10), -- FK
    doctor_id varchar(10), -- FK
    appointment_date date,
    appointment_time time,
    reason varchar(100),
    status varchar(20)
);

SELECT * FROM appointments;


-- =========================================================
-- 6. CREATE PRESCRIPTIONS TABLE
-- =========================================================

CREATE TABLE prescriptions(
    prescription_id varchar(10) PRIMARY KEY,
    appointment_id varchar(10), -- FK
    patient_id varchar(10), -- FK
    doctor_id varchar(10), -- FK
    medicine_name varchar(75),
    dosage varchar(50),
    prescription_date date
);

SELECT * FROM prescriptions;


-- =========================================================
-- 7. FOREIGN KEYS
-- =========================================================

ALTER TABLE employees
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

ALTER TABLE doctors
ADD CONSTRAINT fk_doctor_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

ALTER TABLE appointments
ADD CONSTRAINT fk_appointment_patient
FOREIGN KEY (patient_id)
REFERENCES patients(patient_id);

ALTER TABLE appointments
ADD CONSTRAINT fk_appointment_doctor
FOREIGN KEY (doctor_id)
REFERENCES doctors(doctor_id);

ALTER TABLE prescriptions
ADD CONSTRAINT fk_prescription_appointment
FOREIGN KEY (appointment_id)
REFERENCES appointments(appointment_id);

ALTER TABLE prescriptions
ADD CONSTRAINT fk_prescription_patient
FOREIGN KEY (patient_id)
REFERENCES patients(patient_id);

ALTER TABLE prescriptions
ADD CONSTRAINT fk_prescription_doctor
FOREIGN KEY (doctor_id)
REFERENCES doctors(doctor_id);


-- =========================================================
-- 8. INSERT DATA INTO DEPARTMENTS
-- =========================================================

INSERT INTO departments(department_id, department_name, department_location, contact_no)
VALUES
('D001', 'Cardiology', 'First Floor', '+919099880001'),
('D002', 'Neurology', 'Second Floor', '+919099880002'),
('D003', 'Orthopedics', 'Ground Floor', '+919099880003'),
('D004', 'Pediatrics', 'First Floor', '+919099880004'),
('D005', 'Dermatology', 'Second Floor', '+919099880005'),
('D006', 'General Medicine', 'Ground Floor', '+919099880006');

SELECT * FROM departments;


-- =========================================================
-- 9. INSERT DATA INTO EMPLOYEES
-- =========================================================

INSERT INTO employees(emp_id, emp_name, position, salary, department_id)
VALUES
('E101', 'Rahul Sharma', 'Receptionist', 35000, 'D006'),
('E102', 'Priya Mehta', 'Nurse', 48000, 'D001'),
('E103', 'Amit Verma', 'Nurse', 46000, 'D002'),
('E104', 'Neha Kapoor', 'Nurse', 45000, 'D003'),
('E105', 'Rohit Singh', 'Lab Assistant', 42000, 'D006'),
('E106', 'Anjali Gupta', 'Nurse', 47000, 'D004'),
('E107', 'Vikas Malhotra', 'Receptionist', 36000, 'D005'),
('E108', 'Sneha Rao', 'Nurse', 49000, 'D001'),
('E109', 'Arjun Nair', 'Hospital Manager', 70000, 'D006'),
('E110', 'Pooja Joshi', 'Accountant', 52000, 'D006'),
('E111', 'Karan Bhatia', 'Lab Technician', 44000, 'D002');

SELECT * FROM employees;


-- =========================================================
-- 10. INSERT DATA INTO DOCTORS
-- =========================================================

INSERT INTO doctors(doctor_id, doctor_name, specialization, consultation_fee, status, department_id)
VALUES
('DR101', 'Dr. Anil Kumar', 'Cardiologist', 1200.00, 'Available', 'D001'),
('DR102', 'Dr. Meera Shah', 'Neurologist', 1500.00, 'Available', 'D002'),
('DR103', 'Dr. Raj Malhotra', 'Orthopedic Surgeon', 1300.00, 'Available', 'D003'),
('DR104', 'Dr. Kavita Rao', 'Pediatrician', 1000.00, 'Available', 'D004'),
('DR105', 'Dr. Sameer Gupta', 'Dermatologist', 900.00, 'Available', 'D005'),
('DR106', 'Dr. Neeraj Singh', 'General Physician', 700.00, 'Available', 'D006'),
('DR107', 'Dr. Ritu Sharma', 'Cardiologist', 1100.00, 'On Leave', 'D001'),
('DR108', 'Dr. Manish Verma', 'Neurologist', 1400.00, 'Available', 'D002');

SELECT * FROM doctors;


-- =========================================================
-- 11. INSERT DATA INTO PATIENTS
-- =========================================================

INSERT INTO patients(patient_id, patient_name, patient_address, phone, date_of_birth, gender)
VALUES
('P101', 'Aarav Mehta', '12 Green Park', '+919876540001', '1995-04-12', 'Male'),
('P102', 'Diya Sharma', '45 Model Town', '+919876540002', '1998-08-20', 'Female'),
('P103', 'Kabir Singh', '78 Rohini Sector 7', '+919876540003', '1989-01-15', 'Male'),
('P104', 'Ananya Gupta', '23 Lajpat Nagar', '+919876540004', '2001-11-05', 'Female'),
('P105', 'Vivaan Kapoor', '56 Dwarka Sector 10', '+919876540005', '1992-06-18', 'Male'),
('P106', 'Ishita Verma', '89 Saket', '+919876540006', '1997-03-22', 'Female'),
('P107', 'Aditya Rao', '34 Janakpuri', '+919876540007', '1985-09-30', 'Male'),
('P108', 'Myra Joshi', '67 Pitampura', '+919876540008', '2003-12-14', 'Female'),
('P109', 'Arnav Malhotra', '90 Vasant Kunj', '+919876540009', '1990-02-27', 'Male'),
('P110', 'Sara Nair', '21 Mayur Vihar', '+919876540010', '1999-07-09', 'Female'),
('P111', 'Reyansh Bhatia', '43 Karol Bagh', '+919876540011', '1987-05-16', 'Male'),
('P112', 'Kiara Mehta', '76 Civil Lines', '+919876540012', '2000-10-25', 'Female');

SELECT * FROM patients;


-- =========================================================
-- 12. INSERT DATA INTO APPOINTMENTS
-- =========================================================

INSERT INTO appointments(
    appointment_id, patient_id, doctor_id, appointment_date,
    appointment_time, reason, status
)
VALUES
('A101', 'P101', 'DR101', '2024-04-10', '09:30', 'Chest pain', 'Completed'),
('A102', 'P102', 'DR104', '2024-04-11', '10:00', 'Fever', 'Completed'),
('A103', 'P103', 'DR103', '2024-04-12', '11:00', 'Knee pain', 'Completed'),
('A104', 'P104', 'DR105', '2024-04-13', '12:30', 'Skin allergy', 'Completed'),
('A105', 'P105', 'DR106', '2024-04-14', '09:00', 'Cold and cough', 'Completed'),
('A106', 'P106', 'DR102', '2024-04-15', '14:00', 'Headache', 'Completed'),
('A107', 'P107', 'DR101', '2024-04-16', '10:30', 'Blood pressure check', 'Completed'),
('A108', 'P108', 'DR104', '2024-04-17', '11:30', 'Stomach pain', 'Completed'),
('A109', 'P109', 'DR103', '2024-04-18', '15:00', 'Back pain', 'Completed'),
('A110', 'P110', 'DR105', '2024-04-19', '13:00', 'Acne treatment', 'Completed'),
('A111', 'P111', 'DR102', '2024-04-20', '16:00', 'Migraine', 'Completed'),
('A112', 'P112', 'DR106', '2024-04-21', '09:30', 'General checkup', 'Completed'),
('A113', 'P101', 'DR101', '2024-04-25', '10:00', 'Follow-up', 'Completed'),
('A114', 'P104', 'DR105', '2024-04-26', '12:00', 'Skin allergy follow-up', 'Completed'),
('A115', 'P106', 'DR102', '2024-04-27', '14:30', 'Migraine follow-up', 'Scheduled'),
('A116', 'P110', 'DR106', '2024-04-28', '11:00', 'General checkup', 'Scheduled');

SELECT * FROM appointments;


-- =========================================================
-- 13. INSERT DATA INTO PRESCRIPTIONS
-- =========================================================

INSERT INTO prescriptions(
    prescription_id, appointment_id, patient_id, doctor_id,
    medicine_name, dosage, prescription_date
)
VALUES
('PR101', 'A101', 'P101', 'DR101', 'Aspirin', '75 mg once daily', '2024-04-10'),
('PR102', 'A102', 'P102', 'DR104', 'Paracetamol', '500 mg twice daily', '2024-04-11'),
('PR103', 'A103', 'P103', 'DR103', 'Ibuprofen', '400 mg twice daily', '2024-04-12'),
('PR104', 'A104', 'P104', 'DR105', 'Cetirizine', '10 mg once daily', '2024-04-13'),
('PR105', 'A105', 'P105', 'DR106', 'Amoxicillin', '500 mg three times daily', '2024-04-14'),
('PR106', 'A106', 'P106', 'DR102', 'Sumatriptan', '50 mg as needed', '2024-04-15'),
('PR107', 'A107', 'P107', 'DR101', 'Amlodipine', '5 mg once daily', '2024-04-16'),
('PR108', 'A108', 'P108', 'DR104', 'Ondansetron', '4 mg twice daily', '2024-04-17'),
('PR109', 'A109', 'P109', 'DR103', 'Diclofenac', '50 mg twice daily', '2024-04-18'),
('PR110', 'A110', 'P110', 'DR105', 'Adapalene', 'Apply once daily', '2024-04-19'),
('PR111', 'A111', 'P111', 'DR102', 'Propranolol', '40 mg once daily', '2024-04-20'),
('PR112', 'A112', 'P112', 'DR106', 'Vitamin D3', '1000 IU once daily', '2024-04-21'),
('PR113', 'A113', 'P101', 'DR101', 'Atorvastatin', '10 mg once daily', '2024-04-25'),
('PR114', 'A114', 'P104', 'DR105', 'Hydrocortisone', 'Apply twice daily', '2024-04-26');

SELECT * FROM prescriptions;


-- =========================================================
-- 14. SAMPLE SQL QUERIES FOR THE PROJECT
-- =========================================================

-- 1. Show all patients
SELECT * FROM patients;

-- 2. Show all doctors
SELECT * FROM doctors;

-- 3. Show all appointments
SELECT * FROM appointments;

-- 4. Find doctors who are currently available
SELECT *
FROM doctors
WHERE status = 'Available';

-- 5. Find patients who are female
SELECT *
FROM patients
WHERE gender = 'Female';

-- 6. Find doctors with consultation fee greater than 1000
SELECT *
FROM doctors
WHERE consultation_fee > 1000;

-- 7. Count total patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- 8. Count doctors by department
SELECT department_id, COUNT(*) AS total_doctors
FROM doctors
GROUP BY department_id;

-- 9. Show patient and appointment details
SELECT
    p.patient_name,
    a.appointment_date,
    a.appointment_time,
    a.reason,
    a.status
FROM patients p
JOIN appointments a
ON p.patient_id = a.patient_id;

-- 10. Show doctor and department details
SELECT
    d.doctor_name,
    d.specialization,
    dep.department_name
FROM doctors d
JOIN departments dep
ON d.department_id = dep.department_id;

-- 11. Show complete appointment details with patient and doctor
SELECT
    a.appointment_id,
    p.patient_name,
    d.doctor_name,
    d.specialization,
    a.appointment_date,
    a.appointment_time,
    a.reason,
    a.status
FROM appointments a
JOIN patients p
ON a.patient_id = p.patient_id
JOIN doctors d
ON a.doctor_id = d.doctor_id;

-- 12. Find the number of appointments handled by each doctor
SELECT
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY total_appointments DESC;

-- 13. Show prescription details with patient and doctor
SELECT
    pr.prescription_id,
    p.patient_name,
    d.doctor_name,
    pr.medicine_name,
    pr.dosage,
    pr.prescription_date
FROM prescriptions pr
JOIN patients p
ON pr.patient_id = p.patient_id
JOIN doctors d
ON pr.doctor_id = d.doctor_id;

-- 14. Find patients who have appointments with a cardiologist
SELECT DISTINCT
    p.patient_name
FROM patients p
JOIN appointments a
ON p.patient_id = a.patient_id
JOIN doctors d
ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Cardiologist';

-- 15. Find the highest consultation fee
SELECT MAX(consultation_fee) AS highest_consultation_fee
FROM doctors;

-- 16. Find average consultation fee
SELECT AVG(consultation_fee) AS average_consultation_fee
FROM doctors;

-- =========================================================
-- END OF HOSPITAL MANAGEMENT SYSTEM PROJECT
-- =========================================================