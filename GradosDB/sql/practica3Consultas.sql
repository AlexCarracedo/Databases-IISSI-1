USE GradosDB;

SELECT * FROM Subjects s;

SELECT * FROM Subjects s
	WHERE s.acronym = 'FP';

SELECT s.NAME, s.acronym FROM Subjects s;

SELECT AVG(g.value) FROM grades g
	WHERE g.groupId = 18;

SELECT SUM(s.credits) FROM subjects s
	WHERE s.degreeId = 3;

SELECT * FROM grades g
	WHERE g.value <= 4 OR g.value >= 6;

SELECT DISTINCT g.name FROM groups g;

SELECT MAX(g.value) FROM grades g
	WHERE g.studentId = 1;

SELECT * FROM Students s
	WHERE s.surname IN (SELECT sb.acronym FROM Subjects sb);

SELECT DISTINCT(gs.studentId) FROM GroupsStudents gs
	WHERE gs.groupId IN (SELECT g.groupId FROM groups g WHERE g.year = 2019);

SELECT * FROM students s
	WHERE s.dni LIKE('%C');

SELECT * FROM students s
	WHERE s.firstname LIKE('______');

SELECT * FROM Students s
	WHERE YEAR(s.birthDate) < 1995;

SELECT * FROM Students s
	WHERE (MONTH(s.birthDate) >= 1 AND MONTH(s.birthDate) <= 2);

SELECT s.name FROM Subjects s
	WHERE s.`TYPE` = 'Obligatoria';

SELECT AVG(g.value) FROM Grades g
	WHERE g.groupId = 19;

SELECT SUM(g.value)/COUNT(g.value) FROM grades g
	WHERE g.groupId = 19;

SELECT COUNT(DISTINCT g.name) FROM GROUPS g;

SELECT * FROM Grades g
	WHERE g.value >= 4 AND g.value <= 6;

SELECT * FROM Grades g
	WHERE g.value >= 9 AND g.withHonours = FALSE;

CREATE OR REPLACE VIEW vGradesWithHonours AS
	SELECT * FROM Grades v WHERE v.withHonours = TRUE;

SELECT * FROM vGradesWithHonours;