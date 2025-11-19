USE GradosDB;

SELECT * FROM Grades g
	ORDER BY g.value;

SELECT * FROM Grades g
	WHERE g.value >= 5
	ORDER BY (SELECT s.surname FROM Students s
		WHERE s.studentId = g.studentId)
	DESC;

SELECT * FROM Grades g
	ORDER BY g.value DESC
	LIMIT 5;

SELECT * FROM Grades g
	ORDER BY g.value desc
	LIMIT 5 OFFSET 5;

SELECT * FROM Groups, GroupsStudents, Students;

SELECT * FROM GROUPS g
	JOIN GroupsStudents gs ON (g.groupId = gs.groupId)
	JOIN Students s ON (gs.studentId = s.studentId);

SELECT * FROM GROUPS
	NATURAL JOIN GroupsStudents
	NATURAL JOIN Students;

SELECT s.firstName, s.surname, AVG(g.value)
	FROM Students s JOIN Grades g ON (s.studentId = g.studentId)
	GROUP BY s.studentId;

CREATE OR REPLACE VIEW ViewSubjectGrades AS
	SELECT st.studentId, st.firstName, st.surname,
		sb.subjectId, sb.name, gd.value, gd.gradeCall,
		gp.year
		FROM Students st
		JOIN Grades gd ON (st.studentId = gd.studentId)
		JOIN GROUPS gp ON (gd.groupId = gp.groupId)
		JOIN Subjects sb ON (gp.subjectId = sb.subjectId);

SELECT v.gradeCall, v.name, AVG(v.value) FROM ViewSubjectGrades v
	WHERE v.value >= 5 AND v.year = 2018
	GROUP BY v.gradeCall, v.subjectId;

SELECT v.name, AVG(v.value) FROM ViewSubjectGrades v
	GROUP BY v.name
	HAVING COUNT(*) > 2;

SELECT YEAR(s.birthdate), COUNT(*) FROM students s
	GROUP BY YEAR(s.birthdate);

CREATE OR REPLACE VIEW ViewDegreeStudents AS
	SELECT students.*, degrees.*, Groups.year
	FROM Students
	JOIN groupsstudents ON (students.studentId = groupsstudents.studentId)
	JOIN groups ON (groupsstudents.groupId = groups.groupId)
	JOIN subjects ON (groups.subjectId = subjects.subjectId)
	JOIN degrees ON (subjects.degreeId = degrees.degreeId)
;

SELECT NAME, COUNT(DISTINCT(studentId)) FROM ViewDegreeStudents
	WHERE YEAR = 2019
	GROUP BY degreeId;

SELECT v.firstName, v.surname, MAX(v.value)
	FROM ViewSubjectGrades v
	GROUP BY v.studentId;

CREATE OR REPLACE VIEW ViewSubjectGroups AS
	SELECT sb.*, gp.name AS groupName, gp.activity, gp.year AS groupYear
	FROM subjects sb
	JOIN groups gp ON (sb.subjectId = gp.subjectId);

SELECT v.name, COUNT(*) FROM ViewSubjectGroups v
	WHERE v.groupYear = 2019 AND v.activity = 'Teoría'
	GROUP BY v.subjectId
	ORDER BY COUNT(*) DESC LIMIT 3;

CREATE OR REPLACE VIEW ViewAvgGradeYear AS
	SELECT v.year, AVG(v.value) AS average
	FROM ViewSubjectGrades v
	GROUP BY v.year;

SELECT v.firstName, v.surname, v.year AS yearAvg, AVG(v.value) AS studentAverage
	FROM ViewSubjectGrades v
	GROUP BY v.studentId, v.year
	HAVING (studentAverage > (SELECT vAvg.average
		FROM ViewAvgGradeYear vAvg
		WHERE vAvg.year = yearAvg));

CREATE OR REPLACE VIEW ViewDegreeNumSubject AS
	SELECT s.degreeId, COUNT(*) AS numSubjects
	FROM subjects s
	GROUP BY s.degreeId;

SELECT name FROM subjects s
	JOIN ViewDegreeNumSubject v ON (s.degreeId = v.degreeId)
	WHERE v.numSubjects > 4;

CREATE OR REPLACE VIEW ViewStudentGrade AS
	SELECT s.studentId, g.value
	FROM students s
	JOIN grades g ON (s.studentId = g.studentId);

SELECT s.firstName, s.surname, COUNT(*)
	FROM students s
	JOIN ViewStudentGrade v ON (s.studentId = v.studentId)
	WHERE v.value < 5
	GROUP BY s.studentId;

SELECT * FROM groups g
	ORDER BY g.year DESC
	LIMIT 3 OFFSET 3;

SELECT g.*, s.acronym, d.NAME FROM groups g
	JOIN subjects s ON (g.subjectId = s.subjectId)
	JOIN degrees d ON (s.degreeId = d.degreeId);

CREATE OR REPLACE VIEW ViewStudentGroup AS
	SELECT g.groupId, s.*
	FROM groups g
	JOIN GroupsStudents gs ON (g.groupId = gs.groupId)
	JOIN students s ON (gs.studentId = s.studentId);

SELECT v.groupId, COUNT(DISTINCT(v.accessMethod)) FROM ViewStudentGroup v
	GROUP BY v.groupId;
	
CREATE OR REPLACE VIEW ViewStudentSubjectGrade AS
	SELECT st.studentId, st.firstName, st.surname, sb.subjectId,
		sb.credits AS creditos, g.`value`, gr.`year` AS anyo, g.gradeCall AS convocatoria
		FROM students st
		JOIN grades g ON (st.studentId = g.studentId)
		JOIN groups gr ON (g.groupId = gr.groupId)
		JOIN subjects sb ON (gr.subjectId = sb.subjectId);

-- SELECT * FROM ViewStudentSubjectGrade;

SELECT v.firstName, v.surname, SUM(v.`value`/v.creditos)
	FROM ViewStudentSubjectGrade v
	WHERE v.anyo = 2019 AND v.convocatoria = 1
	GROUP BY v.studentId;