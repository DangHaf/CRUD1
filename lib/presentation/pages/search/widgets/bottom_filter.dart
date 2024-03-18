import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/type_product.dart';
import 'package:template/presentation/pages/search/search_controller.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class BottomFilter extends StatefulWidget {
  final Function(FilterSortModel value1, TypeProductModel value2)
      callBack;
  final FilterSortModel initFilterSort;
  final List<FilterSortModel> listDataSort;

  final TypeProductModel initFilterGroupProduct;
  final List<TypeProductModel> listDataGroupProduct;

  const BottomFilter({
    super.key,
    required this.callBack,
    required this.listDataSort,
    required this.initFilterSort,
    required this.initFilterGroupProduct,
    required this.listDataGroupProduct,
  });

  @override
  State<BottomFilter> createState() => _BottomFilterState();
}

class _BottomFilterState extends State<BottomFilter> {
  late FilterSortModel groupValueSort;
  late TypeProductModel groupValueGroupProduct;

  @override
  void initState() {
    groupValueSort = widget.initFilterSort;
    groupValueGroupProduct = widget.initFilterGroupProduct;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BottomFilter oldWidget) {
    setState(() {
      groupValueSort = widget.initFilterSort;
      groupValueGroupProduct = widget.initFilterGroupProduct;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  vertical: 12.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'search_009'.tr,
                      style: AppText.text12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.transparent,
                      ),
                    ),
                    Text(
                      'search_008'.tr,
                      style: AppText.text18.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          groupValueSort = FilterSortModel();
                          groupValueGroupProduct = TypeProductModel();
                        });
                      },
                      child: Text(
                        'search_009'.tr,
                        style: AppText.text12.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.5,
                color: ColorResources.COLOR_B1B1B1,
                height: 0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'search_010'.tr,
                          style: AppText.text16.copyWith(
                            color: ColorResources.COLOR_464647,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        ...List.generate(widget.listDataSort.length, (index) {
                          if (widget.listDataSort[index].id == 5 &&
                              sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
                            return const SizedBox();
                          }
                          return InkWell(
                            onTap: () {
                              setState(() {
                                groupValueSort = widget.listDataSort[index];
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.listDataSort[index].name,
                                      style: AppText.text12.copyWith(
                                        color: ColorResources.COLOR_464647,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Radio(
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      activeColor: ColorResources.COLOR_6750A4,
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => groupValueSort.id ==
                                                  widget.listDataSort[index].id
                                              ? ColorResources.COLOR_6750A4
                                              : ColorResources.COLOR_677275),
                                      value: widget.listDataSort[index].id,
                                      groupValue: groupValueSort.id,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValueSort =
                                              widget.listDataSort[index];
                                        });
                                      }),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    height: 5.h,
                    width: Get.width,
                    color: ColorResources.BACK_GROUND_2,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'search_017'.tr,
                          style: AppText.text16.copyWith(
                            color: ColorResources.COLOR_464647,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        ...List.generate(widget.listDataGroupProduct.length,
                            (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                groupValueGroupProduct =
                                    widget.listDataGroupProduct[index];
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.listDataGroupProduct[index].title,
                                      style: AppText.text12.copyWith(
                                        color: ColorResources.COLOR_464647,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Radio(
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      activeColor: ColorResources.COLOR_6750A4,
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => groupValueGroupProduct
                                                      .id ==
                                                  widget
                                                      .listDataGroupProduct[
                                                          index]
                                                      .id
                                              ? ColorResources.COLOR_6750A4
                                              : ColorResources.COLOR_677275),
                                      value:
                                          widget.listDataGroupProduct[index].id,
                                      groupValue: groupValueGroupProduct.id,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValueGroupProduct = widget
                                              .listDataGroupProduct[index];
                                        });
                                      }),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: IZISizeUtil.SPACE_6X,
                      top: 20,
                      left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                      right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    child: CustomButton(
                      label: 'search_023'.tr,
                      callBack: () {
                        widget.callBack(groupValueSort, groupValueGroupProduct);
                        Get.back();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
