USE GradosDB;

DELIMITER //
CREATE OR REPLACE PROCEDURE pInsertSubject(
	p_name VARCHAR(100),
	p_acronym VARCHAR(8),
	p_credits INT,
	p_year INT,
	p_type VARCHAR(20),
	p_degreeId INT
)
BEGIN
	INSERT INTO subjects (NAME, acronym, credits, YEAR, TYPE, degreeId) VALUES
	(p_name, p_acronym, p_credits, p_year, p_type, p_degreeId);
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE pUpdateSubject(
	p_subjectId INT,
	p_name VARCHAR(100),
	p_acronym VARCHAR(8),
	p_credits INT,
	p_year INT,
	p_type VARCHAR(20),
	p_degreeId INT
)
BEGIN
	UPDATE subjects SET
		NAME = p_name,
		acronym = p_acronym,
		credits = p_credits,
		YEAR = p_year,
		TYPE = p_type,
		degreeId = p_degreeId
	WHERE subjectId = p_subjectId;
END //
DELIMITER ;

-- Crear asignatura con datos correctos. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_1()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Informática', 'FI', 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Crear asignatura con nombre vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_2()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject(NULL, 'FI', 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Crear asignatura con el mismo nombre que otra ya existente. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_3()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Informática', 'FI', 6, 1, 'Obligatoria', 1);
	CALL pInsertSubject('Física Informática', 'FI2', 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Crear asignatura con acrónimo vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_4()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Infomrática', NULL, 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Crear asignatura con el mismo acrónimo que una ya existente. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_5()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Informática', 'FI', 6, 1, 'Obligatoria', 1);
	CALL pInsertSubject('Fundamentos de la Informática', 'FI', 12, 1, 'Formación Básica', 1);
END //
DELIMITER ;

-- Crear asignatura con créditos incorrectos. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_6()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Informática', 'FI', -1, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Crear asignatura con curso incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_7()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Informática', 'FI', 6, 7, 'Obligatoria', 1);
END //
DELIMITER ;

-- Crear asignatura con tipo incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_8()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Informática', 'FI', 6, 1, 'Incorrecto', 1);
END //
DELIMITER ;

-- Actualizar asignatura con valores correctos. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_9()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateSubject(1, 'Física Infromática', 'FI', 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Actualizar asignatura con el mismo nombre que otra. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_10()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Informática', 'FI', 6, 1, 'Obligatoria', 1);
	CALL pUpdateSubject(1, 'Física Informática', 'FI2', 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Actualizar asignatura con nombre a None. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_11()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateSubject(1, NULL, 'FI', 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Actualizar asignatura con el mismo acrónimo que otra. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_12()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Infromática', 'FI', 6, 1, 'Obligatoria', 1);
	CALL pUpdateSubject(2, 'Fundamentos de la Informática', 'FI', 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Actualizar asignatura con acrónimo a None. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_13()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateSubject(1, 'Física Informática', NULL, 6, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Actualizar asignatura con créditos incorrectos. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_14()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateSubject(1, 'Física Informática', 'FI', -1, 1, 'Obligatoria', 1);
END //
DELIMITER ;

-- Actualizar asignatura con curso incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_15()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateSubject(1, 'Física Informática', 'FI', 6, 7, 'Obligatoria', 1);
END //
DELIMITER ;

-- Actualizar asignatura con tipo incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_16()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateSubject(1, 'Física Informática', 'FI', 6, 1, 'Incorrecto', 1);
END //
DELIMITER ;

-- Borrar asignatura. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_17()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	DELETE FROM subjects WHERE subjectId = 3;
END //
DELIMITER ;

-- Borrar asignatura que ha sido borrada. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_18()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	DELETE FROM subjects WHERE subjectId = 3;
	DELETE FROM subjects WHERE subjectId = 3;
END //
DELIMITER ;

-- Borrar asignatura con relaciones. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_19()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	DELETE FROM subjects WHERE subjectId = 1;
END //
DELIMITER ;

-- Crear una asignación entre grado y asignatura, con grado a None. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_20()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertSubject('Física Informática', 'FI', 6, 1, 'Obligatoria', NULL);
END //
DELIMITER ;

-- Actualizar una asignación entre grado y asignatura, con grado a None. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestSubjects_21()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateSubject(1, 'Física Informática', 'FI', 6, 1, 'Obligatoria', NULL);
END //
DELIMITER ;

-- Crear asignatura con datos correctos. (Positiva)
-- CALL pTestSubjects_1();
-- Crear asignatura con nombre vacío. (Negativa)
-- CALL pTestSubjects_2();
-- Crear asignatura con el mismo nombre que otra ya existente. (Negativa)
-- CALL pTestSubjects_3();
-- Crear asignatura con acrónimo vacío. (Negativa)
-- CALL pTestSubjects_4();
-- Crear asignatura con el mismo acrónimo que una ya existente. (Negativa)
-- CALL pTestSubjects_5();
-- Crear asignatura con créditos incorrectos. (Negativa)
-- CALL pTestSubjects_6();
-- Crear asignatura con curso incorrecto. (Negativa)
-- CALL pTestSubjects_7();
-- Crear asignatura con tipo incorrecto. (Negativa)
-- CALL pTestSubjects_8();
-- Actualizar asignatura con valores correctos. (Positiva)
-- CALL pTestSubjects_9();
-- Actualizar asignatura con el mismo nombre que otra. (Negativa)
-- CALL pTestSubjects_10();
-- Actualizar asignatura con nombre a None. (Negativa)
-- CALL pTestSubjects_11();
-- Actualizar asignatura con el mismo acrónimo que otra. (Negativa)
-- CALL pTestSubjects_12();
-- Actualizar asignatura con acrónimo a None. (Negativa)
-- CALL pTestSubjects_13();
-- Actualizar asignatura con créditos incorrectos. (Negativa)
-- CALL pTestSubjects_14();
-- Actualizar asignatura con curso incorrecto. (Negativa)
-- CALL pTestSubjects_15();
-- Actualizar asignatura con tipo incorrecto. (Negativa)
-- CALL pTestSubjects_16();
-- Borrar asignatura. (Positiva)
-- CALL pTestSubjects_17();
-- Borrar asignatura que ha sido borrada. (Negativa)
-- CALL pTestSubjects_18();
-- Borrar asignatura con relaciones. (Negativa)
-- CALL pTestSubjects_19();
-- Crear una asignación entre grado y asignatura, con grado a None. (Negativa)
-- CALL pTestSubjects_20();
-- Actualizar una asignación entre grado y asignatura, con grado a None. (Negativa)
-- CALL pTestSubjects_21();