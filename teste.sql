-- Criado tabela

CREATE TABLE IF NOT EXISTS public.dados_banco
(
    id serial,
    "Cliente" character varying COLLATE pg_catalog."default",
    "Sexo" char(2),
    "Idade" integer,
    "Empresa" character varying COLLATE pg_catalog."default",
    "Salario" decimal(12,2),
    "Saldo_cc" decimal(12,2),
    "Saldo_poupança" decimal(12,2),
    "Saldo_investimento" decimal(12,2),
    "Devedor_cartao" decimal(12,2),
    "Inadimplente" bit,
    
    CONSTRAINT dados_banco_pkey PRIMARY KEY (id)
)


-- Criado schema

CREATE SCHEMA banco;

-- Criado tabela do select

create table banco.cliente as
select "Cliente" as nome, "Sexo" as sexo, "Idade" as idade
 from dados_banco 


-- Criado tabelas auxiliares


CREATE TABLE banco.conta(
    conta_id      serial,
    agencia_id       int NOT NULL,
    gerente_id       int NOT NULL,
    saldo         decimal(12,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (conta_id)

);



CREATE TABLE banco.gerente(
    gerente_id       serial,    
    agencia_id       int NOT NULL,
    nome_agencia     varchar(100) NOT NULL,
    saldo         decimal(12,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (gerente_id)
);


CREATE TABLE banco.agencia(
    agencia_id       serial, 
    saldo         decimal(12,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (agencia_id)
);

-- Join da tabela agencia com a tabela conta

select * from banco.agencia
join banco.conta on banco.agencia.agencia_id = banco.conta.agencia_id

-- Selecionei a media e o maximo dos saldos agrupados

SELECT avg(saldo), max(saldo) FROM banco.agencia
group by saldo