-- -----------------------------------------------------
-- Criação das tabelas do Banco de Dados Biblioteca Interdimensional
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Criando a table nivel_perigo
-- -----------------------------------------------------
CREATE TABLE nivel_perigo (
  nome VARCHAR(45) PRIMARY KEY
);


-- -----------------------------------------------------
-- Table CLASSE
-- -----------------------------------------------------
CREATE TABLE CLASSE (
  nome VARCHAR(45) NOT NULL PRIMARY KEY,
  descricao VARCHAR(255) NOT NULL, -- Alterado de mito para descricao
  UNIQUE (nome)
);

-- -----------------------------------------------------
-- Table CRIATURA
-- -----------------------------------------------------
CREATE TABLE CRIATURA (
  idcriatura SERIAL,
  nome VARCHAR(45) NOT NULL,
  descricao VARCHAR(255), -- Alterado de historia para descricao
  classe VARCHAR(45) NOT NULL,
  PRIMARY KEY (idcriatura, classe),
  UNIQUE (idcriatura),
  CONSTRAINT fk_criatura_classe1
    FOREIGN KEY (classe)
    REFERENCES CLASSE (nome)
);

-- -----------------------------------------------------
-- Table MAGIZOOLOGISTA
-- -----------------------------------------------------
CREATE TABLE MAGIZOOLOGISTA (
  cum VARCHAR(15) NOT NULL PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  data_nasc DATE NOT NULL,
  UNIQUE (cum)
);

-- -----------------------------------------------------
-- Table CACADOR_DE_RECOMPENSA
-- -----------------------------------------------------
CREATE TABLE CACADOR_DE_RECOMPENSA (
  especialidade VARCHAR(255) NOT NULL,
  equipamentos VARCHAR(255) NOT NULL,
  cacador_cum VARCHAR(15) NOT NULL,
  PRIMARY KEY (cacador_cum),
  CONSTRAINT fk_CACADOR_RECOMPENSA_MAGIZOOLOGISTA1
    FOREIGN KEY (cacador_cum)
    REFERENCES MAGIZOOLOGISTA (cum)
);

-- -----------------------------------------------------
-- Table GUARDIAO
-- -----------------------------------------------------
CREATE TABLE GUARDIAO (
  nivel INT NOT NULL,
  guardiao_cum VARCHAR(15) NOT NULL,
  data_formacao VARCHAR(45) NOT NULL,
  PRIMARY KEY (guardiao_cum),
  CONSTRAINT fk_GUARDIAO_MAGIZOOLOGISTA1
    FOREIGN KEY (guardiao_cum)
    REFERENCES MAGIZOOLOGISTA (cum)
);

-- -----------------------------------------------------
-- Table UNIVERSO
-- -----------------------------------------------------
CREATE TABLE UNIVERSO (
  iduniverso SERIAL PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  ano_surgimento INT NOT NULL,
  historia_origem VARCHAR(255)
);

-- -----------------------------------------------------
-- Table HEROI
-- -----------------------------------------------------
CREATE TABLE HEROI (
  nome VARCHAR(45) NOT NULL,
  historia VARCHAR(255) NOT NULL,
  idcriatura_associada INT NOT NULL,
  iduniverso_origem INT NOT NULL,
  data_nasc DATE NOT NULL,  -- Atributo adicionado
  PRIMARY KEY (nome, iduniverso_origem),
  CONSTRAINT fk_heroi_criatura
    FOREIGN KEY (idcriatura_associada)
    REFERENCES CRIATURA (idcriatura),
  CONSTRAINT fk_heroi_universo1
    FOREIGN KEY (iduniverso_origem)
    REFERENCES UNIVERSO (iduniverso)
);

-- -----------------------------------------------------
-- Table LOCALIZACAO
-- -----------------------------------------------------
CREATE TABLE LOCALIZACAO (
  id_localizacao SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  regiao VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  UNIQUE (id_localizacao)
);

