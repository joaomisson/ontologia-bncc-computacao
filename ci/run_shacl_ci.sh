#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Uso: $0 /caminho/ontologia_bncc_computacao_inicial.ttl [caminho_shapes_ci]"
  exit 2
fi

DATA_GRAPH="$1"
SHAPES_GRAPH="${2:-bncc_computacao_shapes_ci.ttl}"

if ! command -v pyshacl >/dev/null 2>&1; then
  echo "Erro: pyshacl não encontrado no PATH. Instale com: pip install -r ci/requirements.txt"
  exit 2
fi

echo "==> Validando RDF + SHACL (CI profile)"
pyshacl   -s "$SHAPES_GRAPH"   -m   -f human   --allow-info   --allow-warnings   "$DATA_GRAPH"

echo "==> Validação concluída"
echo "Observação: por padrão, apenas sh:Violation falha o pipeline."
