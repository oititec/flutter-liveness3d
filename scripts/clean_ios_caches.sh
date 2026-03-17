#!/usr/bin/env bash
# Limpa caches do Xcode que podem causar erros de módulo (.pcm inválido, "Could not build module 'os'").
# Também remove DerivedData do Runner e do plugin para forçar rebuild limpo.
#
# Uso: ./scripts/clean_ios_caches.sh [--all]
#   --all  Remove todo o DerivedData e ModuleCache do Xcode (mais lento, build seguinte será completo)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
EXAMPLE_DIR="$PROJECT_DIR/example"

DERIVED="$HOME/Library/Developer/Xcode/DerivedData"
MODULE_CACHE="$DERIVED/ModuleCache.noindex"
RUNNER_PREFIX="Runner-"
OITI_PREFIX="oiti_liveness3d-"

CLEAN_ALL=false
[ "${1:-}" = "--all" ] && CLEAN_ALL=true

echo "→ Limpando caches iOS/Xcode..."

# Sempre: ModuleCache (corrompe com frequência e gera erro de .pcm / módulo 'os')
if [ -d "$MODULE_CACHE" ]; then
  echo "  Removendo ModuleCache..."
  rm -rf "$MODULE_CACHE"
fi

# Sempre: DerivedData do Runner e do plugin (por nome aproximado)
for dir in "$DERIVED"/Runner-* "$DERIVED"/oiti_liveness3d-*; do
  [ -d "$dir" ] && echo "  Removendo $dir" && rm -rf "$dir"
done

if [ "$CLEAN_ALL" = true ]; then
  echo "  Removendo todo DerivedData..."
  rm -rf "$DERIVED"
fi

# Limpar build do Flutter no example
if [ -d "$EXAMPLE_DIR/build" ]; then
  echo "  Removendo example/build..."
  rm -rf "$EXAMPLE_DIR/build"
fi

echo "→ Caches limpos. Rode o archive novamente."
echo ""
echo "Se ainda aparecer erro de versão do Swift (OIComponents/OILiveness3D), use um Xcode"
echo "compatível com os frameworks (ex.: Swift 6.0.2). Liste versões: ls /Applications | grep Xcode"
