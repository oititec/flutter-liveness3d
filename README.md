# [Flutter] oiti_liveness3d

# 1. Sobre o Repositório

Este repositório é responsável pelo plugin do Liveness 2d da Oiti para flutter, com ele é possível instalar e usar a função de `starLiveness3d` da Oititec disponíveis para aplicativos híbridos em React Native.

# 2. O que é o plugin?

Em Flutter, um plugin é um pacote de software que fornece acesso a recursos nativos de dispositivos, como câmera, GPS e sensores. Plugins permitem que aplicativos Flutter se comuniquem com sistemas operacionais iOS e Android, adicionando funcionalidades extras e melhorando a experiência do usuário. Eles são escritos em Dart e podem incluir código em linguagens nativas como Kotlin e Swift.

O Pub.dev é um repositório de pacotes de software para a linguagem de programação Dart, utilizada principalmente para desenvolvimento de aplicativos móveis e web. Nele, desenvolvedores podem encontrar diversas bibliotecas e ferramentas úteis para agilizar o processo de desenvolvimento. Além disso, é possível avaliar e comentar os pacotes disponíveis, o que ajuda a comunidade a identificar quais são as melhores opções. O Pub.dev é uma ferramenta valiosa para quem trabalha com Dart e quer maximizar sua produtividade.

# 3. Requisitos Mínimos

| Android                         | iOS                             |
| ------------------------------- | ------------------------------- |
| Gradle: 6.8                     | iOS: 11                         |
| Permissão de Camera: Habilitado | Permissão de Camera: Habilitado |

# 3. Uso (PASSO 1)

As instruções de uso, integração, implementação do **Liveness Oiti** podem ser acessadas através das etapas abaixo:

## 3.1. Instalação

Usando Flutter:

```bash
flutter pub add oiti_liveness3d
```

## 3.2. iOS Configuração (Configuração)

Adicionar o Pod do FaceCaptcha no seu Podfile que está localizado dentro da pasta `ios`

```objectivec
pod 'FaceCaptcha', '~> 4.10.0', :source => 'https://github.com/oititec/liveness-ios-specs.git'
```

Em seguida, caso não tenha habilitado as permissões de câmera você pode inserir as seguintes linhas no seu `info.plist`

```xml
<key>NSCameraUsageDescription</key>
<string>CAMERA</string>
```

# 4. Uso no Dart (PASSO 2)

Primeiro devemos importar o plugin 'package:oiti_liveness3d/oiti_liveness3d.dart'

```dart
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
```

## 4.1. Future

### 4.1.1. Future Existentes

| Função                   | Parâmetros                                                                     | Retorno                    |
| ------------------------ | ------------------------------------------------------------------------------ | -------------------------- |
| startliveness3d(params); | https://www.notion.so/Flutter-oiti_liveness2d-640e32e941634d0eb91a5924f22afc71 | RESULT_OK, RESULT_CANCELED |

### 4.1.2. Exemplo de uso (Funções)

Após efetuar a importação da biblioteca, deve ser aplicada a app Key gerada dentro do parâmetro da função desejada, no exemplo abaixo chamamos a função quando clicamos no botão "Liveness 2D" ou "Documentoscopia"

```dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'intruction_view.dart';
import 'permission_view.dart';

import 'package:flutter/services.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _oitiLiveness3dPlugin = OitiLiveness3d();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String? platformVersion = "11";
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Liveness + Doc - Flutter'),
        ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: Text(' '),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final appKey =
                        "SUA_APP_KEY";
                    print("\n$appKey\n");
                    try {
                      final x = await OitiLiveness3d.startliveness3d(
                          "https://comercial.certiface.com.br:8443", appKey);
                      print(x);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text("Liveness 2D")),
              ElevatedButton(
                  onPressed: () async {
                    final appKey = "SUA_APP_KEY";
                    try {
                      final x = await OitiLiveness3d.startdocumentscopy(
                          "https://comercial.certiface.com.br:8443", appKey);
                      print(x);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text("Documentoscopia"))
            ],
          ),
        ),
      ),
    );
  }
}

```

### 4.1.3. Exemplo de uso (View Customizada)

Para utilizar uma view customizada você pode aplicar o seguinte código em seu aplicativo Dart:

```jsx
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _oitiLiveness3dPlugin = OitiLiveness3d();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String? platformVersion = "11";
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Liveness + Doc - Flutter'),
        ),
        body: Center(
          child: Column(
            children: [
              Center(
                child: Text(' '),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final appKey =
                        "SUA_APP_KEY";
                    print("\n$appKey\n");
                    try {
                      final x = await OitiLiveness3d.startliveness3d(
                          "https://comercial.certiface.com.br:8443", appKey, IntroductionView());
                      print(x);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text("Liveness 2D")),
              ElevatedButton(
                  onPressed: () async {
                    final appKey = "SUA_APP_KEY";
                    try {
                      final x = await OitiLiveness3d.startdocumentscopy(
                          "https://comercial.certiface.com.br:8443", appKey, PermissionView());
                      print(x);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text("Documentoscopia"))
            ],
          ),
        ),
      ),
    );
  }
}

```

# 5. Como executar o clone do Repositório?

Execute o código abaixo em seu terminal para clonar o código:

```bash
git clone https://github.com/oititec/flutter-liveness3d
```

# 6. Como rodar o Script?

Para rodar o script desse repositório você deve na pasta root do projeto clonado rodar o comando.

> Executar sempre em dispositivos físicos e não no simulador do iOS e Android

Yarn

```bash
flutter example android
```

```bash
flutter example ios
```
