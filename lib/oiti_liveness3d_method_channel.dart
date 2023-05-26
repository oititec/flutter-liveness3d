import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'oiti_liveness3d_platform_interface.dart';

/// An implementation of [OitiLiveness3dPlatform] that uses method channels.
class MethodChannelOitiLiveness3d extends OitiLiveness3dPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('oiti_liveness3d');

  /*  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
 */
  @override
  Future startLiveness(String? baseUrl, String? appKey, bool isProd) async {
    final result = await methodChannel.invokeMapMethod(
      'OITI.startLiveness3d',
      {
        'appKey': appKey,
        'baseUrl': baseUrl,
        'isProd': isProd,
      },
    );

    return result;
  }

  @override
  Future eventLog(
    String? event,
  ) async {
    final result = await methodChannel.invokeMapMethod(
      'OITI.eventLog',
      {
        'event': event,
      },
    );

    return result;
  }
}
