# Pacote complementar: SHACL + SPARQL para a ontologia da BNCC Computação

Este pacote complementa o arquivo `ontologia_bncc_computacao_inicial.ttl` com:

1. `bncc_computacao_shapes.ttl`: shapes SHACL Core e SHACL-SPARQL;
2. consultas SPARQL focadas em pré-requisitos, progressão curricular e detecção de lacunas;
3. exemplos já parametrizados para o indivíduo `bc:PlanoExemploSegurancaEF8`.

## Arquivos

- `bncc_computacao_shapes.ttl`
- `sparql/01_prerequisitos_explicitos.rq`
- `sparql/02a_prerequisitos_implicitos_select.rq`
- `sparql/02b_materializar_prerequisitos_implicitos_construct.rq`
- `sparql/03_progressao_vertical_por_conceito.rq`
- `sparql/04_progressao_por_eixo_e_codigo.rq`
- `sparql/05_lacunas_de_itens_no_plano_por_ano.rq`
- `sparql/06_lacunas_de_conceitos_no_plano_por_ano.rq`
- `sparql/07_prerequisitos_conceituais_faltantes_no_plano.rq`
- `sparql/08_saltos_de_progressao_no_plano.rq`
- `sparql/09_resumo_cobertura_por_eixo.rq`

## Observações de uso

### 1) SHACL

Os shapes foram separados em dois grupos:

- **estruturais**: exigem cardinalidade, faixa de valores, padrões de código e alinhamento com classes;
- **analíticos**: operam como warnings, para apontar incoerências prováveis de modelagem curricular, como aprofundamento sem conceito compartilhado ou pré-requisito explícito sem precedência observável.

### 2) SPARQL

As consultas usam a namespace:

- `bc:` → `https://w3id.org/bncc/comp#`

Várias consultas estão parametrizadas com `VALUES`, para facilitar adaptação.

### 3) Reasoning

As consultas funcionam em grafo simples, mas produzem resultados melhores quando executadas com:

- RDFS/OWL RL materializado; ou
- um endpoint/engine que suporte reasoning; ou
- a saída do `02b_materializar_prerequisitos_implicitos_construct.rq` unida ao grafo base.

### 4) Lacunas de cobertura

As consultas de lacunas assumem um **escopo de comparação fechado** indicado por `VALUES`, por exemplo:

- um `bc:AnoEscolar` para o Ensino Fundamental;
- um `bc:SegmentoEtapa` para o Ensino Médio;
- um `bc:Eixo`, quando se quer avaliar cobertura temática.

Como OWL opera sob hipótese de mundo aberto, a detecção operacional de lacunas é feita por **consultas SPARQL**, não apenas por inferência OWL.

## Exemplo de fluxo de trabalho

1. carregar `ontologia_bncc_computacao_inicial.ttl`;
2. validar com `bncc_computacao_shapes.ttl`;
3. executar `02b_materializar_prerequisitos_implicitos_construct.rq`;
4. anexar o resultado ao grafo de trabalho;
5. executar as consultas de análise (`03` a `09`).
