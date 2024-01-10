-- Задание 3
-- Вывести списки групп по заданному направлению с указание номера группы в формате ФИО, бюджет/внебюджет. Студентов выводить в алфавитном порядке.

SELECT `Student`.`full_name` as `Full name`, 
		`Groups`.`group_name` as `Group name`, 
		if (`Student`.`budget` = 1, "Бюджет", "Внебюджет") as `Budget`
FROM `Student`
JOIN `Groups` ON `Groups`.`id` = `Student`.`group_id`
ORDER BY `Student`.`full_name`;
 
-- Вывести студентов с фамилией, начинающейся с первой буквы вашей фамилии, с указанием ФИО, номера группы и направления обучения.

SELECT `Student`.`full_name` as `Full name`,
		`Groups`.`group_name` as `Group name`,
        `Directions_of_study`.`direction_name` as `Direction name`
FROM `Student`
JOIN `Groups` ON `Groups`.`id` = `Student`.`group_id`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `Groups`.`direction_id`
WHERE `Student`.`full_name` LIKE "К%";

-- Вывести список студентов для поздравления по месяцам в формате Фамилия И.О., день и название месяца рождения, номером группы и направлением обучения.

SELECT 
CONCAT(LEFT(`full_name`, LOCATE(' ', `full_name`)),
       CONCAT(LEFT(RIGHT(`full_name`, CHAR_LENGTH(`full_name`) - LOCATE(' ', `full_name`)), 1), '. '),
      CONCAT(LEFT(RIGHT(`full_name`, CHAR_LENGTH(`full_name`) - LOCATE(' ', `full_name`, (LOCATE(' ', `full_name`) + 1))), 1), '.')) 
as `Name`,
DAYOFMONTH(`Student`.`date_of_birth`) as `Day`,
CASE
	WHEN MONTHNAME(`Student`.`date_of_birth`) = "January" 
    	THEN "Январь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "February" 
    	THEN "Февраль"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "March" 
    	THEN "Март"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "April" 
    	THEN "Апрель"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "May" 
    	THEN "Май"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "June" 
    	THEN "Июнь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "July" 
    	THEN "Июль"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "August" 
    	THEN "Август"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "September" 
    	THEN "Сентябрь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "October" 
    	THEN "Октябрь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "November" 
    	THEN "Ноябрь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "December" 
    	THEN "Декабрь"
 END AS 'Month',
`Groups`.`group_name` as `Group name`,
`Directions_of_study`.`direction_name` as `Direction name`
FROM `Student`
JOIN `Groups` ON `Groups`.`id` = `Student`.`group_id`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `Groups`.`direction_id`
ORDER BY MONTH(`Student`.`date_of_birth`); 

-- Вывести студентов с указанием возраста в годах.

SELECT full_name, (YEAR(CURRENT_DATE()) - YEAR(date_of_birth)) as Age
FROM Student;

-- Вывести студентов, у которых день рождения в текущем месяце.

SELECT `full_name` as `Name`, `date_of_birth` as `Birthday`
FROM `Student`
WHERE MONTH(`Student`.`date_of_birth`) = MONTH(CURRENT_DATE());

-- Вывести количество студентов по каждому направлению.

SELECT COUNT(`Student`.`id`) as `Students number`, `Directions_of_study`.`direction_name` as `Direction name`
FROM `Student`
JOIN `Groups` ON `Groups`.`id` = `Student`.`group_id`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `Groups`.`direction_id`
GROUP BY `Directions_of_study`.`direction_name`;

-- Вывести количество бюджетных и внебюджетных мест по группам. Для каждой группы вывести номер и название направления.

SELECT 
	Groups.group_name, 
    Directions_of_study.direction_name, 
	COUNT(CASE WHEN budget = true THEN 1 ELSE 0 END) as number_of_buget 
FROM Student
	JOIN Groups ON Groups.id = Student.group_id
    JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY Groups.id


-- Задание 5
-- Вывести списки групп по каждому предмету с указанием преподавателя.

SELECT `Disciplines`.`name`, `Groups`.`group_name`,`Teachers`.`name`
FROM `Disciplines`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`discipline_id` = `Disciplines`.`id`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `DirectionDisciplineTeacher`.`direction_id`
JOIN `Groups` ON `Groups`.`direction_id` = `Directions_of_study`.`id`
JOIN `Teachers` ON `Teachers`.`id` = `DirectionDisciplineTeacher`.`teacher_id`

-- Определить, какую дисциплину изучает максимальное количество студентов.

