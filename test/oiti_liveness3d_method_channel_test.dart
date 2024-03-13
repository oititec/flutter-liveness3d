import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oiti_liveness3d/oiti_liveness3d_method_channel.dart';

void main() {
  MethodChannelOitiLiveness3d platform = MethodChannelOitiLiveness3d();
  const MethodChannel channel = MethodChannel('oiti_liveness3d');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'OITI.startLiveness3d':
          return <String, Object?>{
            'valid': false,
            'cause': 'PROVA DE VIDA',
            'codId': '300.2',
            'protocol': '123455123',
            'blob': null,
          };
        case 'OITI.eventLog':
          return true;
        case 'OITI.checkPermission':
          return true;
        case 'OITI.askPermission':
          return true;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('checkPermission', () async {
    expect(await platform.checkPermission(), true);
  });

  test('askPermission', () async {
    expect(await platform.askPermission(), true);
  });
}
