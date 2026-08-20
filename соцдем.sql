
#Распределение по полу всех пользователей, которым показывалась наша реклама
SELECT sex.sex, SUM(display) AS count_people_views, ROUND(SUM(display)*100.0/(SELECT SUM(display) FROM vision_test), 2) AS percent
FROM vision_test
	INNER JOIN sex ON vision_test.sex = sex.id_sex
GROUP BY sex.sex;

#Распределение по полу и возрасту




