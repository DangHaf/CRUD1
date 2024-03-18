import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/provider/provider_model.dart';

class ItemProviderSearch extends StatelessWidget {
  final ProviderModel provider;

  const ItemProviderSearch({
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
        width: Get.width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          vertical: 14.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: IZIImage(
                provider.thumbnail ?? '',
                width: 70.w,
                height: 70.w,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name ?? '',
                    style: AppText.text14.copyWith(
                      color: ColorResources.COLOR_535354,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Image.asset(
                        ImagesPath.icLocationOrange,
                        width: 19.w,
                        height: 19.w,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          provider.addressWithCityState,
                          style: AppText.text12.copyWith(
                              color: ColorResources.COLOR_808089,
                              fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
