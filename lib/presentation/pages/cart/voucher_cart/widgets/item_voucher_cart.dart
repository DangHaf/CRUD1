import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/date_time_extension.dart';
import 'package:template/data/model/voucher/voucher_model.dart';

class ItemVoucherCart extends StatelessWidget {
  final VoucherModel voucher;
  final String? groupId;
  final Function() onSelect;

  const ItemVoucherCart({
    super.key,
    required this.voucher,
    this.groupId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoute.VOUCHER_DETAIL, arguments: voucher.id),
      child: Container(
        color: ColorResources.WHITE,
        padding: IZISizeUtil.setEdgeInsetsSymmetric(
          vertical: 12.h,
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(9.r),
              ),
              child: IZIImage(
                voucher.thumbnail ?? '',
                width: 86.r,
                height: 75.r,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          voucher.title,
                          style: AppText.text12.copyWith(
                            color: ColorResources.COLOR_535354,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                              height: 15.w,
                              child: Image.asset(ImagesPath.icCalender),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: Text(
                                '${'voucher_008'.tr}: ${DateTime.fromMillisecondsSinceEpoch(voucher.endDateTime).formatExpiryVoucher}',
                                style: AppText.text11.copyWith(
                                    color: ColorResources.COLOR_677275,
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                              height: 15.w,
                              child: Image.asset(ImagesPath.icSale),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: Text(
                                '${'voucher_009'.tr}: ${voucher.disCount}',
                                style: AppText.text11.copyWith(
                                    color: ColorResources.COLOR_677275,
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (voucher.unitTypeDiscount != MONEY)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 15.w,
                                    height: 15.w,
                                    child: Image.asset(ImagesPath.icMaxSale),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${'voucher_005'.tr}: ${voucher.getMaxDiscount}',
                                      style: AppText.text11.copyWith(
                                          color: ColorResources.COLOR_677275,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Radio(
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    activeColor: ColorResources.COLOR_3B71CA,
                    fillColor: MaterialStateColor.resolveWith((states) =>
                        groupId == voucher.id
                            ? ColorResources.COLOR_3B71CA
                            : ColorResources.COLOR_677275),
                    value: voucher.id,
                    groupValue: groupId,
                    onChanged: (value) {
                      onSelect();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
