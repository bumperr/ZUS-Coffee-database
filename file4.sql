SELECT 
    E.E_position,
    Ps.Per_firstname,
    D.Dpt_name,
    V.Vec_price,
    I.Itm_name,
    B.B_name,
    P.Proc_totalCost,
    S.Ship_receiveDate
FROM Employee E

JOIN Person Ps ON E.Per_email=Ps.Per_email

JOIN Employee_Vehicle EV ON E.E_ID = EV.E_ID

JOIN Vehicle V ON EV.Vec_ID = V.Vec_ID

JOIN Item I ON V.Vec_ID = I.Vec_ID

JOIN Department D ON D.Dpt_ID= E.Dpt_ID

JOIN
    Branch B ON V.B_ID = B.B_ID
JOIN
    Procurement P ON P.Proc_ID = I.Proc_ID
JOIN
    Shipment S ON S.Ship_ID = I.Ship_ID
WHERE
    S.ship_status='Completed'
    AND V.Vec_price > 3500
    AND I.Itm_cost < 300
    AND E.E_employmentStatus = 'Permanent'
ORDER BY V.Vec_price DESC;
