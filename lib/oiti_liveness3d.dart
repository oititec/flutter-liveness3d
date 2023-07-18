import 'package:flutter/material.dart';
import 'package:oiti_liveness3d/common/enum_case_name.dart';
import 'package:oiti_liveness3d/oiti_liveness3d_platform_interface.dart';
import 'package:oiti_liveness3d/common/enumerations.dart';
import 'package:oiti_liveness3d/common/texts_builder.dart';
import 'package:oiti_liveness3d/common/loading_appearance.dart';
import 'package:oiti_liveness3d/widgets/liveness3d.dart';
import 'package:oiti_liveness3d/store/reducer.dart';
import 'package:redux/redux.dart';

class NoCameraPermissionException implements Exception {}

class OitiLiveness3d {
  Future openLiveness3D(
      {required String appKey,
      required Environment environment,
      TextsBuilder? textsBuilder,
      LoadingAppearence? loading}) async {
    return await OitiLiveness3dPlatform.instance.startLiveness(
        appKey,
        environment.caseName().toUpperCase(),
        textsBuilder?.toJson(),
        loading?.toJson());
  }

  Future eventLog(String? event) async {
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

  Widget createLiveness3DWidget(
      {required String appKey,
      required Environment environment,
      TextsBuilder? textsBuilder,
      LoadingAppearence? loadingAppearance}) {
    final store = Store<int>(reducer, initialState: 99);

    return Liveness3DWidget(
        store: store,
        appKey: appKey,
        environment: environment,
        textsBuilder: textsBuilder,
        loadingAppearance: loadingAppearance);
  }
}
