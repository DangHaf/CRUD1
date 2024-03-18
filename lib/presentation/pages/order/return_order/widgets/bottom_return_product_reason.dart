import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/order/return_order/return_order_controller.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class BottomReturnProductReason extends StatefulWidget {
  final Function(ReturnReasonModel) callBack;
  final ReturnReasonModel initData;

  const BottomReturnProductReason({
    super.key,
    required this.callBack,
    required this.initData,
  });

  @override
  State<BottomReturnProductReason> createState() =>
      _BottomReturnProductReasonState();
}

class _BottomReturnProductReasonState extends State<BottomReturnProductReason> {
  ReturnReasonModel reason = ReturnReasonModel(id: -1, name: 'return_004'.tr);

  List<ReturnReasonModel> listReason = [
    ReturnReasonModel(id: 1, name: 'return_012'.tr),
    ReturnReasonModel(id: 2, name: 'return_013'.tr),
    ReturnReasonModel(id: 3, name: 'return_014'.tr),
    ReturnReasonModel(id: 4, name: 'return_015'.tr),
    ReturnReasonModel(id: 5, name: 'return_016'.tr),
  ];

  @override
  void initState() {
    reason = widget.initData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.clear,
                        color: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'account_059'.tr,
                        style: AppText.text18.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: ColorResources.COLOR_A4A2A2,
              ),
              Padding(
                padding: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                child: Text(
                  'account_060'.tr,
                  style: AppText.text12,
                ),
              ),
              Column(
                children: List.generate(
                  listReason.length,
                  (int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              reason = listReason[index];
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 16.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 7.r,
                                  height: 7.r,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: ColorResources.COLOR_464647),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Text(
                                      listReason[index].name,
                                      style: AppText.text14,
                                    ),
                                  ),
                                ),
                                if (listReason[index].id == reason.id)
                                  Container(
                                    width: 22.r,
                                    height: 22.r,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: ColorResources.COLOR_30BB1A,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18.r,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 0.5,
                          color: ColorResources.COLOR_A4A2A2,
                          endIndent: 14.w,
                          indent: 14.w,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 28.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    vertical: 20.h),
                child: CustomButton(
                  label: 'return_018'.tr,
                  callBack: () {
                    Get.back();
                    widget.callBack(reason);
                  },
                  backgroundColor: ColorResources.COLOR_3B71CA,
                  paddingVertical: 12.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
