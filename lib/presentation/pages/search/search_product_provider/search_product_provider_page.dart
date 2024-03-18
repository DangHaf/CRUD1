import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/home/widgets/item_product.dart';
import 'package:template/presentation/pages/search/search_product_provider/search_product_provider_controller.dart';

class SearchProductProviderPage
    extends GetView<SearchProductProviderController> {
  const SearchProductProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        titleWidget: Padding(
          padding: EdgeInsets.only(
            right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          ),
          child: _buildInput(),
        ),
      ),
      body: Obx(
        () => controller.isLoading
            ? Center(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    const SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        strokeAlign: 10,
                      ),
                    ),
                  ],
                ),
              )
            : controller.listProduct.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                : SmartRefresher(
                    controller: controller.refreshController,
                    onLoading: () =>
                        controller.getListProduct(isLoadMore: true),
                    enablePullDown: false,
                    enablePullUp: controller.isLoadMore,
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.listProduct.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 10.r,
                          mainAxisSpacing: 10.r),
                      padding: EdgeInsets.symmetric(
                        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                        vertical: 10.h,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ItemProduct(
                          product: controller.listProduct[index],
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  Widget _buildInput() {
    return Obx(
      () => TextFormField(
        controller: controller.searchController,
        focusNode: controller.focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'search_product_provider_001'.tr,
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(
                  ImagesPath.icSearchInput,
                  width: 18.r,
                  height: 18.r,
                ),
              ),
            ],
          ),
          suffixIcon: controller.searchKey.value.trim().isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.searchController.clear();
                        controller.searchKey.value = '';
                        controller.initSearch();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(
                          ImagesPath.icClearSearch,
                          width: 18.r,
                          height: 18.r,
                        ),
                      ),
                    ),
                  ],
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 18.h,
          ),
          isDense: true,
        ),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {},
        onChanged: (val) {
          controller.onChangeSearch();
        },
      ),
    );
  }
}
