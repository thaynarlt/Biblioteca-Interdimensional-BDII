-- -----------------------------------------------------
-- CRIACAO DO BANCO DE DADOS
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

-- -----------------------------------------------------
-- POPULANDO O BANCO DE DADOS
-- -----------------------------------------------------

-- Inserir classes na tabela CLASSE
INSERT INTO CLASSE (nome, descricao) VALUES
('Seres Monstruosos', 'Criaturas com formas híbridas ou deformadas, geralmente ameaçadoras e com características físicas extraordinárias.'),
('Seres Míticos', 'Seres extraordinários de mitologias que possuem habilidades especiais, poderosos e muitas vezes ligados a divindades.'),
('Seres Híbridos', 'Criaturas que combinam traços de diferentes espécies, geralmente metade humano e metade animal.'),
('Seres Sobrenaturais', 'Entidades com habilidades mágicas, poderes místicos ou relacionadas à morte e aos elementos sobrenaturais.'),
('Animais Místicos', 'Animais com poderes extraordinários, habilidades mágicas, ou que têm significados simbólicos.'),
('Semi-Deus e Deuses', 'Seres com poderes extraordinários, descendentes de deuses ou divindades completas que habitam mitologias.'),
('Seres Magos e Bruxos', 'Indivíduos que possuem habilidades de manipular e controlar a magia.'),
('Seres Humanos', 'Seres terrestres comuns sem habilidades especiais.');

-- Inserir criaturas na tabela CRIATURA sem as datas de nascimento
INSERT INTO CRIATURA (nome, descricao, classe) VALUES
-- Seres Monstruosos
('Minotauro', 'Criatura com corpo de homem e cabeça de touro.', 'Seres Monstruosos'),
('Hidra de Lerna', 'Serpente de várias cabeças que se regeneram.', 'Seres Monstruosos'),
('Ciclope', 'Gigante com um olho só.', 'Seres Monstruosos'),
('Quimera', 'Criatura híbrida de leão, cabra e serpente.', 'Seres Monstruosos'),
('Grifo', 'Metade leão, metade águia.', 'Seres Monstruosos'),
('Fenrir', 'Lobo monstruoso.', 'Seres Monstruosos'),
('Trolls', 'Gigantes monstruosos das montanhas.', 'Seres Monstruosos'),
('Beholder', 'Criatura flutuante com um grande olho central e tentáculos com olhos.', 'Seres Monstruosos'),
('Mind Flayer', 'Criatura com cabeça de polvo e poderes psíquicos.', 'Seres Monstruosos'),
('Gelatina Cuboide', 'Massa gelatinosa que dissolve qualquer coisa em seu caminho.', 'Seres Monstruosos'),
('Naga', 'Serpentes semi-divinas.', 'Seres Monstruosos'),
('Wargs', 'Lobos gigantes.', 'Seres Monstruosos'),
('Murloc', 'Criaturas aquáticas humanoides.', 'Seres Monstruosos'),
('Gnoll', 'Criaturas meio humanas, meio hiena.', 'Seres Monstruosos'),
('Cão Infernal', 'Cachorros gigantes do submundo.', 'Seres Monstruosos'),

-- Seres Míticos
('Pegasus', 'Cavalo alado.', 'Seres Míticos'),
('Rakshasa', 'Demônios com habilidades mágicas.', 'Seres Míticos'),
('Garuda', 'Pássaro gigante, montaria de Vishnu.', 'Seres Míticos'),
('Valkírias', 'Guerreiras que escolhem os que morrerão nas batalhas.', 'Seres Míticos'),
('Draenei', 'Seres alienígenas com poderes mágicos.', 'Seres Míticos'),
('Dracaenae', 'Mulheres-serpentes guerreiras.', 'Seres Míticos'),

-- Seres Híbridos
('Centauro', 'Metade homem, metade cavalo.', 'Seres Híbridos'),
('Sátiro', 'Metade homem, metade bode.', 'Seres Híbridos'),
('Hipogrifo', 'Metade cavalo, metade águia.', 'Seres Híbridos'),
('Selkie', 'Criaturas que podem se transformar de focas em humanos.', 'Seres Híbridos'),
('Fauno', 'Criaturas com corpo humano e pernas de cabra.', 'Seres Híbridos'),

-- Seres Sobrenaturais
('Dementador', 'Criatura sombria que suga a felicidade.', 'Seres Sobrenaturais'),
('Thestral', 'Cavalo alado esquelético visível apenas para quem viu a morte.', 'Seres Sobrenaturais'),
('Banshee', 'Espírito feminino que anuncia a morte com seu grito.', 'Seres Sobrenaturais'),
('Pooka', 'Espírito travesso que pode se transformar em várias formas.', 'Seres Sobrenaturais'),
('White Walker', 'Seres gelados que podem reanimar os mortos.', 'Seres Sobrenaturais'),
('Nazgûl', 'Espectros a serviço de Sauron.', 'Seres Sobrenaturais'),
('Draugr', 'Mortos-vivos guardiões de tumbas.', 'Seres Sobrenaturais'),

-- Animais Místicos
('Nundu', 'Felino gigantesco com hálito mortal.', 'Animais Místicos'),
('Dragão', 'Criaturas aladas capazes de cuspir fogo.', 'Animais Místicos'),
('Benu', 'Ave sagrada semelhante a uma garça.', 'Animais Místicos'),
('Qilin', 'Criatura mística semelhante a um cervo com chifres e escamas.', 'Animais Místicos'),
('Huli Jing', 'Raposa mágica com múltiplas caudas.', 'Animais Místicos'),

