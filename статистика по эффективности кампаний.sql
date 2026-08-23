
#Статистика по кампаниям
SELECT company_direct.name_company AS company, SUM(display) AS count_display, 
	SUM(clicks) AS count_clicks,
    SUM(consumption) AS count_consumption,
    SUM(conversions) AS count_conversions,
    ROUND(SUM(clicks)*100.0/SUM(display), 2) as str,
    ROUND(SUM(consumption)/SUM(conversions), 2) AS cpa
FROM vision_test 
	INNER JOIN company_direct ON vision_test.company = company_direct.id_company
GROUP BY company;
