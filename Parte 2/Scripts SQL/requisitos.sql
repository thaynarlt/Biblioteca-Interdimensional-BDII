-- 1 consulta com uma tabela usando operadores básicos de filtro (e.g., IN, between, is null, etc).

SELECT nome, descricao, classe
FROM CRIATURA
WHERE idcriatura IN (
  SELECT idcriatura
  FROM CRIATURA_TEM_PODER
  WHERE poder = 'Cuspir Fogo'
);

---------------------------------------------------------------------------------------------------------------
--3 consultas com inner JOIN na cláusula FROM (pode ser self join, caso o domínio indique esse uso).

--Justificativa consulta 1: Fornecer um panorama completo dos registros de criaturas feitos pela magizoologista Fiona Moonbreeze
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
    INNER JOIN LOCALIZACAO l ON r.id_localizacao = l.id_localizacao
WHERE
    m.nome = 'Fiona Moonbreeze';


--Justificativa consulta 2: Listar todas as criaturas, conjutamente com sua classe, descricao da classe, o poder da criatura e a descricao do poder
SELECT
    cr.nome AS nome_criatura,
    cl.nome AS classe_criatura,
	cl.descricao AS descricao_da_classe,
    p.nome AS poder_associado,
    p.descricao AS descricao_do_poder
FROM
    CRIATURA cr
    INNER JOIN CLASSE cl ON cr.classe = cl.nome
    INNER JOIN CRIATURA_TEM_PODER ctp ON cr.idcriatura = ctp.idcriatura
    INNER JOIN PODER p ON ctp.poder = p.nome;


--Justificativa consulta 3: Fornece uma visão detalhada sobre quais poderes estão associados a quais criaturas, bem como o nível de perigo de cada poder.
SELECT
    c.nome AS nome_criatura,
    c.descricao AS descricao_criatura,
    p.nome AS poder_da_criatura,
    p.descricao AS descricao_poder,
    n.nome AS nivel_perigo
FROM
    CRIATURA_TEM_PODER ct
    INNER JOIN CRIATURA c ON ct.idcriatura = c.idcriatura AND ct.classe_criatura = c.classe
    INNER JOIN PODER p ON ct.poder = p.nome
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome;

---------------------------------------------------------------------------------------------------------------
--1 consulta com left/right/full outer join na cláusula FROM

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
---------------------------------------------------------------------------------------------------------------

--2 consultas usando Group By (e possivelmente o having)

--1. Justificativa: Mostra o número de criaturas em cada classe
SELECT
    c.classe AS nome_classe,
    COUNT(c.idcriatura) AS quantidade_criaturas
FROM
    CRIATURA c
GROUP BY
    c.classe;

--2. Justificativa: Mostra o número de criaturas com mais de um poder
SELECT 
    cr.nome AS nome_criatura,
    COUNT(ctp.poder) AS quantidade_poderes
FROM 
    CRIATURA cr
    INNER JOIN CRIATURA_TEM_PODER ctp ON cr.idcriatura = ctp.idcriatura
GROUP BY 
    cr.nome
HAVING 
    COUNT(ctp.poder) > 1;

---------------------------------------------------------------------------------------------------------------
--1 consulta usando alguma operação de conjunto (union, except ou intersect)

-- Justificativa: fornece uma lista das criaturas com poderes classificados como de alto nível de perigo,
-- mas sem os poderes classificados como médio.
SELECT
    p.nome AS nome_poder,
    cr.nome AS nome_criatura,
    n.nome AS nivel_perigo_poder
FROM
    PODER p
    INNER JOIN CRIATURA_TEM_PODER ctp ON p.nome = ctp.poder
    INNER JOIN CRIATURA cr ON ctp.idcriatura = cr.idcriatura
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome = 'alto'

EXCEPT

SELECT
    p.nome AS nome_poder,
    cr.nome AS nome_criatura,
    n.nome AS nivel_perigo_poder
FROM
    PODER p
    INNER JOIN CRIATURA_TEM_PODER ctp ON p.nome = ctp.poder
    INNER JOIN CRIATURA cr ON ctp.idcriatura = cr.idcriatura
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome = 'medio';
---------------------------------------------------------------------------------------------------------------

--2 consultas que usem subqueries.

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

--2. Justificativa: 
-- A consulta encontra as criaturas que possuem o maior número de poderes em relação a todas as criaturas registradas no banco de dados.
-- Utiliza uma subconsulta para calcular o máximo de poderes e filtra as criaturas que possuem esse número máximo.
SELECT c.idcriatura, c.nome,
    COUNT(ct.poder) AS total_poderes
FROM
    CRIATURA c
    INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
GROUP BY
    c.idcriatura, c.nome
