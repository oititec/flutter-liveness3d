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
pod 'OILiveness3D', '~> 1.0.1', :source => 'https://github.com/oititec/ios-artifactory.git'
```

Em seguida, caso não tenha habilitado as permissões de câmera você pode inserir as seguintes linhas no seu `info.plist`

```xml
<key>NSCameraUsageDescription</key>
<string>CAMERA</string>
```

# 4. Uso no Dart (PASSO 2)

## 4.1. Importação
Primeiro devemos importar o plugin e os _enums_.

```dart
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';
```

### 4.2. Criação do Widget do Liveness 3D
A classe `OitiLiveness3d` possui o método estático `createLiveness3DWidget(params)` que é responsável por criar e configurar o Widget do Liveness 3D.

#### 4.2.1. Parâmetros
| Parâmetro         | Tipo               | Descrição                                  |
| :---------------- | :----------------- | :----------------------------------------- |
| appKey            | String             | Chave gerada para execução dessa etapa.    |
| environment       | Environment        | Ambiente de execução desejado.             |
| textsBuilder      | TextsBuilder?      | Objeto contendo a customização dos textos. |
| loadingAppearance | LoadingAppearence? | Objeto contendo a customização do loading. |
| onSuccess         | Function(LivenessSuccessResult result) | Função de retorno de sucesso. |
| onError           | Function(Object? error) | Função de retorno de erro. |

> **Nota** <br>
> Os parâmetros `textsBuilder` e `loadingAppearance` são **opcionais** e estão relacionados a customização.

### 4.3. Tratamento dos retornos

Os parâmetros `onSuccess` e `onError` são responsáveis por receber os retornos do Widget para o devido tratamento.

#### 4.3.1. Sucesso

O parâmetro `onSuccess` é uma função que recebe um objeto do tipo `LivenessSuccessResult` que possui as seguintes propriedades:

| Propriedade    | Descrição                                                          |
| :------------- | :----------------------------------------------------------------- |
| valid          | Indica a autencidade das informações verificadas na prova de vida. |
| cause          | Código identificador do tipo da transação.                         |
| codId          | Indica por qual motivo o processo finalizou sem sucesso.           |
| protocol       | Protocolo da transação de prova de vida.                           |
| scanResultBlob | É um blob criptografado para uso do SDK no tratamento do retorno.  |

| codId | Descrição                                  |
| :---- | :----------------------------------------- |
| 1.1   | Cadastro com sucesso.                      |
| 1.2   | Certificação positiva. (Conhecido = True)  |
| 200.1 | Cadastro com alertas.                      |
| 200.2 | Certificação negativa. (Conhecido = True)  |
| 200.3 | Certificação positiva. (Conhecido = False) |
| 200.4 | Certificação negativa. (Conhecido = False) |
| 200.5 | Validação na Base da Serpro                |
| 300.1 | Prova de vida inválida.                    |
| 300.2 | Usuário foi bloqueado.                     |

#### 4.3.2. Erro

O parâmetro `onError` é uma função que recebe um objeto indicando o erro ocorrido:

### 4.4. Exemplo de uso

Após efetuar a importação da biblioteca, deve ser aplicada a App Key gerada dentro do parâmetro da função desejada, no exemplo abaixo chamamos a função quando clicamos no botão "Liveness 3D".

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
                appKey: 'APP-KEY',
                environment: Environment.hml,
                onSuccess: (result) => print(result.toString()),
                onError: (error) => print(error.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```

### 4.5. Customização

Dentro plugin é possível customizar os textos que serão apresentados durante a prova de vida e a aparência do loading apresentado depois da tela de instruções.

#### 4.5.1 Customização de textos
Para customização dos textos é necessário fazer primeiro da classe responsável.

```dart
import 'package:oiti_liveness3d/common/loading_appearance.dart';
```

**Exemplo de customização dos textos:**

```dart
import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';
import 'package:oiti_liveness3d/common/texts_builder.dart';

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
            onPressed: () {
              final builder = TextsBuilder()
                ..readyHeader1 = 'ready_header_1'
                ..readyHeader2 = 'ready_header_2';

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OitiLiveness3d.createLiveness3DWidget(
                    appKey: 'APP-KEY',
                    environment: Environment.hml,
                    textsBuilder: builder,
                    onSuccess: (result) => print(result.toString()),
                    onError: (error) => print(error.toString()),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

```

**Tags de customização**

_Ready Screen_

