-- -----------------------------------------------------
-- População das tabelas do Banco de Dados Biblioteca Interdimensional
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
   
