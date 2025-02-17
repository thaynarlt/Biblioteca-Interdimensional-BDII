
-- -----------------------------------------------------
-- ÍNDICES
-- -----------------------------------------------------

-- 3 índices para campos indicados com justificativas dentro do contexto das consultas formuladas
CREATE INDEX idx_criatura_classe ON CRIATURA(classe); -- banco de dados localize rapidamente as linhas onde classe = 'Dragão' sem precisar varrer toda a tabela.
CREATE INDEX idx_magizoologista_cum ON MAGIZOOLOGISTA(cum); -- consultas na tabela MAGIZOOLOGISTA que façam filtros ou junções na coluna cum, agilizando essas operações.
CREATE INDEX idx_poder_nome ON PODER(nome); --melhoraria o desempenho de consultas que filtrem ou façam junção usando a coluna nome na tabela PODER.
-- Teste performance com a consulta:
EXPLAIN SELECT * FROM CRIATURA WHERE classe = 'Dragão';


-- -----------------------------------------------------
-- REESCRITA DE CONSULTAS
-- -----------------------------------------------------

-- Identificar 2 exemplos de consultas dentro do contexto da aplicação que possam e devam ser melhoradas e devam ser melhoradas. Reescrevê-las e justificar a reescrita.

-- Consulta antiga:
SELECT nome FROM CRIATURA WHERE idcriatura = 1;
-- Consulta nova:
SELECT nome, descricao FROM CRIATURA WHERE idcriatura = 1;
-- (fornece mais dados sem aumentar significativamente o custo da consulta)

-- Consulta antiga:
SELECT * FROM CAPTURA WHERE quantidade_capturada > 10;
-- Consulta nova:
SELECT ca.cacador_cum, m.nome, ca.quantidade_capturada 
FROM CAPTURA ca
JOIN MAGIZOOLOGISTA m ON ca.cacador_cum = m.cum
WHERE quantidade_capturada > 10;
-- (aprimora a usabilidade ao fornecero nome do magizoologista, sem a necessidade de uma segunda consulta.)


-- -----------------------------------------------------
-- Funções e procedures armazenadas:
-- -----------------------------------------------------

-- 1 função que use SUM, MAX, MIN, AVG ou COUNT
CREATE FUNCTION contar_criaturas() RETURNS INT AS $$
BEGIN
   RETURN (SELECT COUNT(*) FROM CRIATURA); -- COUNT
END;
$$ LANGUAGE plpgsql;
SELECT contar_criaturas();


-- Outras 2 funções com justificativa semântica, conforme os requisitos da aplicação
-- Função 1
CREATE FUNCTION idade_heroi(nome_heroi VARCHAR) RETURNS INT AS $$
BEGIN
   RETURN EXTRACT(YEAR FROM AGE((SELECT data_nasc FROM HEROI WHERE nome = nome_heroi)));
END;
$$ LANGUAGE plpgsql;
SELECT idade_heroi('Nome_do_Heroi');
SELECT idade_heroi('Harry Potter');



-- Função 2
CREATE FUNCTION verificar_perigo_poder(nome_poder VARCHAR) RETURNS VARCHAR AS $$
BEGIN
   RETURN (SELECT nivel_perigo_nome FROM PODER WHERE nome = nome_poder);
END;
$$ LANGUAGE plpgsql;
SELECT verificar_perigo_poder('Cuspir Fogo');



-- Função 3 (em análise)
CREATE OR REPLACE FUNCTION mostrarCacadoresPorCriatura(nome_criatura VARCHAR)
RETURNS VOID AS $$
DECLARE
    cacador RECORD;
    cursor_cacadores CURSOR FOR
        SELECT MZ.nome AS nome_cacador
        FROM CAPTURA CAP
        JOIN CRIATURA CR ON CAP.idcriatura = CR.idcriatura AND CAP.classe_criatura = CR.classe
        JOIN CACADOR_DE_RECOMPENSA CA ON CAP.cacador_cum = CA.cacador_cum
        JOIN MAGIZOOLOGISTA MZ ON CA.cacador_cum = MZ.cum
        WHERE CR.nome = nome_criatura;
