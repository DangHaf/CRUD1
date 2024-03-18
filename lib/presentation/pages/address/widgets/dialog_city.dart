import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/address/address_model.dart';

class DialogCity extends StatefulWidget {
  final Function(CityModel value) callBack;
  final StateModel? initValueState;
  final CityModel? initValueCity;
  final List<CityModel> listCity;

  const DialogCity({
    super.key,
    required this.callBack,
    this.initValueState,
    this.initValueCity,
    required this.listCity,
  });

  @override
  State<DialogCity> createState() => _DialogDistantState();
}

class _DialogDistantState extends State<DialogCity> {
  CityModel? groupValue;

  @override
  void initState() {
    groupValue = widget.initValueCity;
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
            itemCount: widget.listCity.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    groupValue = widget.listCity[index];
                  });
                  Get.back();
                  widget.callBack(widget.listCity[index]);
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
                          fillColor: MaterialStateColor.resolveWith(
                                  (states) =>
                              groupValue == widget.listCity[index]
                                  ? ColorResources.COLOR_3B71CA
                                  : ColorResources.COLOR_A4A2A2),
                          value: widget.listCity[index],
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = widget.listCity[index];
                            });
                            Get.back();
                            widget.callBack(widget.listCity[index]);
                          }),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Text(
                          widget.listCity[index].name,
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
