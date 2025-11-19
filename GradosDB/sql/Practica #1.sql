DROP DATABASE if EXISTS gradosdb;
CREATE DATABASE gradosdb;
USE gradosdb;

CREATE TABLE DEGREES(
	degreeId INT NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(60) NOT NULL,
	years INT DEFAULT(4) NOT NULL,
	PRIMARY KEY (degreeId),
	CONSTRAINT invalidDegreeYear CHECK (years>=3 AND years<=5),
	CONSTRAINT uniqueDegreeName UNIQUE (NAME)
);

CREATE TABLE Subjects (
	subjectId INT NOT NULL AUTO_INCREMENT,
	degreeId INT NOT NULL,
	NAME VARCHAR(100) NOT NULL,
	acronym VARCHAR(8) NOT NULL,
	credits INT NOT NULL,
	YEAR INT NOT NULL,
	TYPE VARCHAR(20) NOT NULL,
	PRIMARY KEY (subjectId),
	FOREIGN KEY (degreeId) REFERENCES DEGREES (degreeId) ON DELETE CASCADE,
	CONSTRAINT uniqueSubjectName UNIQUE (NAME),
	CONSTRAINT uniqueSubjectAcronym UNIQUE (acronym),
	CONSTRAINT negativeSubjectCredits CHECK (credits>0),
	CONSTRAINT invalidSubjectCourse CHECK (YEAR>=1 AND YEAR<=5),
	CONSTRAINT invalidSubjectType CHECK (TYPE IN ('Formación Básica',
		'Optativa',
		'Obligatoria'))
);

CREATE TABLE GROUPS(
	groupId INT NOT NULL AUTO_INCREMENT,
	subjectId INT NOT NULL,
	NAME VARCHAR(30) NOT NULL,
	activity VARCHAR(20) NOT NULL,
	YEAR INT NOT NULL,
	PRIMARY KEY (groupId),
	FOREIGN KEY (subjectId) REFERENCES Subjects (subjectId),
	CONSTRAINT repeatedGroup UNIQUE (NAME, YEAR, subjectId),
	CONSTRAINT negativeGroupYear CHECK (YEAR>0),
	CONSTRAINT invalidGroupActivity CHECK (activity IN ('Teoría', 'Laboratorio'))
);

CREATE TABLE Students(
	studentId INT NOT NULL AUTO_INCREMENT,
	accessMethod VARCHAR(30) NOT NULL,
	dni CHAR(9) NOT NULL,
	firstName VARCHAR(100) NOT NULL,
	surname VARCHAR(100) NOT NULL,
	birthDate DATE NOT NULL,
	email VARCHAR(250) NOT NULL,
	PASSWORD VARCHAR(250) NOT NULL,
	PRIMARY KEY (studentId),
	CONSTRAINT uniqueStudentDni UNIQUE (dni),
	CONSTRAINT uniqueStudentEmail UNIQUE (email),
	CONSTRAINT invalidStudentAccessMethod CHECK (accessMethod IN
		('Selectividad', 'Ciclo', 'Mayor', 'Titulado Extranjero'))
);

CREATE TABLE GroupsStudens(
	groupStudentId INT NOT NULL AUTO_INCREMENT,
	groupId INT NOT NULL,
	studentId INT NOT NULL,
	PRIMARY KEY (groupStudentId),
	FOREIGN KEY (groupId) REFERENCES GROUPS (groupId),
	FOREIGN KEY (studentId) REFERENCES Students (studentId),
	UNIQUE (groupId, studentId)
);

CREATE TABLE Grades(
	gradeId INT NOT NULL AUTO_INCREMENT,
	studentId INT NOT NULL,
	groupId INT NOT NULL,
	VALUE DECIMAL(4,2) NOT NULL,
	gradeCall INT NOT NULL,
	withHonours BOOLEAN NOT NULL,
	PRIMARY KEY (gradeId),
	FOREIGN KEY (studentId) REFERENCES Students (studentId),
	FOREIGN KEY (groupId) REFERENCES GROUPS (groupId),
	CONSTRAINT invalidGradeValue CHECK (VALUE>=0 AND VALUE<=10),
	CONSTRAINT invalidGradeCall CHECK (gradeCall>=1 AND gradeCall<=3),
	CONSTRAINT RN_002_duplicatedCallGrade UNIQUE (gradeCall, studentId, groupId)
);