BEGIN
    OPEN cursor_cacadores;
    LOOP
        FETCH cursor_cacadores INTO cacador;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Caçador: %', cacador.nome_cacador;
    END LOOP;
    CLOSE cursor_cacadores;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM mostrarCacadoresPorCriatura('Minotauro');


-- 1 procedure com justificativa semântica, conforme os requisitos da aplicação com:
-- ** Pelo menos uma função ou procedure deve ter tratamento de exceção
-- ** As funções desta seção não são as mesmas das funções de triggers

CREATE OR REPLACE PROCEDURE inserir_captura(
    p_quantidade_capturada INTEGER,
    p_cacador_cum VARCHAR,
    p_idcriatura INTEGER,
    p_classe_criatura VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o caçador existe na tabela CACADOR_DE_RECOMPENSA
    IF NOT EXISTS (SELECT 1 FROM CACADOR_DE_RECOMPENSA WHERE c_cum = p_cacador_cum) THEN
        RAISE EXCEPTION 'O caçador com CUM % não existe.', p_cacador_cum;
    END IF;

    -- Verifica se a criatura e a classe da criatura existem
    IF NOT EXISTS (SELECT 1 FROM CRIATURA WHERE idcriatura = p_idcriatura AND classe = p_classe_criatura) THEN
        RAISE EXCEPTION 'A criatura com ID % e classe % não existe.', p_idcriatura, p_classe_criatura;
    END IF;

    -- Insere a captura na tabela captura
    INSERT INTO captura (quantidade_capturada, cacador_cum, idcriatura, classe_criatura)
    VALUES (p_quantidade_capturada, p_cacador_cum, p_idcriatura, p_classe_criatura);
    
    RAISE NOTICE 'Captura inserida com sucesso.';
END;
$$;




-- Tentando inserir uma captura com quantidade inválida
CALL inserir_captura(-1, 'ABC123', 1, 'Dragão');

-- Tentando inserir uma captura para uma criatura que não existe
CALL inserir_captura(3, 'ABC123', 999, 'Inexistente');

-- Tentando inserir uma captura para um caçador que não existe
CALL inserir_captura(3, 'INEXISTENTE', 1, 'Dragão');

-- Inserindo uma captura válida
CALL inserir_captura(3, '7766554433UVWX6', 1, 'Seres Monstruosos');

-- Verificar se a captura foi inserida corretamente
SELECT * FROM captura;






-- -----------------------------------------------------
-- Triggers
-- -----------------------------------------------------

-- 3 diferentes triggers com justificativa semântica, de acordo com os requisitos da aplicação.

-- TRIGGER 1: para Registrar Atualizações de Proteção de Criaturas
CREATE OR REPLACE FUNCTION atualizaNivelProtecao()
RETURNS trigger AS $$
BEGIN
    -- Atualiza o nível de proteção da criatura com base no novo nível do guardião
    UPDATE protege
    SET nivel_protecao = NEW.nivel_protecao
    WHERE guardiao_cum = NEW.guardiao_cum AND idcriatura = NEW.idcriatura AND classe_criatura = NEW.classe_criatura;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER triggerAtualizaProtecao
AFTER UPDATE ON protege
FOR EACH ROW
EXECUTE FUNCTION atualizaNivelProtecao();

-- Atualizando o nível de proteção de uma criatura
UPDATE protege
SET nivel_protecao = 5
WHERE guardiao_cum = 'ABC123' AND idcriatura = 1 AND classe_criatura = 'Dragão';

-- Verificar se a tabela 'protege' foi atualizada com sucesso
SELECT * FROM protege;





-- TRIGGER 2: para Registro de Capturas de Criaturas
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




-- TRIGGER 3: para Verificar Inserções de Magizoologistas
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
