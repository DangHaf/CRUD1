import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/enums/enum_date_type.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class BottomSelectDate extends StatelessWidget {
  final DateType? dateType;
  final Function(DateType) callBack;

  const BottomSelectDate({Key? key, this.dateType, required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          ),
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              ItemDateType(
                isSelected: dateType == DateType.TODAY,
                dateType: DateType.TODAY,
                callBack: () {
                  Get.back();
                  callBack(DateType.TODAY);
                },
              ),
              ItemDateType(
                isSelected: dateType == DateType.YESTERDAY,
                dateType: DateType.YESTERDAY,
                callBack: () {
                  Get.back();
                  callBack(DateType.YESTERDAY);
                },
              ),
              ItemDateType(
                isSelected: dateType == DateType.LAST_WEEK,
                dateType: DateType.LAST_WEEK,
                callBack: () {
                  Get.back();
                  callBack(DateType.LAST_WEEK);
                },
              ),
              ItemDateType(
                isSelected: dateType == DateType.LAST_MONTH,
                dateType: DateType.LAST_MONTH,
                callBack: () {
                  Get.back();
                  callBack(DateType.LAST_MONTH);
                },
              ),
              ItemDateType(
                isSelected: dateType == DateType.PERIOD,
                dateType: DateType.PERIOD,
                callBack: () {
                  Get.back();
                  callBack(DateType.PERIOD);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemDateType extends StatelessWidget {
  final Function() callBack;
  final bool isSelected;
  final DateType dateType;

  const ItemDateType({
    required this.dateType,
    required this.callBack,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callBack();
      },
      child: Container(
        color: isSelected ? ColorResources.COLOR_3B71CA.withOpacity(0.1) : null,
        width: Get.width,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
          child: Text(
            dateType.stringValue,
            style: AppText.text14.copyWith(
              color: isSelected
                  ? ColorResources.COLOR_3B71CA
                  : ColorResources.COLOR_A4A2A2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
