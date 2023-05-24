CREATE DATABASE despacho;
USE despacho;

CREATE TABLE ubigeos 
(
  ubigeo 		CHAR(6) PRIMARY KEY,
  dpto 			VARCHAR(32) 	NOT NULL,
  prov 			VARCHAR(32) 	NOT NULL,
  distrito 		VARCHAR(32)		NOT NULL,
  coddist 		CHAR(6)			NOT NULL,
  orden 			VARCHAR(1) 		NOT NULL DEFAULT '0'
) ENGINE = INNODB;

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
	ubigeo 			 	CHAR(6) 			NOT NULL,
	idrango 				INT 				NULL,
	create_at 			DATETIME 		NOT NULL DEFAULT NOW(),
	update_at 			DATETIME 		NULL,
	CONSTRAINT uk_nrodocumento_per UNIQUE (tipodocumento, nrodocumento),
	CONSTRAINT fk_ubigeo_per FOREIGN KEY (ubigeo) REFERENCES ubigeos (ubigeo),
	CONSTRAINT fk_idrango_per FOREIGN KEY (idrango) REFERENCES rangos (idrango)
)ENGINE = INNODB;

CREATE TABLE centros
(
	idcentro 			INT AUTO_INCREMENT PRIMARY KEY,
	ubigeo 				CHAR(6) 			NOT NULL,
	idresponsable		INT 				NOT NULL,
	nombre 				VARCHAR(40)		NOT NULL,
	direccion			VARCHAR(90)		NOT NULL,
	telefono 			VARCHAR(12)		NOT NULL,
	pais 					CHAR(2) 			NOT NULL,
	create_at 			DATETIME 		NOT NULL DEFAULT NOW(),
	update_at 			DATETIME 		NULL,
	CONSTRAINT fk_ubigeo_cen FOREIGN KEY (ubigeo) REFERENCES ubigeos (ubigeo),
	CONSTRAINT fk_idresponsable_cen FOREIGN KEY (idresponsable) REFERENCES personas (idpersona)
)ENGINE = INNODB;


CREATE TABLE usuarios
(
	idusuario 			INT AUTO_INCREMENT PRIMARY KEY,
	idpersona 			INT 				NOT NULL,
	nombreusuario 		VARCHAR(20) 	NOT NULL,
	claveacceso			VARCHAR(90) 	NOT NULL,
	nivelacceso			CHAR(1) 			NOT NULL,
	estado 				CHAR(1) 			NOT NULL DEFAULT '1',
	create_at 			DATETIME 		NOT NULL DEFAULT NOW(),
	update_at 			DATETIME 		NULL,
	CONSTRAINT fk_idpersona_usu FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
	CONSTRAINT uk_nombre_usu UNIQUE (nombreusuario)	
)ENGINE = INNODB;


CREATE TABLE asignaciones
(
	idasignacion		INT AUTO_INCREMENT PRIMARY KEY,
	idcentro 			INT 				NOT NULL,
	idsocio 				INT 				NOT NULL,
	idrecoge 			INT 				NULL,			-- Si es NULL recogerá el mismo titular
	idusuario			INT 				NOT NULL,
	create_at 			DATETIME 		NOT NULL DEFAULT NOW(),
	update_at 			DATETIME 		NULL,	
	CONSTRAINT fk_idcentro_asg FOREIGN KEY (idcentro) REFERENCES centros (idcentro),
	CONSTRAINT fk_idsocio_asg FOREIGN KEY (idsocio) REFERENCES personas (idpersona),
	CONSTRAINT fk_idrecoge_asg FOREIGN KEY (idrecoge) REFERENCES personas (idpersona),
	CONSTRAINT fk_idusuario_asg FOREIGN KEY (idusuario) REFERENCES personas (idpersona)
)ENGINE = INNODB;

