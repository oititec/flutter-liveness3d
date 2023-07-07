import 'oiti_liveness3d_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './store/reducer.dart';
import 'package:redux/redux.dart';
import 'dart:convert';

import './screen/instruction_screen.dart';
import './screen/permission_screen.dart';
import './common/loading.dart';

class OitiLiveness3d {
  static Future startLiveness(String? baseUrl, String? appKey, Object? loading,
      {bool isProd = false}) async {
    return await OitiLiveness3dPlatform.instance
        .startLiveness(baseUrl, appKey, loading, isProd);
  }

  //Bridge

  static Future eventLog(String? event) async {
    return await OitiLiveness3dPlatform.instance.eventLog(event);
  }

  static Future checkPermission() async {
    return await OitiLiveness3dPlatform.instance.checkPermission();
  }

  static Future askPermission() async {
    return await OitiLiveness3dPlatform.instance.askPermission();
  }

  static Future checkScreen(
      BuildContext context, String? appKey, Object? loading) async {
    final Store<int> store = Store<int>(reducer, initialState: 99);
    final checkPermission = await OitiLiveness3d.checkPermission();

    if (checkPermission == true) {
      try {
        final livenessResult = await OitiLiveness3d.startLiveness(
            "https://comercial.certiface.com.br:8443", appKey, loading,
            isProd: false);
      } catch (e) {
        print(e.toString());
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PermissionScreen(
                store: store, appKey: appKey, loading: loading)),
      );
    }
  }

  //Futures

  static Future verifyPermission(
      BuildContext context, String? appKey, Object? loading) async {
    final Store<int> store = Store<int>(reducer, initialState: 99);
    final askPermission = await OitiLiveness3d.askPermission();

    if (askPermission == true) {
      await OitiLiveness3d.checkScreen(context, appKey, loading);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InstructionScreen(
                store: store, appKey: appKey, loading: loading)),
      );
    }
  }

  static Future startLiveness3d(
      BuildContext context,
      String? appKey,
      Object? loading,
      Widget? instructionScreen,
      Widget? permissionScreen) async {
    final Store<int> store = Store<int>(reducer, initialState: 99);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => InstructionScreen(
              store: store, appKey: appKey, loading: loading)),
    );
  }

  static Future<LoadingApparence> configLoading(Object? json) async {
    var jsonD = jsonDecode(json.toString());
    print(jsonD);
    var loading = LoadingApparence.config(jsonD);
    print(loading.type);
    return LoadingApparence(type: loading.type, size: loading.size);
  }
}
