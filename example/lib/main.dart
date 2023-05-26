import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
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
    /*  initPlatformState(); */
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  /*  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _oitiLiveness3dPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Liveness 3D - Flutter'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  /* onPressed: () async {
                    // var status = await Permission.camera.request();
                    final appKey =
                        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjZXJ0aWZhY2UiLCJ1c2VyIjoiMDhDOTczQTc2NTZGQUU0MEQ2OTMzMDZCODI4MDVCQTQyfG9pdGkuZmFjZXRlYy5obWwiLCJlbXBDb2QiOiIwMDAwMDAwMDAxIiwiZmlsQ29kIjoiMDAwMDAwMjc2OSIsImNwZiI6IjU0MjczOTY2MDg1Iiwibm9tZSI6Ijk4RUU4RUVEOEEzOUJFN0IzRjY3OTZFOEVBNzZFNEU3ODlBMTkwOTMyOTFDNDJGMjYyMUMyMzlGMTU1RkE4QTkwMTM0NkQyREI4MDUxRDM3N0E3NzlFMkEzMTMyRkNENDNFOEQ0QjIzM0MyNTg2NTdBQTlBNzU3OTE2RUY5NzU5fEFTSEFVQVMgQVNVSEFTSFUgQVNVSCIsIm5hc2NpbWVudG8iOiIwOC8xMC8xOTkxIiwiZWFzeS1pbmRleCI6IkFBQUFFcjE5TnhqVHc4TmI5dDNJRW53cnU0dTMyZlkxdWVBZ0VIcTB4S1h3Tm9ob0hXMXd5Z0RwN3pPMjZBPT0iLCJrZXkiOiJRV3hzYjNkaGJtTmxJSEpsY0hWc2MybDJaU0J6WlhnZ2JXRjVJR052Ym5SaGFXND0iLCJleHAiOjE2NzY2NDUzMTIsImlhdCI6MTY3NjY0NTAxMn0.HsVjuc8r3bjhbHIhbKHPSqir43X_Sfz0K95w2OvbSzQ";
                    print("\n$appKey\n");
                    try {
                      final x = await OitiLiveness3d.startLiveness(
                          "https://comercial.certiface.com.br:8443", appKey,
                          isProd: false);
                      print(x);
                    } catch (e) {
                      print(e.toString());
                    }
                  }, */
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondRoute()),
                    );
                  },
                  child: Text("Liveness 3D"))
            ],
          ),
        ),
      ),
    );
  }
}

@override
class SecondRoute extends StatelessWidget {
  SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    OitiLiveness3d.eventLog("STATE_L3FT_instructionView");
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        backgroundColor: Color.fromRGBO(22, 72, 205, 1),
        extendBodyBehindAppBar: true,
        appBar: null,
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                OitiLiveness3d.eventLog("ACTION_L3FT_instructionContinue");
              },
              child: titleSection,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(top: 30),
                elevation: 5,
                primary: Colors.transparent,
                shadowColor: Colors.transparent.withOpacity(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Image.asset(
              'assets/images/img_face.png',
              height: 330,
              fit: BoxFit.cover,
            ),
            Expanded(
              flex: 2,
              child: navigate,
            ),
            Expanded(
              child: info1,
            ),
            Expanded(
              child: info2,
            ),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PermissionRoute()),
                      );
                    },
                    child: const Text("Continuar"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 100, right: 100),
                      primary: Color.fromARGB(255, 0, 180, 12),
                      shadowColor: Colors.transparent.withOpacity(0.0),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/

              Image.asset(
                'assets/images/left-arrow.png',
                height: 40,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  Widget info1 = Container(
    padding: const EdgeInsets.only(right: 32, left: 32),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15, top: 0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1,
              color: Color.fromARGB(255, 224, 224, 224),
              style: BorderStyle.solid,
            ),
          ),
          child: Image.asset(
            'assets/images/lightbulb_outline.png',
            height: 32,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          /*1*/
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*2*/
              Expanded(
                child: Text(
                  'Escolha um ambiente bem iluminado.',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  Widget info2 = Container(
    padding: const EdgeInsets.only(right: 32, left: 32),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1,
              color: Color.fromARGB(255, 224, 224, 224),
              style: BorderStyle.solid,
            ),
          ),
          child: Image.asset(
            'assets/images/face.png',
            height: 32,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          /*1*/
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*2*/
              Expanded(
                child: Text(
                  'Não use acessórios como bonés, máscaras e afins.',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  Widget navigate = Container(
    padding: const EdgeInsets.all(32),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  'Reconhecimento Facial',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Text(
                'Isso garante que você é você mesmo.',
                style: TextStyle(color: Colors.grey[500], fontSize: 22),
              ),
            ],
          ),
        ),
        /*3*/
      ],
    ),
  );
}

