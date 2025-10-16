-- Insert sample data into FACILITY_ADDRESS table
INSERT INTO FACILITY_ADDRESS (AddressID, StreetAddress, City, State, Zip) VALUES
(1, '123 Main St', 'Anytown', 'CA', 12345),
(2, '456 Elm St', 'Othertown', 'NY', 54321),
(3, '789 Oak St', 'Anothertown', 'TX', 67890),
(4, '321 Maple St', 'Somewhere', 'FL', 09876),
(5, '654 Pine St', 'Nowhere', 'WA', 45678),
(6, '1234 Elm Street', 'Anytown', 'CA', 90210),
(7, '5678 Oak Avenue', 'Othertown', 'TX', 75001),
(8, '9102 Maple Road', 'Heretown', 'FL', 33021);

-- Insert sample data into FACILITIES table
INSERT INTO FACILITIES (FacilityUID, FacilityName, Details, FacilityCategory, ServiceRating, AddressID) VALUES
(1,'Hospital A', 'Full-service hospital', 'Hospital', 4, 1),
(2,'Clinic B', 'Primary care clinic', 'Clinic', 5, 2),
(3,'Rehab Center C', 'Physical therapy and rehabilitation center', 'Rehabilitation', 3, 3),
(4,'Urgent Care D', 'Urgent medical care facility', 'Urgent Care', 4, 4),
(5,'Wellness Center E', 'Wellness and fitness center', 'Wellness', 4, 5),
(6, 'Anytown Health Center', 'Comprehensive community health services.', 'General', 5, 6),
(7, 'Othertown Clinic', 'Emergency and outpatient services.', 'Urgent Care', 4, 7),
(8, 'Heretown Hospital', 'Full range hospital services.', 'Hospital', 4, 8);

-- Insert sample data into FACILITY_STATISTICS table
INSERT INTO FACILITY_STATISTICS (FacilityUID, StatName, StatValue) VALUES
(1, 'Number of Beds', 200),
(2, 'Number of Physicians', 10),
(2, 'Patients Served', 1500),
(3, 'Number of Therapy Rooms', 5),
(3, 'Patients Served', 2000),
(4, 'Number of Exam Rooms', 8),
(5, 'Number of Fitness Equipment', 50),
(5, 'Patients Served', 800);

-- Insert sample data into FACILITY_SPECIAL_SERVICES table
INSERT INTO FACILITY_SPECIAL_SERVICES (FacilityUID, ServiceName, ServiceDetails) VALUES
(1, 'Cardiology', 'Specialized heart care services'),
(2, 'Pediatrics', 'Medical care for children'),
(3, 'Occupational Therapy', 'Therapeutic services to improve daily activities'),
(4, 'Radiology', 'Diagnostic imaging services'),
(5, 'Nutrition Counseling', 'Dietary guidance and nutrition education'),
(6, 'Maternity Care', 'High-quality prenatal and postnatal care.'),
(7, 'Radiology', 'State-of-the-art imaging and diagnostics.'),
(8, 'Cardiology', 'Advanced heart disease treatment and surgery.');

-- Insert sample data into FACILITY_CONTACT_INFORMATION table
INSERT INTO FACILITY_CONTACT_INFORMATION (FacilityUID, Email, Phone, Link, IsPrimary, ContactType) VALUES
(1, 'info@hospitala.com', '123-456-7890', 'www.hospitala.com', true, 'Email'),
(2, 'info@clinicb.com', '987-654-3210', 'www.clinicb.com', true, 'Email'),
(3, 'info@rehabcenterc.com', '555-555-5555', 'www.rehabcenterc.com', true, 'Email'),
(4, 'info@urgentcared.com', '111-222-3333', 'www.urgentcared.com', true, 'Email'),
(5, 'info@wellnesscentere.com', '999-888-7777', 'www.wellnesscentere.com', true, 'Email'),
(6, 'contact@anytownhealth.org', '555-1234', NULL, TRUE, 'Email'),
(7, NULL, '555-5678', 'www.othertownclinic.com', TRUE, 'Link');


