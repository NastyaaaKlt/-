
#Распределение по полу и возрасту всех пользователей, которым показывалась наша реклама
SELECT sex.sex, age.age, SUM(vision_test.display) AS count_show,
    ROUND(SUM(vision_test.display) OVER (PARTITION BY sex.sex) * 100.0 / SUM(vision_test.display) OVER (), 2)  AS percent_too
FROM vision_test 
	INNER JOIN age ON vision_test.age = age.id_age
	INNER JOIN sex ON vision_test.sex = sex.id_sex
GROUP BY sex.sex, age.age;