-- Seres Magos e Bruxos
('Bruxo', 'Indivíduos que possuem habilidades de manipular e controlar a magia.', 'Seres Magos e Bruxos'),
('Mago', 'Indivíduo com vasto conhecimento mágico e habilidades arcanas, capaz de manipular as forças da magia.', 'Seres Magos e Bruxos'),

-- Semi-Deus e Deuses
('Semi-Deus', 'Seres nascidos da união entre um deus e um mortal, possuindo força, habilidades e características divinas.', 'Semi-Deus e Deuses'),
('Deus Grego', 'Seres poderosos que governam aspectos da vida e da natureza, com personalidades humanas e habilidades divinas.', 'Semi-Deus e Deuses'),
('Humano', 'Espécie inteligente do planeta Terra.', 'Seres Humanos'),
('Avatar', 'Ser mítico que pode controlar os quatro elementos: ar, água, terra e fogo.', 'Seres Humanos');

-- Inserir características na tabela CARACTERISTICA
INSERT INTO CARACTERISTICA (descricao, classe) VALUES
-- Características para Seres Monstruosos
('Criaturas com aparência aterrorizante e habilidades especiais.', 'Seres Monstruosos'),
('Seres que costumam ter um aspecto físico imponente ou ameaçador.', 'Seres Monstruosos'),

-- Características para Seres Míticos
('Criaturas frequentemente associadas a antigas religiões e mitologias.', 'Seres Míticos'),

-- Características para Seres Híbridos
('Criaturas que combinam características de diferentes espécies.', 'Seres Híbridos'),
('Seres que frequentemente têm a capacidade de se adaptar a múltiplos ambientes.', 'Seres Híbridos'),

-- Características para Seres Sobrenaturais
('Seres com poderes ou habilidades que desafiam as leis naturais.', 'Seres Sobrenaturais'),
('Criaturas que possuem uma conexão direta com o mundo espiritual ou etéreo.', 'Seres Sobrenaturais'),
('Seres que frequentemente têm uma presença impactante ou um efeito emocional sobre os vivos.', 'Seres Sobrenaturais'),
('Seres geralmente conectados a morte.', 'Seres Sobrenaturais'),

-- Características para Animais Místicos
('Criaturas com habilidades especiais relacionadas ao ambiente natural ou mágico.', 'Animais Místicos'),
('Seres frequentemente associados a forças naturais ou divinas.', 'Animais Místicos'),
('Criaturas que possuem características visivelmente místicas ou encantadoras.', 'Animais Místicos'),

-- Características para Seres Magos e Bruxos
('Seres que possuem a capacidade de manipular e controlar a magia.', 'Seres Magos e Bruxos'),
('Criaturas ou indivíduos com profundo conhecimento em feitiçaria e encantamentos.', 'Seres Magos e Bruxos'),
('Seres que frequentemente têm habilidades excepcionais em rituais e magia.', 'Seres Magos e Bruxos'),

-- Características para Semi-Deus e Deuses
('Possuem habilidades extraordinárias como força sobre-humana, controle de elementos ou poderes divinos herdados.', 'Semi-Deus e Deuses'),

-- Características para Humanos
('Seres simples que a princípio não possuem habilidades especiais ou algum tipo de poder.', 'Seres Humanos'),
('Possuem um potencial enorme, podendo adquirir dons e habilidades mágicas através de experiências místicas.', 'Seres Humanos');

-- Inserindo universos associados a heróis
INSERT INTO UNIVERSO (nome, ano_surgimento, historia_origem) VALUES
('Hogwarts', 1991, 'Universo mágico de Hogwarts, onde bruxos e feiticeiros praticam magia.'),
('Monte Olimpo', 2, 'Universo onde Deuses e Semi-Deuses vivem suas trajetórias.'),
('Grã-Bretanha',400, 'Reino lendário medieval e mágico da Bretanha, onde o Rei Arthur empunha a espada Excalibur e enfrenta várias aventuras.'),
('Ilha dos Dragões', 200, 'Terra natal de muitos dragões, onde eles vivem e treinam.'),
('Terra 616', 1965, 'Universo onde os mutantes são originados.');


-- Inserindo heróis associados a criaturas
INSERT INTO HEROI (nome, data_nasc, historia, idcriatura_associada, iduniverso_origem) VALUES

('Harry Potter', '1992-07-31', 'O famoso bruxo que sobreviveu e derrotou Voldemort.', (SELECT idcriatura FROM criatura WHERE nome = 'Bruxo'), (SELECT iduniverso FROM universo WHERE nome = 'Hogwarts')),

('Perseu', '1190-01-01', 'Herói grego que derrotou Medusa.', (SELECT idcriatura FROM criatura WHERE nome = 'Semi-Deus'), (SELECT iduniverso FROM universo WHERE nome = 'Monte Olimpo')),

('Hércules', '1200-01-01', 'Herói grego conhecido por sua força e por completar os 12 Trabalhos.', (SELECT idcriatura FROM criatura WHERE nome = 'Semi-Deus'), (SELECT iduniverso FROM universo WHERE nome = 'Monte Olimpo')),

('Arthur', '500-01-01', 'Rei lendário da Bretanha, portador da espada Excalibur.', (SELECT idcriatura FROM criatura WHERE nome = 'Humano'), (SELECT iduniverso FROM universo WHERE nome = 'Grã-Bretanha')),

