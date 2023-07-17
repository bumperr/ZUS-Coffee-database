SELECT 
	E.E_ID, 
	E.E_position, 
	P.P_category, 
	P.P_retailPrice, 
	r.R_name, 
	r.R_dateCreated,
	RM.Rm_qualitygrades, 
	RM.Rm_brand, 
	s.S_dealerName, 
	s.S_email,
	p.Proc_quantity, 
	p.Proc_totalCost

FROM Employee E

JOIN Employee_Product EP ON E.E_ID = EP.E_ID
JOIN Product P ON EP.P_ID = P.P_ID

JOIN Recipe r ON P.R_ID = r.R_ID

JOIN RawMaterial_Recipe RR ON r.R_ID = RR.R_ID
JOIN RawMaterial RM ON RR.Rm_ID = RM.Rm_ID

JOIN Supplier s ON s.S_ID =  RM.S_ID

JOIN Procurement_Supplier PS ON s.S_ID = PS.S_ID
JOIN Procurement p ON PS.Proc_ID = p.Proc_ID

WHERE (E.E_position = 'Baristar' OR E.E_position = 'Head Quarters')
AND p.Proc_quantity<4
AND P.P_category = 'Cakes'

;