| **Identificador** | **Exemplos para uso de texto**                |
| :---------------- | :-------------------------------------------- |
| READY_HEADER_1    | Prepare-se para seu                           |
| READY_HEADER_2    | reconhecimento facial.                        |
| READY_MESSAGE_1   | Posicione o seu rosto na moldura, aproxime-se |
| READY_MESSAGE_2   | e toque em começar.                           |
| READY_BUTTON      | Começar                                       |

_Feedback_

| **Identificador**                        | **Exemplos para uso de texto**   |
| :--------------------------------------- | :------------------------------- |
| FEEDBACK_CENTER_FACE                     | Centralize Seu Rosto             |
| FEEDBACK_FACE_NOT_FOUND                  | Enquadre o Seu Rosto             |
| FEEDBACK_FACE_NOT_LOOKING_STRAIGHT_AHEAD | Olhe Para Frente                 |
| FEEDBACK_FACE_NOT_UPRIGHT                | Mantenha a Cabeça Reta           |
| FEEDBACK_HOLD_STEADY                     | Segure Firme                     |
| FEEDBACK_MOVE_PHONE_AWAY                 | Afaste-se                        |
| FEEDBACK_MOVE_PHONE_CLOSER               | Aproxime-se                      |
| FEEDBACK_MOVE_PHONE_TO_EYE_LEVEL         | Telefone ao Nível dos Olhos      |
| FEEDBACK_USE_EVEN_LIGHTING               | Ilumine Seu Rosto Uniformemente  |
| FEEDBACK_FRAME_YOUR_FACE                 | Encaixe Seu Rosto no Espaço Oval |
| FEEDBACK_POSITION_FACE_STRAIGHT_IN_OVAL  | Olhe Para Frente                 |
| FEEDBACK_HOLD_STEADY_1                   | Aguente Firme: 1                 |
| FEEDBACK_HOLD_STEADY_2                   | Aguente Firme: 2                 |
| FEEDBACK_HOLD_STEADY_3                   | Aguente Firme: 3                 |
| FEEDBACK_REMOVE_DARK_GLASSES             | Tire Seus Óculos de Sol          |
| FEEDBACK_NEUTRAL_EXPRESSION              | Fique Neutro, Não Sorria         |
| FEEDBACK_EYES_STRAIGHT_AHEAD             | Olhe Para Frente                 |
| FEEDBACK_CONDITIONS_TOO_BRIGHT           | Ambiente Muito Iluminado         |
| FEEDBACK_BRIGHTEN_YOUR_ENVIRONMENT       | Ambiente Muito Escuro            |

_Result Screen_

| **Identificador**      | **Exemplos para uso de texto** |
| :--------------------- | :----------------------------- |
| RESULT_UPLOAD_MESSAGE  | Enviando...                    |
| RESULT_SUCCESS_MESSAGE | Sucesso                        |

_Retry Screen_

| **Identificador**      | **Exemplos para uso de texto**       |
| :--------------------- | :----------------------------------- |
| RETRY_HEADER           | Vamos tentar novamente?              |
| RETRY_SUBHEADER        | Siga o exemplo de foto ideal abaixo: |
| RETRY_MESSAGE_SMILE    | Expressão Neutra, Sem Sorrir.        |
| RETRY_MESSAGE_LIGHTING | Evite reflexos e iluminação extrema. |
| RETRY_MESSAGE_CONTRAST | Limpe Sua Câmera.                    |
| RETRY_YOUR_PICTURE     | Sua foto.                            |
| RETRY_IDEAL_PICTURE    | Foto ideal.                          |
| RETRY_BUTTON           | Tentar novamente.                    |

#### 4.5.1 Customização do loading

Para customização do loading é necessário fazer primeiro a importação dele.

```dart
import 'package:oiti_liveness3d/common/loading_appearance.dart';
```

**Exemplo de customização do loading:**

```dart
import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';
import 'package:oiti_liveness3d/common/loading_appearance.dart';

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
            onPressed: () {
              final loadingAppearance = LoadingAppearence(
                type: LoadingType.activity,
                size: 10,
                loadingColor: 'FFFFFF',
                backgroundColor: '#000000',
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OitiLiveness3d.createLiveness3DWidget(
                    appKey: 'APP-KEY',
                    environment: Environment.hml,
                    loadingAppearance: loadingAppearance,
                    onSuccess: (result) => print(result.toString()),
                    onError: (error) => print(error.toString()),
                  ),
                ),
              );
            }),
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
