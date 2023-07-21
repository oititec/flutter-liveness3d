import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:oiti_liveness3d/oiti_liveness3d_platform_interface.dart';

class MethodChannelOitiLiveness3d extends OitiLiveness3dPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('oiti_liveness3d');

  @override
  Future startLiveness(
    String appKey,
    String environment,
    Object? builder,
    Object? loading,
  ) async {
    return await methodChannel.invokeMapMethod(
      'OITI.startLiveness3d',
      {
        'appkey': appKey,
        'environment': environment,
        'texts': builder,
        'loading': loading,
      },
    );
  }

  @override
  Future<void> eventLog(
    String? event,
  ) async {
    return await methodChannel.invokeMethod(
      'OITI.eventLog',
      {
        'event': event,
      },
    );
  }

  @override
  Future checkPermission() async {
    return await methodChannel.invokeMethod(
      'OITI.checkPermission',
    );
  }

  @override
  Future askPermission() async {
    return await methodChannel.invokeMethod(
      'OITI.askPermission',
    );
  }

  @override
  Future<void> openSettings() async {
    return await methodChannel.invokeMethod(
      'OITI.openSettingsApp',
    );
  }
}