HAVING
    COUNT(ct.poder) = (
        -- Subconsulta para encontrar o número máximo de poderes atribuídos a qualquer criatura
        SELECT
            MAX(poder_count)
        FROM (
            SELECT c.idcriatura,
                COUNT(ct.poder) AS poder_count
            FROM
                CRIATURA c
                INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
            GROUP BY c.idcriatura
        ) AS subquery
    );


---------------------------------------------------------------------------------------------------------------

-- VIEW QUE PERMITE INSERÇÃO
CREATE OR REPLACE VIEW visao_insercao_criatura AS
SELECT idcriatura, nome, classe
FROM CRIATURA
WITH CHECK OPTION; -- Inserção de dados

-- Testanto inserção de dados de uma nova criatura
INSERT INTO visao_insercao_criatura (idcriatura, nome, classe)
VALUES (47, 'Ogro', 'Seres Monstruosos');

-- Testando view
SELECT * FROM visao_insercao_criatura;
---------------------------------------------------------------------------------------------------------------

-- VIEW ROBUSTA 1
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


-- VIEW ROBUSTA 2
CREATE OR REPLACE VIEW visao_criaturas_por_regiao_magizoologista AS
SELECT 
    l.regiao AS regiao_localizacao,
    c.idcriatura,
    c.nome AS nome_criatura,
    m.nome AS nome_magizoologista,
    COUNT(r.id_registro) AS total_registros
FROM 
    CRIATURA c
INNER JOIN 
    REGISTRO r ON c.idcriatura = r.idcriatura
INNER JOIN 
    LOCALIZACAO l ON r.id_localizacao = l.id_localizacao
INNER JOIN 
    MAGIZOOLOGISTA m ON r.cum_magizoologista = m.cum
GROUP BY 
    l.regiao, c.idcriatura, c.nome, m.nome
ORDER BY 
    total_registros DESC, regiao_localizacao;

--Chamada da view:
SELECT * FROM visao_criaturas_por_regiao_magizoologista;

---------------------------------------------------------------------------------------------------------------
-- ÍNDICE 1
CREATE INDEX idx_criatura_nome ON CRIATURA(nome);
-- banco de dados localiza rapidamente as linhas onde nome = 'Dragão' sem precisar varrer toda a tabela.


-- ÍNDICE 2
CREATE INDEX idx_magizoologista_cum ON MAGIZOOLOGISTA(cum);
-- consultas na tabela MAGIZOOLOGISTA que façam filtros ou junções na coluna cum, agilizando essas operações.


-- ÍNDICE 3
CREATE INDEX idx_poder_nome ON PODER(nome);
--melhoraria o desempenho de consultas que filtrem ou façam junção usando a coluna nome na tabela PODER.

---------------------------------------------------------------------------------------------------------------
-- REESCRITA DE CONSULTAS

-- CONSULTA 1: ORIGINAL
SELECT
    p.nome AS nome_poder,
    cr.nome AS nome_criatura,
    n.nome AS nivel_perigo_poder
FROM
    PODER p
    INNER JOIN CRIATURA_TEM_PODER ctp ON p.nome = ctp.poder
    INNER JOIN CRIATURA cr ON ctp.idcriatura = cr.idcriatura
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome = 'alto'

EXCEPT

SELECT
    p.nome AS nome_poder,
    cr.nome AS nome_criatura,
    n.nome AS nivel_perigo_poder
FROM
    PODER p
    INNER JOIN CRIATURA_TEM_PODER ctp ON p.nome = ctp.poder
    INNER JOIN CRIATURA cr ON ctp.idcriatura = cr.idcriatura
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome = 'medio';

-- CONSULTA 1: OTIMIZADA
SELECT
    p.nome AS nome_poder,
    cr.nome AS nome_criatura,
    n.nome AS nivel_perigo_poder
FROM
    PODER p
    INNER JOIN CRIATURA_TEM_PODER ctp ON p.nome = ctp.poder
    INNER JOIN CRIATURA cr ON ctp.idcriatura = cr.idcriatura
    INNER JOIN nivel_perigo n ON p.nivel_perigo_nome = n.nome
WHERE
    n.nome = 'alto'
    AND NOT EXISTS (
        SELECT 1
        FROM PODER p2
        INNER JOIN CRIATURA_TEM_PODER ctp2 ON p2.nome = ctp2.poder
        INNER JOIN nivel_perigo n2 ON p2.nivel_perigo_nome = n2.nome
        WHERE n2.nome = 'medio'
        AND p2.nome = p.nome
        AND cr.nome = cr.nome
    );