SELECT `Disciplines`.`name` as `disc_name`, COUNT(`Student`.`full_name`) as `s_num`
FROM `Disciplines`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`discipline_id` = `Disciplines`.`id`
JOIN `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
JOIN `Student` ON `Marks`.`student_id` = `Student`.`id`
GROUP BY `Disciplines`.`name`
ORDER BY COUNT(`Student`.`full_name`) DESC 
LIMIT 1

-- Определить сколько студентов обучатся у каждого их преподавателей.

SELECT `Teachers`.`name`, COUNT(`Student`.`id`) as `s_num`
FROM `Teachers`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`teacher_id` = `Teachers`.`id`
JOIn `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
JOIN `Student` ON `Student`.`id` = `Marks`.`student_id`
GROUP BY `Teachers`.`name`

-- Определить долю сдавших студентов по каждой дисциплине (не оценки или 2 считать не сдавшими).

SELECT `Disciplines`.`name` as `disc_name`, COUNT(IF(`Marks`.`mark` > 2, 1, NULL)) as `s_num`
FROM `Disciplines`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`discipline_id` = `Disciplines`.`id`
JOIN `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
JOIN `Student` ON `Marks`.`student_id` = `Student`.`id`
GROUP BY `Disciplines`.`name`
ORDER BY COUNT(`Student`.`full_name`) DESC

-- Определить среднюю оценку по предметам (для сдавших студентов)

SELECT `Disciplines`.`name` as `disc_name`, AVG(IF(`Marks`.`mark` > 2, `Marks`.`mark`, NULL)) as `s_avg`
FROM `Disciplines`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`discipline_id` = `Disciplines`.`id`
JOIN `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
JOIN `Student` ON `Marks`.`student_id` = `Student`.`id`
GROUP BY `Disciplines`.`name`
ORDER BY COUNT(`Student`.`full_name`) DESC

-- Определить группу с максимальной средней оценкой (включая не сдавших)

SELECT `Groups`.`group_name`, AVG(`Marks`.`mark`) as `average_mark`
FROM `Groups`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `Groups`.`direction_id`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`direction_id` = `Directions_of_study`.`id`
JOIN `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
GROUP BY `Groups`.`group_name`
LIMIT 1

-- Вывести студентов со всем оценками отлично и не имеющих несданный экзамен

SELECT Student.full_name, AVG(Marks.mark)
FROM Student
JOIN Marks ON Marks.student_id = Student.id
GROUP BY Student.full_name
HAVING AVG(Marks.mark) = 5.0;

-- Вывести кандидатов на отчисление (не сдан не менее двух предметов)

SELECT Student.full_name
FROM Student
JOIN Marks ON Marks.student_id = Student.id
WHERE Marks.mark = 2
GROUP BY Student.full_name
HAVING COUNT(*)>1



-- Задание 7
-- Вывести по заданному предмету количество посещенных занятий.

SELECT COUNT(Attendance.id) as num_presense 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Disciplines.name = "Анализ данных" AND Attendance.presense = true
GROUP BY Attendance.presense;

-- Вывести по заданному предмету количество пропущенных занятий.

SELECT COUNT(Attendance.id) as num_presense 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Disciplines.name = "Анализ данных" AND Attendance.presense = false
GROUP BY Attendance.presense;

-- • Вывести по заданному преподавателю количество студентов на каждом занятии.

SELECT COUNT(Attendance.id) as num_presense, DirectionDisciplineTeacher.id
FROM Teachers
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Teachers.name = "Ковригин Алексей Викторович" AND Attendance.presense = true
GROUP BY Lessons_shedule.sub_disc_teach_id;

-- • Для каждого студента вывести общее время, потраченное на изучение каждого предмета.

SELECT
Student.id AS student_id, Student.full_name AS student_name, Directions_of_study.direction_name AS direction_name, Disciplines.name AS discipline_name, 
SUM(TIME_TO_SEC(Pair_time.time_end) - TIME_TO_SEC(Pair_time.time_start)) AS total_study_time
FROM Student
JOIN Groups ON Student.group_id = Groups.id
JOIN Directions_of_study ON Groups.direction_id = Directions_of_study.id
JOIN DirectionDisciplineTeacher ON Directions_of_study.id = DirectionDisciplineTeacher.direction_id
JOIN Disciplines ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_shedule ON DirectionDisciplineTeacher.id = Lessons_shedule.sub_disc_teach_id
JOIN Pair_time ON Lessons_shedule.time_id = Pair_time.id
JOIN Attendance ON Lessons_shedule.id = Attendance.schedule_id AND Student.id = Attendance.student_id AND Attendance.presense = true
GROUP BY Student.id, Directions_of_study.id, Disciplines.id;

