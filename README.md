# Desafio Técnico - Cientista de Dados Júnior

## Descrição

Este repositório é destinado a resolver o desafio técnico para a vaga de Cientista de Dados Júnior no Escritório Municipal de Dados do Rio de Janeiro. O objetivo deste desafio é realizar análises exploratórias em conjuntos de dados públicos disponíveis no BigQuery, responder a perguntas específicas sobre esses dados utilizando SQL e Python, e criar visualizações informativas e visualmente atraentes.

### Conjunto de Dados

Os conjuntos de dados que serão utilizados neste desafio são:

- **Chamados do 1746:** Dados relacionados a chamados de serviços públicos na cidade do Rio de Janeiro. O caminho da tabela é: `datario.administracao_servicos_publicos.chamado_1746`
- **Bairros do Rio de Janeiro:** Dados sobre os bairros da cidade do Rio de Janeiro - RJ. O caminho da tabela é: `datario.dados_mestres.bairro`
- **Ocupação Hoteleira em Grandes Eventos no Rio**: Dados contendo o período de duração de alguns grandes eventos que ocorreram no Rio de Janeiro em 2022 e 2023 e a taxa de ocupação hoteleira da cidade nesses períodos. O caminho da tabela é: `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`

### Perguntas do Desafio

1. Quantos chamados foram abertos no dia 01/04/2023?
2. Qual o tipo de chamado que teve mais teve chamados abertos no dia 01/04/2023?
3. Quais os nomes dos 3 bairros que mais tiveram chamados abertos nesse dia?
4. Qual o nome da subprefeitura com mais chamados abertos nesse dia?
5. Existe algum chamado aberto nesse dia que não foi associado a um bairro ou subprefeitura na tabela de bairros? Se sim, por que isso acontece?
6. Quantos chamados com o subtipo "Perturbação do sossego" foram abertos desde 01/01/2022 até 31/12/2023 (incluindo extremidades)?
7. Selecione os chamados com esse subtipo que foram abertos durante os eventos contidos na tabela de eventos (Reveillon, Carnaval e Rock in Rio).
8. Quantos chamados desse subtipo foram abertos em cada evento?
9. Qual evento teve a maior média diária de chamados abertos desse subtipo?
10. Compare as médias diárias de chamados abertos desse subtipo durante os eventos específicos (Reveillon, Carnaval e Rock in Rio) e a média diária de chamados abertos desse subtipo considerando todo o período de 01/01/2022 até 31/12/2023.