('Merlim', '200-11-04', 'Lendário mago da era medieval, conhecido por sua sabedoria, poderes mágicos e papel crucial como conselheiro do Rei Arthur.', (SELECT idcriatura FROM criatura WHERE nome = 'Mago'), (SELECT iduniverso FROM universo WHERE nome = 'Grã-Bretanha')),

('Banguela', '300-06-02', 'Dragão raro da espécie Fúria da Noite, inteligente, ágil, com habilidades de voo excepcionais e poderosa rajada de fogo.', (SELECT idcriatura FROM criatura WHERE nome = 'Dragão'), (SELECT iduniverso FROM universo WHERE nome = 'Ilha dos Dragões')),

('Marsias', '1300-09-04', 'Um sátiro habilidoso com a flauta, desafiou Apolo em um concurso musical. Sua bravura em enfrentar um deus e sua arte o tornaram um herói trágico da mitologia grega..', (SELECT idcriatura FROM criatura WHERE nome = 'Sátiro'), (SELECT iduniverso FROM universo WHERE nome = 'Monte Olimpo')),

('Percy Jackson', '2003-01-23', 'Filho de Poseidon, se tornou um herói ao recuperar raio roubado de Zeus', (SELECT idcriatura FROM criatura WHERE nome = 'Semi-Deus'), (SELECT iduniverso FROM universo WHERE nome = 'Monte Olimpo'));



INSERT INTO NIVEL_PERIGO (nome) VALUES
('medio'),
('alto'),
('altissimo');


INSERT INTO PODER (nome, descricao, poder_gerador, nivel_perigo_nome) VALUES
('Cuspir Fogo', 'Permite ao usuário exalar fogo de sua boca.', NULL, 'alto'),
('Controle da Água', 'Dá ao usuário a capacidade de manipular a água em qualquer forma.', NULL, 'alto'),
('Controle de Fogo', 'Permite ao usuário manipular e controlar o fogo.', NULL, 'altissimo'),
('Controle do Ar', 'Permite ao usuário manipular e controlar o ar e os ventos.', NULL, 'medio'),
('Controle da Terra', 'Permite ao usuário manipular e controlar a terra e rochas.', NULL, 'alto'),
('Ler Mentes', 'Permite ao usuário ler e compreender os pensamentos das pessoas.', NULL, 'altissimo'),
('Telecinese', 'Permite ao usuário mover objetos com a mente.', NULL, 'alto'),
('Lançar Feitiços', 'Permite ao usuário conjurar feitiços variados com diferentes efeitos.', NULL, 'medio'),
('Transmutação', 'Permite transformar objetos e seres vivos em outras formas.', NULL, 'altissimo'),
('Teletransporte', 'Permite ao usuário se transportar instantaneamente para outro local.', NULL, 'altissimo'),
('Dobra de Sangue', 'Permite ao usuário manipular o sangue dentro dos corpos, controlando os movimentos de outras criaturas.', 'Controle da Água', 'altissimo'),
('Dobra de Metal', 'Permite ao usuário manipular e dobrar o metal, uma forma avançada de dobra de terra.', 'Controle da Terra', 'alto'),
('Dobra de Relâmpago', 'Permite ao usuário gerar e redirecionar relâmpagos, uma técnica avançada de dobra de fogo.', 'Controle de Fogo', 'altissimo');

INSERT INTO CRIATURA_TEM_PODER (idcriatura, classe_criatura, poder) VALUES
((SELECT idcriatura FROM criatura WHERE nome = 'Dragão'), 'Animais Místicos', 'Cuspir Fogo'),
((SELECT idcriatura FROM criatura WHERE nome = 'Hidra de Lerna'), 'Seres Monstruosos', 'Cuspir Fogo'),
((SELECT idcriatura FROM criatura WHERE nome = 'Mago'), 'Seres Magos e Bruxos', 'Ler Mentes'),
((SELECT idcriatura FROM criatura WHERE nome = 'Mago'), 'Seres Magos e Bruxos', 'Telecinese'),
((SELECT idcriatura FROM criatura WHERE nome = 'Mago'), 'Seres Magos e Bruxos', 'Transmutação'),
((SELECT idcriatura FROM criatura WHERE nome = 'Mago'), 'Seres Magos e Bruxos', 'Teletransporte'),
((SELECT idcriatura FROM criatura WHERE nome = 'Mago'), 'Seres Magos e Bruxos', 'Lançar Feitiços'),
((SELECT idcriatura FROM criatura WHERE nome = 'Bruxo'), 'Seres Magos e Bruxos', 'Lançar Feitiços'),
((SELECT idcriatura FROM criatura WHERE nome = 'Bruxo'), 'Seres Magos e Bruxos', 'Telecinese'),
((SELECT idcriatura FROM criatura WHERE nome = 'Avatar'), 'Seres Humanos', 'Controle da Água'),
((SELECT idcriatura FROM criatura WHERE nome = 'Avatar'), 'Seres Humanos', 'Controle de Fogo'),
((SELECT idcriatura FROM criatura WHERE nome = 'Avatar'), 'Seres Humanos', 'Controle do Ar'),
((SELECT idcriatura FROM criatura WHERE nome = 'Avatar'), 'Seres Humanos', 'Controle da Terra'),
((SELECT idcriatura FROM criatura WHERE nome = 'Avatar'), 'Seres Humanos', 'Dobra de Sangue'),
((SELECT idcriatura FROM criatura WHERE nome = 'Avatar'), 'Seres Humanos', 'Dobra de Metal'),
((SELECT idcriatura FROM criatura WHERE nome = 'Avatar'), 'Seres Humanos', 'Dobra de Relâmpago');

