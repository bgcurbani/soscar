CREATE TABLE USUARIO (
  CD_USUARIO INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  NM_USUARIO VARCHAR(50)  NULL,
  NM_LOGIN VARCHAR(50)  NOT NULL,
  SE_SENHA VARCHAR(50)  NOT NULL,
PRIMARY KEY(CD_USUARIO));



CREATE TABLE USUARIO_FAV_OFICINA (
  CD_USUARIO INTEGER UNSIGNED  NOT NULL,
  ID_OFICINA INTEGER UNSIGNED  NOT NULL,
PRIMARY KEY(CD_USUARIO),  
FOREIGN KEY(CD_USUARIO) REFERENCES USUARIO(CD_USUARIO);



CREATE TABLE AVALIACAO (
  CD_AVALIACAO INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  CD_USUARIO INTEGER UNSIGNED  NOT NULL ,
  ID_OFICINA VARCHAR(50)  NOT NULL ,
  DS_AVALIACAO INTEGER UNSIGNED  NULL ,
  NR_NOTA INTEGER UNSIGNED  NOT NULL,
PRIMARY KEY(CD_AVALIACAO),
FOREIGN KEY(CD_USUARIO) REFERENCES USUARIO(CD_USUARIO);



