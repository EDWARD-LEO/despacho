CREATE DATABASE despacho;
USE despacho;


CREATE TABLE ubigeos
(
	idubigeo 			INT AUTO_INCREMENT PRIMARY KEY,
	codubigeo 			VARCHAR(7)		NOT NULL,
	ubigeo 				VARCHAR(150)	NOT NULL,
	CONSTRAINT uk_codubigeo_ubi UNIQUE (codubigeo)
)ENGINE = INNODB;

CREATE TABLE rangos
(
	idrango 				INT AUTO_INCREMENT PRIMARY KEY,
	rango 				VARCHAR(100)	NOT NULL,
	create_at 			DATETIME 		NOT NULL DEFAULT NOW(),
	update_at 			DATETIME 		NULL,
	CONSTRAINT uk_rango_rng UNIQUE (rango)
)ENGINE = INNODB;

CREATE TABLE personas
(
	idpersona			INT AUTO_INCREMENT PRIMARY KEY,
	uli					VARCHAR(8) 		NULL,			-- NULL (no es socio)
	apellidos 			VARCHAR(40)		NOT NULL,
	nombres 				VARCHAR(40) 	NOT NULL,
	nacionalidad 		CHAR(2)			NOT NULL DEFAULT 'PE',
	tipodocumento		CHAR(3)			NOT NULL DEFAULT 'DNI',
	nrodocumento 		VARCHAR(12)		NOT NULL,
	telefono 			VARCHAR(12)		NOT NULL,
	correo 				VARCHAR(70)		NOT NULL,
	idubigeo 			INT 				NOT NULL,
	idrango 				INT 				NULL,
	create_at 			DATETIME 		NOT NULL DEFAULT NOW(),
	update_at 			DATETIME 		NULL,
	CONSTRAINT uk_nrodocumento_per UNIQUE (tipodocumento, nrodocumento),
	CONSTRAINT fk_idubigeo_per FOREIGN KEY (idubigeo) REFERENCES ubigeos (idubigeo),
	CONSTRAINT fk_idrango_per FOREIGN KEY (idrango) REFERENCES rangos (idrango)
)ENGINE = INNODB;