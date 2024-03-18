import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final _showToast = FToast();

  @override
  void onInit() {
    _listenForConnectivity();

    super.onInit();
  }

  ///
  /// Listen for connectivity.
  ///
  Future<void> _listenForConnectivity() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _showToast.init(Get.context!);
    });

    final _status = await _connectivity.checkConnectivity();
    _connectivityResult(result: _status);

    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityResult(result: result);
    });
  }

  ///
  /// Connectivity result.
  ///
  void _connectivityResult({required ConnectivityResult result}) {
    if (result == ConnectivityResult.wifi) {
      log('Connectivity You are now connected to wifi');
    } else if (result == ConnectivityResult.mobile) {
      log('Connectivity You are now connected to mobile data');
    } else if (result == ConnectivityResult.none) {
      log('Connectivity No connection available');

      _showToastDisconnect();
    } else {
      log('Connectivity No Connection!!');

      _showToastDisconnect();
    }
  }

  void _showToastDisconnect() {
    _showToast.showToast(
      toastDuration: const Duration(milliseconds: 3000),
      child: Container(
        padding: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.SPACE_3X),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(100),
        ),
        height: 45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: IZISizeUtil.setEdgeInsetsOnly(right: IZISizeUtil.SPACE_1X),
                      child: IZIImage(
                        ImagesPath.idNoInternet,
                        width: 25,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'connectivity_001'.tr,
                    style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
