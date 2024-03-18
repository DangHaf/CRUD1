import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/data/model/provider/provider_model.dart';

class ItemLeadingProvider extends StatelessWidget {
  final ProviderModel provider;

  const ItemLeadingProvider({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoute.DETAIL_PROVIDER, arguments: provider.id);
      },
      child: Container(
          width: Get.width * 0.55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.r),
              bottomLeft: Radius.circular(5.r),
            ),
            color: ColorResources.COLOR_F2F2F2,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: IZIImage(
                  provider.thumbnail ?? '',
                  width: Get.width * 0.55 * 0.34,
                  height: Get.width * 0.55 * 0.33,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 3.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.name ?? '',
                        style: AppText.text14.copyWith(
                          color: ColorResources.COLOR_181313,
                          fontWeight: FontWeight.w600,
                        ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                            height: 15.w,
                            child: Image.asset(ImagesPath.icLocationBlue),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              provider.addressWithCityState,
                              style: AppText.text10.copyWith(
                                color: ColorResources.COLOR_464647,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                            height: 15.w,
                            child: Image.asset(ImagesPath.icStar),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: provider.averagePointSupplier.averagePoint,
                                    style: AppText.text10.copyWith(
                                      color: ColorResources.COLOR_464647,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                      ' (${provider.totalRateSupplier} ${'review_001'.tr})',
                                    style: AppText.text10.copyWith(
                                      color: ColorResources.COLOR_A4A2A2,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
        ),
        ),
    );
  }
}

class ItemLeadingProviderLoading extends StatelessWidget {
  const ItemLeadingProviderLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.r),
          bottomLeft: Radius.circular(5.r),
        ),
        color: ColorResources.COLOR_F2F2F2,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: IZIImage(
              '',
              width: Get.width * 0.55 * 0.34,
              height: Get.width * 0.55 * 0.33,
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 3.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: ColorResources.NEUTRALS_6,
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      width: Get.width * 0.5,
                      height: 16.sp,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                        height: 15.w,
                        child: Image.asset(ImagesPath.icLocationBlue),
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Shimmer.fromColors(
                          baseColor: ColorResources.NEUTRALS_6,
                          highlightColor: Colors.grey.withOpacity(0.2),
                          child: Container(
                            width: Get.width * 0.4,
                            height: 10.sp,
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                        height: 15.w,
                        child: Image.asset(ImagesPath.icStar),
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Shimmer.fromColors(
                          baseColor: ColorResources.NEUTRALS_6,
                          highlightColor: Colors.grey.withOpacity(0.2),
                          child: Container(
                            width: Get.width * 0.4,
                            height: 10.sp,
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
