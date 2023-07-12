import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'oiti_liveness3d_platform_interface.dart';

class MethodChannelOitiLiveness3d extends OitiLiveness3dPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('oiti_liveness3d');

  @override
  Future startLiveness(
      String? baseUrl, String? appKey, Object? loading, bool isProd) async {
    final result = await methodChannel.invokeMapMethod(
      'OITI.startLiveness3d',
      {
        'appKey': appKey,
        'baseUrl': baseUrl,
        'loading': loading,
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

  @override
  Future checkPermission() async {
    final result = await methodChannel.invokeMethod(
      'OITI.checkPermission',
    );

    return result;
  }

  @override
  Future askPermission() async {
    final result = await methodChannel.invokeMethod(
      'OITI.askPermission',
    );

    return result;
  }
}
