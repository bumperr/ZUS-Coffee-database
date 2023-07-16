SELECT A.Applicant_ic, APP.Application_OutletApplied
FROM
    Applicant_Application AA
JOIN
    Applicant A ON AA.Applicant_ID = A.Applicant_ID
JOIN
    Application APP ON AA.Application_ID = APP.Application_ID;
