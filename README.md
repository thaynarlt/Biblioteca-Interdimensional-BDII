# Biblioteca-Interdimensional-BDII
> Projeto de Banco de Dados II com o tema de Biblioteca-Interdimensional realizado por Thayná Tolentino e Felipe Brito

Em um universo onde **magizoologistas**, **guardiões** e **caçadores de recompensas** interagem com criaturas mágicas, surge a necessidade de uma **Biblioteca Interdimensional** para catalogar e organizar informações essenciais sobre esses seres.  

O sistema deve registrar **dados detalhados** das criaturas, como **poderes, classificação, universo de origem e conexões com heróis**. Cada criatura possui um **nível de ameaça** e está associada a uma **região específica**.  

Os **magizoologistas** precisam estar devidamente cadastrados, com seus dados pessoais e a licença do **Conselho Universal Mágico (CUM)**, permitindo que atualizem registros e acompanhem a evolução das criaturas. Eles se dividem em dois grupos principais:  

- **Guardiões**: responsáveis pela **proteção e preservação das criaturas**, garantindo sua sobrevivência. Seu nível de proteção aumenta anualmente.  
- **Caçadores de Recompensa**: especializados na **captura de criaturas raras**, utilizando informações detalhadas para rastrear e conter essas entidades.  

Os **poderes** das criaturas são categorizados por nome, descrição e **nível de perigo** (baixo, médio, alto e altíssimo). Além disso, o **universo de origem** de cada criatura desempenha um papel fundamental, influenciando suas características e sua associação com heróis lendários.  

A **conexão entre criaturas e heróis** é essencial para a pesquisa dos magizoologistas e para as estratégias dos caçadores, fornecendo informações valiosas sobre o papel dessas criaturas em seus respectivos mundos.

---
## Roteiro para Projeto de Banco de Dados Relacional - Diretrizes Gerais

- Criar um documento Google e incluir todos os códigos e enunciados/explicações solicitados.
- Os comandos devem ser entregues via um único script SQL anexado à tarefa.


### 1. Diagramas Entidade-Relacionamento (10,0 pontos)

- Diagramas em nível **conceitual** e **lógico** atualizados.

### 2. Implementação no SGBD PostgreSQL

Todas as operações devem incluir enunciado e solução, garantindo que os comandos façam sentido à aplicação e seus requisitos.

#### a. Criação e Uso de Objetos Básicos (15,0 pontos)

- Definição de **tabelas e constraints** (PK, FK, UNIQUE, NOT NULL, CHECK) conforme regras de negócio.
- 10 consultas SQL variadas com justificativa semântica:
  - **1 consulta** com uma tabela usando operadores básicos (IN, BETWEEN, IS NULL, etc.).
  - **3 consultas** com INNER JOIN.
  - **1 consulta** com LEFT/RIGHT/FULL OUTER JOIN.
  - **2 consultas** usando GROUP BY (e possivelmente HAVING).
  - **1 consulta** usando operações de conjunto (UNION, EXCEPT ou INTERSECT).
  - **2 consultas** usando subqueries.

#### b. Visões (14,0 pontos)

- **1 visão** que permita inserção.
- **2 visões robustas** (com vários joins) e justificativa semântica.

#### c. Índices (12,0 pontos)

- **3 índices** para campos relevantes, com justificativa baseada nas consultas formuladas.

#### d. Reescrita de Consultas (6,0 pontos)

- Identificação de **2 consultas** que possam ser otimizadas.
- Reescrita e justificativa das melhorias.

#### e. Funções e Procedures Armazenadas (16,0 pontos)

- **1 função** usando SUM, MAX, MIN, AVG ou COUNT.
- **2 funções** adicionais com justificativa semântica.
- **1 procedure** com justificativa semântica.
- Pelo menos uma função ou procedure deve incluir tratamento de exceção.

#### f. Triggers (12,0 pontos)

- **3 triggers** com justificativa semântica, conforme requisitos da aplicação.

---