INSERT INTO MAGIZOOLOGISTA (cum, nome, data_nasc) VALUES
('1234567890ABCD1', 'Newt Scamander', '1897-02-24'),
('0987654321EFGH2', 'Luna Lovegood', '1981-02-13'),
('1122334455IJKL3', 'Rubeus Hagrid', '1928-12-06'),
('5566778899MNOP4', 'Bruno Wildfang', '1975-07-19'),
('6677889900QRST5', 'Fiona Moonbreeze', '1983-05-10'),
('7766554433UVWX6', 'Oliver Woodhart', '1970-11-22'),
('3344556677YZAB7', 'Elara Starwind', '1987-03-03'),
('9988776655CDEF8', 'Tobias Swiftfoot', '1990-01-17'),
('8877665544GHIJ9', 'Ariana Willowshade', '1979-04-15'),
('2233445566KLMN0', 'Cedric Thundereye', '1985-09-29');

INSERT INTO GUARDIAO (nivel, guardiao_cum, data_formacao) VALUES
(5, '1234567890ABCD1', '2010-07-14'),
(4, '0987654321EFGH2', '2015-06-21'),
(10, '1122334455IJKL3', '2000-09-10'),
(5, '5566778899MNOP4', '2005-11-05'),
(1, '6677889900QRST5', '2009-04-03');


INSERT INTO CACADOR_DE_RECOMPENSA (especialidade, equipamentos, cacador_cum) VALUES
('Dragões', 'Lança e Rede Mágica', '7766554433UVWX6'),
('Hipogrifos', 'Lança Leve e Cordas de Seda Mágica','3344556677YZAB7'),
('Grifos', 'Espada Encantada e Armadilha Rápida', '9988776655CDEF8'),
('Quimeras', 'Armadilhas especializadas', '8877665544GHIJ9'),
('Trolls', 'Rede de Constrição Mágica e Escudo', '2233445566KLMN0');

INSERT INTO CAPTURA (quantidade_capturada, cacador_cum, idcriatura, classe_criatura) VALUES
(10, '7766554433UVWX6', (SELECT idcriatura FROM criatura WHERE nome = 'Dragão'), 'Animais Místicos'),
(3, '7766554433UVWX6', (SELECT idcriatura FROM criatura WHERE nome = 'Grifo'), 'Seres Monstruosos'),
(1, '7766554433UVWX6', (SELECT idcriatura FROM criatura WHERE nome = 'Ciclope'), 'Seres Monstruosos'),
(13, '3344556677YZAB7', (SELECT idcriatura FROM criatura WHERE nome = 'Hipogrifo'), 'Seres Híbridos'),
(8, '9988776655CDEF8', (SELECT idcriatura FROM criatura WHERE nome = 'Grifo'), 'Seres Monstruosos'),
(11, '8877665544GHIJ9', (SELECT idcriatura FROM criatura WHERE nome = 'Quimera'), 'Seres Monstruosos'),
(4, '8877665544GHIJ9', (SELECT idcriatura FROM criatura WHERE nome = 'Dragão'), 'Animais Místicos'),
(2, '2233445566KLMN0', (SELECT idcriatura FROM criatura WHERE nome = 'Dragão'), 'Animais Místicos'),
(5, '2233445566KLMN0', (SELECT idcriatura FROM criatura WHERE nome = 'Sátiro'), 'Seres Híbridos'),
(4, '2233445566KLMN0', (SELECT idcriatura FROM criatura WHERE nome = 'Fauno'), 'Seres Híbridos'),
(3, '2233445566KLMN0', (SELECT idcriatura FROM criatura WHERE nome = 'Minotauro'), 'Seres Monstruosos');


INSERT INTO PROTEGE (nivel_protecao, guardiao_cum, idcriatura, classe_criatura) VALUES
(5, '1234567890ABCD1', (SELECT idcriatura FROM criatura WHERE nome = 'Dragão'), 'Animais Místicos'),
(2, '0987654321EFGH2', (SELECT idcriatura FROM criatura WHERE nome = 'Fauno'), 'Seres Híbridos'),
(3, '0987654321EFGH2', (SELECT idcriatura FROM criatura WHERE nome = 'Sátiro'), 'Seres Híbridos'),
(6, '1122334455IJKL3', (SELECT idcriatura FROM criatura WHERE nome = 'Quimera'), 'Seres Monstruosos'),
(7, '5566778899MNOP4', (SELECT idcriatura FROM criatura WHERE nome = 'Ciclope'), 'Seres Monstruosos'),
(1, '6677889900QRST5', (SELECT idcriatura FROM criatura WHERE nome = 'Grifo'), 'Seres Monstruosos');

