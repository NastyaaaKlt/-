
#Статистика по кампаниям, благодаря которой мы видим, какие кампании были более успешными 
	(1.Проверка зрения МОЛОДЕЖЬ Поиск №82 от 22-01-2026 с самым большим числом конверсий 73, нормальным str (10%) 
	и допустимой средней ценой заявки (≈890 руб)
	2. Проверка зрения молодежь Перезапуск 08.05 - 
	3. "Проверка зрения МОЛОДЕЖЬ Поиск Копия 23.06" с самой низкой средней ценой заявки и хорошим str 15%.
	
	Можно сделать предположение, что кампании, направленные на молодую ЦА (от 18 до 34 лет) более эффективны, 
	но для точных выводов нужен более детальный анализ по результатам обработки заявок)
	
SELECT company_direct.name_company AS company, SUM(display) AS count_display, 
	SUM(clicks) AS count_clicks,
    SUM(consumption) AS count_consumption,
    SUM(conversions) AS count_conversions,
    ROUND(SUM(clicks)*100.0/SUM(display), 2) AS str,
    ROUND(SUM(consumption)/SUM(conversions), 2) AS cpa
FROM vision_test 
	INNER JOIN company_direct ON vision_test.company = company_direct.id_company
GROUP BY company;


#Статистика по запросам пользователей. Из полученных данных можно составить список запросов, 
	которые следует обязательно включать в следующие рекламные кампании, а какие можно убрать из-за отсутствия результата.
SELECT keywords, SUM(display) AS count_display_keywords, SUM(clicks) AS count_clicks, SUM(conversions) AS count_conversion, 
ROUND(SUM(clicks)*100.0/SUM(display), 2) AS STR
FROM vision_test
GROUP BY keywords
ORDER BY count_conversion DESC
LIMIT 30;


#На каких позициях показов чаще бывают конверсии (1). Все, что ниже 3, неэффективно.
SELECT avg_display_pos, SUM(conversions) AS sum_conv
FROM vision_test
GROUP BY avg_display_pos;

#Частота конверсий в зависимости от пола. 
	Как видно из полученных данных, женщины оставляют заявку на проверку зрения чаще мужчин.
	
SELECT sex.sex, SUM(conversions) AS sum_conversions,
	ROUND(SUM(conversions)*100.0/(SELECT SUM(conversions) FROM vision_test), 2) as percent
FROM vision_test 
	INNER JOIN sex ON vision_test.sex = sex.id_sex
GROUP BY sex.sex;

#Среднее число конверсий по месту показа (Оконная функция).С помощью нее мы видим, 
	что большая часть показов пришлась на Спецразмещение и не зря, так как в среднем конверсия у данного места 
	в Поиске оказалась выше, чем у Прочего, Эксклюзивного размещения и Рекламы в саджесте, 
	а STR у большинства заголовков объявлений выше, чем на других площадках.
	
SELECT placement, text, sum_display, sum_clicks, ROUND((sum_clicks*100.0/sum_display), 2) as str,
	ROUND(SUM(sum_display) OVER(PARTITION BY placement), 2) AS sum_display,
	ROUND(AVG(sum_conv) OVER(PARTITION BY placement), 2) AS avg_conv_by_plcmnt
FROM
	(SELECT placement, text,
     	SUM(display) AS sum_display,
     	SUM(clicks) AS sum_clicks,
		SUM(conversions) AS sum_conv
	FROM vision_test
	GROUP BY placement, text
	ORDER BY placement) as table_1
 ORDER BY sum_display DESC;

