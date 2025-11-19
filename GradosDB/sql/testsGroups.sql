USE GradosDB;

DELIMITER //
CREATE OR REPLACE PROCEDURE pInsertGroups(
	g_name VARCHAR(30),
	g_activity VARCHAR(20),
	g_year INT,
	g_subjectId INT
)
BEGIN
	INSERT INTO groups (NAME, activity, YEAR, subjectId) VALUES
	(g_name, g_activity, g_year, g_subject);
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE pUpdateGroups(
	g_groupId INT,
	g_name VARCHAR(30),
	g_activity VARCHAR(20),
	g_year INT,
	g_subject INT
)
BEGIN
	UPDATE groups SET
		NAME = g_name,
		activity = g_activity,
		YEAR = g_year,
		SUBJECT = g_subject
		WHERE groupId = g_groupId;
END//
DELIMITER ;

-- Crear grupo con datos correctos (positivo)
DELIMITER //
CREATE OR REPLACE PROCEDURE testGroups_1()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	
END //
DELIMITER ;

-- Crear grupo con nombre vacío (negativo)
-- Crear grupo con actividad vacía (negativo)
-- Crear grupo con año vacío (negativo)
-- Crear grupo con asignatura vacía (negativo)
-- Crear grupo con nombre, año y asignatura repetidos (negativo)
-- Crear grupo con años inválidos (negativo)
-- Crear grupo con actividad incorrecta (negativo)
-- Actualizar grupo con datos correctos (positivo)
-- Actualizar grupo con nombre vacío (negativo)
-- Actualizar grupo con actividad vacía (negativo)
-- Actualizar grupo con año vacío (negativo)
-- Actualizar grupo con asignatura vacía (negativo)
-- Actualizar grupo con nombre, año y asignatura repetidos (negativo)
-- Actualizar grupo con años inválidos (negativo)
-- Actualizar grupo con actividad incorrecta (negativo)
-- Borrar grupo (positivo)
-- Borrar grupo inexistente (negativo sin excepción)
-- Borrar grupo con relaciones (negativo)


-- Crear grupo con datos correctos (positivo)
-- Crear grupo con nombre vacío (negativo)
-- Crear grupo con actividad vacía (negativo)
-- Crear grupo con año vacío (negativo)
-- Crear grupo con asignatura vacía (negativo)
-- Crear grupo con nombre, año y asignatura repetidos (negativo)
-- Crear grupo con años inválidos (negativo)
-- Crear grupo con actividad incorrecta (negativo)
-- Actualizar grupo con datos correctos (positivo)
-- Actualizar grupo con nombre vacío (negativo)
-- Actualizar grupo con actividad vacía (negativo)
-- Actualizar grupo con año vacío (negativo)
-- Actualizar grupo con asignatura vacía (negativo)
-- Actualizar grupo con nombre, año y asignatura repetidos (negativo)
-- Actualizar grupo con años inválidos (negativo)
-- Actualizar grupo con actividad incorrecta (negativo)
-- Borrar grupo (positivo)
-- Borrar grupo inexistente (negativo sin excepción)
-- Borrar grupo con relaciones (negativo)