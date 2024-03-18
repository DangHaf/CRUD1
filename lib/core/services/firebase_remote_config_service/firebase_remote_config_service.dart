import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:template/core/services/firebase_remote_config_service/model/remote_config_model.dart';

import '../../export/core_export.dart';

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;

  FirebaseRemoteConfigService() {
    init();
  }

  Future<void> init() async {
    try {
      await firebaseRemoteConfig.ensureInitialized();
      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await firebaseRemoteConfig.fetchAndActivate();
    } on FirebaseException catch (e, st) {
      log(
        'Unable to initialize Firebase Remote Config',
        error: e,
        stackTrace: st,
      );
    }

    // Get remove config ads.
    final _json = firebaseRemoteConfig.getString(AdsConfig);

    if (!IZIValidate.nullOrEmpty(_json)) {
      RemoveConfigModel.fromMap(
        jsonDecode(_json) as Map<String, dynamic>,
      );
    }
  }
}