INSERT INTO LOCALIZACAO (nome, regiao, descricao) VALUES
('Floresta Proibida', 'Perto do Reino de Eldoria', 'Uma vasta floresta densa habitada por diversas criaturas mágicas.'),
('Montanhas da Perdição', 'Ao leste da Fortaleza de Grimhold', 'Cadeia de montanhas íngremes, lar de criaturas raras e perigosas.'),
('Lago Encantado', 'Próximo à Vila de Brighthollow', 'Um lago profundo e misterioso com propriedades mágicas.'),
('Caverna do Dragão', 'Abaixo do Castelo de Ironpeak', 'Uma caverna subterrânea conhecida por abrigar dragões e outras criaturas míticas.'),
('Planícies da Eternidade', 'Entre o Reino de Mont e as Colinas de Ilwind', 'Extensas planícies onde muitas criaturas mágicas migratórias podem ser encontradas.'),
('Ilha do Trovão', 'Além da Costa do Mar Ocidental', 'Uma ilha isolada constantemente cercada por tempestades.'),
('Deserto das Sombras', 'Ao sul da Cidade de Blackstone', 'Um deserto vasto e sombrio, lar de criaturas noturnas e perigosas.'),
('Pântano das Lamentações', 'Nos arredores da Floresta Sombria de Verden', 'Pântano traiçoeiro e cheio de criaturas venenosas e encantadas.'),
('Vale dos Ventos', 'Ao norte das Montanhas de Windcrest', 'Um vale sempre ventoso, conhecido por ser o habitat de criaturas voadoras.'),
('Bosque das Fadas', 'Próximo ao Reino de Lumina', 'Bosque encantado onde fadas e outras criaturas mágicas pequenas habitam.');

INSERT INTO REGISTRO (data, idcriatura, classe_criatura, cum_magizoologista, id_localizacao)
VALUES
   ('2024-09-01', 
   (SELECT idcriatura FROM CRIATURA WHERE nome = 'Dragão'), 
   'Animais Místicos', 
   '1234567890ABCD1',
   (SELECT id_localizacao FROM LOCALIZACAO WHERE nome = 'Floresta Proibida' LIMIT 1)),

   ('2023-05-03', 
   (SELECT idcriatura FROM CRIATURA WHERE nome = 'Fauno'), 
   'Seres Híbridos', 
   '0987654321EFGH2',
   (SELECT id_localizacao FROM LOCALIZACAO WHERE nome = 'Bosque das Fadas')),

   ('2023-01-20', 
   (SELECT idcriatura FROM CRIATURA WHERE nome = 'Sátiro'), 
   'Seres Híbridos', 
   '0987654321EFGH2',
   (SELECT id_localizacao FROM LOCALIZACAO WHERE nome = 'Planícies da Eternidade')),

   ('2022-11-30', 
   (SELECT idcriatura FROM CRIATURA WHERE nome = 'Dementador'), 
   'Seres Sobrenaturais', 
   '1122334455IJKL3',
   (SELECT id_localizacao FROM LOCALIZACAO WHERE nome = 'Planícies da Eternidade')),

   ('2021-12-26', 
   (SELECT idcriatura FROM CRIATURA WHERE nome = 'Dragão'), 
   'Animais Místicos', 
   '5566778899MNOP4',
   (SELECT id_localizacao FROM LOCALIZACAO WHERE nome = 'Caverna do Dragão')),

   ('2020-06-22', 
   (SELECT idcriatura FROM CRIATURA WHERE nome = 'Beholder'), 
   'Seres Monstruosos', 
   '6677889900QRST5',
   (SELECT id_localizacao FROM LOCALIZACAO WHERE nome = 'Deserto das Sombras')),

   ('2017-02-17', 
   (SELECT idcriatura FROM CRIATURA WHERE nome = 'Hipogrifo'), 
   'Seres Híbridos', 
   '6677889900QRST5',
   (SELECT id_localizacao FROM LOCALIZACAO WHERE nome = 'Floresta Proibida')),

   ('2015-05-19', 
   (SELECT idcriatura FROM CRIATURA WHERE nome = 'Ciclope'), 
   'Seres Monstruosos', 
   '6677889900QRST5',
   (SELECT id_localizacao FROM LOCALIZACAO WHERE nome = 'Ilha do Trovão'));


-- -----------------------------------------------------
-- 1 consulta com uma tabela usando operadores básicos de filtro (e.g., IN,
--between, is null, etc).
-- -----------------------------------------------------

--Justificativa: Esta consulta usa o operador IN para filtrar criaturas que 
--têm o poder 'Fogo', mostrando suas informações.

SELECT nome, descricao
FROM CRIATURA
WHERE idcriatura IN (
  SELECT idcriatura
  FROM CRIATURA_TEM_PODER
  WHERE poder = 'Lançar Feitiços'
);

-- -----------------------------------------------------
--3 consultas com inner JOIN na cláusula FROM (pode ser self join, caso o
--domínio indique esse uso).
-- -----------------------------------------------------

--Justificativa: fornecer um panorama completo dos registros de criaturas no banco de dados.
SELECT
    r.id_registro,
    r.data,
    c.nome AS nome_criatura,
    m.nome AS nome_magizoologista,
    l.nome AS nome_localizacao,
    l.regiao
FROM
    REGISTRO r
    INNER JOIN CRIATURA c ON r.idcriatura = c.idcriatura AND r.classe_criatura = c.classe
    INNER JOIN MAGIZOOLOGISTA m ON r.cum_magizoologista = m.cum
    INNER JOIN LOCALIZACAO l ON r.id_localizacao = l.id_localizacao;


--Justificativa: Listar todos os poderes de uma criatura e suas descrições, incluindo o nome da criatura.
SELECT cr.nome AS nome_criatura, p.nome AS nome_poder, p.descricao
FROM CRIATURA cr
INNER JOIN CRIATURA_TEM_PODER ctp ON cr.idcriatura = ctp.idcriatura
INNER JOIN PODER p ON ctp.poder = p.nome;


--Justificativa:Fornece uma visão detalhada sobre quais poderes estão associados a 
--quais criaturas, bem como o nível de perigo de cada poder.
SELECT
    c.nome AS nome_criatura,
    c.descricao AS descricao_criatura,
    p.nome AS poder,
    p.descricao AS descricao_poder,
    n.nome AS nivel_perigo
