import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class CircleButton extends StatelessWidget {
  final Function() callBack;

  const CircleButton({
    Key? key,
    required this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: IZISizeUtil.setSize(percent: 0.069),
        height: IZISizeUtil.setSize(percent: 0.069),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorResources.COLOR_3B71CA,
            borderRadius: BorderRadius.circular(100)),
        child: Icon(Icons.arrow_forward, color: Colors.white, size: 24.sp),
      ),
    );
  }
}
