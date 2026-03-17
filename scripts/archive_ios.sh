#!/usr/bin/env bash
# Gera o archive iOS do app de exemplo (Runner).
# Uso: ./scripts/archive_ios.sh [--clean] [--clean-xcode] [--xcarchive-only]
#
# --clean           Executa flutter clean antes do build
# --clean-xcode     Limpa DerivedData/ModuleCache do Xcode (use se der erro de .pcm ou módulo 'os')
# --xcarchive-only Gera apenas o .xcarchive (não exporta IPA)
#
# Em erro "SDK is not supported by the compiler" (OIComponents/OILiveness3D): rode
#   ./scripts/clean_ios_caches.sh
# e use Xcode com Swift 6.0.2 se possível, ou atualize os frameworks OITI.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
EXAMPLE_DIR="$PROJECT_DIR/example"
ARCHIVE_DIR="$EXAMPLE_DIR/build/ios/archive"

CLEAN=false
CLEAN_XCODE=false
XCARCHIVE_ONLY=false

for arg in "$@"; do
  case "$arg" in
    --clean)        CLEAN=true ;;
    --clean-xcode)  CLEAN_XCODE=true ;;
    --xcarchive-only) XCARCHIVE_ONLY=true ;;
    -h|--help)
      echo "Uso: $0 [--clean] [--clean-xcode] [--xcarchive-only]"
      echo "  --clean           flutter clean antes do build"
      echo "  --clean-xcode      limpa DerivedData/ModuleCache do Xcode"
      echo "  --xcarchive-only  só gera o .xcarchive (não exporta IPA)"
      exit 0
      ;;
  esac
done

echo "→ Diretório do app: $EXAMPLE_DIR"
cd "$EXAMPLE_DIR"

if [ "$CLEAN_XCODE" = true ]; then
  echo "→ Limpando caches Xcode..."
  "$SCRIPT_DIR/clean_ios_caches.sh"
fi

if [ "$CLEAN" = true ]; then
  echo "→ Limpando projeto..."
  flutter clean
fi

echo "→ Obtendo dependências..."
flutter pub get

echo "→ Resolvendo pods (iOS)..."
cd ios
pod install --repo-update
cd ..

if [ "$XCARCHIVE_ONLY" = true ]; then
  echo "→ Gerando archive (.xcarchive)..."
  mkdir -p "$ARCHIVE_DIR"
  xcodebuild -workspace ios/Runner.xcworkspace \
    -scheme Runner \
    -configuration Release \
    -archivePath "$ARCHIVE_DIR/Runner.xcarchive" \
    -destination "generic/platform=iOS" \
    archive
  echo "→ Archive salvo em: $ARCHIVE_DIR/Runner.xcarchive"
else
  echo "→ Gerando IPA (archive + export)..."
  flutter build ipa
  echo "→ Build concluído. IPA em: $EXAMPLE_DIR/build/ios/ipa/"
fi

echo "→ Concluído."
