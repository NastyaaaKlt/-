
#Статистика по кампаниям
SELECT company_direct.name_company AS company, SUM(display) AS count_display, 
	SUM(clicks) AS count_clicks,
    SUM(consumption) AS count_consumption,
    SUM(conversions) AS count_conversions,
    ROUND(SUM(clicks)*100.0/SUM(display), 2) AS str,
    ROUND(SUM(consumption)/SUM(conversions), 2) AS cpa
FROM vision_test 
	INNER JOIN company_direct ON vision_test.company = company_direct.id_company
GROUP BY company;


#Статистика по запросам
SELECT keywords, SUM(display) AS count_display_keywords, SUM(clicks) AS count_clicks, SUM(conversions) AS count_conversion, 
ROUND(SUM(clicks)*100.0/SUM(display), 2) AS STR
FROM vision_test
GROUP BY keywords
ORDER BY count_conversion DESC
LIMIT 30;


#На каких позициях показов чаще бывают конверсии
SELECT avg_display_pos, SUM(conversions) AS sum_display
FROM vision_test
GROUP BY avg_display_pos;

#Распределение среднего количества конверсий по полу
SELECT sex, ROUND(AVG(conversions) *100.0, 2) AS avg_conversions
FROM vision_test
GROUP BY sex;

#Среднее число конверсий по месту показа (Оконная функция)
SELECT placement, text, 
	ROUND(AVG(sum_conv) OVER(PARTITION BY placement), 2) AS avg_conv_by_plcmnt
FROM
	(SELECT placement, text,
		SUM(display) AS sum_display,
		SUM(conversions) AS sum_conv
	FROM vision_test
	GROUP BY placement, text
	ORDER BY placement) AS table_1;
