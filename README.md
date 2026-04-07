# Ontologia da BNCC Computação

Repositório para modelagem ontológica da **BNCC Computação** em **OWL/RDF**, com artefatos complementares em **SHACL** e **SPARQL** para validação, análise de progressão curricular, inferência de pré-requisitos e detecção de lacunas de cobertura.

## Objetivo

Este projeto organiza uma base formal para representar os objetos curriculares da BNCC Computação, permitindo:

- modelagem semântica de **competências, habilidades, objetivos de aprendizagem e objetos de conhecimento**;
- alinhamento com **eixos curriculares** e **conceitos computacionais**;
- uso de **reasoners OWL** para consistência e inferência;
- uso de **SHACL** para validação estrutural e qualidade dos dados;
- uso de **SPARQL** para consultas analíticas e apoio a sistemas curriculares inteligentes.

## Conteúdo principal

### `ontologia_bncc_computacao_inicial.ttl`
Ontologia inicial em Turtle/OWL com:

- classes principais;
- propriedades de objeto e de dados;
- hierarquias e axiomas básicos;
- indivíduos reais da BNCC Computação;
- relações de progressão, cobertura e conceitos computacionais.

### `bncc_complemento_shacl_sparql/`
Pacote complementar com:

- shapes SHACL para validação semântica e estrutural;
- consultas SPARQL para:
  - pré-requisitos explícitos;
  - pré-requisitos implícitos;
  - progressão curricular;
  - cobertura;
  - detecção de lacunas.

### `bncc_pacote_ci_parametrizado/`
Pacote voltado para automação e integração contínua, com:

- shapes SHACL com severidades `Info`, `Warning` e `Violation`;
- consultas SPARQL parametrizadas por **ano**, **eixo**, **conceito** e **plano curricular**;
- scripts de CI;
- exemplo de workflow para GitHub Actions.

## Casos de uso

Este repositório pode ser usado para:

- análise de **progressão vertical** entre anos e etapas;
- identificação de **pré-requisitos implícitos** entre habilidades;
- verificação de **consistência estrutural** da base curricular;
- detecção de **lacunas de cobertura** em planos curriculares;
- apoio a sistemas de recomendação curricular, trilhas de aprendizagem e análise educacional.

## Tecnologias e padrões utilizados

- **OWL 2 DL**
- **RDF / Turtle**
- **SKOS**
- **Dublin Core**
- **SHACL**
- **SPARQL 1.1**

## Sugestão de uso

### 1. Validar a ontologia base
Use a ontologia principal como grafo de referência:

- `ontologia_bncc_computacao_inicial.ttl`

### 2. Aplicar validação SHACL
Escolha uma das versões:

- validação geral: `bncc_complemento_shacl_sparql/bncc_computacao_shapes.ttl`
- validação para CI: `bncc_pacote_ci_parametrizado/bncc_computacao_shapes_ci.ttl`

### 3. Executar consultas SPARQL
Use:

- `bncc_complemento_shacl_sparql/sparql/` para análises gerais;
- `bncc_pacote_ci_parametrizado/sparql_parametrizadas/` para análises parametrizadas e automação.

## Organização

```text
.
├── docs/
│   └── bncc_computacao_oficial.pdf
├── ontology/
│   └── ontologia_bncc_computacao_inicial.ttl
├── shapes/
│   ├── bncc_computacao_shapes.ttl
│   └── bncc_computacao_shapes_ci.ttl
├── queries/
│   ├── sparql/
│   └── sparql_parametrizadas/
├── ci/
│   ├── run_shacl_ci.sh
│   └── github-actions-example.yml
├── packages/
│   ├── bncc_complemento_shacl_sparql/
│   └── bncc_pacote_ci_parametrizado/
├── README.md
└── LICENSE
```

## Contribuição

Sugestões de evolução incluem:

- expansão da cobertura da BNCC Computação;
- refinamento das regras de pré-requisito e progressão;
- novas shapes SHACL para qualidade de dados;
- novas consultas SPARQL analíticas e de materialização.
