USE GradosDB;

INSERT INTO DEGREES VALUES (NULL, 'Tecnologías Informáticas', 4);
 
INSERT INTO DEGREES (NAME, years) VALUES
 	('Ingeniería del Software', 4),
 	('Ingeniería de Computadores', 4);
 	
INSERT INTO Subjects (NAME, acronym, credits, YEAR, TYPE, degreeId) VALUES
	('Fundamentos de Programación', 'FP', 12, 1, 'Formacion Básica', 3),
	('Lógica Informática', 'LI', 6, 2, 'Optativa', 3);
	
INSERT INTO Groups (name, activity, year, subjectId) VALUES
	('T1', 'Teoría', 2019, 1),
	('L1', 'Laboratorio', 2019, 1),
	('L2', 'Laboratorio', 2019, 1);
	
INSERT INTO Students (accessMethod, dni, firstname, surname, birthdate, email, password) VALUES
	('Selectividad', '12345678A', 'Daniel', 'Pérez', '1991-01-01', 
		'daniel@alum.us.es', 'password1'),
	('Selectividad', '22345678A', 'Rafael', 'Ramírez', '1992-01-01', 
		'rafael@alum.us.es', 'password2'),
	('Selectividad', '32345678A', 'Gabriel', 'Hernández', '1993-01-01', 
		'gabriel@alum.us.es', 'password3');

INSERT INTO GroupsStudents (groupId, studentId) VALUES
	(1, 1),
	(3, 1);
	
INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
	(4.50, 1, 0, 1, 1),
	(5.00, 1, 0, 2, 1),
	(6.00, 1, 0, 3, 1),
	(7.00, 2, 0, 1, 1),
	(9.00, 2, 1, 2, 1),
	(9.00, 2, 0, 3, 1),
	(10.00, 3, 0, 1, 3),
	(5.50, 3, 0, 2, 3),
	(6.00, 2, 1, 3, 3);
	
UPDATE Students
	SET birthdate  = '1998-01-01', surname = 'Fernández'
	WHERE studentId=3;

UPDATE Subjects
	SET credits = credits / 2;
	
DELETE FROM Grades
	WHERE gradeId = 1;

SELECT s.firstName, s.surname
	FROM Students s
	WHERE accessMethod = 'Selectividad';

SELECT s.credits>3
	FROM Subjects s;

SELECT AVG(s.credits)
	FROM subjects s;

SELECT AVG(s.credits), SUM(s.credits), s.name
	FROM subjects s;
	
SELECT COUNT(*)
	FROM Subjects s
	WHERE s.credits>4;

SELECT COUNT(DISTINCT s.accessMethod)
	FROM Students s;

CREATE OR REPLACE VIEW vGradesGroup1 AS
	SELECT * FROM grades g WHERE g.groupId = 1;

SELECT MAX(v.value) FROM vGradesGroup1 v;

SELECT COUNT(*) FROM vGradesGroup1 v;

SELECT * FROM vGradesGroup1 v WHERE v.gradeCall = 1;

CREATE OR REPLACE VIEW vGradesGroupCall1 AS
	SELECT * FROM vGradesGroup1 v WHERE v.gradeCall = 1;

SELECT * FROM vGradesGroupCall1;