FROM
    CRIATURA_TEM_PODER ct
    INNER JOIN CRIATURA c ON ct.idcriatura = c.idcriatura AND ct.classe_criatura = c.classe
    INNER JOIN PODER p ON ct.poder = p.nome
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome;

-- -----------------------------------------------------
--1 consulta com left/right/full outer join na cláusula FROM
-- -----------------------------------------------------

--Justificativa: Suponha que você deseja listar todas as criaturas, incluindo seus 
--poderes associados, se existirem. Se uma criatura não tiver nenhum poder associado, 
--ainda assim será incluída na lista, mas com informações de poder como NULL.
SELECT
    c.nome AS nome_criatura,
    c.descricao AS descricao_criatura,
    p.nome AS nome_poder,
    p.descricao AS descricao_poder
FROM
    CRIATURA c
    LEFT JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
    LEFT JOIN PODER p ON ct.poder = p.nome;
-- -----------------------------------------------------
--2 consultas usando Group By (e possivelmente o having)
-- -----------------------------------------------------

--1. Justificativa: Mostra o número de criaturas em cada classe
SELECT
    c.classe AS nome_classe,
    COUNT(c.idcriatura) AS quantidade_criaturas
FROM
    CRIATURA c
GROUP BY
    c.classe;

--2. Justificativa: Mostra o número de criaturas que cada poder é possuído
SELECT
    p.nome AS nome_poder,
    COUNT(ct.idcriatura) AS quantidade_criaturas
FROM
    PODER p
    INNER JOIN CRIATURA_TEM_PODER ct ON p.nome = ct.poder
GROUP BY
    p.nome
HAVING
    COUNT(ct.idcriatura) > 0;

-- -----------------------------------------------------
--1 consulta usando alguma operação de conjunto (union, except ou intersect)
-- -----------------------------------------------------
--Justificativa: fornece uma lista das criaturas (com ID e nome) que têm pelo menos um poder 
--classificado como "alto", excluindo aquelas que não têm nenhum poder de nível "alto".
SELECT
    c.idcriatura,
    c.nome
FROM
    CRIATURA c
    INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
    INNER JOIN PODER p ON ct.poder = p.nome
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome = 'alto'

EXCEPT

SELECT
    c.idcriatura,
    c.nome
FROM
    CRIATURA c
    INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
    LEFT JOIN PODER p ON ct.poder = p.nome
    LEFT JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome IS DISTINCT FROM 'alto';

-- -----------------------------------------------------
--2 consultas que usem subqueries.
-- -----------------------------------------------------
--1. Justificativa: encontra os magizoologistas que têm registrado a captura de criaturas em localizações específicas, como "Floresta Proibida"

SELECT
    m.nome,
    m.cum
FROM
    MAGIZOOLOGISTA m
WHERE
    m.cum IN (
        SELECT
            r.cum_magizoologista
        FROM
            REGISTRO r
            INNER JOIN LOCALIZACAO l ON r.id_localizacao = l.id_localizacao
        WHERE
            l.nome IN ('Floresta Proibida')
    );

--2. Justificativa: Consulta principal para encontrar as criaturas com o maior número de poderes
SELECT
    c.idcriatura,
    c.nome,
    COUNT(ct.poder) AS total_poderes
FROM
    CRIATURA c
    INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
GROUP BY
    c.idcriatura, c.nome
HAVING
    COUNT(ct.poder) = (
        -- Subconsulta para encontrar o maior número de poderes de qualquer criatura
        SELECT
            MAX(poder_count)
        FROM (
            SELECT
                c.idcriatura,
                COUNT(ct.poder) AS poder_count
            FROM
                CRIATURA c
                INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
            GROUP BY
                c.idcriatura
        ) AS subquery
    );
-- -----------------------------------------------------
-- VIEW QUE PERMITE INSERÇÃO
-- -----------------------------------------------------
CREATE OR REPLACE VIEW visao_insercao_criatura AS
SELECT idcriatura, nome, classe
FROM CRIATURA
WITH CHECK OPTION; -- Inserção de dados

-- Testanto inserção de dados de uma nova criatura
INSERT INTO visao_insercao_criatura (idcriatura, nome, classe)
VALUES (47, 'Formiga', 'Seres Monstruosos');

-- Testando view
SELECT * FROM visao_insercao_criatura;


-- -----------------------------------------------------
-- VIEW ROBUSTA 1
-- -----------------------------------------------------
CREATE OR REPLACE VIEW view_dos_cacadores AS
SELECT 
  cdr.cacador_cum,
  m.nome AS nome_cacador,
  m.data_nasc,
  cr.nome AS nome_criatura,
  cr.idcriatura,
  cr.classe AS classe_criatura,  
  ca.quantidade_capturada,
  cdr.especialidade
  
FROM 
  CACADOR_DE_RECOMPENSA cdr
JOIN 
  MAGIZOOLOGISTA m ON cdr.cacador_cum = m.cum
JOIN 
  CAPTURA ca ON cdr.cacador_cum = ca.cacador_cum
JOIN 
  CRIATURA cr ON ca.idcriatura = cr.idcriatura;

--Chamada da view:
SELECT * FROM view_dos_cacadores;


-- -----------------------------------------------------
-- VIEW ROBUSTA 2
-- -----------------------------------------------------

CREATE OR REPLACE VIEW total_capturas_cacador AS
SELECT 
    MAGIZOOLOGISTA.nome AS "nome do cacador",
    CACADOR_DE_RECOMPENSA.cacador_cum AS cum,
    SUM(CAPTURA.quantidade_capturada) AS "total de criaturas capturadas"
