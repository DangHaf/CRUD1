import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/data/model/comment/comment_model.dart';
import 'package:template/presentation/pages/product/widgets/evaluation_widget.dart';

class CommentProviderItem extends StatelessWidget {
  final CommentModel comment;
  final Function() onTapLike;

  const CommentProviderItem({
    super.key,
    required this.onTapLike,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.only(
        left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        top: 12.h,
        bottom: 12.h,
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
                Padding(
                  padding: EdgeInsets.only(
                      right: IZISizeUtil.PADDING_HORIZONTAL_HOME),
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
                                fontWeight: FontWeight.w600,
                              ),
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
                      if (comment.content != null &&
                          comment.content!.isNotEmpty)
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
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoute.DETAIL_PRODUCT, arguments: {
                      "productId": comment.idProduct?.id,
                      "providerId": comment.idStore?.id
                    });
                  },
                  child: Container(
                    color: ColorResources.COLOR_F0F0F0,
                    margin: EdgeInsets.only(top: 10.h),
                    padding: EdgeInsets.only(right: 9.w),
                    child: Row(
                      children: [
                        IZIImage(
                          comment.idProduct?.thumbnail ?? '',
                          height: 30.w,
                          width: 30.w,
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Text(
                            comment.idProduct != null
                                ? comment.idProduct!.title
                                : '',
                            style: AppText.text12.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorResources.COLOR_464647,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentProviderItemLoading extends StatelessWidget {
  const CommentProviderItemLoading({super.key});

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
                    width: Get.width * 0.3,
                    height: 12.sp,
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: Get.width * 0.3,
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
                  SizedBox(height: 10.h),
                  Container(
                    width: Get.width,
                    height: 30.sp,
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
