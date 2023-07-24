import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
import 'package:redux/redux.dart';

class CameraPermissionWidget extends StatelessWidget {
  final Store<int>? store;
  var _canCloseWidget = false;
  final _channel = OitiLiveness3d();

  CameraPermissionWidget({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _channel.eventLog("STATE_L3FT_permissionView");

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        extendBodyBehindAppBar: true,
        appBar: null,
        body: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(top: 30),
                elevation: 5,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent.withOpacity(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: titleSection,
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
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 100,
                        right: 100,
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 180, 12),
                      shadowColor: Colors.transparent.withOpacity(0.0),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      try {
                        _channel.eventLog("ACTION_L3FT_permissionVerify");
                        _channel.askPermission().then(
                          (granted) {
                            _canCloseWidget = false;
                            if (!granted && Platform.isIOS) {
                              _showAlertDialog(context).whenComplete(
                                () {
                                  if (_canCloseWidget) {
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        );
                      } catch (e) {
                        print(e.toString());
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Verificar"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/left-arrow-b.png',
                height: 22,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget permissionDesc = Container(
    padding: const EdgeInsets.only(
      right: 32,
      left: 32,
    ),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      "Permissões da câmera desativadas.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget permissionDesc2 = Container(
    padding: const EdgeInsets.only(
      right: 32,
      left: 32,
    ),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    child: Expanded(
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Text(
                  "Habilitar as configurações do seu sistema operacional.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Precisamos acessar sua câmera'),
          content: const Text(
            'Em seu aparelho, vá em Ajustes e habilite o uso da câmera.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                _canCloseWidget = true;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ajustes'),
              onPressed: () {
                _canCloseWidget = false;
                _channel.openSettings().whenComplete(
                      () => Navigator.of(context).pop(),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
