-- ITEM A
-- matricula - Pedro E. Melha Lemos 
-- 17180398  - Rafael Scotti Zanella

-- ITEM B - conjunto das 3 consultas SQL
-- consulta 1
select NUMERO_GRUPO, NOME_GRUPO                         -- Colunas existentes em GRUPOS
       NUMERO_PESSOA, NOME_PESSOA,                      -- Colunas existentes em PESSOAS1
       TIPO_EMPENHO, DESCRICAO_EMPENHO,                 -- Colunas existentes em TIPO_EMPENHOS
       NUMERO_EMPENHO, VALOR_EMPENHADO, DATA_DESPESA    -- Colunas existentes em DESPESAS1
from PESSOAS1 natural join DESPESAS1
              natural join GRUPOS
              natural join TIPOS_EMPENHOS
where NUMERO_GRUPO between 1 and 3
  and NUMERO_PESSOA > 1000
  and NUMERO_EMPENHO > 8000
  and TIPO_EMPENHO between 5 and 8  
  and DATA_DESPESA between '01-OUT-10' and '1-OUT-11'
order by VALOR_EMPENHADO;

--consulta 2
select NUMERO_PESSOA, NOME_PESSOA, VALOR_EMPENHADO
from PESSOAS1 natural join DESPESAS1
where VALOR_EMPENHADO >= (select avg(VALOR_EMPENHADO) from DESPESAS1)
order by VALOR_EMPENHADO;

--consulta 3
select NOME_RUBRICA, CODIGO_RUBRICA,    -- Colunas existentes em RUBRICA
       VALOR_EMPENHADO, VALOR_PAGO      -- Colunas existentes em DESPESAS1
from RUBRICAS left join DESPESAS1
    on RUBRICAS.NUMERO_RUBRICA = DESPESAS1.NUMERO_RUBRICA
order by CODIGO_RUBRICA;

-- ITEM C - conjunto de comandos de criacao dos indices consulta 1 e 2 respectivamente
create index IX_DATA_DESPESA on DESPESAS1 (DATA_DESPESA);
create index IX_VALOR_EMPENHADO on DESPESAS1 (VALOR_EMPENHADO);

-- ITEM D - as consultas 1 e 2 repetidas, mais a consulta 3 modificada
-- consulta 1
select NUMERO_GRUPO, NOME_GRUPO                         -- Colunas existentes em GRUPOS
       NUMERO_PESSOA, NOME_PESSOA,                      -- Colunas existentes em PESSOAS1
       TIPO_EMPENHO, DESCRICAO_EMPENHO,                 -- Colunas existentes em TIPO_EMPENHOS
       NUMERO_EMPENHO, VALOR_EMPENHADO, DATA_DESPESA    -- Colunas existentes em DESPESAS1
from PESSOAS1 natural join DESPESAS1
              natural join GRUPOS
              natural join TIPOS_EMPENHOS
where NUMERO_GRUPO between 1 and 3
  and NUMERO_PESSOA > 1000
  and NUMERO_EMPENHO > 8000
  and TIPO_EMPENHO between 5 and 8  
  and DATA_DESPESA between '01-OUT-10' and '1-OUT-11'
order by VALOR_EMPENHADO;

--consulta 2
select NUMERO_PESSOA, NOME_PESSOA, VALOR_EMPENHADO
from PESSOAS1 natural join DESPESAS1
where VALOR_EMPENHADO >= (select avg(VALOR_EMPENHADO) from DESPESAS1)
order by VALOR_EMPENHADO;

--consulta 3 modificada
select NOME_RUBRICA, CODIGO_RUBRICA,    -- Colunas existentes em RUBRICA
       VALOR_EMPENHADO, VALOR_PAGO      -- Colunas existentes em DESPESAS1
from RUBRICAS inner join DESPESAS1
    on RUBRICAS.NUMERO_RUBRICA = DESPESAS1.NUMERO_RUBRICA
union
select NOME_RUBRICA, CODIGO_RUBRICA,    -- Colunas existentes em RUBRICA
       NULL, NULL
from RUBRICAS
where not exists (
    select * from DESPESAS1 where RUBRICAS.NUMERO_RUBRICA = DESPESAS1.NUMERO_RUBRICA
)
order by CODIGO_RUBRICA;