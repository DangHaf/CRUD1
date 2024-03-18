import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';

mixin BaseDialog {
  static Future<void> showGenerateDialog({
    required BuildContext context,
    bool? isAllowCloseOutSize = true,
    required Widget childWidget,
    bool? allowWillPop = true,
  }) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        final curve = Curves.easeInOut.transform(a1.value);
        return WillPopScope(
          onWillPop: () async {
            return allowWillPop!;
          },
          child: Transform.scale(
            scale: curve,
            child: Dialog.fullscreen(
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  if (isAllowCloseOutSize!) {
                    Get.back();
                  }
                },
                child: Container(
                  width: IZISizeUtil.getMaxWidth(),
                  height: IZISizeUtil.getMaxHeight(),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      childWidget,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
