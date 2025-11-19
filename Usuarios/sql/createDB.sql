-- 
-- Autor: Álex Carracedo
-- Fecha: Noviembre de 2025
-- Descripción: Script para crear la BD del ejercicio de Usuarios
-- 

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS UsuariosDB; 
USE UsuariosDB;

DROP TABLE IF EXISTS Usuarios;

CREATE OR REPLACE TABLE Usuarios(
	usuarioId INT AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	genero ENUM('MASCULINO', 'FEMENINO', 'OTRO'),
	edad INTEGER NOT NULL,
	email VARCHAR(64) NOT NULL,
	PRIMARY KEY(usuarioId),
	CONSTRAINT RN_1_EdadAdulta CHECK (edad>=18), -- RN-1
	UNIQUE (email) -- RN-2
);

