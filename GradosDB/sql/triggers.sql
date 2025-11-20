USE GradosDB;


-- DELIMITER //
-- CREATE OR REPLACE TRIGGER rn_001triggerWithHonours
-- BEFORE INSERT ON grades
-- FOR EACH ROW
-- BEGIN
--	IF (NEW.withHonours = 1 AND NEW.value < 9.0) THEN
--		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
--		'You cannot insert a grade with honours whose value is less than 9';
--	END if;
-- END //
-- DELIMITER ;


DELIMITER //

CREATE OR REPLACE PROCEDURE pWithHonours (withHonours INT, VALUE DECIMAL(4,2))
BEGIN
	IF (withHonours = 1 AND VALUE < 9,0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
		'A grade with honours can not have a value less than 9.0';
	END if;
END //

CREATE OR REPLACE TRIGGER rn001i_triggerWithHonours
BEFORE INSERT ON grades
FOR EACH ROW
BEGIN
	CALL pWithHonours (NEW.withHonours, NEW.value);
END //

CREATE OR REPLACE TRIGGER rn001u_triggerWithHonours
BEFORE UPDATE ON grades
FOR EACH ROW
BEGIN
	CALL pWithhonours (NEW.withHonours, NEW.value);
END //

DELIMITER ;

-- DELIMITER //

-- CREATE OR REPLACE TRIGGER rn004_triggerGradeStudentGroup
-- BEFORE INSERT ON grades
-- FOR EACH ROW
-- BEGIN
--	DECLARE isInGroup INT;
--	SET isInGroup = (SELECT COUNT(*)
--		FROM groupsstudents
--			WHERE studentId = NEW.studentId AND groupid = NEW.groupId);
--	IF (isInGroup < 1) THEN
--		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
--		'A student can not have grades for groups in which they are not registered';
--	END if;
-- END //

-- DELIMITER ;


DELIMITER //

CREATE OR REPLACE PROCEDURE pGradeStudentGroup (estudianteid INT, grupoId INT)
BEGIN
	DECLARE isInGroup INT;
	SET isInGroup = (SELECT COUNT(*)
		FROM groupsstudents
			WHERE studentId = estudianteid AND groupid = grupoId);
	IF (isInGroup < 1) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
		'A student can not have grades for groups in which they are not registered';
	END if;
END //

CREATE OR REPLACE TRIGGER rn004i_triggerGradeStudentGroup
BEFORE INSERT ON grades
FOR EACH ROW
BEGIN
	CALL pGradeStudentGroup(NEW.studentid, NEW.groupId);
END //

CREATE OR REPLACE TRIGGER rn004u_triggerGradeStudentGroup
BEFORE UPDATE ON grades
FOR EACH ROW
BEGIN
	CALL pGradeStudentGroup(NEW.studentid, NEW.groupId);
END //

DELIMITER ;

DELIMITER //

-- CREATE OR REPLACE TRIGGER rn005_triggerGradesChangeDifference
-- BEFORE UPDATE ON grades
-- FOR EACH ROW
-- BEGIN
-- 	DECLARE difference DECIMAL(4,2);
-- 	DECLARE student ROW TYPE OF students;
-- 	SET difference = NEW.value - OLD.value;
-- 	IF (difference > 4) THEN
-- 		SELECT * INTO student FROM students WHERE studentId = NEW.studentId;
-- 		SET @error_message = CONCAT('You can not add ', difference,
-- 		' points to a grade for the student ', student.firstName, ' ', student.surname);
-- 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
-- 	END if;
-- END //


CREATE OR REPLACE TRIGGER rn005_triggerGradesChangeDifference
BEFORE UPDATE ON grades
FOR EACH ROW
BEGIN
	DECLARE difference DECIMAL(4,2);
	SET difference = NEW.value - OLD.value;
	IF (difference > 4) THEN
		SET NEW.value = OLD.value + 4;
	END if;
END //

DELIMITER ;
-- RN-003, que evita que un alumno que accede por selectividad tenga menos de 16 años.
DELIMITER //

CREATE OR REPLACE TRIGGER rn003i_alumnoSelectividadMenor
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
	CALL pAlumnoSelectividadMenor(NEW.accessMethod, NEW.birthdate);
END //

CREATE OR REPLACE TRIGGER rn003u_alumnoSelectividadMenor
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
	CALL pAlumnoSelectividadMenor(NEW.accessMethod, NEW.birthdate);
END //

CREATE OR REPLACE FUNCTION menor16 (fechaNacimiento DATE) RETURNS BOOLEAN
BEGIN
	DECLARE menor BOOLEAN;
	SET menor = TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) < 16;
	RETURN menor;
