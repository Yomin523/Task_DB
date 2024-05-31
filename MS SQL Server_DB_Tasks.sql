-- Задание 3
-- Вывести списки групп по заданному направлению с указание номера группы в формате ФИО, бюджет/внебюджет. Студентов выводить в алфавитном порядке.

SELECT Student.full_name as 'Full name', 
		Groups.group_name as 'Group name', 
		IIF(Student.budget = 1, 'Бюджет', 'Внебюджет') as 'Budget'
FROM Student
JOIN Groups ON Groups.id = Student.group_id
ORDER BY Student.full_name;

 
-- Вывести студентов с фамилией, начинающейся с первой буквы вашей фамилии, с указанием ФИО, номера группы и направления обучения.

SELECT Student.full_name as 'Full name',
		Groups.group_name as 'Group name',
        Directions_of_study.direction_name as 'Direction name'
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
WHERE Student.full_name LIKE 'К%';


-- -- Вывести список студентов для поздравления по месяцам в формате Фамилия И.О., день и название месяца рождения, номером группы и направлением обучения.

SELECT 
CONCAT(LEFT(full_name, CHARINDEX(' ', full_name)),
      CONCAT(LEFT(RIGHT(full_name, LEN(full_name) - CHARINDEX(' ', full_name)), 1), '. '),
      CONCAT(LEFT(RIGHT(full_name, LEN(full_name) - CHARINDEX(' ', full_name, (CHARINDEX(' ', full_name) + 1))), 1), '.')) 
as Name,
DAY(date_of_birth) as Day,
CASE
	WHEN DATENAME(month, date_of_birth) = 'January' 
    	THEN 'January'
    WHEN DATENAME(month, date_of_birth) = 'February' 
    	THEN 'February'
    WHEN DATENAME(month, date_of_birth) = 'March' 
    	THEN 'Март'
    WHEN DATENAME(month, date_of_birth) = 'April' 
    	THEN 'April'
    WHEN DATENAME(month, date_of_birth) = 'May' 
    	THEN 'Май'
    WHEN DATENAME(month, date_of_birth) = 'June' 
    	THEN 'June'
    WHEN DATENAME(month, date_of_birth) = 'July' 
    	THEN 'Июль'
    WHEN DATENAME(month, date_of_birth) = 'August' 
    	THEN 'August'
    WHEN DATENAME(month, date_of_birth) = 'September' 
    	THEN 'September'
    WHEN DATENAME(month, date_of_birth) = 'October' 
    	THEN 'October'
    WHEN DATENAME(month, date_of_birth) = 'November' 
    	THEN 'November'
    WHEN DATENAME(month, date_of_birth) = 'December' 
    	THEN 'December'
END AS Month,
Groups.group_name as [Group name],
Directions_of_study.direction_name as [Direction name]
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
ORDER BY MONTH(date_of_birth);
 

-- -- Вывести студентов с указанием возраста в годах.

SELECT full_name, (YEAR(GETDATE()) - YEAR(date_of_birth)) AS Age
FROM Student;


-- -- Вывести студентов, у которых день рождения в текущем месяце.

SELECT full_name AS Name, date_of_birth AS Birthday
FROM Student
WHERE MONTH(date_of_birth) = MONTH(GETDATE());


-- -- Вывести количество студентов по каждому направлению.

SELECT COUNT(Student.id) as [Students number], Directions_of_study.direction_name as [Direction name]
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY Directions_of_study.direction_name;


-- -- Вывести количество бюджетных и внебюджетных мест по группам. Для каждой группы вывести номер и название направления.

SELECT 
	Groups.group_name, 
    Directions_of_study.direction_name, 
	COUNT(CASE WHEN budget = 1 THEN 1 ELSE 0 END) as number_of_buget 
FROM Student
	JOIN Groups ON Groups.id = Student.group_id
    JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY Groups.group_name, Directions_of_study.direction_name;



-- -- Задание 5
-- -- Вывести списки групп по каждому предмету с указанием преподавателя.

SELECT Disciplines.name, Groups.group_name, Teachers.name
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Directions_of_study ON Directions_of_study.id = DirectionDisciplineTeacher.direction_id
JOIN Groups ON Groups.direction_id = Directions_of_study.id
JOIN Teachers ON Teachers.id = DirectionDisciplineTeacher.teacher_id;