-- Insert sample data into FACILITY_OPERATING_HOURS table
INSERT INTO FACILITY_OPERATING_HOURS (FacilityUID, DayofWeek, OpenHour, CloseHour) VALUES
(1, 'Monday', '08:00:00', '17:00:00'),
(1, 'Tuesday', '08:00:00', '17:00:00'),
(1, 'Wednesday', '08:00:00', '17:00:00'),
(1, 'Thursday', '08:00:00', '17:00:00'),
(1, 'Friday', '08:00:00', '17:00:00'),
(2, 'Monday', '08:00:00', '18:00:00'),
(3, 'Tuesday', '08:00:00', '18:00:00');

-- Insert sample data into PROVIDERS table
INSERT INTO PROVIDERS (ProviderUID, FirstName, MiddleName, LastName, HasAccess) VALUES
(1, 'John', 'Doe', 'Smith', true),
(2, 'Jane', '', 'Doe', true),
(3, 'Michael', 'A', 'Johnson', true),
(4, 'Emily', 'R', 'Davis', true),
(5, 'Christopher', '', 'Wilson', true),
(6, 'John', 'A.', 'Doe', TRUE),
(7, 'Jane', 'B.', 'Smith', TRUE);


-- Insert sample data into PROVIDER_FACILITIES table
INSERT INTO PROVIDER_FACILITIES (ProviderUID, FacilityUID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

-- Insert sample data into specialty table
INSERT INTO SPECIALTY (SpecialtyUID, Specialties) VALUES
(1, 'Cardiology'),
(2, 'Pediatrics'),
(3, 'Physical Therapy'),
(4, 'Emergency Medicine'),
(5, 'Nutrition'),
(6, 'Pediatrics'),
(7, 'General Surgery');

-- Insert sample data into QUALIFICATION table
INSERT INTO QUALIFICATION (QualificationUID, Qualification) VALUES
(1, 'MD'),
(2, 'DO'),
(3, 'PT'),
(4, 'DDS'),
(5, 'DC'),
(6, 'DPT'),
(7, 'RD');

-- Insert sample data into Provider_Specialties table
INSERT INTO PROVIDER_SPECIALTIES (ProviderUID, SpecialtyUID) VALUES
(1,1),
(1,6),
(2,4),
(3,7),
(4,5),
(5,2);

INSERT INTO PROVIDER_QUALIFICATIONS (ProviderUID, QualificationUID) VALUES
(1,1),
(2,4),
(3,7),
(4,3),
(5,2),
(6,5);

-- Insert sample data into PROVIDER_CONTACT_INFORMATION table
INSERT INTO PROVIDER_CONTACT_INFORMATION (ProviderUID, Phone, Email, ContactType, IsPrimary) VALUES
(1, '111-111-1111', 'john.doe@hospitala.com', 'Phone', true),
(2, '222-222-2222', 'jane.doe@clinicb.com', 'Phone', true),
(3, '333-333-3333', 'michael.johnson@rehabcenterc.com', 'Phone', true),
(4, '444-444-4444', 'emily.davis@urgentcared.com', 'Phone', true),
(5, '555-555-5555', 'christopher.wilson@wellnesscentere.com', 'Phone', true),
(6, '555-9876', 'johndoe@email.com', 'Email', TRUE),
(7, '555-6543', NULL, 'Phone', TRUE);


-- Insert sample data into PATIENTS table
INSERT INTO PATIENTS (PatientUID, FirstName, MiddleName, LastName, DateOfBirth, HasAccess) VALUES
(1, 'Alice', 'M', 'Johnson', '1990-05-15', true),
(2, 'Bob', '', 'Smith', '1985-10-20', true),
(3, 'Carol', 'A', 'Williams', '1978-03-25', true),
(4, 'David', 'R', 'Brown', '2000-12-10', true),
(5, 'Emma', '', 'Miller', '1995-08-05', true),
(6, 'Alice', 'C.', 'Johnson', '1985-07-15', TRUE),
(7, 'Bob', 'D.', 'Lee', '1990-12-01', TRUE),
(8, 'Charlie', 'E.', 'Brown', '1975-05-22', TRUE);

-- Insert sample data into PATIENT_ADDRESS table
INSERT INTO PATIENT_ADDRESS (AddressID, PatientUID, StreetAddress, City, State, Zip, AddressType) VALUES
(1, 1, '123 Oak St', 'Anytown', 'CA', 12345, 'Home'),
(2, 2, '456 Pine St', 'Othertown', 'NY', 54321, 'Home'),
(3, 3, '789 Maple St', 'Anothertown', 'TX', 67890, 'Home'),
(4, 4, '321 Elm St', 'Somewhere', 'FL', 09876, 'Home'),
(5, 5, '654 Cedar St', 'Nowhere', 'WA', 45678, 'Home'),
(6, 6, '1111 Birch Street', 'Anytown', 'CA', 90210, 'Home'),
(7, 7, '2222 Cedar Blvd', 'Othertown', 'TX', 75001, 'Home'),
(8, 8, '3333 Pine Street', 'Heretown', 'FL', 33021, 'Home');

-- Insert sample data into PATIENT_CONTACTINFORMATION table
INSERT INTO PATIENT_CONTACT_INFORMATION (PatientUID, PhoneNumber, EmailAddress, IsPrimary, ContactType) VALUES
(1, '111-111-1111', 'alice.johnson@example.com', true, 'Mobile'),
(2, '222-222-2222', 'bob.smith@example.com', true, 'Mobile'),
(3, '333-333-3333', 'carol.williams@example.com', true, 'Mobile'),
(4, '444-444-4444', 'david.brown@example.com', true, 'Mobile'),
(5, '555-555-5555', 'emma.miller@example.com', true, 'Mobile'),
(6, '555-1111', 'alice.johnson@email.com', TRUE, 'Mobile'),
(7, '555-2222', 'bob.lee@email.com', TRUE, 'Mobile'),
(8, '555-3333', 'charlie.brown@email.com', TRUE, 'Mobile');

-- Insert sample data into PATIENT_PREFERRED_FACILITIES table
INSERT INTO PATIENT_PREFERRED_FACILITIES (PatientUID, FacilityUID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6,6),
(7,7);

-- Insert sample data into PREMIUM_PATIENTS table
INSERT INTO PREMIUM_PATIENTS (PatientUID, HasMembership) VALUES
(1, true),
(2, true),
(3, true),
(4, true),
(5, true),
(6,true),
(7,true);

-- Insert sample data into ENGAGEMENT_FORUM table
INSERT INTO ENGAGEMENT_FORUM (PostUID, PostedOn, PostData, PatientUID) VALUES
(1,'2024-04-12 08:00:00', 'Hello world!', 1),
(2,'2024-04-12 09:00:00', 'How are you all doing today?', 2),
(3,'2024-04-12 10:00:00', 'I have a question about my medication.', 3),
(4,'2024-04-12 11:00:00', 'Does anyone know when the next wellness event is?', 4),
(5,'2024-04-12 12:00:00', 'Just wanted to share my progress!', 5),
(6, '2023-04-01 14:30:00', 'Looking for advice on managing diabetes.', 6),
(7, '2023-04-02 15:45:00', 'Has anyone tried the new clinic in Anytown?', 7);

-- Insert sample data into EQUIPMENT_SERVICE table
INSERT INTO EQUIPMENT_SERVICE (EquipmentUID, EquipmentName, DateAquired, LastServiceDate, ServiceInterval, FacilityUID) VALUES
(1, 'X-Ray Machine', '2023-01-01', '2024-03-01', 90, 1),
(2, 'Treadmill', '2022-05-15', '2024-01-01', 180, 5),
(3, 'Ultrasound Machine', '2023-08-20', '2024-02-15', 120, 3),
(4, 'MRI Scanner', '2023-03-10', '2024-04-10', 60, 2),
(5, 'Blood Pressure Monitor', '2023-11-05', '2024-03-25', 30, 4),
(6, 'MRI Scanner', '2018-06-15', '2023-03-01', 12, 6),
(7, 'Ultrasound Machine', '2019-07-20', '2023-01-15', 6, 7);


-- Insert sample data into WELLNESS_PROGRAM table
INSERT INTO WELLNESS_PROGRAM (ProgramUID, ProgramName, ProgramDetails, Progress, Goal, FacilityUID) VALUES
(1, 'Weight Loss Program', '12-week program to help lose weight', 'Making good progress', 'Lose 10 pounds', 5),
(2, 'Yoga Class', 'Weekly yoga classes for all levels', 'Participants are enjoying the classes', 'Improve flexibility', 5),
(3, 'Smoking Cessation Program', 'Support program to quit smoking', 'Some participants have successfully quit', 'Quit smoking for good', 2),
(4, 'Stress Management Workshop', 'Workshop to learn stress management techniques', 'Participants found it helpful', 'Reduce stress levels', 1),
(5, 'Nutrition Education Series', 'Monthly sessions on healthy eating habits', 'Positive feedback from participants', 'Eat a balanced diet', 3),
(6, 'Healthy Heart', 'Program to reduce heart disease risks.', '80% complete', 'Reduce patient cholesterol by 20%', 4),
(7, 'Weight Management', 'Program to help patients achieve and maintain a healthy weight.', '60% complete', 'Patients achieve a 10% weight reduction', 6);

-- Insert sample data into WELLNESS_PROGRAM_FEEDBACK table
INSERT INTO WELLNESS_PROGRAM_FEEDBACK (ProgramUID, PatientUID, FeedbackDate, PatientFeedback) VALUES
(1, 1, '2024-04-12 08:00:00', 'I am seeing results already!'),
(2, 2, '2024-04-12 09:00:00', 'Great way to relax after work.'),
(3, 3, '2024-04-12 10:00:00', 'Really helping me stay smoke-free.'),
(4, 4, '2024-04-12 11:00:00', 'Learning valuable techniques.'),
(5, 5, '2024-04-12 12:00:00', 'Understanding nutrition better.'),
(6, 6, '2023-04-05 10:00:00', 'This program has been great for my health!'),
(7, 7, '2023-04-06 11:00:00', 'Looking for more personalized support.');

-- Insert sample data into INSURANCE_POLICIES table
INSERT INTO INSURANCE_POLICIES (PolicyUID, CoverageDetails, PatientUID, PolicyHolderName, StartDate, EndDate, PolicyNumber, ProviderName) VALUES
(1,'Medical coverage', 1, 'Alice Johnson', '2023-01-01', NULL, 'ABC123', 'Health Insurance Co.'),
(2,'Dental coverage', 2, 'Bob Smith', '2022-05-15', NULL, 'DEF456', 'Dental Insurance Co.'),
(3,'Vision coverage', 3, 'Carol Williams', '2023-08-20', NULL, 'GHI789', 'Vision Insurance Co.'),
(4,'Health Savings Account', 4, 'David Brown', '2023-03-10', NULL, 'JKL012', 'Bank'),
(5,'Life insurance', 5, 'Emma Miller', '2023-11-05', NULL, 'MNO345', 'Life Insurance Co.'),
(6, 'Covers all primary care and emergency services.', 6, 'Alice Johnson', '2023-01-01', '2024-01-01', 'P10001', 'HealthPlus Insurance'),
(7, 'Basic coverage with high deductible.', 7, 'Bob Lee', '2023-01-01', '2024-01-01', 'P10002', 'BudgetCare');

-- Insert sample data into BILLING table
INSERT INTO BILLING (PolicyUID, DueDate, PostedDate, BillDescription, Amount, PaidAmount, FacilityUID, PatientUID, PaymentStatus) VALUES
(1, '2024-04-30', '2024-04-01', 'Medical services', 150.00, 0.00, 1, 1, 'Unpaid'),
(2, '2024-04-30', '2024-04-01', 'Dental checkup', 80.00, 0.00, 2, 2, 'Unpaid'),
(3, '2024-04-30', '2024-04-01', 'Eye exam', 50.00, 0.00, 3, 3, 'Unpaid'),
(4, '2024-04-30', '2024-04-01', 'Health savings account contribution', 200.00, 0.00, 4, 4, 'Unpaid'),
(5, '2024-04-30', '2024-04-01', 'Life insurance premium', 100.00, 0.00, 5, 5, 'Unpaid');

-- Insert sample data into JOURNALS table
INSERT INTO JOURNALS (JournalDate, Entry, Visibility, PatientUID) VALUES
('2024-04-12 08:00:00', 'Feeling great today!', 'PRIVATE', 1),
('2024-04-12 09:00:00', 'Workout went well.', 'SHARED', 2),
('2024-04-12 10:00:00', 'Trying to stay positive.', 'PUBLIC', 3),
('2024-04-12 11:00:00', 'New medication seems to be helping.', 'PRIVATE', 4),
('2024-04-12 12:00:00', 'Taking steps towards better health.', 'SHARED', 5);

-- Insert sample data into PATIENT_RECORDS table
INSERT INTO PATIENT_RECORDS (RecordUID, PermissionRequirement, PatientUID, ProviderUID) VALUES
(11, false, 1, 1),
(12, false, 2, 2),
(13, true, 3, 3),
(14, true, 4, 4),
(15, true, 5, 5),
(21, false, 1, 1),
(22, false, 2, 2),
(23, true, 3, 3),
(24, true, 4, 4),
(25, true, 5, 5);

-- Insert sample data into APPOINTMENTS table
INSERT INTO APPOINTMENTS (AppointmentDateTime, AppointmentType, AppointmentDetails, FollowUpDetails, PatientFeedback, PatientUID, ProviderUID, AppointmentStatus) VALUES
('2024-04-15 10:00:00', 'In Person', 'Routine checkup', NULL, NULL, 1, 1, 'Scheduled'),
('2024-04-16 09:00:00', 'Virtual', 'Follow-up consultation', 'Review test results', NULL, 2, 2, 'Scheduled'),
('2024-04-17 11:00:00', 'Phone', 'Medication review', NULL, NULL, 3, 3, 'Scheduled'),
('2024-04-18 13:00:00', 'In Person', 'Physical therapy session', 'Exercise plan discussion', NULL, 4, 4, 'Scheduled'),
('2024-04-19 14:00:00', 'Virtual', 'Nutrition counseling', 'Meal planning', NULL, 5, 5, 'Scheduled');

-- Insert sample data into PERSONALIZED_PLANS table
INSERT INTO PERSONALIZED_PLANS (PlanUID, PlanDetails, Progress, GoalDescription, PlanConsultation, PatientUID) VALUES
(1, 'Exercise plan', 'Doing well', 'Lose weight', 'Discuss progress', 1),
(2, 'Diet plan', 'Making changes', 'Eat healthier', 'Review dietary habits', 2),
(3, 'Smoking cessation plan', 'Successfully quit', 'Stay smoke-free', 'Support sessions', 3),
(4, 'Stress management plan', 'Learning techniques', 'Reduce stress', 'Workshop attendance', 4),
(5, 'Wellness plan', 'Implementing changes', 'Improve overall health', 'Review progress', 5);

-- Insert sample data into PATIENT_VISITS table
INSERT INTO PATIENT_VISITS (PatientUID, FacilityUID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insert sample data into WELLNESS_PROGRAM_ENROLLMENT table
INSERT INTO WELLNESS_PROGRAM_ENROLLMENT (ProgramUID, PatientUID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insert sample data into GENERAL_RECORD table
INSERT INTO GENERAL_RECORD (RecordUID, RecordDate, RecordInformation, ProviderUID) VALUES
(21, '2024-04-01', 'Annual checkup', 1),
(22, '2024-04-02', 'Dental cleaning', 2),
(23, '2024-04-03', 'Eye exam', 3),
(24, '2024-04-04', 'Health assessment', 4),
(25, '2024-04-05', 'Life insurance consultation', 5);

-- Insert sample data into LAB_RECORD table
INSERT INTO LAB_RECORD (RecordUID, DateOrdered, DateGenerated, Results, ProviderUID) VALUES
(11, '2024-04-01', '2024-04-05', 'Normal results', 1),
(12, '2024-04-02', '2024-04-06', 'No issues found', 2),
(13, '2024-04-03', '2024-04-07', 'Healthy results', 3),
(14, '2024-04-04', '2024-04-08', 'Stable condition', 4),
(15, '2024-04-05', '2024-04-09', 'Excellent health', 5);