import 'package:flutter/material.dart';
import '../oiti_liveness3d.dart';
import './permission_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

class InstructionScreen extends StatelessWidget {
  InstructionScreen({Key? key, this.store, this.appKey, this.loading})
      : super(key: key);
  final Store<int>? store;
  final String? appKey;
  final Object? loading;

  @override
  Widget build(BuildContext context) {
    OitiLiveness3d.eventLog("STATE_L3FT_instructionView");
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) => MaterialApp(
              title: 'Instruction View',
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: Scaffold(
                      backgroundColor: Color.fromRGBO(22, 72, 205, 1),
                      extendBodyBehindAppBar: true,
                      appBar: null,
                      body: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              OitiLiveness3d.eventLog(
                                  "ACTION_L3FT_instructionContinue");
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
                            height: 270.sp,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 32, right: 32, top: 32),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /*2*/
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: const Text(
                                          'Reconhecimento Facial',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Text(
                                        'Isso garante que você é você mesmo.',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [info1, info2],
                                    ),
                                  )
                                  /*3*/
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 32, left: 32, right: 32),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    OitiLiveness3d.checkScreen(
                                        context, appKey, loading);
                                  },
                                  child: const Text("Continuar"),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 100,
                                        right: 100),
                                    primary: Color.fromARGB(255, 0, 180, 12),
                                    shadowColor:
                                        Colors.transparent.withOpacity(0.0),
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
                    ));
              },
            ));
  }

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
  Widget info1 = Container(
    padding: const EdgeInsets.only(bottom: 5, top: 5),
    margin: const EdgeInsets.only(top: 0),
    decoration: const BoxDecoration(
      color: Color.fromARGB(0, 255, 255, 255),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 15, top: 0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(255, 224, 224, 224),
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
            children: const [
              /*2*/
              Expanded(
                child: Text(
                  'Escolha um ambiente bem iluminado.',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
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
    padding: const EdgeInsets.only(bottom: 5, top: 5),
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
            children: const [
              /*2*/
              Expanded(
                child: Text(
                  'Não use acessórios como bonés, máscaras e afins.',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
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
    padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text(
                'Isso garante que você é você mesmo.',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ),
        /*3*/
      ],
    ),
  );
}