-- -- Определить, какую дисциплину изучает максимальное количество студентов.

SELECT Disciplines.name AS disc_name, COUNT(Student.full_name) AS s_num
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Marks.student_id = Student.id
GROUP BY Disciplines.name
ORDER BY COUNT(Student.full_name) DESC 
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


-- -- Определить сколько студентов обучатся у каждого их преподавателей.

SELECT Teachers.name, COUNT(Student.id) as s_num
FROM Teachers
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Student.id = Marks.student_id
GROUP BY Teachers.name;


-- -- Определить долю сдавших студентов по каждой дисциплине (не оценки или 2 считать не сдавшими).

SELECT Disciplines.name AS disc_name, COUNT(CASE WHEN Marks.mark > 2 THEN 1 ELSE NULL END) AS s_num
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Marks.student_id = Student.id
GROUP BY Disciplines.name
ORDER BY s_num DESC;


-- -- Определить среднюю оценку по предметам (для сдавших студентов)

SELECT Disciplines.name AS disc_name, AVG(CASE WHEN Marks.mark > 2 THEN Marks.mark ELSE NULL END) AS s_avg
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Marks.student_id = Student.id
GROUP BY Disciplines.name
ORDER BY COUNT(Student.full_name) DESC;


-- -- Определить группу с максимальной средней оценкой (включая не сдавших)

SELECT Groups.group_name, AVG(Marks.mark) AS average_mark
FROM Groups
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.direction_id = Directions_of_study.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
GROUP BY Groups.group_name
ORDER BY average_mark DESC
LIMIT 1;


-- -- Вывести студентов со всем оценками отлично и не имеющих несданный экзамен

SELECT Student.full_name, AVG(Marks.mark) AS average_mark
FROM Student
JOIN Marks ON Marks.student_id = Student.id
GROUP BY Student.full_name
HAVING AVG(Marks.mark) = 5.0;


-- -- Вывести кандидатов на отчисление (не сдан не менее двух предметов)

SELECT Student.full_name
FROM Student
JOIN Marks ON Marks.student_id = Student.id
WHERE Marks.mark = 2
GROUP BY Student.full_name
HAVING COUNT(*) > 1;



-- -- Задание 7
-- -- Вывести по заданному предмету количество посещенных занятий.

SELECT COUNT(Attendance.id) AS num_presence 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_schedule ON Lessons_schedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_schedule.id
WHERE Disciplines.name = 'Data analysis' AND Attendance.presence = 1
GROUP BY Attendance.presence;


-- -- Вывести по заданному предмету количество пропущенных занятий.

SELECT COUNT(Attendance.id) AS num_presence 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_schedule ON Lessons_schedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_schedule.id
WHERE Disciplines.name = 'Data analysis' AND Attendance.presence = 0
GROUP BY Attendance.presence;

-- -- • Вывести по заданному преподавателю количество студентов на каждом занятии.

SELECT COUNT(Attendance.id) AS num_presence, DirectionDisciplineTeacher.id
FROM Teachers
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
JOIN Lessons_schedule ON Lessons_schedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_schedule.id
WHERE Teachers.name = 'Kovrigin Alexey Viktorovich' AND Attendance.presence = 1
GROUP BY DirectionDisciplineTeacher.id;


-- -- • Для каждого студента вывести общее время, потраченное на изучение каждого предмета.

SELECT
    Student.id AS student_id,
    Student.full_name AS student_name,
    Directions_of_study.direction_name AS direction_name,
    Disciplines.name AS discipline_name,
    SUM(DATEDIFF(SECOND, Pair_time.time_start, Pair_time.time_end)) AS total_study_time
FROM Student
JOIN Groups ON Student.group_id = Groups.id
JOIN Directions_of_study ON Groups.direction_id = Directions_of_study.id
JOIN DirectionDisciplineTeacher ON Directions_of_study.id = DirectionDisciplineTeacher.direction_id
JOIN Disciplines ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_schedule ON DirectionDisciplineTeacher.id = Lessons_schedule.sub_disc_teach_id
JOIN Pair_time ON Lessons_schedule.time_id = Pair_time.id
JOIN Attendance ON Lessons_schedule.id = Attendance.schedule_id AND Student.id = Attendance.student_id AND Attendance.presence = 1
GROUP BY Student.id, Directions_of_study.id, Disciplines.id;
