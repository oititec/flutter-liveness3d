# Instalação do Liveness 3D iOS — Debug e Release

O plugin `oiti_liveness3d` utiliza **dois SDKs nativos distintos**, conforme o perfil de build do app. Ambos expõem o mesmo módulo Swift (`OILiveness3D`), mas o binário linkado muda automaticamente:

| Perfil de build | Pod utilizado | Sufixo `-Debug` |
|-----------------|---------------|-----------------|
| **Debug** | `OILiveness3D-Debug` | Sim |
| **Release / Profile** | `OILiveness3D` | Não |

---

## Debug vs Release — quando usar cada um

### `OILiveness3D-Debug` (com sufixo `-Debug`)

Use durante o **desenvolvimento local**. Este SDK é otimizado para debug e permite validar a integração no dia a dia.

**Quando entra em ação:**
- `flutter run` (modo padrão)
- Build **Debug** no Xcode
- Testes locais em simulador ou dispositivo físico durante o desenvolvimento

**Configuração:** o cliente precisa adicionar manualmente no `Podfile` do app (veja [Configuração do Podfile — Debug](#configuração-do-podfile--debug)).

---

### `OILiveness3D` (sem sufixo `-Debug`)

Use em **qualquer build que vá para ambiente real ou de homologação final**. Este é o SDK de produção, sem o sufixo `-Debug`.

**Quando entra em ação:**
- `flutter build ios --release`
- `flutter run --release`
- `flutter run --profile` (Profile usa configuração Release no CocoaPods)
- Archive no Xcode para TestFlight ou App Store
- Builds de CI/CD para distribuição

**Configuração:** **não é necessária nenhuma ação do cliente.** O pod de Release já vem declarado no podspec do plugin (`oiti_liveness3d.podspec`) e é linkado automaticamente em builds Release e Profile.

```ruby
# Já incluído no plugin — o cliente NÃO precisa adicionar isso no Podfile
s.dependency 'OILiveness3D', '3.15.0', :configurations => ['Release']
```

> **Resumo:** adicione `OILiveness3D-Debug` no Podfile para desenvolvimento. Para publicar o app, basta fazer o build em Release — o `OILiveness3D` (sem `-Debug`) será usado automaticamente.

---

## O que o plugin faz automaticamente

A partir da versão atual do plugin, **não é necessário** adicionar `require`, hooks de `pre_install`/`post_install` nem pods extras (`OILiveness3D`, `OILiveness3D_FT`, etc.) no `Podfile` do cliente.

Ao instalar o plugin, o `oiti_liveness3d.podspec` carrega internamente o script `oiti_liveness3d_internal.rb`, que:

1. Permite a coexistência dos dois SDKs durante o `pod install` (limitação do CocoaPods com frameworks de mesmo nome).
2. Garante que, em builds **Debug**, apenas `OILiveness3D-Debug` e `OILiveness3D_FT-Debug` sejam embedados no app.
3. Garante que, em builds **Release** e **Profile**, apenas `OILiveness3D` e `OILiveness3D_FT` sejam embedados.
4. Configura o target do plugin para compilar corretamente contra o SDK de Debug quando o pod `-Debug` está presente.

**O cliente só precisa da linha do pod de Debug no `Podfile`.** Todo o restante é tratado pelo plugin.

---

## Pré-requisitos

1. **Repositório Oiti no CocoaPods** — o `Podfile` do app deve incluir a source do artifactory:

```ruby
source 'https://github.com/oititec/ios-artifactory.git'
source 'https://cdn.cocoapods.org'
```

2. **Versão do SDK** — use a mesma versão indicada na documentação do plugin (ex.: `3.15.0`) tanto para Debug quanto para Release.

3. **Mapeamento Profile → Release** — o `Podfile` deve mapear Profile como Release (padrão nos projetos Flutter):

```ruby
project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}
```

---

## Configuração do Podfile — Debug

Abra o arquivo `ios/Podfile` do seu app Flutter e, dentro do bloco `target 'Runner'`, adicione a linha do pod de debug **antes** de `flutter_install_all_ios_pods`:

```ruby
target 'Runner' do
  use_frameworks!
  use_modular_headers!

  # SDK de debug — usado apenas em builds Debug
  pod 'OILiveness3D-Debug', '3.15.0', :configurations => ['Debug']

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

> **Importante:** a opção `:configurations => ['Debug']` garante que o SDK de debug seja linkado **somente** em builds Debug. Em Release e Profile, o plugin usa automaticamente o `OILiveness3D` (sem `-Debug`).

---

## Configuração do Podfile — Release

**Nenhuma configuração adicional é necessária para Release.**

Ao instalar o plugin `oiti_liveness3d`, o pod `OILiveness3D` (versão `3.15.0`, sem sufixo `-Debug`) já é resolvido como dependência transitiva do plugin, restrito à configuração Release.

O cliente só precisa garantir que:
1. A source do artifactory Oiti está no `Podfile` (pré-requisito acima).
2. O pod de debug (`OILiveness3D-Debug`) **não** foi adicionado sem `:configurations => ['Debug']` — caso contrário, o SDK de debug poderia ser linkado em builds de produção.

---

## Instalação

Após editar o `Podfile` (apenas a linha de debug), execute:

```bash
cd ios
pod install
cd ..
```

Ou, a partir da raiz do projeto Flutter:

```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
```

---

## Verificação

| Comando | SDK esperado |
|---------|--------------|
| `flutter run` | `OILiveness3D-Debug` |
| `flutter run --release` | `OILiveness3D` |
| `flutter run --profile` | `OILiveness3D` |
| Archive no Xcode (Release) | `OILiveness3D` |

Para confirmar no `Podfile.lock`, após `pod install`:
- Deve aparecer `OILiveness3D-Debug` (dependência do Podfile, builds Debug).
- Deve aparecer `OILiveness3D` (dependência do plugin, builds Release/Profile).

Para confirmar o embed por configuração, verifique os arquivos gerados em `ios/Pods/Target Support Files/Pods-Runner/`:
- `Pods-Runner-frameworks-Debug-input-files.xcfilelist` → contém `OILiveness3D-Debug`, **não** contém `OILiveness3D/` (Release).
- `Pods-Runner-frameworks-Release-input-files.xcfilelist` → contém `OILiveness3D/`, **não** contém `OILiveness3D-Debug`.

---

## Troubleshooting

**Erro ao resolver o pod `OILiveness3D-Debug` ou `OILiveness3D`**
- Verifique se a source `https://github.com/oititec/ios-artifactory.git` está no topo do `Podfile`.
- Confirme a versão do SDK com a equipe Oiti.

**Sandbox is not in sync with the Podfile.lock**
```bash
cd ios && pod install
```

**`Multiple commands produce ... OILiveness3D.framework` ou `FaceTecSDK.framework`**
- Ocorre quando Debug e Release são embedados na mesma configuração de build.
- Atualize o plugin `oiti_liveness3d` para a versão que inclui `oiti_liveness3d_internal.rb`.
- Rode `cd ios && pod install` novamente após adicionar o pod de Debug.
- Confirme que a linha do pod de Debug possui `:configurations => ['Debug']`.

**`Unable to resolve module dependency: 'OILiveness3D'` em build Debug**
- Confirme que o pod `OILiveness3D-Debug` está declarado no `Podfile`.
- Rode `flutter pub get` e `cd ios && pod install`.

**Build Release falhando após adicionar o pod de debug**
- Não remova o pod de debug — ele só é usado em Debug graças ao `:configurations`.
- Garanta que não há outra referência manual ao `OILiveness3D-Debug` sem a restrição de configuração.

**App em produção usando SDK de debug**
- Verifique se o build foi feito em **Release** (`flutter build ios --release` ou Archive no Xcode).
- Confirme que `OILiveness3D-Debug` no Podfile possui `:configurations => ['Debug']`.

---

## Referência completa do Podfile

Exemplo mínimo com as configurações necessárias:

```ruby
platform :ios, '13.0'

source 'https://github.com/oititec/ios-artifactory.git'
source 'https://cdn.cocoapods.org'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

# ... flutter_root e demais helpers padrão do Flutter ...

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  # Debug: cliente adiciona manualmente
  pod 'OILiveness3D-Debug', '3.15.0', :configurations => ['Debug']

  # Release: resolvido automaticamente via oiti_liveness3d (OILiveness3D, sem -Debug)
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
end
```

> Um exemplo funcional está disponível em `example/ios/Podfile` neste repositório.
