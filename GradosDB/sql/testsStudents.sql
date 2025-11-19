USE GradosDB;

DELIMITER //
CREATE OR REPLACE PROCEDURE pInsertStudent(
	s_accessMethod VARCHAR(30),
	s_dni CHAR(9),
	s_firstName VARCHAR(100),
	s_surname VARCHAR(100),
	s_birthdate DATE,
	s_email VARCHAR(250),
	s_password VARCHAR(250)
)
BEGIN
	INSERT INTO students (accessMethod, dni, firstName, surname, birthdate, email, PASSWORD) VALUES
		(s_accessMethod, s_dni, s_firstName, s_surname, s_birthdate, s_email, s_password);
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE pUpdateStudent(
	s_studentId INT,
	s_accessMethod VARCHAR(30),
	s_dni CHAR(9),
	s_firstName VARCHAR(100),
	s_surname VARCHAR(100),
	s_birthdate DATE,
	s_email VARCHAR(250),
	s_password VARCHAR(250)
)
BEGIN
	UPDATE students SET
		accessMethod = s_accessMethod,
		dni = s_dni,
		firstName = s_firstName,
		surname = s_surname,
		birthdate = s_birthdate,
		email = s_email,
		PASSWORD = s_password
	WHERE studentId = s_studentId;
END //
DELIMITER ;

-- Crear alumno con datos correctos. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_1()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Selectividad', '12345678F', 'David', 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Crear alumno con el mismo DNI que otro. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_2()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Selectividad', '12345678A', 'David', 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Crear alumno con el mismo email que otro. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_3()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Selectividad', '12345678F', 'Daniel', 'Ruiz', '2000-01-01', 'daniel@alum.us.es', 'passsword1');
END //
DELIMITER ;

-- Crear alumno con formato de fecha de nacimiento incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_4()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Selectividad', '12345678F', 'David', 'Ruiz', '2000-01-32', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Crear alumno con método de acceso incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_5()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Incorrecto', '12345678F', 'David', 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Crear alumno con nombre vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_6()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Selectividad', '12345678F', NULL, 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Crear alumno con apellidos vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_7()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Selectividad', '12345678F', 'David', NULL, '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Crear alumno con email vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_8()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Selectividad', '12345678F', 'David', 'Ruiz', '2000-01-01', NULL, 'passsword1');
END //
DELIMITER ;

-- Crear alumno con DNI vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_9()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pInsertStudent('Selectividad', NULL, 'David', 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con datos correctos. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_10()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(1, 'Selectividad', '12345678F', 'David', 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con el mismo DNI que otro. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_11()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(2, 'Selectividad', '12345678A', 'David', 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con el mismo email que otro. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_12()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(2, 'Selectividad', '12345678F', 'Daniel', 'Ruiz', '2000-01-01', 'daniel@alum.us.es', 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con formato de fecha de nacimiento incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_13()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(1, 'Selectividad', '12345678F', 'David', 'Ruiz', '2000-01-32', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con método de acceso incorrecto. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_14()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(1, 'Incorrecto', '12345678F', 'David', 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con nombre vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_15()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(1, 'Selectividad', '12345678F', NULL, 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con apellidos vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_16()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(1, 'Selectividad', '12345678F', 'David', NULL, '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con email vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_17()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(1, 'Selectividad', '12345678F', 'David', 'Ruiz', '2000-01-01', NULL, 'passsword1');
END //
DELIMITER ;

-- Actualizar alumno con DNI vacío. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_18()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	CALL pUpdateStudent(1, 'Selectividad', NULL, 'David', 'Ruiz', '2000-01-01', 'david.ruiz@example.com', 'passsword1');
END //
DELIMITER ;

-- Borrar alumno. (Positiva)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_19()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	DELETE FROM students WHERE studentId = 3;
END //
DELIMITER ;

-- Borrar alumno que no existe. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_20()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	DELETE FROM students WHERE studentId = 9999;
END //
DELIMITER ;

-- Borrar alumno con relaciones. (Negativa)
DELIMITER //
CREATE OR REPLACE PROCEDURE pTestStudents_21()
BEGIN
	CALL pCreateDB();
	CALL pPopulateDB();
	DELETE FROM students WHERE studentId = 1;
END //
DELIMITER ;



-- Crear alumno con datos correctos. (Positiva)
-- CALL pTestStudents_1();
-- Crear alumno con el mismo DNI que otro. (Negativa)
-- CALL pTestStudents_2();
-- Crear alumno con el mismo email que otro. (Negativa)
-- CALL pTestStudents_3();
-- Crear alumno con formato de fecha de nacimiento incorrecto. (Negativa)
-- CALL pTestStudents_4();
-- Crear alumno con método de acceso incorrecto. (Negativa)
-- CALL pTestStudents_5();
-- Crear alumno con nombre vacío. (Negativa)
-- CALL pTestStudents_6();
-- Crear alumno con apellidos vacío. (Negativa)
-- CALL pTestStudents_7();
-- Crear alumno con email vacío. (Negativa)
-- CALL pTestStudents_8();
-- Crear alumno con DNI vacío. (Negativa)
-- CALL pTestStudents_9();
-- Actualizar alumno con datos correctos. (Positiva)
-- CALL pTestStudents_10();
-- Actualizar alumno con el mismo DNI que otro. (Negativa)
-- CALL pTestStudents_11();
-- Actualizar alumno con el mismo email que otro. (Negativa)
-- CALL pTestStudents_12();
-- Actualizar alumno con formato de fecha de nacimiento incorrecto. (Negativa)
-- CALL pTestStudents_13();
-- Actualizar alumno con método de acceso incorrecto. (Negativa)
-- CALL pTestStudents_14();
-- Actualizar alumno con nombre vacío. (Negativa)
-- CALL pTestStudents_15();
-- Actualizar alumno con apellidos vacío. (Negativa)
-- CALL pTestStudents_16();
-- Actualizar alumno con email vacío. (Negativa)
-- CALL pTestStudents_17();
-- Actualizar alumno con DNI vacío. (Negativa)
-- CALL pTestStudents_18();
-- Borrar alumno. (Positiva)
-- CALL pTestStudents_19();
-- Borrar alumno que no existe. (Negativa)
-- CALL pTestStudents_20();
-- Borrar alumno con relaciones. (Negativa)
-- CALL pTestStudents_21();