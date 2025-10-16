use HEALTHCONNECT;

-- Create a view that combines patient information with their appointment history, showing details of each visit, including the healthcare provider and facility.
CREATE VIEW PatientAppointmentDetails AS
SELECT
    p.PatientUID,
    p.FirstName,
    p.LastName,
    a.AppointmentDateTime,
    a.AppointmentType,
    a.AppointmentDetails,
    a.FollowUpDetails,
    a.PatientFeedback,
    a.AppointmentStatus,
    prv.FirstName AS ProviderFirstName,
    prv.LastName AS ProviderLastName,
    f.FacilityName,
    f.Details AS FacilityDetails
FROM PATIENTS p
JOIN APPOINTMENTS a ON p.PatientUID = a.PatientUID
JOIN PROVIDERS prv ON a.ProviderUID = prv.ProviderUID
JOIN PROVIDER_FACILITIES pf ON prv.ProviderUID = pf.ProviderUID
JOIN FACILITIES f ON pf.FacilityUID = f.FacilityUID;

select * from PatientAppointmentDetails;

-- create a view that provides a summary of each healthcare facility's services, including their average service rating and the number of special services they offer.

CREATE VIEW FacilityServiceSummary AS
SELECT
    f.FacilityUID,
    f.FacilityName,
    f.Details AS FacilityDetails,
    AVG(f.ServiceRating) AS AverageServiceRating,
    COUNT(ss.ServiceName) AS NumberOfSpecialServices
FROM FACILITIES f
LEFT JOIN FACILITY_SPECIAL_SERVICES ss ON f.FacilityUID = ss.FacilityUID
GROUP BY f.FacilityUID, f.FacilityName, f.Details;

select * from FacilityServiceSummary;

-- Create a view that combines healthcare provider details with their appointment counts, average patient ratings, and last appointment date

CREATE VIEW ProviderAppointmentSummary AS
SELECT
    prv.ProviderUID,
    prv.FirstName,
    prv.LastName,
    COUNT(a.AppointmentUID) AS TotalAppointments,
    AVG(CAST(a.PatientFeedback AS DECIMAL(10,2))) AS AveragePatientRating,
    MAX(a.AppointmentDateTime) AS LastAppointmentDate
FROM PROVIDERS prv
LEFT JOIN APPOINTMENTS a ON prv.ProviderUID = a.ProviderUID
GROUP BY prv.ProviderUID, prv.FirstName, prv.LastName;

select * from ProviderAppointmentSummary;

-- Create a view that shows each patient's enrollment in wellness programs, including the number of programs and the names of those programs

CREATE VIEW PatientWellnessProgramSummary AS
SELECT
    p.PatientUID,
    p.FirstName,
    p.LastName,
    COUNT(wpe.ProgramUID) AS NumberOfPrograms,
    GROUP_CONCAT(wp.ProgramName SEPARATOR ', ') AS ProgramNames
FROM PATIENTS p
LEFT JOIN WELLNESS_PROGRAM_ENROLLMENT wpe ON p.PatientUID = wpe.PatientUID
LEFT JOIN WELLNESS_PROGRAM wp ON wpe.ProgramUID = wp.ProgramUID
GROUP BY p.PatientUID, p.FirstName, p.LastName;

select * from PatientWellnessProgramSummary;





-- Retrieve the names, addresses, of the 3 most visited healthcare facilities in Texas.

SELECT 
    F.FacilityName,
    FA.StreetAddress,
    FA.City,
    FA.State,
    FA.Zip
FROM FACILITIES F
JOIN FACILITY_ADDRESS FA ON F.AddressID = FA.AddressID
JOIN (
    SELECT PV.FacilityUID, COUNT(*) AS VisitCount
    FROM PATIENT_VISITS PV
    JOIN FACILITY_ADDRESS FA ON FA.AddressID = (SELECT AddressID FROM FACILITIES WHERE FacilityUID = PV.FacilityUID)
    WHERE FA.State = 'Texas'
    GROUP BY PV.FacilityUID
    ORDER BY VisitCount DESC
    LIMIT 3
) AS V ON F.FacilityUID = V.FacilityUID
WHERE FA.State = 'Texas';