FROM 
    CACADOR_DE_RECOMPENSA
JOIN 
    MAGIZOOLOGISTA ON CACADOR_DE_RECOMPENSA.cacador_cum = MAGIZOOLOGISTA.cum
JOIN 
    CAPTURA ON CACADOR_DE_RECOMPENSA.cacador_cum = CAPTURA.cacador_cum
GROUP BY 
    MAGIZOOLOGISTA.nome, CACADOR_DE_RECOMPENSA.cacador_cum;

SELECT * FROM total_capturas_cacador;

--Chamada da view:
SELECT * FROM total_capturas_cacador;

-- -----------------------------------------------------
-- ÍNDICES
-- -----------------------------------------------------

-- -----------------------------------------------------
-- ÍNDICE 1
-- -----------------------------------------------------
CREATE INDEX idx_criatura_nome ON CRIATURA(nome); -- banco de dados localize rapidamente as linhas onde nome = 'Dragão' sem precisar varrer toda a tabela.

-- -----------------------------------------------------
-- ÍNDICE 2
-- -----------------------------------------------------
CREATE INDEX idx_magizoologista_cum ON MAGIZOOLOGISTA(cum); -- consultas na tabela MAGIZOOLOGISTA que façam filtros ou junções na coluna cum, agilizando essas operações.

-- -----------------------------------------------------
-- ÍNDICE 3
-- -----------------------------------------------------
CREATE INDEX idx_poder_nome ON PODER(nome); --melhoraria o desempenho de consultas que filtrem ou façam junção usando a coluna nome na tabela PODER.


-- -----------------------------------------------------
-- REESCRITA DE CONSULTAS
-- -----------------------------------------------------

-- CONSULTA 1:ORIGINAL
SELECT
    c.idcriatura,
    c.nome
FROM
    CRIATURA c
    INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
    INNER JOIN PODER p ON ct.poder = p.nome
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome = 'alto'

EXCEPT

SELECT
    c.idcriatura,
    c.nome
FROM
    CRIATURA c
    INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
    LEFT JOIN PODER p ON ct.poder = p.nome
    LEFT JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome IS DISTINCT FROM 'alto';


-- CONSULTA 1:OTIMIZADA
SELECT DISTINCT
    c.idcriatura,
    c.nome
FROM
    CRIATURA c
WHERE
    EXISTS (
        SELECT 1
        FROM CRIATURA_TEM_PODER ctp
        JOIN PODER p ON ctp.poder = p.nome
        JOIN nivel_perigo np ON p.nivel_perigo_nome = np.nome
        WHERE c.idcriatura = ctp.idcriatura
          AND c.classe = ctp.classe_criatura
          AND np.nome = 'medio'
    );


--A versão otimizada usa uma subconsulta com EXISTS para verificar diretamente a presença de poderes de nível "alto", o que pode ser mais eficiente do que usar EXCEPT.

-- CONSULTA 2:ORIGINAL
-- Mostra o número de criaturas em cada classe
SELECT
    c.classe AS nome_classe,
    COUNT(c.idcriatura) AS quantidade_criaturas
FROM
    CRIATURA c
GROUP BY
    c.classe;


-- CONSULTA 2:OTIMIZADA
-- Otimização para listar o número de criaturas por classe
SELECT
    classe,
    COUNT(*) AS total_criaturas
FROM
    CRIATURA
GROUP BY
    classe;

--Como estamos lidando com apenas 1 tabela, não precisamos usar o alias e count(*) é mais direto no contexto.


-- -----------------------------------------------------
-- FUNÇÃO
-- -----------------------------------------------------

-- 1 função que use SUM, MAX, MIN, AVG ou COUNT
CREATE FUNCTION contar_criaturas() RETURNS INT AS $$
BEGIN
   RETURN (SELECT COUNT(*) FROM CRIATURA); -- COUNT
END;
$$ LANGUAGE plpgsql;
SELECT contar_criaturas();


-- 2 Função para Verificar nivel de perigo de um poder
CREATE FUNCTION verificar_perigo_poder(nome_poder VARCHAR) RETURNS VARCHAR AS $$
BEGIN
   RETURN (SELECT nivel_perigo_nome FROM PODER WHERE nome = nome_poder);
END;
$$ LANGUAGE plpgsql;
SELECT verificar_perigo_poder('Cuspir Fogo');


-- 3 Função Mostrar caçadores através de criatura 
CREATE OR REPLACE FUNCTION get_cacadores_por_criatura(nome_criatura VARCHAR)
RETURNS TABLE (
  nome_cacador VARCHAR,
  especialidade VARCHAR,
  equipamentos VARCHAR
) AS $$
DECLARE
  cacador_cursor CURSOR FOR
    SELECT 
      m.nome AS nome_cacador,
      cdr.especialidade,
      cdr.equipamentos
    FROM 
      CACADOR_DE_RECOMPENSA cdr
    JOIN 
      MAGIZOOLOGISTA m ON cdr.cacador_cum = m.cum
    JOIN 
      CAPTURA ca ON cdr.cacador_cum = ca.cacador_cum
    JOIN 
      CRIATURA cr ON ca.idcriatura = cr.idcriatura
    WHERE 
      cr.nome = nome_criatura;
  rec RECORD;
