import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/presentation/pages/order/review/widgets/rating_widget.dart';

class ReviewItem extends StatelessWidget {
  final ItemReviewModel data;
  final int indexProduct;
  final Function(int) callBackRate;
  final Function(String) callBackContent;

  const ReviewItem({
    super.key,
    required this.data,
    required this.indexProduct,
    required this.callBackRate,
    required this.callBackContent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            vertical: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          ),
          color: ColorResources.WHITE,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'rate_004'.tr} ($indexProduct)',
                style: AppText.text14.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.COLOR_181313,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: IZISizeUtil.PADDING_HORIZONTAL_HOME),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: IZIImage(
                        data.product.thumbnail ?? '',
                        height: 70.w,
                        width: 70.w,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.product.title,
                            style: AppText.text14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorResources.COLOR_464647,
                            ),
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            data.option,
                            style: AppText.text12.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorResources.COLOR_8A92A6,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          child: RatingWidget(
            callBack: (rate) {
              callBackRate(rate);
            },
            initRate: data.rating,
          ),
        ),
        Container(
          height: 202,
          margin: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 10.h),
          padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            border: Border.all(width: .5.w, color: ColorResources.COLOR_3B71CA),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextField(
            style: AppText.text12.copyWith(
                fontWeight: FontWeight.w400, color: ColorResources.TEXT_BOLD),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Hãy chia sẻ những điểu bạn thích ở sản phẩm này nhé',
            ),
            maxLines: null,
            onChanged: (value){
              callBackContent(value);
            },
          ),
        )
      ],
    );
  }
}