-- Retrieve the top 5 healthcare facilities based on patient volume and satisfaction ratings this year.
SELECT 
    F.FacilityName,
    F.ServiceRating,
    COUNT(PV.PatientUID) AS PatientVolume
FROM FACILITIES F
LEFT JOIN PATIENT_VISITS PV ON F.FacilityUID = PV.FacilityUID
GROUP BY F.FacilityUID, F.FacilityName, F.ServiceRating
ORDER BY PatientVolume DESC, F.ServiceRating DESC
LIMIT 5;


-- Retrieve the facilities that have had no appointments in the past month.
SELECT 
    F.FacilityName,
    F.FacilityUID
FROM FACILITIES F
LEFT JOIN PROVIDER_FACILITIES PF ON F.FacilityUID = PF.FacilityUID
LEFT JOIN APPOINTMENTS A ON PF.ProviderUID = A.ProviderUID
    AND A.AppointmentDateTime >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
    AND A.AppointmentDateTime < CURRENT_DATE()
WHERE A.AppointmentUID IS NULL
GROUP BY F.FacilityName, F.FacilityUID;

-- Retrieve the name, membership status, and the total number of health entries of the patient who has recorded the most health journal entries.
SELECT 
    P.FirstName,
    P.LastName,
    (CASE WHEN PP.PatientUID IS NOT NULL THEN 'Yes' ELSE 'No' END) AS MembershipStatus,
    COUNT(J.EntryUID) AS TotalJournalEntries
FROM PATIENTS P
LEFT JOIN JOURNALS J ON P.PatientUID = J.PatientUID
LEFT JOIN PREMIUM_PATIENTS PP ON P.PatientUID = PP.PatientUID
GROUP BY P.PatientUID, P.FirstName, P.LastName, MembershipStatus
ORDER BY TotalJournalEntries DESC
LIMIT 1;

-- Retrieve the names of all premium patients who have never visited any facility in the US.
SELECT 
    P.FirstName,
    P.LastName
FROM PATIENTS P
JOIN PREMIUM_PATIENTS PP ON P.PatientUID = PP.PatientUID
LEFT JOIN (
    SELECT PV.PatientUID
    FROM PATIENT_VISITS PV
    JOIN FACILITIES F ON PV.FacilityUID = F.FacilityUID
    JOIN FACILITY_ADDRESS FA ON F.AddressID = FA.AddressID
    WHERE FA.State IS NOT NULL -- Assuming all US states are adequately represented
) AS VisitedUS ON P.PatientUID = VisitedUS.PatientUID
WHERE VisitedUS.PatientUID IS NULL;

-- Retrieve the number of patients who have had appointments at facilities that operate 24/7 in Texas over the last year.

SELECT COUNT(DISTINCT A.PatientUID) AS NumberOfPatients
FROM APPOINTMENTS A
JOIN PROVIDERS P ON A.ProviderUID = P.ProviderUID
JOIN PROVIDER_FACILITIES PF ON P.ProviderUID = PF.ProviderUID
JOIN FACILITIES F ON PF.FacilityUID = F.FacilityUID
JOIN FACILITY_ADDRESS FA ON F.AddressID = F.AddressID
JOIN FACILITY_OPERATING_HOURS FOH ON F.FacilityUID = FOH.FacilityUID
WHERE FA.State = 'Texas'
  AND FOH.OpenHour = '00:00:00'
  AND FOH.CloseHour = '23:59:00'
  AND A.AppointmentDateTime >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)
GROUP BY FOH.FacilityUID
HAVING COUNT(DISTINCT FOH.DayOfWeek) = 7;

-- Retrieve detailed profiles of patients who have attended every type of wellness program offered by their preferred facility
SELECT DISTINCT
    P.FirstName,
    P.LastName,
    P.DateOfBirth,
    F.FacilityUID AS PreferredFacility,
    GROUP_CONCAT(DISTINCT WP.ProgramName ORDER BY WP.ProgramName) AS AttendedPrograms
