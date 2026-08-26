
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


#Статистика по запросам
SELECT keywords, SUM(display) AS count_display_keywords, SUM(clicks) AS count_clicks, SUM(conversions) AS count_conversion, 
ROUND(SUM(clicks)*100.0/SUM(display), 2) as STR
FROM vision_test
GROUP BY keywords
ORDER BY count_conversion DESC
LIMIT 30;


#На каких позициях показов чаще бывают конверсии
select avg_display_pos, SUM(conversions) AS sum_display
FROM vision_test
GROUP BY avg_display_pos;
