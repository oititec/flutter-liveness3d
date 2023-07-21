import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';
import 'package:oiti_liveness3d/oiti_liveness3d.dart';
import 'package:oiti_liveness3d/oiti_liveness3d_method_channel.dart';
import 'package:oiti_liveness3d/oiti_liveness3d_platform_interface.dart';

void main() {
  final OitiLiveness3dPlatform initialPlatform =
      OitiLiveness3dPlatform.instance;
  const MethodChannel channel = MethodChannel('oiti_liveness3d');
  final plugin = OitiLiveness3d();

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

  test('$MethodChannelOitiLiveness3d is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOitiLiveness3d>());
  });

  test('openLiveness3D', () async {
    const appKey = 'app-key';
    const environment = Environment.hml;

    final result = await plugin.openLiveness3D(
      appKey: appKey,
      environment: environment
    );

    expect(result.valid, false);
    expect(result.cause, 'PROVA DE VIDA');
    expect(result.codId, '300.2');
    expect(result.protocol, '123455123');
    expect(result.scanResultBlob, '');
  });

  test('checkPermission', () async {
    expect(await plugin.checkPermission(), true);
  });

  test('askPermission', () async {
    expect(await plugin.askPermission(), true);
  });
}
