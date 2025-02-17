# Biblioteca-Interdimensional-BDII
> Projeto de Banco de Dados II com o tema de Biblioteca-Interdimensional realizado por Thayná Tolentino e Felipe Brito

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

