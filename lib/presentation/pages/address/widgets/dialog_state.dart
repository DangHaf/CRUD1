import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/address/address_model.dart';

class DialogState extends StatefulWidget {
  final Function(StateModel value) callBack;
  final StateModel? initValue;

  const DialogState({
    super.key,
    required this.callBack,
    this.initValue,
  });

  @override
  State<DialogState> createState() => _DialogDistantState();
}

class _DialogDistantState extends State<DialogState> {
  StateModel? groupValue;

  @override
  void initState() {
    groupValue = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.9,
        ),
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
            shrinkWrap: true,
            itemCount: LookUpData.listState.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    groupValue = LookUpData.listState[index];
                  });
                  Get.back();
                  widget.callBack(LookUpData.listState[index]);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 9.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          activeColor: ColorResources.COLOR_3B71CA,
                          fillColor: MaterialStateColor.resolveWith((states) =>
                              groupValue == LookUpData.listState[index]
                                  ? ColorResources.COLOR_3B71CA
                                  : ColorResources.COLOR_A4A2A2),
                          value: LookUpData.listState[index],
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = LookUpData.listState[index];
                            });
                            Get.back();
                            widget.callBack(LookUpData.listState[index]);
                          }),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Text(
                          LookUpData.listState[index].name,
                          style: AppText.text14.copyWith(
                            color: ColorResources.COLOR_181313,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
