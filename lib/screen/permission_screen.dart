import 'package:flutter/material.dart';
import '../oiti_liveness3d.dart';
import 'package:redux/redux.dart';
import '../store/reducer.dart';

class PermissionScreen extends StatelessWidget {
  PermissionScreen({Key? key, this.store, this.appKey, this.loading})
      : super(key: key);
  final Store<int>? store;
  final String? appKey;
  final Object? loading;

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
                      final appKey = '';
                      try {
                        OitiLiveness3d.eventLog("ACTION_L3FT_permissionVerify");
                        await OitiLiveness3d.verifyPermission(
                            context, this.appKey, loading);
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
                height: 22,
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
                            fontWeight: FontWeight.w700, fontSize: 22),
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
                            fontWeight: FontWeight.w400, fontSize: 14),
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
