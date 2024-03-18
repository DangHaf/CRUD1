import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class ItemFavoriteLoadingProvider extends StatelessWidget {
  const ItemFavoriteLoadingProvider({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: IZISizeUtil.SPACE_3X,
        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
      ),
      color: ColorResources.WHITE,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(5.r),
            ),
            child: IZIImage(
              '',
              width: 70.w,
              height: 70.w,
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: IZISizeUtil.SPACE_2X),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: ColorResources.NEUTRALS_6,
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      width: Get.width,
                      height: 14.sp,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Shimmer.fromColors(
                    baseColor: ColorResources.NEUTRALS_6,
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      width: Get.width,
                      height: 14.sp,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
