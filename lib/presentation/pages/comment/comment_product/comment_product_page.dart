import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/enums/extension.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/comment/comment_product/comment_product_controller.dart';
import 'package:template/presentation/pages/comment/widgets/item_tap_comment.dart';
import 'package:template/presentation/pages/comment/widgets/comment_product_item.dart';

class CommentProductPage extends GetView<CommentProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'product_detail_010'.tr,
      ),
      body: Obx(
        () => SmartRefresher(
          controller: controller.refreshController,
          header: Platform.isAndroid
              ? const MaterialClassicHeader(color: ColorResources.COLOR_3B71CA)
              : null,
          onLoading: () => controller.getListComment(isLoadMore: true),
          enablePullUp: controller.isLoadMore,
          onRefresh: () => controller.initData(isRefresh: true),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                _buildHeader(),
                SizedBox(height: 10.h),
                Obx(
                  () => (!controller.isLoading && controller.comments.isEmpty)
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(height: 100.h),
                              Text(
                                'empty_data'.tr,
                                style: AppText.text14.copyWith(
                                  color: ColorResources.COLOR_677275,
                                ),
                              ),
                            ],
                          ),
                        )
                      : _buildListComment(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListComment() {
    return Obx(
      () => controller.isLoading
          ? ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              itemBuilder: (BuildContext context, int index) {
                return const CommentProductItemLoading();
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 0.3,
                  color: ColorResources.COLOR_A4A2A2,
                  height: 0,
                );
              },
            )
          : ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.comments.length,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              itemBuilder: (BuildContext context, int index) {
                return CommentProductItem(
                  onTapLike: () {
                    controller.onTapLike(index: index);
                  },
                  comment: controller.comments[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 0.3,
                  color: ColorResources.COLOR_A4A2A2,
                  height: 0,
                );
              },
            ),
    );
  }

  Widget _buildHeader() {
    return Obx(
      () => Container(
        color: ColorResources.BACK_GROUND_2,
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Column(
          children: [
            Row(
              children: [
                ItemTapComment(
                    isSelected: controller.currentType == EvaluationType.ALL,
                    quantity:
                        controller.cmtQuantity.value.totalRate?.totalRate ?? 0,
                    title: EvaluationType.ALL.title,
                    onTap: () {
                      controller.onChangeType(EvaluationType.ALL);
                    }),
                SizedBox(width: 10.r),
                ItemTapComment(
                    isSelected:
                        controller.currentType == EvaluationType.HAVE_CONTENT,
                    quantity:
                        controller.cmtQuantity.value.content?.content ?? 0,
                    title: EvaluationType.HAVE_CONTENT.title,
                    onTap: () {
                      controller.onChangeType(EvaluationType.HAVE_CONTENT);
                    }),
              ],
            ),
            SizedBox(height: 10.r),
            Row(
              children: [
                ItemTapComment(
                    isSelected:
                        controller.currentType == EvaluationType.NEAREST,
                    quantity:
                        controller.cmtQuantity.value.nearest?.nearest ?? 0,
                    title: EvaluationType.NEAREST.title,
                    onTap: () {
                      controller.onChangeType(EvaluationType.NEAREST);
                    }),
                SizedBox(width: 10.r),
                ItemTapComment(
                    isSelected:
                        controller.currentType == EvaluationType.TALLEST,
                    quantity:
                        controller.cmtQuantity.value.tallest?.tallest ?? 0,
                    title: EvaluationType.TALLEST.title,
                    onTap: () {
                      controller.onChangeType(EvaluationType.TALLEST);
                    }),
                SizedBox(width: 10.r),
                ItemTapComment(
                    isSelected:
                        controller.currentType == EvaluationType.SHORTEST,
                    quantity:
                        controller.cmtQuantity.value.shortest?.shortest ?? 0,
                    title: EvaluationType.SHORTEST.title,
                    onTap: () {
                      controller.onChangeType(EvaluationType.SHORTEST);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
