# Guia de Tratamento de Retornos - Flutter Liveness 3D

Este documento apresenta as informações necessárias sobre os diferentes tipos de retornos do plugin Flutter Liveness 3D.

## Sumário

- [Liveness 3D](#liveness-3d)
  - [Sucesso](#1-sucesso)
  - [Erro](#2-erro)
  - [Exemplo de Uso](#3-exemplo-de-uso)

---

## Liveness 3D

O widget `OitiLiveness3d` utiliza dois parâmetros principais para tratamento de retornos:

- `onSuccess`: Callback executado quando a prova de vida é concluída com sucesso
- `onError`: Callback executado quando ocorre algum erro durante o processo

### 1. Sucesso

O parâmetro `onSuccess` é uma função que recebe um objeto do tipo `LivenessSuccessResult`, que possui as seguintes propriedades:

| Propriedade      | Tipo     | Descrição                                                            |
|------------------|----------|----------------------------------------------------------------------|
| `valid`          | `bool`   | Indica a autenticidade das informações verificadas na prova de vida. |
| `cause`          | `String` | Indica por qual motivo o processo finalizou sem sucesso.             |
| `codId`          | `String` | Código identificador do tipo da transação.                           |
| `protocol`       | `String` | Protocolo da transação de prova de vida.                             |
| `scanResultBlob` | `String` | Blob criptografado para uso do SDK no tratamento do retorno.         |

#### Tabela de CodId

| codId   | Descrição                                                               |
|---------|-------------------------------------------------------------------------|
| `1.0`   | Prova de Vida **Aprovada**                                              |
| `300.1` | Prova de Vida **Reprovada** (face não identificada; necessário retentativa) |
| `300.2` | Prova de Vida **Reprovada** (usuário bloqueado; retentativa não disponível) |

### 2. Erro

O parâmetro `onError` é uma função que recebe um objeto do tipo `PlatformException` indicando o erro ocorrido.

As propriedades encontradas no objeto estão listadas na tabela abaixo:

| Atributo  | Tipo     | Descrição                                               |
|-----------|----------|---------------------------------------------------------|
| `code`    | `String` | Representação do erro em valor string.                  |
| `message` | `String` | Texto que contém uma mensagem explicativa sobre o erro. |

#### Tabela de Códigos de Erro

| Code | Message                                                     |
|------|-------------------------------------------------------------|
| `0`  | App Key inválido.                                           |
| `1`  | Não foi concedida permissão de acesso à câmera do aparelho. |
| `2`  | Sem conexão à Internet.                                     |
| `3`  | Prova de vida não foi completada.                           |
| `4`  | Liveness não foi inicializado corretamente.                 |

---

## Mapeamento do Platform Channel

Os erros são transmitidos através do Platform Channel (`MethodChannel`) entre as plataformas nativas e o Flutter.

### Arquitetura do Platform Channel

```
┌─────────────────────────────────────────────────────────────────────────┐
│                              FLUTTER (Dart)                              │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  MethodChannel('oiti_liveness3d')                               │    │
│  │  └─> invokeMapMethod('OITI.startLiveness3d', {...})             │    │
│  │  └─> Recebe: Map<String, dynamic> (sucesso) ou PlatformException│    │
│  └─────────────────────────────────────────────────────────────────┘    │
└───────────────────────────────┬─────────────────────────────────────────┘
                                │
        ┌───────────────────────┴───────────────────────┐
        ▼                                               ▼
┌───────────────────────────┐               ┌───────────────────────────┐
│        iOS (Swift)        │               │      Android (Kotlin)     │
│  FlutterMethodChannel     │               │     MethodChannel         │
│  'oiti_liveness3d'        │               │     'oiti_liveness3d'     │
└───────────────────────────┘               └───────────────────────────┘
```

### iOS - Mapeamento de Erros

**Arquivo:** `ios/Classes/Common/Liveness3DErrorCode.swift`

```swift
public enum Liveness3DErrorCode: Int, Error {
    case invalidAppKey = 0          // "App Key inválido."
    case noCameraPermission = 1     // "Não foi concedida permissão de acesso à câmera do aparelho."
    case noInternetConnection = 2   // "Sem conexão à Internet."
    case livenessNotCompleted = 3   // "Prova de vida não foi completada."
    case livenessNotInitialized = 4 // "Liveness não foi inicializado corretamente."
}
```

**Envio do erro para Flutter:** `ios/Classes/Extensions/OitiLiveness3dPlugin+Utils.swift`

```swift
func finishChannel(error code: Liveness3DErrorCode, result: FlutterResult?) {
    let flutterError = FlutterError(
        code: String(code.code),    // "0", "1", "2", "3" ou "4"
        message: code.message,       // Mensagem descritiva
        details: nil
    )
    result?(flutterError)
}
```

### Android - Mapeamento de Erros

**Arquivo:** `android/src/main/kotlin/.../utils/AltLiveness3d.kt`

```kotlin
// Erro de AppKey inválido
class InvalidAppKey(
    code: String = "INVALID_APP_KEY",
    message: String = "INVALID_APP_KEY"
) : AltLiveness3dException(code, message)

// Erro quando o liveness é cancelado
fun onLiveness3DResultCancelled(data: Intent?) {
    val errorMessage = data?.getStringExtra(HybridLiveness3DActivity.PARAM_RESULT_ERROR) ?: ""
    result?.error(errorMessage, errorMessage, null)
}
```

**Envio do erro para Flutter:** `android/src/main/kotlin/.../OitiLiveness3dPlugin.kt`

```kotlin
try {
    // ... inicialização do liveness
} catch (e: AltLiveness3dException) {
    result.error(e.code, e.message, null)
} catch (e: Exception) {
    result.error("UNKNOWN_ERROR", e.message, e.stackTrace)
}
```

### Flutter - Recebimento de Erros

**Arquivo:** `lib/oiti_liveness3d_method_channel.dart`

```dart
final methodChannel = const MethodChannel('oiti_liveness3d');

Future startLiveness(...) async {
    return await methodChannel.invokeMapMethod(
        'OITI.startLiveness3d',
        { ... },
    );
    // Erros são lançados como PlatformException
}
```

### Fluxo Completo de Erro

```
1. [Nativo] Ocorre erro no SDK (ex: sem permissão de câmera)
                    │
                    ▼
2. [iOS]    FlutterError(code: "1", message: "Não foi concedida...", details: nil)
   [Android] result.error("1", "Não foi concedida...", null)
                    │
                    ▼
3. [Flutter] PlatformException é lançado pelo MethodChannel
                    │
                    ▼
4. [Widget]  onError callback recebe o erro
                    │
                    ▼
5. [App]     Tratamento do erro pela aplicação
```

### Mapeamento por Plataforma

| Code | iOS (Liveness3DErrorCode)      | Android                        | Descrição                          |
|------|-------------------------------|--------------------------------|------------------------------------|
| `0`  | `.invalidAppKey`              | `INVALID_APP_KEY`              | App Key inválido                   |
| `1`  | `.noCameraPermission`         | SDK nativo                     | Sem permissão de câmera            |
| `2`  | `.noInternetConnection`       | SDK nativo                     | Sem conexão à Internet             |
| `3`  | `.livenessNotCompleted`       | `PARAM_RESULT_ERROR`           | Prova de vida não completada       |
| `4`  | `.livenessNotInitialized`     | SDK nativo                     | Liveness não inicializado          |

### 3. Exemplo de Uso

#### Método 1: Usando Widget (Recomendado)

```dart
import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';

void main() => runApp(const MaterialApp(home: ExampleWidget()));

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liveness 3D'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open liveness'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OitiLiveness3d.createLiveness3DWidget(
                appKey: 'SUA-APP-KEY',
                environment: Environment.hml, // Use Environment.prd para produção
                onSuccess: (result) {
                  // Tratamento de sucesso
                  print('Valid: ${result.valid}');
                  print('CodId: ${result.codId}');
                  print('Protocol: ${result.protocol}');
                  print('Cause: ${result.cause}');
                  
                  // Verificar resultado da prova de vida
                  if (result.valid) {
                    // Prova de vida aprovada
                    Navigator.pop(context);
                    // Prosseguir com o fluxo do app
                  } else {
                    // Verificar motivo da reprovação
                    switch (result.codId) {
                      case '300.1':
                        // Face não identificada - permitir retentativa
                        break;
                      case '300.2':
                        // Usuário bloqueado - não permitir retentativa
                        break;
                    }
                  }
                },
                onError: (error) {
                  // Tratamento de erro
                  print('Erro: $error');
                  Navigator.pop(context);
                  
                  // Exibir mensagem de erro apropriada ao usuário
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

#### Método 2: Usando Método Assíncrono

```dart
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';

class LivenessService {
  final _liveness = OitiLiveness3d();

  Future<void> executeLiveness() async {
    try {
      final result = await _liveness.openLiveness3D(
        appKey: 'SUA-APP-KEY',
        environment: Environment.hml,
      );

      if (result.valid) {
        // Prova de vida aprovada
        print('Sucesso! Protocolo: ${result.protocol}');
      } else {
        // Prova de vida reprovada
        print('Reprovado. Motivo: ${result.cause}');
      }
    } catch (error) {
      // Tratamento de erro
      print('Erro durante liveness: $error');
    }
  }
}
```

---

## Ambientes Disponíveis

O SDK suporta dois ambientes através do enum `Environment`:

| Ambiente           | Valor              | Descrição                    |
|--------------------|--------------------|------------------------------|
| Homologação        | `Environment.hml`  | Ambiente de testes           |
| Produção           | `Environment.prd`  | Ambiente de produção         |

---

## Permissões de Câmera

O SDK fornece métodos auxiliares para gerenciar permissões de câmera:

```dart
final liveness = OitiLiveness3d();

// Verificar se a permissão foi concedida
final hasPermission = await liveness.checkPermission();

// Solicitar permissão ao usuário
await liveness.askPermission();

// Abrir configurações do app (para quando a permissão foi negada)
await liveness.openSettings();
```

---

## Tratamento de Erros Recomendado

```dart
import 'package:flutter/services.dart';

onError: (error) {
  String mensagem;
  String? code;
  
  // O erro vem como PlatformException do MethodChannel
  if (error is PlatformException) {
    code = error.code;
    
    switch (code) {
      case '0':
      case 'INVALID_APP_KEY':
        mensagem = 'Configuração inválida. Entre em contato com o suporte.';
        break;
      case '1':
        mensagem = 'É necessário permitir o acesso à câmera para continuar.';
        break;
      case '2':
        mensagem = 'Verifique sua conexão com a internet e tente novamente.';
        break;
      case '3':
        mensagem = 'O processo foi interrompido. Tente novamente.';
        break;
      case '4':
        mensagem = 'Erro ao iniciar. Reinicie o aplicativo e tente novamente.';
        break;
      default:
        // Para erros não mapeados, usar a mensagem do SDK
        mensagem = error.message ?? 'Ocorreu um erro inesperado. Tente novamente.';
    }
  } else {
    mensagem = 'Ocorreu um erro inesperado. Tente novamente.';
  }
  
  // Log para debug
  debugPrint('Liveness3D Error - Code: $code, Message: $mensagem');
  
  // Exibir mensagem ao usuário
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Erro'),
      content: Text(mensagem),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
```

---

## Links Úteis

- [Guia de Instalação](https://devcenter.certiface.io/docs/guia-de-instalacao-flutter)
- [Guia de Uso e Integração](https://devcenter.certiface.io/docs/guia-de-uso-e-integracao-flutter)
- [Guia de Customização](https://devcenter.certiface.io/docs/customizacao-flutter)
- [Documentação Oficial](https://devcenter.certiface.io/docs/guia-de-tratamento-de-retornos-flutter)

---

## Suporte

Para dúvidas ou problemas, acesse o [Portal de Atendimento Oiti](https://devcenter.certiface.io/docs/portal-de-atendimento).
