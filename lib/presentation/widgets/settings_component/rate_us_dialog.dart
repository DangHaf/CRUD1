import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_lazy_index_stack.dart';
import 'package:template/core/export/core_export.dart';

class RateUsDialog extends StatefulWidget {
  const RateUsDialog({super.key, required this.callBack});

  final Function callBack;

  @override
  State<RateUsDialog> createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  ///
  /// Declare the data.
  final List<String> _rateUsList = [
    ImagesPath.rateIc0Star,
    ImagesPath.rateIc1Star,
    ImagesPath.rateIc2Star,
    ImagesPath.rateIc3Star,
    ImagesPath.rateIc4Star,
    ImagesPath.rateIc5Star,
  ];
  final List<String> _rateUsMessages = [
    'setting_24'.tr,
    'setting_25'.tr,
    'setting_26'.tr,
    'setting_27'.tr,
    'setting_28'.tr,
    'setting_29'.tr,
  ];
  int _currentRate = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: IZISizeUtil.setEdgeInsetsSymmetric(
            horizontal: IZISizeUtil.setSizeWithWidth(percent: .15),
          ),
          width: IZISizeUtil.getMaxWidth(),
          decoration: BoxDecoration(
            color: ColorResources.RATE_US_BG,
            borderRadius: IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_6X),
          ),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              LazyIndexedStack(
                index: _currentRate,
                children: [
                  ...List.generate(
                    _rateUsList.length,
                    (index) => IZIImage(
                      _rateUsList[index],
                      width: IZISizeUtil.setSizeWithWidth(percent: .4),
                    ),
                  ),
                ],
              ),
              Container(
                height: 48.h,
                padding: const EdgeInsets.symmetric(horizontal: IZISizeUtil.SPACE_4X),
                child: Text(
                  _rateUsMessages[_currentRate],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorResources.WHITE,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      'setting_07'.tr,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xFF00B2FF),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(
                      top: IZISizeUtil.SPACE_3X,
                      left: IZISizeUtil.SPACE_1X,
                      right: IZISizeUtil.SPACE_5X,
                    ),
                    child: IZIImage(
                      ImagesPath.rateIcArrowRight,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(
                  top: IZISizeUtil.SPACE_2X,
                  bottom: IZISizeUtil.SPACE_5X,
                ),
                child: RatingBar.builder(
                  unratedColor: ColorResources.WHITE,
                  glowColor: Colors.transparent,
                  initialRating: 5,
                  itemSize: 35,
                  maxRating: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                  itemBuilder: (context, index) {
                    if (index == 4 && _currentRate == 0) {
                      return IZIImage(
                        ImagesPath.rateIcUnSelectStar,
                        width: IZISizeUtil.setSize(percent: .01),
                        colorIconsSvg: ColorResources.YELLOW,
                      );
                    }
                    return IZIImage(
                      _currentRate - 1 >= index ? ImagesPath.rateIcSelectStar : ImagesPath.rateIcUnSelectStar,
                      width: IZISizeUtil.setSize(percent: .01),
                      colorIconsSvg: _currentRate - 1 >= index ? ColorResources.YELLOW : ColorResources.WHITE,
                    );
                  },
                  onRatingUpdate: (rating) {
                    _currentRate = IZINumber.parseInt(rating);
                    setState(() {});
                  },
                ),
              ),
              IZIButton(
                margin: IZISizeUtil.setEdgeInsetsOnly(
                  left: IZISizeUtil.SPACE_4X,
                  right: IZISizeUtil.SPACE_4X,
                  bottom: IZISizeUtil.SPACE_6X,
                ),
                fontSizedLabel: 14.sp,
                label: _currentRate >= _rateUsList.length - 2 ? 'setting_30'.tr : 'setting_05'.tr,
                onTap: () {
                  Get.back();
                  widget.callBack(_currentRate);
                },
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: IZISizeUtil.setEdgeInsetsOnly(top: IZISizeUtil.SPACE_2X),
            width: IZISizeUtil.setSize(percent: .04),
            height: IZISizeUtil.setSize(percent: .04),
            decoration: BoxDecoration(
              color: ColorResources.WHITE.withOpacity(.2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.close,
                color: ColorResources.WHITE,
              ),
            ),
          ),
        )
      ],
    );
  }
}