@override
class PermissionRoute extends StatelessWidget {
  PermissionRoute({super.key});

  @override
  Widget build(BuildContext context) {
    OitiLiveness3d.eventLog("STATE_L3FT_permissionView");
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        extendBodyBehindAppBar: true,
        appBar: null,
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: titleSection,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(top: 30),
                elevation: 5,
                primary: Colors.transparent,
                shadowColor: Colors.transparent.withOpacity(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Image.asset(
              'assets/images/camera_alt.png',
              height: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: permissionDesc,
            ),
            Expanded(
              child: permissionDesc2,
            ),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // var status = await Permission.camera.request();
                      final appKey =
                          "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjZXJ0aWZhY2UiLCJ1c2VyIjoiMDhDOTczQTc2NTZGQUU0MEQ2OTMzMDZCODI4MDVCQTQyfG9pdGkuZmFjZXRlYy5obWwiLCJlbXBDb2QiOiIwMDAwMDAwMDAxIiwiZmlsQ29kIjoiMDAwMDAwMjc2OSIsImNwZiI6IjU0MjczOTY2MDg1Iiwibm9tZSI6Ijk4RUU4RUVEOEEzOUJFN0IzRjY3OTZFOEVBNzZFNEU3ODlBMTkwOTMyOTFDNDJGMjYyMUMyMzlGMTU1RkE4QTkwMTM0NkQyREI4MDUxRDM3N0E3NzlFMkEzMTMyRkNENDNFOEQ0QjIzM0MyNTg2NTdBQTlBNzU3OTE2RUY5NzU5fEFTSEFVQVMgQVNVSEFTSFUgQVNVSCIsIm5hc2NpbWVudG8iOiIwOC8xMC8xOTkxIiwiZWFzeS1pbmRleCI6IkFBQUFFcjE5TnhqVHc4TmI5dDNJRW53cnU0dTMyZlkxdWVBZ0VIcTB4S1h3Tm9ob0hXMXd5Z0RwN3pPMjZBPT0iLCJrZXkiOiJRV3hzYjNkaGJtTmxJSEpsY0hWc2MybDJaU0J6WlhnZ2JXRjVJR052Ym5SaGFXND0iLCJleHAiOjE2NzY2NDUzMTIsImlhdCI6MTY3NjY0NTAxMn0.HsVjuc8r3bjhbHIhbKHPSqir43X_Sfz0K95w2OvbSzQ";

                      try {
                        OitiLiveness3d.eventLog("ACTION_L3FT_permissionVerify");

                        final x = await OitiLiveness3d.startLiveness(
                            "https://comercial.certiface.com.br:8443", appKey,
                            isProd: false);
                        print(x);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: const Text("Verificar"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 100, right: 100),
                      primary: Color.fromARGB(255, 0, 180, 12),
                      shadowColor: Colors.transparent.withOpacity(0.0),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/

              Image.asset(
                'assets/images/left-arrow-b.png',
                height: 40,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  Widget permissionDesc = Container(
    padding: const EdgeInsets.only(right: 32, left: 32),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Expanded(
            /*1*/
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Expanded(
                  child: new Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Permissões da câmera desativadas.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 34),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  @override
  Widget permissionDesc2 = Container(
    padding: const EdgeInsets.only(right: 32, left: 32),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    child: Row(
      children: [
        Container(
          child: Expanded(
            /*1*/
            child: Row(
              children: [
                /*2*/
                Expanded(
                  child: new Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Habilitar as configurações do seu sistema operacional.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
