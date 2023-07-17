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
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjZXJ0aWZhY2UiLCJ1c2VyIjoiOTc4QzExMjRGMjg2MTcyNUVGQjM0REI5QjkwNDczNkI5fG1vYmlsZS5hcGlnbG9iYWwiLCJlbXBDb2QiOiIwMDAwMDAwNjc5IiwiZmlsQ29kIjoiMDAwMDAwMjc3NCIsImNwZiI6IjU0MjczOTY2MDg1Iiwibm9tZSI6IjI1RjM0RENGNUI4MTRDOUVCODVBNDAzN0UxNjc5RTNGQ0NFRENBNkE3RTVFNjlFQjJBRjYyNEQ2MDBERjQyMEJDNUNFQTM5QjA0N0YwOUU3MzY2QjYzRTkyNjEzNjVEM0NCMUYyQ0Q4MjExMkYxRDNFQkI0RjdBQjFFQTU1NEI1fEFTSEFVQVMgQVNVSEFTSFUgQVNVSCIsIm5hc2NpbWVudG8iOiIwOC8xMC8xOTkxIiwiZWFzeS1pbmRleCI6IkFBQUFFZ1p4RkhlOHIxQ0pNM3F4OWpjYnBvaVQwOU1yQWZZWmUwcFhFdmVyNy9IMUxEbkJicmdVQThsUG5RPT0iLCJrZXkiOiJRMjl1YzJsa1pYSWdjM0JsWVd0cGJtY2diV1VnY0hKdmMzQmxZM1FnZDJoaGRHVT0iLCJleHAiOjE2ODg3NDAwNTMsImlhdCI6MTY4ODczOTc1M30.B0jCFu15EGyq9EcvKSumFmkqzZ-iF9NSGafCBC9qkzk';
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
