-- Questão 1
SELECT COUNT(*) as NumeroChamados
FROM datario.administracao_servicos_publicos.chamado_1746
WHERE DATETIME_TRUNC(data_inicio, DAY) = '2023-04-01T00:00:00';

-- Questão 2
WITH tipo_chamados AS (
  SELECT 
      tipo
    , COUNT(*) as NumeroChamados
  FROM datario.administracao_servicos_publicos.chamado_1746
  WHERE DATETIME_TRUNC(data_inicio, DAY) = '2023-04-01T00:00:00'
  GROUP BY tipo
  ORDER BY NumeroChamados DESC
  LIMIT 1
)
SELECT tipo
FROM tipo_chamados;

-- Questão 3
WITH bairro_chamados AS (
  SELECT
      bairros.nome as Bairro
    , COUNT(*) as NumeroChamados
  FROM datario.administracao_servicos_publicos.chamado_1746 chamados
  LEFT JOIN datario.dados_mestres.bairro bairros
    USING(id_bairro)
  WHERE DATETIME_TRUNC(data_inicio, DAY) = '2023-04-01T00:00:00'
  GROUP BY bairros.nome
  ORDER BY NumeroChamados DESC
  LIMIT 3
) 
SELECT Bairro
FROM bairro_chamados;

-- Questão 4
WITH subprefeitura_chamados AS (
  SELECT 
      bairros.subprefeitura as Subprefeitura
    , COUNT(*) as NumeroChamados
  FROM datario.administracao_servicos_publicos.chamado_1746 chamados
  LEFT JOIN datario.dados_mestres.bairro bairros
    USING(id_bairro)
  WHERE DATETIME_TRUNC(data_inicio, DAY) = '2023-04-01T00:00:00'
  GROUP BY bairros.subprefeitura
  ORDER BY NumeroChamados DESC
  LIMIT 1
)
SELECT subprefeitura
FROM subprefeitura_chamados;

-- Questão 5
SELECT 
    bairros.nome
  , chamados.id_bairro
  , bairros.subprefeitura
  , COUNT(*) as NumeroChamados
FROM datario.administracao_servicos_publicos.chamado_1746 chamados
LEFT JOIN datario.dados_mestres.bairro bairros
  USING(id_bairro)
WHERE
  1=1
  AND DATETIME_TRUNC(data_inicio, DAY) = '2023-04-01T00:00:00'
  AND (bairros.nome IS NULL OR bairros.subprefeitura IS NULL)
GROUP BY bairros.nome, chamados.id_bairro,bairros.subprefeitura;

SELECT * 
FROM datario.administracao_servicos_publicos.chamado_1746
WHERE DATETIME_TRUNC(data_inicio, DAY) = '2023-04-01T00:00:00'
AND id_bairro IS NULL;

-- Questão 6
SELECT COUNT(*)
FROM datario.administracao_servicos_publicos.chamado_1746
WHERE data_inicio BETWEEN '2022-01-01T00:00:00' AND '2023-12-31T23:59:59'
AND subtipo = 'Perturbação do sossego';

-- Questão 7
SELECT chamados.id_chamado
      ,chamados.data_inicio
      ,chamados.id_bairro
      ,chamados.tipo
      ,chamados.subtipo
      ,chamados.situacao
      ,eventos.*
FROM datario.administracao_servicos_publicos.chamado_1746 chamados
INNER JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos eventos
  ON DATETIME_TRUNC(chamados.data_inicio, DAY) BETWEEN eventos.data_inicial AND eventos.data_final
WHERE chamados.subtipo = 'Perturbação do sossego';

-- Questão 8
SELECT eventos.evento
      ,COUNT(*) as NumeroChamados
FROM datario.administracao_servicos_publicos.chamado_1746 chamados
INNER JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos eventos
  ON DATETIME_TRUNC(chamados.data_inicio, DAY) BETWEEN eventos.data_inicial AND eventos.data_final
WHERE chamados.subtipo = 'Perturbação do sossego'
GROUP BY eventos.evento
ORDER BY NumeroChamados DESC;

-- Questão 9
WITH duracao_evento AS (
  SELECT 
      evento as Evento
    , SUM(DATE_DIFF(data_final, data_inicial, DAY) + 1) as Duracao
  FROM datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos
  GROUP BY evento
),
chamados_evento AS (
  SELECT 
      eventos.evento as Evento
    , COUNT(*) as NumeroChamados
  FROM datario.administracao_servicos_publicos.chamado_1746 chamados
  INNER JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos eventos
    ON DATETIME_TRUNC(chamados.data_inicio, DAY) BETWEEN eventos.data_inicial AND eventos.data_final
  WHERE chamados.subtipo = 'Perturbação do sossego'
  GROUP BY eventos.evento
) 
SELECT 
    duracao_evento.evento
  , ROUND(chamados_evento.NumeroChamados/duracao_evento.Duracao, 2) as MediaDiariaChamados   
FROM duracao_evento
INNER JOIN chamados_evento
  USING(Evento)
ORDER BY MediaDiariaChamados DESC
LIMIT 1;

-- Questão 10
WITH duracao_evento AS (
  SELECT 
      evento as Evento
    , SUM(DATE_DIFF(data_final, data_inicial, DAY) + 1) as Duracao
  FROM datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos
  GROUP BY evento
),
chamados_evento AS (
  SELECT 
      eventos.evento as Evento
    , COUNT(*) as NumeroChamados
  FROM datario.administracao_servicos_publicos.chamado_1746 chamados
  INNER JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos eventos
    ON DATETIME_TRUNC(chamados.data_inicio, DAY) BETWEEN eventos.data_inicial AND eventos.data_final
  WHERE chamados.subtipo = 'Perturbação do sossego'
  GROUP BY eventos.evento
) 
SELECT 
    duracao_evento.evento
  , ROUND(chamados_evento.NumeroChamados/duracao_evento.Duracao, 2) as MediaDiariaChamados   
FROM duracao_evento
INNER JOIN chamados_evento
  USING(Evento)

UNION ALL

SELECT
    'Ano 2022 e 2023' AS descricao 
  , ROUND(COUNT(*)/DATE_DIFF('2024-01-01', '2022-01-01', DAY), 2)
FROM datario.administracao_servicos_publicos.chamado_1746
WHERE data_inicio BETWEEN '2022-01-01T00:00:00' AND '2023-12-31T23:59:59'
AND subtipo = 'Perturbação do sossego'
ORDER BY MediaDiariaChamados DESC;