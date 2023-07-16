--File 4 , data and attribute need to adjust to get 2 row
SELECT 
    E.Employee_Name,
    V.Vec_plateNum,
    I.Itm_name,
    A.Application_Date,
    B.Branch_Location,
    C.Customer_Name,
    P.Procurement_Date,
    S.Shipment_Date
FROM
    Employee E
JOIN
    Employee_Vehicle EV ON E.E_ID = EV.E_ID
JOIN
    Vehicle V ON EV.Vec_ID = V.Vec_ID
JOIN
    Item I ON V.Vec_ID = I.Vec_ID
JOIN
    Application A ON A.B_ID = V.B_ID
JOIN
    Branch B ON V.B_ID = B.B_ID
JOIN
    Customer C ON C.Customer_ID = I.Customer_ID
JOIN
    Procurement P ON P.Proc_ID = I.Proc_ID
JOIN
    Shipment S ON S.Ship_ID = I.Ship_ID
WHERE
    A.Application_Points > 100
    AND V.Vec_price > 50000
    AND I.Itm_cost < 100
    AND E.Employee_Position = 'Manager'
ORDER BY
    E.Employee_ID DESC, V.Vec_ID DESC, I.Itm_ID DESC, A.Application_ID DESC
FETCH FIRST 2 ROWS ONLY;