-- CONSULTA 2:ORIGINAL
SELECT c.idcriatura, c.nome,
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
            SELECT c.idcriatura,
                COUNT(ct.poder) AS poder_count
            FROM
                CRIATURA c
                INNER JOIN CRIATURA_TEM_PODER ct ON c.idcriatura = ct.idcriatura AND c.classe = ct.classe_criatura
            GROUP BY c.idcriatura
        ) AS subquery
    );


-- CONSULTA 2:OTIMIZADA
SELECT c.idcriatura, c.nome, COUNT(ct.poder) AS total_poderes
FROM CRIATURA c
INNER JOIN CRIATURA_TEM_PODER ct 
    ON c.idcriatura = ct.idcriatura 
    AND c.classe = ct.classe_criatura
GROUP BY c.idcriatura, c.nome
HAVING COUNT(ct.poder) = (
    SELECT COUNT(ct2.poder) 
    FROM CRIATURA_TEM_PODER ct2
    GROUP BY ct2.idcriatura
    ORDER BY COUNT(ct2.poder) DESC
    LIMIT 1
);
---------------------------------------------------------------------------------------------------------------
-- FUNÇÃO
-- 1 função que use SUM, MAX, MIN, AVG ou COUNT
CREATE FUNCTION contar_criaturas_por_poder(poder_nome TEXT) RETURNS INT AS $$
DECLARE 
    total INT;
BEGIN
    SELECT COUNT(DISTINCT c.idcriatura) 
    INTO total
    FROM CRIATURA c
    INNER JOIN CRIATURA_TEM_PODER ctp ON c.idcriatura = ctp.idcriatura
    WHERE ctp.poder = poder_nome;

    RETURN total;
END;
$$ LANGUAGE plpgsql;

--Chamada da função:
SELECT contar_criaturas_por_poder('Teletransporte');


-- Outras 2 funções com justificativa semântica, conforme os requisitos da aplicação
-- Função para Verificar nivel de perigo de um poder
CREATE FUNCTION verificar_perigo_poder(nome_poder VARCHAR) RETURNS VARCHAR AS $$
BEGIN
   RETURN (SELECT nivel_perigo_nome FROM PODER WHERE nome = nome_poder);
END;
$$ LANGUAGE plpgsql;

--Chamada da função:
SELECT verificar_perigo_poder('Cuspir Fogo');


-- Função Mostrar caçadores através de criatura 
CREATE OR REPLACE FUNCTION get_cacadores_por_criatura(nome_criatura VARCHAR)
RETURNS TABLE (
  nome_cacador VARCHAR,
  especialidade VARCHAR,
  equipamentos VARCHAR
) AS $$
BEGIN
  RETURN QUERY 
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

  RAISE NOTICE 'Caçadores de % listados com sucesso.', nome_criatura;
END;
$$ LANGUAGE plpgsql;

--Chamada da função:
SELECT * FROM get_cacadores_por_criatura('Dragão');

---------------------------------------------------------------------------------------------------------------
-- PROCEDURE
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


--Teste da procedure SEM ERRO
CALL AtualizarNivelGuardiao('1234567890ABCD1', 7);
SELECT * FROM guardiao;

--Teste da procedure COM ERRO
CALL AtualizarNivelGuardiao('2358967890ABCD1', 9);
-- Mensagem: NOTA:  Erro ao atualizar o nível de proteção: Guardião com CUM 2358967890ABCD1 não encontrado.

---------------------------------------------------------------------------------------------------------------
-- TRIGGER 1
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


-- TRIGGER 2
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


-- TRIGGER 3
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

---------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION verificar_cum_duplicado()
RETURNS trigger AS $$
DECLARE
    nome_magizoologista VARCHAR;
BEGIN
    -- Verifica se o 'cum' do magizoologista já existe na tabela
    SELECT nome INTO nome_magizoologista
    FROM MAGIZOOLOGISTA
    WHERE cum = NEW.cum
    LIMIT 1;

    -- Se o 'cum' já existir, gera um erro com o nome do magizoologista
    IF nome_magizoologista IS NOT NULL THEN
        RAISE EXCEPTION 'O cum % já está registrado para o magizoologista %.', NEW.cum, nome_magizoologista;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verifica_cum_duplicado
BEFORE INSERT ON MAGIZOOLOGISTA
FOR EACH ROW
EXECUTE FUNCTION verificar_cum_duplicado();

-- Supondo que o cum '9988776655CDEF8' já esteja registrado:
INSERT INTO MAGIZOOLOGISTA (cum, nome, data_nasc)
VALUES ('9988776655CDEF8', 'Albert', '1990-01-01');

-- Tentando inserir um magizoologista com cum único:
INSERT INTO MAGIZOOLOGISTA (cum, nome, data_nasc)
VALUES ('5533445566KLFN1', 'Cassandra Clair', '1985-05-20');

select * from magizoologista;
