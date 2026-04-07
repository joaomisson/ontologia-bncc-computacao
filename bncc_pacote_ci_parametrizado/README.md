# Pacote adicional: SPARQL parametrizada + SHACL com severidades para CI

Este pacote complementa os arquivos já gerados para a ontologia da BNCC Computação com:

1. uma versão de shapes SHACL orientada a **pipeline CI/CD**, com severidades explícitas em `sh:Info`, `sh:Warning` e `sh:Violation`;
2. um conjunto adicional de **consultas SPARQL parametrizadas por ano, eixo, conceito e plano curricular**;
3. exemplos de automação em shell e GitHub Actions.

## Estrutura

- `bncc_computacao_shapes_ci.ttl`
- `sparql_parametrizadas/`
  - `q01_itens_por_ano_e_eixo.rq`
  - `q02_itens_por_conceito.rq`
  - `q03_progressao_vertical_por_conceito_ano_e_eixo.rq`
  - `q04_prerequisitos_explicitos_parametrizados.rq`
  - `q05_prerequisitos_implicitos_parametrizados.rq`
  - `q06_lacunas_de_itens_no_plano_por_ano_e_eixo.rq`
  - `q07_lacunas_de_conceitos_no_plano_por_ano_e_eixo.rq`
  - `q08_prerequisitos_conceituais_faltantes_no_plano_por_ano_e_eixo.rq`
  - `q09_cobertura_do_plano_por_conceito_ano_e_eixo.rq`
  - `q10_matriz_curricular_por_ano_eixo_conceito.rq`
  - `q11_heatmap_cobertura_plano_por_ano_e_eixo.rq`
  - `q12_resumo_progressao_por_ano_eixo_conceito.rq`
- `ci/run_shacl_ci.sh`
- `ci/requirements.txt`
- `ci/github-actions-example.yml`

## Política de severidade sugerida

### Violation
Use para falhar o pipeline. Neste pacote, entram aqui:
- erro de cardinalidade estrutural;
- código BNCC ausente, duplicado ou em padrão inválido;
- item normativo sem vínculos curriculares mínimos;
- uso indevido de `bc:temObjetoConhecimento` no Ensino Médio;
- conceito em ciclo por `bc:requerConceito+`.

### Warning
Use para sinalizar revisão humana, sem necessariamente bloquear merge:
- `bc:temPrerequisitoExplicito` sem precedência observável;
- `bc:aprofunda` sem conceito compartilhado;
- `bc:cobreConceito` declarado sem suporte em item implementado;
- conceito computacional ainda não mobilizado no currículo modelado.

### Info
Use para higiene semântica e observabilidade:
- ausência de `rdfs:label`;
- ausência de `bc:textoNormativo`;
- ausência de `bc:paginaFonte`;
- falta de materialização explícita de `bc:abordaConceito` em habilidades do Fundamental.

## Convenção de parametrização nas queries

As queries usam `VALUES` com parâmetros como:

- `?anoSel`
- `?eixoSel`
- `?conceitoSel`
- `?planoSel`

Para desabilitar um filtro, use `UNDEF`.

Exemplos:
```sparql
VALUES (?anoSel ?eixoSel ?conceitoSel) { (bc:Ano8EF bc:CulturaDigital UNDEF) }
VALUES (?planoSel ?anoSel ?eixoSel) { (bc:PlanoExemploSegurancaEF8 bc:Ano8EF bc:CulturaDigital) }
VALUES (?conceitoSel ?anoSel ?eixoSel) { (bc:Algoritmo UNDEF UNDEF) }
```

## Uso sugerido em CI

### Opção 1 — `pyshacl`
```bash
pip install -r ci/requirements.txt
bash ci/run_shacl_ci.sh /caminho/ontologia_bncc_computacao_inicial.ttl
```

O script considera:
- `sh:Violation` como falha de pipeline;
- `sh:Warning` e `sh:Info` como saída diagnóstica.

### Opção 2 — endpoint SPARQL / RDF triplestore
As consultas `.rq` podem ser executadas após a validação SHACL para alimentar:
- dashboards curriculares;
- checagem de lacunas por ano/eixo;
- gates de cobertura mínima;
- relatórios de progressão conceitual.

## Sequência operacional recomendada

1. validar sintaxe RDF/Turtle;
2. executar SHACL CI;
3. materializar `temPrerequisitoImplicito`, se desejado, com o pacote anterior;
4. rodar queries parametrizadas por ano/eixo/conceito;
5. transformar resultados em artefatos de observabilidade do pipeline.

## Observação importante

As queries de lacunas operam sob **escopo fechado operacional** por meio de parâmetros (`VALUES`), porque OWL trabalha sob hipótese de mundo aberto. Portanto, a decisão de “falta” ou “cobertura insuficiente” deve ser tratada como uma política analítica do pipeline, e não apenas como inferência lógica aberta.
