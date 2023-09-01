import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/common/enum_case_name.dart';
import 'package:oiti_liveness3d/oiti_liveness3d_platform_interface.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';
import 'package:oiti_liveness3d/common/texts_builder.dart';
import 'package:oiti_liveness3d/common/theme_builder.dart';
import 'package:oiti_liveness3d/common/fonts_builder.dart';
import 'package:oiti_liveness3d/common/loading_appearance.dart';
import 'package:oiti_liveness3d/common/liveness_success_result.dart';
import 'package:oiti_liveness3d/widgets/liveness3d.dart';
import 'package:oiti_liveness3d/store/reducer.dart';
import 'package:redux/redux.dart';

class OitiLiveness3d {
  Future<LivenessSuccessResult> openLiveness3D({
    required String appKey,
    required Environment environment,
    TextsBuilder? textsBuilder,
    ThemeBuilder? themeBuilder,
    Liveness3dFonts? fontsBuilder,
    LoadingAppearence? loading,
  }) async {
    final result = await OitiLiveness3dPlatform.instance.startLiveness(
      appKey,
      environment.caseName().toUpperCase(),
      textsBuilder?.toJson(),
      themeBuilder?.toJson(),
      fontsBuilder?.toJson(),
      loading?.toJson(),
    );

    return LivenessSuccessResult(
      result['valid'] as bool? ?? false,
      result['cause'] as String? ?? '',
      result['codId'] as String? ?? '',
      result['protocol'] as String? ?? '',
      result['blob'] as String? ?? '',
    );
  }

  Future<void> eventLog(String? event) async {
    return await OitiLiveness3dPlatform.instance.eventLog(event);
  }

  Future checkPermission() async {
    return await OitiLiveness3dPlatform.instance.checkPermission();
  }

  Future askPermission() async {
    return await OitiLiveness3dPlatform.instance.askPermission();
  }

  Future<void> openSettings() async {
    return await OitiLiveness3dPlatform.instance.openSettings();
  }

  static Widget createLiveness3DWidget({
    required String appKey,
    required Environment environment,
    TextsBuilder? textsBuilder,
    ThemeBuilder? themeBuilder,
    Liveness3dFonts? fontsBuilder,
    LoadingAppearence? loadingAppearance,
    required Function(LivenessSuccessResult result) onSuccess,
    required Function(Object? error) onError,
  }) {
    final store = Store<int>(reducer, initialState: 99);

    return Liveness3DWidget(
      store: store,
      appKey: appKey,
      environment: environment,
      textsBuilder: textsBuilder,
      themeBuilder: themeBuilder,
      fontsBuilder: fontsBuilder,
      loadingAppearance: loadingAppearance,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