BEGIN
  RAISE NOTICE 'Caçadores de %:', nome_criatura;

  OPEN cacador_cursor;
  LOOP
    FETCH cacador_cursor INTO rec;
    EXIT WHEN NOT FOUND;

    RAISE NOTICE 'Nome do Caçador: %', rec.nome_cacador;

    RETURN QUERY 
    SELECT rec.nome_cacador, rec.especialidade, rec.equipamentos;
  END LOOP;

  CLOSE cacador_cursor;
END;
$$ LANGUAGE plpgsql;


--Chamada da função:
SELECT * FROM get_cacadores_por_criatura('Dragão');

-- -----------------------------------------------------
-- PROCEDURE
-- -----------------------------------------------------
--Atualiza o nivel de um guardião, com tratamento para ver se o CUM dado existe e se o novo nível é válido.
CREATE OR REPLACE PROCEDURE AtualizarNivelGuardiao(
    p_guardiao_cum VARCHAR(15),
    p_novo_nivel INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar se o nível é maior que zero
    IF p_novo_nivel <= 0 THEN
        RAISE EXCEPTION 'Nível % é inválido. O nível deve ser um valor maior que zero.', p_novo_nivel;
    END IF;

    -- Tentar atualizar o nível de proteção do guardião
    UPDATE GUARDIAO
    SET nivel = p_novo_nivel
    WHERE guardiao_cum = p_guardiao_cum;

    -- Verificar se alguma linha foi atualizada
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Guardião com CUM % não encontrado.', p_guardiao_cum;
    END IF;

EXCEPTION
    -- Tratamento para outros erros inesperados
    WHEN OTHERS THEN
        RAISE NOTICE 'Erro ao atualizar o nível de proteção: %', SQLERRM;
END $$;


--teste da procedure
CALL AtualizarNivelGuardiao('1234567890ABCD1', 7);
SELECT * FROM guardiao;

-- -----------------------------------------------------
-- TRIGGER 1
-- -----------------------------------------------------

CREATE TABLE HISTORICO_CAPTURA (
  id SERIAL PRIMARY KEY,
  cacador_cum VARCHAR(15) NOT NULL,
  idcriatura INT NOT NULL,
  nome_criatura VARCHAR(45) NOT NULL,
  quantidade_capturada INT,
  data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  acao VARCHAR(50) 
);

CREATE OR REPLACE FUNCTION log_captura_update()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO HISTORICO_CAPTURA (
    cacador_cum,
    idcriatura,
    nome_criatura, 
    quantidade_capturada,
    acao
  )
  VALUES (
    OLD.cacador_cum,
    OLD.idcriatura,
    (SELECT nome FROM CRIATURA 
     WHERE idcriatura = OLD.idcriatura 
       AND classe = OLD.classe_criatura), 
    OLD.quantidade_capturada,
    'UPDATE'
  );
  
  RETURN NEW; 
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_log_captura_update
AFTER UPDATE ON CAPTURA
FOR EACH ROW
EXECUTE FUNCTION log_captura_update();

-- Atualizar o registro na tabela CAPTURA
UPDATE CAPTURA
SET quantidade_capturada = 11
WHERE cacador_cum = '7766554433UVWX6' AND idcriatura = (SELECT idcriatura FROM criatura WHERE nome = 'Dragão');



-- Consultar a tabela HISTORICO_CAPTURA para verificar o histórico de alterações
SELECT * FROM HISTORICO_CAPTURA;


-- -----------------------------------------------------
-- TRIGGER 2
-- -----------------------------------------------------

CREATE OR REPLACE FUNCTION verificaQuantidadeCapturada()
RETURNS trigger AS $$
BEGIN
    -- Garante que a quantidade capturada seja maior que zero
    IF NEW.quantidade_capturada <= 0 THEN
        RAISE EXCEPTION 'A quantidade capturada deve ser maior que zero';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER triggerVerificaCaptura
BEFORE INSERT OR UPDATE ON captura
FOR EACH ROW
EXECUTE FUNCTION verificaQuantidadeCapturada();

-- Tentando inserir uma captura com quantidade inválida
INSERT INTO captura (quantidade_capturada, cacador_cum, idcriatura, classe_criatura)
VALUES (-1, 'ABC123', 1, 'Dragão');

-- Tentando inserir uma captura válida
INSERT INTO captura (quantidade_capturada, cacador_cum, idcriatura, classe_criatura)
VALUES (3, '7766554433UVWX6', 1, 'Seres Monstruosos');

-- Verificar se as capturas foram inseridas corretamente
SELECT * FROM captura;

-- -----------------------------------------------------
-- TRIGGER 3
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION verificaDataNascimento()
RETURNS trigger AS $$
BEGIN
    -- Verifica se a data de nascimento é anterior à data atual
    IF NEW.data_nasc > CURRENT_DATE THEN
        RAISE EXCEPTION 'A data de nascimento não pode ser uma data futura';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER triggerVerificaMagizoologista
BEFORE INSERT OR UPDATE ON magizoologista
FOR EACH ROW
EXECUTE FUNCTION verificaDataNascimento();

-- Tentando inserir um magizoologista com uma data de nascimento no futuro
INSERT INTO magizoologista (cum, nome, data_nasc) 
VALUES ('DEF456', 'Novo Magizoologista', '2025-01-01');

-- Tentando inserir um magizoologista com uma data válida
INSERT INTO magizoologista (cum, nome, data_nasc) 
VALUES ('DEF456', 'Novo Magizoologista', '1990-05-23');

-- Verificar se os magizoologistas foram inseridos corretamente
SELECT * FROM magizoologista;

