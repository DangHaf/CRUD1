import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/type_product.dart';
import 'package:template/presentation/pages/home/widgets/item_product.dart';
import 'package:template/presentation/pages/search/search_controller.dart';
import 'package:template/presentation/pages/search/widgets/bottom_filter.dart';

class SearchPage extends GetView<SearchAppController> {
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
        onBack: () {
          controller.saveHistorySearch();
          Get.back();
        },
      ),
      body: controller.idUser.isNotEmpty
          ? Obx(
              () =>
                  controller.isSearch.value ? _buildSearch() : _buildHistory(),
            )
          : _buildSearch(),
    );
  }

  Widget _buildSearch() {
    return Column(
      children: [
        _buildFilter(),
        SizedBox(height: 8.h),
        Expanded(
          child: Obx(
            () => controller.isLoading
                ? Column(
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
                  )
                : controller.listProduct.isEmpty &&
                        controller.provider.value == null
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
                              'no_data_result'.tr,
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (controller.provider.value != null)
                                _buildProvider(),
                              GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: controller.listProductData.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.8,
                                        crossAxisSpacing: 10.r,
                                        mainAxisSpacing: 10.r),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      IZISizeUtil.PADDING_HORIZONTAL_HOME,
                                  vertical: 8.h,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return ItemProduct(
                                    product: controller.listProduct[index],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilter() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME, vertical: 12.h),
      margin: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2<FilterSortModel>(
                  customButton: Obx(
                    () => Container(
                      width: 95.w,
                      height: 28.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 0.7,
                          color: ColorResources.COLOR_A4A2A2.withOpacity(0.6),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.filterSort.value.id != -1
                                  ? controller.filterSort.value.name
                                  : 'search_005'.tr,
                              style: AppText.text12.copyWith(
                                color: ColorResources.COLOR_808089,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: ColorResources.COLOR_808089,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: Get.height * 0.6,
                    width: Get.width * 0.5,
                  ),
                  onChanged: (val) {
                    controller.onChangeFilterSort(val!);
                  },
                  hint: Text(
                    'search_005'.tr,
                    style: AppText.text12
                        .copyWith(color: ColorResources.COLOR_808089),
                  ),
                  items: (sl<SharedPreferenceHelper>().getIdUser.isNotEmpty
                          ? controller.listFilterSort
                          : controller.listFilterSortNoLogin)
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              e.name,
                              style: AppText.text12.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorResources.COLOR_464647,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(width: 6.w),
              DropdownButtonHideUnderline(
                child: DropdownButton2<TypeProductModel>(
                  customButton: Obx(
                    () => Container(
                      width: 95.w,
                      height: 28.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 0.7,
                          color: ColorResources.COLOR_A4A2A2.withOpacity(0.6),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.filterGroupProduct.value.title,
                              style: AppText.text12.copyWith(
                                color: ColorResources.COLOR_808089,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: ColorResources.COLOR_808089,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: Get.height * 0.6,
                    width: Get.width * 0.5,
                  ),
                  onChanged: (val) {
                    controller.onChangeFilterGroupProduct(val!);
                  },
                  hint: Text(
                    'search_005'.tr,
                    style: AppText.text12
                        .copyWith(color: ColorResources.COLOR_808089),
                  ),
                  items: controller.listFilterGroupProduct
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              e.title,
                              style: AppText.text12.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorResources.COLOR_464647,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Get.bottomSheet(
                isScrollControlled: true,
                Obx(
                  () => BottomFilter(
                    callBack: (value1, value2) {
                      controller.onApplySort(value1, value2);
                    },
                    initFilterGroupProduct: controller.filterGroupProduct.value,
                    initFilterSort: controller.filterSort.value,
                    listDataSort: controller.listFilterSort,
                    listDataGroupProduct: controller.listFilterGroupProduct,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Image.asset(
                  ImagesPath.icFilter,
                  width: 20.r,
                  height: 18.r,
                ),
                Text(
                  'search_006'.tr,
                  style: AppText.text12.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorResources.COLOR_808089),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistory() {
    return Obx(
      () => controller.historySearch.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'search_002'.tr,
                            style: AppText.text14.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorResources.COLOR_464647),
                          ),
                          InkWell(
                            onTap: () {
                              controller.onClearHistorySearch();
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorResources.COLOR_677275,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 2.h,
                              ),
                              child: Text(
                                'search_003'.tr,
                                style: AppText.text12.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Flexible(
                      child: ListView.separated(
                        padding: EdgeInsets.only(bottom: 12.h),
                        shrinkWrap: true,
                        itemCount: controller.historySearch.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              controller.onTapItemHistorySearch(
                                  controller.historySearch[index]);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                                vertical: 5.h,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImagesPath.icHistorySearch,
                                    width: 18.r,
                                    height: 18.r,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: Text(
                                        controller.historySearch[index],
                                        style: AppText.text14.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: ColorResources.COLOR_535354,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller
                                          .onRemoveItemHistorySearch(index);
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: ColorResources.COLOR_677275,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                color: Colors.white,
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                ),
                child: Text(
                  'search_004'.tr,
                  style: AppText.text14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
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
          hintText: 'search_001'.tr,
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
                        if (controller.idUser.isNotEmpty) {
                          controller.isSearch.value = false;
                          controller.listProduct.clear();
                          return;
                        }
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
        onFieldSubmitted: (value) {
          controller.onSearchAction();
        },
        onChanged: (val) {
          controller.searchKey.value = val;
          if (val.isEmpty && controller.idUser.isNotEmpty) {
            controller.isSearch.value = false;
            controller.listProduct.clear();
            return;
          }
          controller.onSearch();
        },
      ),
    );
  }

  Widget _buildProvider() {
    return Obx(
      () => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME, vertical: 14.h),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: IZIImage(
                      controller.provider.value?.thumbnail ?? '',
                      width: 72.r,
                      height: 70.r,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.provider.value?.name ?? '',
                            style: AppText.text14.copyWith(
                              fontWeight: FontWeight.w700,
                              color: ColorResources.COLOR_535354,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 19.w,
                                height: 19.w,
                                child: Image.asset(ImagesPath.icLocationOrange),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2.5),
                                  child: Text(
                                    controller.provider.value
                                            ?.addressWithCityState ??
                                        '',
                                    style: AppText.text12.copyWith(
                                      color: ColorResources.COLOR_808089,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 0.5,
              color: ColorResources.COLOR_A4A2A2,
              height: 60.r,
              margin: EdgeInsets.symmetric(horizontal: 12.w),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoute.SEARCH_PROVIDER,
                  arguments: controller.searchKey.value,
                );
              },
              child: Row(
                children: [
                  Text(
                    'search_024'.tr,
                    style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_3B71CA,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                    color: ColorResources.COLOR_3B71CA,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
