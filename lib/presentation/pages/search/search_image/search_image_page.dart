import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/home/widgets/item_product.dart';
import 'package:template/presentation/pages/search/search_image/search_image_controller.dart';
import 'package:template/presentation/pages/search/search_image/widgets/persitent_header.dart';

class SearchImagePage extends GetView<SearchImageController> {
  const SearchImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.filePath.value.isNotEmpty
          ? Scaffold(
              body: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top),
                  IZIImage.file(
                    File(controller.filePath.value),
                    width: Get.width,
                  ),
                ],
              ),
            )
          : Scaffold(
              backgroundColor: ColorResources.BACK_GROUND_2,
              appBar: BaseAppBar(
                title: 'search_image_001'.tr,
              ),
              body: Column(
                children: [
                  SizedBox(height: 5.h),
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                      vertical: 28.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10.r),
                              onTap: () async {
                                await controller.pickImageCamera();
                                if (controller.filePath.isNotEmpty) {
                                  await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          topRight: Radius.circular(20.r),
                                        ),
                                      ),
                                      backgroundColor:
                                          ColorResources.BACK_GROUND_2,
                                      enableDrag: false,
                                      isDismissible: true,
                                      builder: (context) {
                                        return _buildBottomSheetResult();
                                      });
                                  controller.filePath.value = '';
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorResources.COLOR_EBEBEB,
                                ),
                                padding: EdgeInsets.all(16.r),
                                child: Image.asset(ImagesPath.icCameraSearch,
                                    width: 80.r, height: 80.r),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'search_image_003'.tr,
                              style: AppText.text14.copyWith(
                                color: ColorResources.COLOR_677275,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10.r),
                              onTap: () async {
                                await controller.pickImageGallery();
                                if (controller.filePath.isNotEmpty) {
                                  await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          topRight: Radius.circular(20.r),
                                        ),
                                      ),
                                      backgroundColor:
                                          ColorResources.BACK_GROUND_2,
                                      enableDrag: false,
                                      isDismissible: true,
                                      builder: (context) {
                                        return _buildBottomSheetResult();
                                      });
                                  controller.filePath.value = '';
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: ColorResources.COLOR_EBEBEB,
                                ),
                                padding: EdgeInsets.all(16.r),
                                child: Image.asset(ImagesPath.imageUpload,
                                    width: 80.r, height: 80.r),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'search_image_004'.tr,
                              style: AppText.text14.copyWith(
                                color: ColorResources.COLOR_677275,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildBottomSheetResult() {
    return DraggableScrollableSheet(
        shouldCloseOnMinExtent: false,
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.35,
        snapAnimationDuration: const Duration(milliseconds: 1000),
        expand: false,
        builder: (context, scrollController) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  height: 140.h,
                  widget: Container(
                    decoration: BoxDecoration(
                      color: ColorResources.BACK_GROUND_2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Align(
                          child: Container(
                            width: 102.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: ColorResources.COLOR_8A92A6,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 14.h),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.transparent,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'search_image_002'.tr,
                                  style: AppText.text18.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                              right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                              bottom: 14.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: ColorResources.COLOR_E4E4E4,
                            ),
                            padding: EdgeInsets.all(14.r),
                            child: Image.asset(
                              ImagesPath.icCameraBlue,
                              width: 22.r,
                              height: 22.r,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 0,
                          thickness: 0.5,
                          color: ColorResources.COLOR_A4A2A2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(
                  () => controller.isLoading
                      ? GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: 30,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8,
                                  crossAxisSpacing: 10.r,
                                  mainAxisSpacing: 10.r),
                          padding: EdgeInsets.symmetric(
                            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                            vertical: 10.h,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return const ItemProductLoading();
                          },
                        )
                      : controller.listProduct.isEmpty
                          ? SizedBox(
                              width: Get.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 100),
                                  Image.asset(
                                    ImagesPath.icNoProduct,
                                    width: 118.w,
                                    height: 118.w,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'no_data_product'.tr,
                                    style: AppText.text16.copyWith(
                                      color: ColorResources.COLOR_464647,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: controller.listProduct.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 10.r,
                                      mainAxisSpacing: 10.r),
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    IZISizeUtil.PADDING_HORIZONTAL_HOME,
                                vertical: 10.h,
                              ),
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return ItemProduct(
                                  product: controller.listProduct[index],
                                );
                              },
                            ),
                ),
              ),
            ],
          );
        });
  }
}
