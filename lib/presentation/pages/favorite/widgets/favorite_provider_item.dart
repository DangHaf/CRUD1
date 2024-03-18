import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/provider/provider_model.dart';

class ItemFavoriteProvider extends StatelessWidget {
  const ItemFavoriteProvider({
    super.key,
    required this.provider,
    required this.onTap,
    required this.removeItem,
  });

  final ProviderModel provider;
  final Function() onTap;
  final Function() removeItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final res =
            await Get.toNamed(AppRoute.DETAIL_PROVIDER, arguments: provider.id);
        if (res != null) {
          final data = res as bool;
          if (!data) {
            removeItem();
          }
          try {} catch (_) {}
        }
      },
      child: Container(
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
                provider.thumbnail ?? '',
                width: 70.w,
                height: 70.w,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: IZISizeUtil.SPACE_2X),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            provider.name ?? '',
                            style: AppText.text14.copyWith(
                              color: ColorResources.COLOR_535354,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: IZISizeUtil.SPACE_3X),
                          child: GestureDetector(
                            onTap: onTap,
                            child: IZIImage(
                              ImagesPath.icFavorite,
                              height: 18.w,
                              width: 18.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 19.w,
                          height: 19.w,
                          child: Image.asset(ImagesPath.icLocationOrange),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            provider.addressWithCityState,
                            style: AppText.text12.copyWith(
                                color: ColorResources.COLOR_808089,
                                fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
