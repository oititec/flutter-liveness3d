import 'oiti_liveness3d_platform_interface.dart';

class OitiLiveness3d {
  /*  Future<String?> getPlatformVersion() {
    return OitiLiveness3dPlatform.instance.getPlatformVersion();
  } */

  static Future startLiveness(String? baseUrl, String? appKey,
      {bool isProd = false}) async {
    return await OitiLiveness3dPlatform.instance
        .startLiveness(baseUrl, appKey, isProd);
  }

  static Future eventLog(String? event) async {
    return await OitiLiveness3dPlatform.instance.eventLog(event);
  }
}
