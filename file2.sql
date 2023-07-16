SELECT b.B_name,SUM(s.sale_totalAmount)
FROM  Sale  s
JOIN Branch  b ON b.B_ID = s.B_ID
JOIN Promotion  p ON p.promo_ID=s.promo_ID
JOIN MarketingProgram  mp ON mp.Mrkt_ID=p.Mrkt_ID
WHERE p.promo_redemptionLimit>200000 AND mp.Mrkt_budget<10000
GROUP BY b.B_name;
