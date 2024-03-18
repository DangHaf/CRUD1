import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class ItemTapOrder extends StatelessWidget {
  final String title;
  final String icon;
  final Function() callBack;
  final int count;

  const ItemTapOrder({
    super.key,
    required this.title,
    required this.icon,
    required this.callBack,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Column(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: count > 9 ? 40.r : 30.r,
                    height: 30.r,
                    alignment: Alignment.center,
                    child: Image.asset(
                      icon,
                      width: 22.r,
                      height: 22.r,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: count == 0
                        ? const SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                              color: ColorResources.COLOR_FF4D00,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            child: Text(
                              count > 9 ? '9+' : count.toString(),
                              style: AppText.text9.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorResources.WHITE,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                title,
                style: AppText.text10.copyWith(
                  color: ColorResources.COLOR_677275,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
