import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
import 'package:oiti_liveness3d/common/loading.dart';
import 'package:oiti_liveness3d/screen/instruction_screen.dart';
import 'package:oiti_liveness3d/screen/permission_screen.dart';

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
  final appKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjZXJ0aWZhY2UiLCJ1c2VyIjoiMTYzMkUxQkZERTlBQkEyNzNGMTIwM0M1NDNFQ0Q5QUNBfG1vYmlsZS5hcGlnbG9iYWwiLCJlbXBDb2QiOiIwMDAwMDAwNjc5IiwiZmlsQ29kIjoiMDAwMDAwMjc3NCIsImNwZiI6IjU0MjczOTY2MDg1Iiwibm9tZSI6IjgwQzYyODlCQjQ2NTkzQjgxMEMzOTFFNTc1MzNFMDVFQ0QzMUREODBGMDE1ODE0RUEwNDg1OUM1RDhBMDJBRjBDNkRBNjRFOTcwNERDRjNEQUNGQTc1NzRDNUVBMDYwMTFGNUE3OTQzQzQxMEQ3OTE2NDRBNzRGMzNFNzQ2OENGfEFTSEFVQVMgQVNVSEFTSFUgQVNVSCIsIm5hc2NpbWVudG8iOiIwOC8xMC8xOTkxIiwiZWFzeS1pbmRleCI6IkFBQUFFcFkxaXYwTEsreFhwMXZ1dEtXcnVZWFB4K3pROHpaNHFhSGlPSHduV0gxNzFsQ0RPMmhhb0JxUUp3PT0iLCJrZXkiOiJUWFZqYUNCbGRtbHNJSE52YjI0Z2FHbG5hQ0JwYmlCb2IzQmxJR1J2SUhacFpYYz0iLCJleHAiOjE2ODg3MjQwMDUsImlhdCI6MTY4ODcyMzcwNX0.z7z2S-YphdocGb6Hc18iFiVUecF1CVw199PFkRMt6Kc';
  final _oitiLiveness3dPlugin = OitiLiveness3d();

  var loading = LoadingApparence(
      type: "spinner",
      size: 4,
      backgroundColor: "#000000",
      loadingColor: "#FFFFFF");

  @override
  void initState() {
    super.initState();
    /*  initPlatformState(); */
  }

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
                  onPressed: () {
                    OitiLiveness3d.startLiveness3d(
                        context,
                        appKey,
                        loading.toJson(),
                        InstructionScreen(),
                        PermissionScreen());
                  },
                  child: Text("Liveness 3D"))
            ],
          ),
        ),
      ),
    );
  }
}
