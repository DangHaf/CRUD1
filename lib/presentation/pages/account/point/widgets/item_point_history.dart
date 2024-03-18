import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/point_history_model.dart';

class ItemPointHistory extends StatelessWidget {
  final PointHistoryModel pointHistory;

  const ItemPointHistory({
    super.key,
    required this.pointHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 0.25,
                color: ColorResources.COLOR_A4A2A2,
              ),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              pointHistory.getIcon,
              width: 27.r,
              height: 27.r,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pointHistory.getTitle,
                        style: AppText.text16.copyWith(
                          color: ColorResources.COLOR_181313,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        pointHistory.getContent,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        pointHistory.historyDate != null
                            ? DateFormat('HH:mm MM/dd/yyyy')
                                .format(pointHistory.historyDate!)
                            : '',
                        style: AppText.text10.copyWith(
                          color: ColorResources.COLOR_A4A2A2,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  pointHistory.getPoint,
                  style: AppText.text14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: pointHistory.colorPoint,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
