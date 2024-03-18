import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/utils/color_resources.dart';

class RatingWidget extends StatefulWidget {
  final Function(int) callBack;
  final int initRate;

  const RatingWidget({
    super.key,
    required this.callBack,
    required this.initRate,
  });

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int rate = 5;

  @override
  void initState() {
    rate = widget.initRate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) {
          return InkWell(
            onTap: () {
              setState(() {
                rate = index + 1;
              });
              widget.callBack(rate);
            },
            child: (index < rate)
                ? Icon(
                    Icons.star_sharp,
                    color: ColorResources.COLOR_FFD600,
                    size: 34.w,
                  )
                : Icon(
                    Icons.star_border,
                    color: ColorResources.COLOR_FFD600,
                    size: 34.w,
                  ),
          );
        },
      ),
    );
  }
}