FROM PATIENTS P
JOIN PATIENT_PREFERRED_FACILITIES PF ON P.PatientUID = PF.PatientUID
JOIN WELLNESS_PROGRAM_ENROLLMENT WPE ON P.PatientUID = WPE.PatientUID
JOIN WELLNESS_PROGRAM WP ON WPE.ProgramUID = WP.ProgramUID
JOIN FACILITIES F ON WP.FacilityUID = F.FacilityUID AND F.FacilityUID = PF.FacilityUID
WHERE NOT EXISTS (
    SELECT 1
    FROM WELLNESS_PROGRAM WP2
    WHERE WP2.FacilityUID = PF.FacilityUID
    AND NOT EXISTS (
        SELECT 1
        FROM WELLNESS_PROGRAM_ENROLLMENT WPE2
        WHERE WPE2.PatientUID = P.PatientUID
        AND WPE2.ProgramUID = WP2.ProgramUID
    )
)
GROUP BY P.PatientUID, P.FirstName, P.LastName, P.DateOfBirth, PF.FacilityUID;

-- Retrieve a list of patients along with their insurance plan and the total amount billed to them over the last year, including how much was covered by insurance.

SELECT 
    P.PatientUID,
    P.FirstName,
    P.LastName,
    IP.PolicyHolderName,
    IP.ProviderName AS InsuranceProvider,
    IP.PolicyNumber,
    SUM(B.Amount) AS TotalAmountBilled,
    SUM(B.PaidAmount) AS TotalCoveredByInsurance
FROM PATIENTS P
JOIN INSURANCE_POLICIES IP ON P.PatientUID = IP.PatientUID
LEFT JOIN BILLING B ON P.PatientUID = B.PatientUID
WHERE B.PostedDate >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR)
GROUP BY P.PatientUID, P.FirstName, P.LastName, IP.PolicyHolderName, IP.ProviderName, IP.PolicyNumber
ORDER BY P.LastName, P.FirstName;

-- Retrieve the contact information of the healthcare provider who has the highest number of appointments and the one who has treated the most patients.
WITH ProviderStats AS (
    SELECT 
        A.ProviderUID,
        COUNT(*) AS TotalAppointments,
        COUNT(DISTINCT A.PatientUID) AS UniquePatients
    FROM APPOINTMENTS A
    GROUP BY A.ProviderUID
),
MaxAppointments AS (
    SELECT 
        ProviderUID,
        TotalAppointments
    FROM ProviderStats
    ORDER BY TotalAppointments DESC
    LIMIT 1
),
MaxPatients AS (
    SELECT 
        ProviderUID,
        UniquePatients
    FROM ProviderStats
    ORDER BY UniquePatients DESC
    LIMIT 1
)
SELECT 
    P.ProviderUID,
    P.FirstName,
    P.LastName,
    PCI.Email,
    PCI.Phone
FROM PROVIDERS P
JOIN PROVIDER_CONTACT_INFORMATION PCI ON P.ProviderUID = PCI.ProviderUID
WHERE P.ProviderUID IN (SELECT ProviderUID FROM MaxAppointments)
   OR P.ProviderUID IN (SELECT ProviderUID FROM MaxPatients);

-- Retrieve the top three wellness programs with the highest enrollment in each city within Texas.
WITH EnrollmentRankings AS (
    SELECT
        FA.City,
        WP.ProgramName,
        COUNT(WPE.PatientUID) AS EnrollmentCount,
        RANK() OVER (PARTITION BY FA.City ORDER BY COUNT(WPE.PatientUID) DESC) AS ProgramRank
    FROM WELLNESS_PROGRAM WP
    JOIN WELLNESS_PROGRAM_ENROLLMENT WPE ON WP.ProgramUID = WPE.ProgramUID
    JOIN FACILITIES F ON WP.FacilityUID = F.FacilityUID
    JOIN FACILITY_ADDRESS FA ON F.AddressID = FA.AddressID
    WHERE FA.State = 'Texas'
    GROUP BY FA.City, WP.ProgramName
)
SELECT 
    City,
    ProgramName,
    EnrollmentCount
FROM EnrollmentRankings
WHERE ProgramRank <= 3;

