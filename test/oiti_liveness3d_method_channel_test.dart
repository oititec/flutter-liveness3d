import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oiti_liveness3d/oiti_liveness3d_method_channel.dart';

void main() {
  MethodChannelOitiLiveness3d platform = MethodChannelOitiLiveness3d();
  const MethodChannel channel = MethodChannel('oiti_liveness3d');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
/* 
  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  }); */
}
