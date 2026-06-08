# Guia de Instalação — Liveness 3D Flutter

Apresenta as informações necessárias para instalação do plugin `oiti_liveness3d` em aplicativos Flutter.

---

## 1. Biblioteca

**oiti_liveness3d** — Plugin Liveness 3D da CertiFace para Flutter.

Publicado no [pub.dev](https://pub.dev/packages/oiti_liveness3d).

---

## 2. Requisitos

| Android | iOS |
|---------|-----|
| **Gradle** 7.6+ | **iOS** 12+ |
| **minSDK** 33+ | **Swift** 5+ |
| **targetSDK** 21+ | |

---

## 3. Permissão de câmera no iOS

Nos dispositivos iOS, o aplicativo precisa de permissão para acessar a câmera. Adicione no `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>CAMERA</string>
```

Ou, no Xcode, configure **Privacy - Camera Usage Description** no `Info.plist` do projeto.

---

## 3.1. Instalação Liveness 3D

### Flutter

```bash
flutter pub add oiti_liveness3d
```

---

### 3.1.1. iOS (Configuração)

O plugin utiliza **dois SDKs nativos**, conforme o perfil de build. Ambos expõem o mesmo módulo Swift (`OILiveness3D`), mas o binário linkado muda automaticamente:

| Perfil de build | Pod utilizado | Sufixo `-Debug` |
|-----------------|---------------|-----------------|
| **Debug** | `OILiveness3D-Debug` | Sim |
| **Release / Profile** | `OILiveness3D` | Não |

| Comando / build | SDK utilizado |
|-----------------|---------------|
| `flutter run` | `OILiveness3D-Debug` |
| `flutter run --release` | `OILiveness3D` |
| `flutter run --profile` | `OILiveness3D` |
| Archive no Xcode (Release) | `OILiveness3D` |

#### Passo 1 — Sources do CocoaPods

No **topo** do `ios/Podfile`:

```ruby
source 'https://github.com/oititec/ios-artifactory.git'
source 'https://cdn.cocoapods.org'
```

> Substitui a abordagem anterior de declarar `:source` diretamente no pod.

#### Passo 2 — SDK de Debug (desenvolvimento local)

Dentro do `target 'Runner'`, adicione **uma linha** antes de `flutter_install_all_ios_pods` (função padrão do Flutter — já presente em todo projeto Flutter):

```ruby
pod 'OILiveness3D-Debug', '3.15.0', :configurations => ['Debug']
```

| Parte da linha | Obrigatório | Descrição |
|----------------|-------------|-----------|
| `'OILiveness3D-Debug'` | Sim | Nome do pod de desenvolvimento |
| `'3.15.0'` | Sim | Versão do SDK (alinhar com a do plugin) |
| `:configurations => ['Debug']` | Sim | Restringe o SDK de debug apenas a builds Debug |

#### Passo 3 — SDK de Release (produção)

**Nenhuma ação do cliente.** O pod de produção já vem no `podspec` do plugin:

```ruby
# Incluído automaticamente — NÃO adicionar no Podfile
s.dependency 'OILiveness3D', '3.15.0', :configurations => ['Release']
```

#### O que o plugin faz automaticamente

Ao instalar o plugin via `flutter pub add`, a configuração nativa iOS é aplicada automaticamente:

- Resolve o SDK de **Release** como dependência do plugin (sem ação no `Podfile`)
- Trata a coexistência dos dois SDKs durante o `pod install` e o build
- Garante o embed correto por configuração (Debug usa `-Debug`; Release/Profile usa produção)

**O cliente não precisa** adicionar `require`, hooks de `pre_install`/`post_install`, o pod `OILiveness3D` de produção nem pods auxiliares (`OILiveness3D_FT`, etc.).

#### Mapeamento Profile → Release

Mantenha o padrão do Flutter no `Podfile` (já presente na maioria dos projetos):

```ruby
project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}
```

O modo **Profile** (`flutter run --profile`) é usado para medição de performance — não é Debug. Por isso Profile e Release compartilham o SDK de produção no CocoaPods.

#### Instalação dos pods

```bash
cd ios && pod install && cd ..
```

Ou, a partir da raiz do projeto:

```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
```

#### Exemplo de `Podfile` (trecho relevante)

```ruby
platform :ios, '13.0'

source 'https://github.com/oititec/ios-artifactory.git'
source 'https://cdn.cocoapods.org'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

# ... flutter_root e helpers padrão do Flutter ...

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  pod 'OILiveness3D-Debug', '3.15.0', :configurations => ['Debug']

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
end
```

#### Verificação iOS

Após `pod install`, confirme no `Podfile.lock`:
- `OILiveness3D-Debug` — dependência do Podfile (builds Debug)
- `OILiveness3D` — dependência do plugin (builds Release/Profile)

---

### 3.1.2. Android (Configuração)

Adicione o repositório Maven do SDK nativo no `android/build.gradle`, dentro de `allprojects`:

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url 'https://raw.githubusercontent.com/oititec/android-oiti-versions/master'
        }
    }
}
```

---

## Migração em relação à documentação anterior

| Antes ([DevCenter](https://devcenter.certiface.io/docs/guia-de-instalacao-flutter#31-instalação-liveness-3d)) | Agora |
|-----|-------|
| `pod 'OILiveness3D', :source => '...'` no Podfile | **Removido** — Release vem do plugin |
| Um único SDK para todos os builds | Dois SDKs: `-Debug` (dev) e produção (release) |
| Source no pod | Source no **topo** do Podfile |

---

## Troubleshooting

**Erro ao resolver `OILiveness3D-Debug` ou `OILiveness3D`**
- Verifique as sources no topo do `Podfile`
- Confirme a versão do SDK (`3.15.0`) com a equipe Oiti

**Sandbox is not in sync with the Podfile.lock**
```bash
cd ios && pod install
```

**`Multiple commands produce ... OILiveness3D.framework` ou `FaceTecSDK.framework`**
- Atualize o plugin `oiti_liveness3d` para a versão mais recente disponível no [pub.dev](https://pub.dev/packages/oiti_liveness3d)
- Rode `flutter pub get` e `cd ios && pod install` novamente
- Confirme `:configurations => ['Debug']` na linha do pod de debug
- Não adicione manualmente o pod `OILiveness3D` (produção) no `Podfile` — ele já vem do plugin

**`Unable to resolve module dependency: 'OILiveness3D'` em build Debug**
- Rode `flutter pub get` e `cd ios && pod install` após adicionar a linha do pod de debug
- Verifique se a linha está **antes** de `flutter_install_all_ios_pods` dentro do `target 'Runner'`
- Confirme as sources do artifactory no topo do `Podfile`

---