END //

CREATE OR REPLACE PROCEDURE pAlumnoSelectividadMenor(metodoAcceso VARCHAR(30), fechaNacimiento DATE)
BEGIN
	IF (metodoAcceso = 'Selectividad' AND menor16(fechaNacimiento)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
		'Un alumno que entra por selectividad no puede tener menos de 16 años';
	END if;
END //

DELIMITER ;

-- RN-006, que evita que un grupo de teoría tenga mas de 75 alumnos y uno de laboratorio más de 25.

DELIMITER //

CREATE OR REPLACE TRIGGER rn006i_grupoTeoriaLaboratorioMaximaCapacidad
BEFORE INSERT ON groups
FOR EACH ROW
BEGIN
	CALL pGrupoTeoriaLaboratorioMaximaCapacidad(NEW.groupId, NEW.activity);
END //

CREATE OR REPLACE TRIGGER rn006u_grupoTeoriaLaboratorioMaximaCapacidad
BEFORE UPDATE ON groups
FOR EACH ROW
BEGIN
	CALL pGrupoTeoriaLaboratorioMaximaCapacidad(NEW.groupId, NEW.activity);
END //

CREATE OR REPLACE PROCEDURE pGrupoTeoriaLaboratorioMaximaCapacidad(grupoId INT, actividad VARCHAR(30))
BEGIN
	DECLARE aforo INT;
	SET aforo = (SELECT COUNT(*) FROM groupsstudents WHERE groupId = grupoId);
	IF (aforo > 75 AND actividad = 'Teoría') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
		'Un grupo de teoría no puede tener más de 75 alumnos';
	END if;
	IF (aforo > 25 AND actividad = 'Laboratorio') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
		'Un grupo de laboratorio puede tener más de 25 alumnos';
	END if;
END //

DELIMITER ;

-- RN-007, que evita que un alumno pertenezca a más de un grupo de teoría y a más de un grupo de laboratorio de la misma asignatura.
DELIMITER //

CREATE OR REPLACE TRIGGER rn007i_alumnoMaximoUnGrupoTeoriaLaboratorio
BEFORE INSERT ON groupsstudents
FOR EACH ROW
BEGIN
	CALL pAlumnoMaximoUnGrupoTeoriaLaboratorio(NEW.studentId, NEW.groupId);
END //

CREATE OR REPLACE TRIGGER rn007u_alumnoMaximoUnGrupoTeoriaLaboratorio
BEFORE UPDATE ON groupsstudents
FOR EACH ROW
BEGIN
	CALL pAlumnoMaximoUnGrupoTeoriaLaboratorio(NEW.studentid, NEW.groupId);
END //

CREATE OR REPLACE PROCEDURE pAlumnoMaximoUnGrupoTeoriaLaboratorio(estudianteId INT, grupoId INT)
BEGIN
	DECLARE asignatura INT;
	DECLARE veracidadLab INT;
	DECLARE veracidadTeo INT;
	SET asignatura = (SELECT subjectId FROM groups WHERE groupId = grupoId);
	SET veracidadLab = (SELECT COUNT(*)
		FROM students st
		JOIN groupsstudents gs ON (st.studentId = gs.studentId)
		JOIN groups g ON (gs.groupId = g.groupId)
		JOIN subjects sb ON (g.subjectId = sb.subjectId)
		WHERE (studentId = estudiabteId AND subjectId = asignatura AND activity = 'Laboratorio'));
	SET veracidadTeo = (SELECT COUNT(*)
		FROM students st
		JOIN groupsstudents gs ON (st.studentId = gs.studentId)
		JOIN groups g ON (gs.groupId = g.groupId)
		JOIN subjects sb ON (g.subjectId = sb.subjectId)
		WHERE (studentId = estudiabteId AND subjectId = asignatura AND activity = 'Teoría'));
	IF (veracidadLab >= 1) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
		'Un alumno no puede pertenecer a más de un grupo de laboratorio de la misma asignatura';
		END if;
	IF (veracidadTeo >= 1) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =
		'Un alumno no puede pertenecer a más de un grupo de teoría de la misma asignatura';
		END if;
END //

DELIMITER ;