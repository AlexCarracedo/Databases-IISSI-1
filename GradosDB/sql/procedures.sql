USE GradosDB;

/*
DELIMITER //
CREATE OR REPLACE PROCEDURE procDeleteGrades (studentDni CHAR(9))
BEGIN
	DECLARE id INT;
	SET id = (SELECT studentId s FROM students s WHERE s.dni = studentDni);
	DELETE FROM grades WHERE studentId = id;
END //
DELIMITER ;

CALL procDeleteGrades ('12345678A');

DELIMITER //
CREATE  OR REPLACE PROCEDURE procDeleteData()
BEGIN
	DELETE FROM grades;
	DELETE FROM groupsstudents;
	DELETE FROM students;
	DELETE FROM grades;
	DELETE FROM subjects;
	DELETE FROM degrees;
END //
DELIMITER ;

CALL procDeleteData;
*/

DELIMITER //
CREATE OR REPLACE PROCEDURE rf_001agnadirNotaAlumno (nombregrupo VARCHAR(30),
	actividadgrupo VARCHAR(20), anyoGrupo INT, nombreAsignatura VARCHAR(100), studentDni CHAR(9), valorNota DECIMAL(4,2), convocatoria INT, honores BOOLEAN)
BEGIN
	DECLARE alumnoId INT;
	DECLARE grupoId INT;
	SET alumnoId = (SELECT studentId s FROM students s WHERE s.dni = studentDni);
	SET grupoId = (SELECT groupId
		FROM groups g
		JOIN subjects sb ON (g.subjectId = sb.subjectId)
		WHERE nombregrupo = g.`name` AND actividadgrupo = g.activity AND anyogrupo = g.`year` AND nombreAsignatura = sb.`name`);
	INSERT INTO grades (studentId, groupId, VALUE, gradeCall, withHonours) VALUES
		(alumnoId, grupoId, valorNota, convocatoria, honores);
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE FUNCTION avgGrade(studentId INT) RETURNS DOUBLE
BEGIN
	DECLARE avgStudentGrade DOUBLE;
	SET avgStudentGrade = (SELECT AVG(VALUE) FROM grades
		WHERE grades.studentId = studentId);
	RETURN avgStudentGrade;
END //
DELIMITER ;
/*
SELECT avgGrade(2);
SELECT s.firstName, s.surname, avgGrade(s.studentId) FROM students s;
*/

-- RF-003: Obtener un listado de alumnos por orden alfabético con nombre, apellidos, asignatura y grupo.
DELIMITER //
CREATE OR REPLACE PROCEDURE rf_003alumnosAsignaturaGrupoordenAlfabetico()
BEGIN
	SELECT s.firstName, s.surname, sb.subjectId, g.groupId
		FROM students s
		JOIN groupsstudents gs ON (s.studentId = gs.studentId)
		JOIN groups g ON (gs.groupId = g.groupId)
		JOIN subjects sb ON (g.subjectId = sb.subjectId)
		ORDER BY s.firstName;
END //
DELIMITER ;

-- RF-004: Obtener un listado de los alumnos cuyo método de acceso sea mayor de 40 años (Mayor).
DELIMITER //
CREATE OR REPLACE PROCEDURE rf_004alumnosMayor()
BEGIN
	SELECT * FROM students WHERE students.accessMethod = 'Mayor';
END //
DELIMITER ;

-- RF-005: Obtener las asignaturas (nombre, acrónimo, créditos y tipo) de un grado para un curso concreto ordenadas por el acrónimo.
DELIMITER //
CREATE OR REPLACE PROCEDURE rf_005asignaturasGradoCursoOrdenadas (grade INT, curso INT)
BEGIN
	SELECT s.name, s.acronym, s.credits, s.type FROM Subjects s
		WHERE s.degreeId = grade AND s.year = curso
		ORDER BY s.acronym;
END //
DELIMITER ;

-- RF-006: Obtener, por DNI, las notas finales de cada asignatura que ha cursado un alumno, es decir, las de mayor año y convocatoria.
DELIMITER //
CREATE OR REPLACE PROCEDURE rf_006NotasFinalesAsignaturaAlumno (studentDni CHAR(9))
BEGIN
	SELECT v1.gradeId, v1.VALUE, v1.gradecall, v1.withHonours, v1.studentId, v1.groupId, v1.YEAR, v1.subjectId
		FROM (SELECT v3.*, v4.maximo
			FROM (SELECT g.*, gr.`year`, gr.subjectId
				FROM (SELECT * FROM students st
					WHERE st.dni = studentDni) s
				JOIN grades g ON (s.studentId = g.studentId)
				JOIN groups gr ON (g.groupId = gr.groupId)) v3
			JOIN (SELECT v.subjectId, MAX(v.`year`) AS maximo
				FROM (SELECT g.*, gr.`year`, gr.subjectId
					FROM (SELECT * FROM students st
						WHERE st.dni = studentDni) s
					JOIN grades g ON (s.studentId = g.studentId)
					JOIN groups gr ON (g.groupId = gr.groupId)) v
				GROUP BY v.subjectId) v4
				ON (v3.subjectId = v4.subjectId)
			WHERE `year` = maximo) v1
		JOIN (SELECT w.subjectId, MAX(w.gradeCall) AS maxima
			FROM (SELECT v5.*, v6.maximo
				FROM (SELECT g.*, gr.`year`, gr.subjectId
					FROM (SELECT * FROM students st
						WHERE st.dni = studentDni) s
					JOIN grades g ON (s.studentId = g.studentId)
					JOIN groups gr ON (g.groupId = gr.groupId)) v5
				JOIN (SELECT z.subjectId, MAX(z.`year`) AS maximo
					FROM (SELECT g.*, gr.`year`, gr.subjectId
						FROM (SELECT * FROM students st
							WHERE st.dni = studentDni) s
						JOIN grades g ON (s.studentId = g.studentId)
						JOIN groups gr ON (g.groupId = gr.groupId)) z
					GROUP BY z.subjectId) v6
					ON (v5.subjectId = v6.subjectId)
				WHERE `year` = maximo) w
			GROUP BY w.subjectId) v2
			ON (v1.subjectId = v2.subjectId)
		WHERE gradeCall = maxima;
		END //
DELIMITER ;

-- RF-008: Obtener un listado de las asignaturas de un grado.
DELIMITER //
CREATE OR REPLACE PROCEDURE rf_008ListadoAsignaturasGrado (gradoId INT)
BEGIN
	SELECT *
		FROM subjects s
		WHERE s.degreeId = gradoId;
END //
DELIMITER ;