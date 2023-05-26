import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'oiti_liveness3d_method_channel.dart';

abstract class OitiLiveness3dPlatform extends PlatformInterface {
  /// Constructs a OitiLiveness3dPlatform.
  OitiLiveness3dPlatform() : super(token: _token);

  static final Object _token = Object();

  static OitiLiveness3dPlatform _instance = MethodChannelOitiLiveness3d();

  /// The default instance of [OitiLiveness3dPlatform] to use.
  ///
  /// Defaults to [MethodChannelOitiLiveness3d].
  static OitiLiveness3dPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OitiLiveness3dPlatform] when
  /// they register themselves.
  static set instance(OitiLiveness3dPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /*  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  } */

  Future startLiveness(String? baseUrl, String? appKey, bool isProd) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future eventLog(String? event) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
