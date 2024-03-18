import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/comment/comment_model.dart';
import 'package:template/presentation/pages/product/widgets/evaluation_widget.dart';

class CommentProductItem extends StatelessWidget {
  final CommentModel comment;
  final Function() onTapLike;

  const CommentProductItem({
    super.key,
    required this.onTapLike,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        vertical: 12.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: IZIImage(
              comment.idUser!.avatar ?? '',
              height: 40.w,
              width: 40.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.idUser!.fullName ?? '',
                        style: AppText.text12.copyWith(
                            color: ColorResources.COLOR_333334,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            onTapLike();
                          },
                          child: comment.isLike
                              ? Image.asset(
                                  ImagesPath.icLike,
                                  width: 17.r,
                                  height: 17.r,
                                )
                              : Image.asset(
                                  ImagesPath.icUnlike,
                                  width: 19.r,
                                  height: 19.r,
                                ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          comment.userLikes.length.toString(),
                          style: AppText.text14.copyWith(
                              color: comment.isLike
                                  ? ColorResources.COLOR_3B71CA
                                  : ColorResources.COLOR_464647,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 5.h),
                EvaluationWidget(rate: comment.point!.toDouble()),
                SizedBox(height: 10.h),
                Text(
                  comment.option,
                  style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_A4A2A2,
                      fontWeight: FontWeight.w400),
                ),
                if (comment.content != null && comment.content!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Text(
                        comment.content ?? '',
                        style: AppText.text12.copyWith(
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                SizedBox(height: 10.h),
                Text(
                  comment.timeComment,
                  style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_A4A2A2,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentProductItemLoading extends StatelessWidget {
  const CommentProductItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.symmetric(
        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        vertical: 12.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: IZIImage(
              '',
              height: 40.w,
              width: 40.w,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: ColorResources.NEUTRALS_6,
              highlightColor: Colors.grey.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width * 0.4,
                    height: 12.sp,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  const EvaluationWidget(rate: 0),
                  SizedBox(height: 10.h),
                  Container(
                    width: Get.width * 0.6,
                    height: 12.sp,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: Get.width * 0.5,
                    height: 12.sp,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: Get.width * 0.5,
                    height: 12.sp,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: Get.width * 0.3,
                    height: 12.sp,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
