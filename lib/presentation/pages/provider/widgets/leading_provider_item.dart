import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/presentation/pages/provider/leading_provider/leading_provider_controller.dart';

class LeadingProviderItem extends StatefulWidget {
  final ProviderModel provider;
  final Function() onTap;

  const LeadingProviderItem({
    super.key,
    required this.provider,
    required this.onTap,
  });

  @override
  State<LeadingProviderItem> createState() => _LeadingProviderItemState();
}

class _LeadingProviderItemState extends State<LeadingProviderItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Positioned(
            top: 20.h,
            left: 0,
            right: 0,
            child: Container(
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(101, 144, 255, 0.82),
                    Color.fromRGBO(92, 182, 247, 0.84)
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: IZIImage(
                  widget.provider.thumbnail ?? '',
                  height: 30.w,
                  width: 90.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                child: Text(
                  widget.provider.name ?? '',
                  style: AppText.text12.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.WHITE,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => setState(() {
                  Get.find<LeadingProviderController>()
                      .onChangeIsLike(widget.provider);
                }),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 14.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.provider.isLike ? Icons.favorite : Icons.favorite_border_outlined,
                        size: 13.w,
                        color:ColorResources.ERROR_ALERT,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'dash_board_002'.tr,
                        style: AppText.text10.copyWith(
                          fontWeight: FontWeight.w600,
                          color:  ColorResources.COLOR_CE1818,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
