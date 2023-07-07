import 'dart:ffi';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'oiti_liveness3d_method_channel.dart';

abstract class OitiLiveness3dPlatform extends PlatformInterface {
  /// Constructs a OitiLiveness3dPlatform.
  OitiLiveness3dPlatform() : super(token: _token);

  static final Object _token = Object();

  static OitiLiveness3dPlatform _instance = MethodChannelOitiLiveness3d();

  static OitiLiveness3dPlatform get instance => _instance;

  static set instance(OitiLiveness3dPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future startLiveness(
      String? baseUrl, String? appKey, Object? loading, bool isProd) {
    throw UnimplementedError('Liveness3D() has not been implemented.');
  }

  Future eventLog(String? event) {
    throw UnimplementedError('eventLog() has not been implemented.');
  }

  Future checkPermission() {
    throw UnimplementedError('checkPermission() has not been implemented.');
  }

  Future askPermission() {
    throw UnimplementedError('askPermission() has not been implemented.');
  }
}
