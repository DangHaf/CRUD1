import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    this.title,
  });
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Column(
          children: [
            IZIImage(
              ImagesPath.loadingLogo,
              width: IZISizeUtil.setSize(percent: .1),
            ),
            Padding(
              padding: IZISizeUtil.setEdgeInsetsOnly(top: 10),
              child: Text(
                title ?? 'loading_01'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorResources.WHITE,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )),
      ],
    );
  }
}
