USE GradosDB;

DELIMITER //
CREATE OR REPLACE PROCEDURE pInsertDegree(
	p_name VARCHAR(255),
	p_years INT
)
BEGIN
	INSERT INTO degrees(NAME, years) VALUES
	(p_name, p_years);
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE pUpdateDegree(
	p_degreeId INT,
	p_name VARCHAR(255),
	p_years INT
)
BEGIN
	UPDATE degrees SET
		NAME = p_name,
		years = p_years
	WHERE degreeId = p_degreeId;
END //
DELIMITER ;

-- Crear grado con datos correctos. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_1()
BEGIN
	CALL pCreateDB();
	CALL pPopulatedb();
	CALL pInsertDegree('Grado en Ingeniería de la Salud', 4);
END //
DELIMITER ;

-- Crear grado con nombre vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_2()
BEGIN
	CALL pCreateDB();
	CALL pPopulatedb();
	CALL pInsertDegree(NULL, 4);
END //
DELIMITER ;

-- Crear grado con el mismo nombre que otro ya existente. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_3()
BEGIN
	CALL pCreateDB();
	CALL pPopulatedb();
	CALL pInsertDegree('Grado en Ingeniería de la Salud', 4);
	CALL pInsertDegree('Grado en Ingeniería de la Salud', 4);
END //
DELIMITER ;

-- Crear grado con años incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_4()
BEGIN
	CALL pCreateDB();
	CALL pPopulatedb();
	CALL pInsertDegree('Grado en Ingerniería de la Salud', -1);
END //
DELIMITER ;

-- Actualizar grado con datos correctos. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_5()
BEGIN
	CALL pCreateDB();
	CALL pPopulatedb();
	CALL pUpdateDegree(1, 'Grado en Ingeniería de la Salud', 3);
END //
DELIMITER ;

-- Actualizar grado con nombre a None. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_6()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateDegree(1, NULL, 3);
END //
DELIMITER ;

-- Actualizar grado con el mismo nombre que otro existente. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_7()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateDegree(1, 'Grado en Ingeniería de la Salud', 4);
	CALL pUpdateDegree(2, 'Grado en Ingeniería de la Salud', 4);
END //
DELIMITER ;

-- Actualizar grado con años incorrectos. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_8()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateDegree(1, 'Grado en Ingeniería de la Salud', -1);
END //
DELIMITER ;

-- Eliminar grado. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_9()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertDegree('Grado en Ingeniería de la Salud', 4);
	DELETE FROM degrees WHERE degreeId = 4;
END //
DELIMITER ;

-- Eliminar grado no existente. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_10()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertDegree('Grado en Ingeniería de Software', 4);
	DELETE FROM degrees WHERE degreeId = 9999;
END //
DELIMITER ;

-- Eliminar grado con relaciones. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestDegree_11()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	DELETE FROM degrees WHERE degreeId = 1;
END //
DELIMITER ;

-- Crear grado con datos correctos. (Positiva)
-- CALL pTestDegree_1();
-- Crear grado con nombre vacío. (Negativa)
-- CALL ptestDegree_2();
-- Crear grado con el mismo nombre que otro ya existente. (Negativa)
-- CALL ptestDegree_3();
-- Crear grado con años incorrecto. (Negativa)
-- CALL ptestDegree_4();
-- Actualizar grado con datos correctos. (Positiva)
-- CALL ptestDegree_5();
-- Actualizar grado con nombre a None. (Negativa)
-- CALL ptestDegree_6();
-- Actualizar grado con el mismo nombre que otro existente. (Negativa)
-- CALL ptestDegree_7();
-- Actualizar grado con años incorrectos. (Negativa)
-- CALL ptestDegree_8();
-- Eliminar grado. (Positiva)
-- CALL ptestDegree_9();
-- Eliminar grado no existente. (Negativa)
-- CALL ptestDegree_10();
-- Eliminar grado con relaciones. (Negativa)
-- CALL ptestDegree_11();