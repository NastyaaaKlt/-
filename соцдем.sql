
#Распределение по полу всех пользователей, которым показывалась наша реклама
SELECT sex.sex, SUM(display) AS count_people_views, ROUND(SUM(display)*100.0/(SELECT SUM(display) FROM vision_test), 2) AS percent
FROM vision_test
	INNER JOIN sex ON vision_test.sex = sex.id_sex
GROUP BY sex.sex;

#Распределение по полу и возрасту
SELECT sex, age, number_by_age, number_by_sex, ROUND(number_by_age*100.0/number_by_sex, 2) AS percent
FROM
(SELECT sex.sex AS sex, age.age AS age, SUM(display) AS number_by_age,
	CASE
    	WHEN sex.sex = 'Женский' THEN (SELECT SUM(display) FROM vision_test WHERE sex = 1)
        when sex.sex = 'Мужской' THEN (SELECT SUM(display) FROM vision_test WHERE sex = 2)
        ELSE (SELECT SUM(display) FROM vision_test WHERE sex = 3)
       END AS number_by_sex
FROM vision_test
	INNER JOIN sex ON vision_test.sex = sex.id_sex
    INNER JOIN age ON vision_test.age = age.id_age
group by sex.sex, age.age);