-- -----------------------------------------------------
-- Table PODER 
-- -----------------------------------------------------
CREATE TABLE PODER (
  nome VARCHAR(45) NOT NULL PRIMARY KEY,
  descricao VARCHAR(255) NOT NULL,
  poder_gerador VARCHAR(45),
  nivel_perigo_nome VARCHAR(45) NOT NULL,
  UNIQUE (poder_gerador, nivel_perigo_nome),
  FOREIGN KEY (nivel_perigo_nome)
    REFERENCES nivel_perigo (nome),
  FOREIGN KEY (poder_gerador)
    REFERENCES PODER (nome)
);

-- -----------------------------------------------------
-- Table CARACTERISTICA
-- -----------------------------------------------------
CREATE TABLE CARACTERISTICA (
  id_caracteristica SERIAL PRIMARY KEY,
  descricao VARCHAR(255) NOT NULL,
  classe VARCHAR(45) NOT NULL,
  UNIQUE (id_caracteristica),
  CONSTRAINT fk_CARACTERISTICAS_CLASSE1
    FOREIGN KEY (classe)
    REFERENCES CLASSE (nome)
);

-- -----------------------------------------------------
-- Table CRIATURA_TEM_PODER
-- -----------------------------------------------------
CREATE TABLE CRIATURA_TEM_PODER (
  idcriatura INT NOT NULL,
  classe_criatura VARCHAR(45) NOT NULL,
  poder VARCHAR(45) NOT NULL,
  PRIMARY KEY (idcriatura, classe_criatura, poder),
  CONSTRAINT fk_poder_has_criatura_criatura1
    FOREIGN KEY (idcriatura, classe_criatura)
    REFERENCES CRIATURA (idcriatura, classe),
  CONSTRAINT fk_poder_has_criatura_poder1
    FOREIGN KEY (poder)
    REFERENCES PODER (nome)
);

-- -----------------------------------------------------
-- Table CAPTURA
-- -----------------------------------------------------
CREATE TABLE CAPTURA (
  quantidade_capturada INT NOT NULL,
  cacador_cum VARCHAR(15) NOT NULL,
  idcriatura INT NOT NULL,
  classe_criatura VARCHAR(45) NOT NULL,
  PRIMARY KEY (cacador_cum, idcriatura, classe_criatura),
  CONSTRAINT fk_CAPTURA_CACADOR_DE_RECOMPENSA1
    FOREIGN KEY (cacador_cum)
    REFERENCES CACADOR_DE_RECOMPENSA (cacador_cum),
  CONSTRAINT fk_CAPTURA_CRIATURA1
    FOREIGN KEY (idcriatura, classe_criatura)
    REFERENCES CRIATURA (idcriatura, classe)
);

-- -----------------------------------------------------
-- Table PROTEGE
-- -----------------------------------------------------
CREATE TABLE PROTEGE (
  nivel_protecao INT NOT NULL,
  guardiao_cum VARCHAR(15) NOT NULL,
  idcriatura INT NOT NULL,
  classe_criatura VARCHAR(45) NOT NULL,
  PRIMARY KEY (guardiao_cum, idcriatura, classe_criatura),
  CONSTRAINT fk_PROTEGE_GUARDIAO1
    FOREIGN KEY (guardiao_cum)
    REFERENCES GUARDIAO (guardiao_cum),
  CONSTRAINT fk_PROTEGE_CRIATURA1
    FOREIGN KEY (idcriatura, classe_criatura)
    REFERENCES CRIATURA (idcriatura, classe)
);

-- -----------------------------------------------------
-- Table REGISTRO
-- -----------------------------------------------------
CREATE TABLE REGISTRO (
  id_registro SERIAL PRIMARY KEY,
  data DATE NOT NULL,
  idcriatura INT NOT NULL,
  classe_criatura VARCHAR(45) NOT NULL,
  cum_magizoologista VARCHAR(15) NOT NULL,
  id_localizacao INT NOT NULL,
  CONSTRAINT fk_REGISTRO_CRIATURA1
    FOREIGN KEY (idcriatura, classe_criatura)
    REFERENCES CRIATURA (idcriatura, classe),
  CONSTRAINT fk_REGISTRO_MAGIZOOLOGISTA1
    FOREIGN KEY (cum_magizoologista)
    REFERENCES MAGIZOOLOGISTA (cum),
  CONSTRAINT fk_REGISTRO_LOCALIZACAO1
    FOREIGN KEY (id_localizacao)
    REFERENCES LOCALIZACAO (id_localizacao)
);
