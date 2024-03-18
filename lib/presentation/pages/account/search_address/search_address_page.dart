import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/account/search_address/search_address_controller.dart';

class SearchAddressPage extends GetView<SearchAddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'search_map_001'.tr,
        onBack: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          vertical: 14.h,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: controller.searchController,
              focusNode: controller.focusNode,
              textInputAction: TextInputAction.search,
              onChanged: (val) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 18,
                ),
                isDense: true,
                hintText: 'search_001'.tr,
                hintStyle: AppText.text14.copyWith(
                  color: ColorResources.COLOR_B1B1B1,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.asset(
                    ImagesPath.icSearch,
                    width: 30.r,
                    height: 30.r,
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoadingFirst.isTrue) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.placeList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IZIImage(ImagesPath.icMap, width: 150.r),
                        SizedBox(height: 14.h),
                        Text(
                          "search_map_003".tr,
                          style: AppText.text14.copyWith(
                            color: ColorResources.COLOR_464647,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.placeList.length,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectAddress(
                            controller.placeList[i]["description"].toString());
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    controller.placeList[i]["description"]
                                        as String,
                                    style: AppText.text14.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 0.5);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
