import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/address/address/address_controller.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class AddressPage extends GetView<AddressController> {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'address_001'.tr,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      itemCount: controller.listAddress.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.listAddress[index];
                        return InkWell(
                          onTap: () {
                            controller.onChangeAddress(index);
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                                vertical: 16.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.id == controller.address.value.id)
                                  Container(
                                    width: 20.r,
                                    height: 20.r,
                                    decoration: BoxDecoration(
                                      color: ColorResources.COLOR_3B71CA,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: ColorResources.COLOR_3B71CA,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 14.sp,
                                    ),
                                  )
                                else
                                  Container(
                                    width: 20.r,
                                    height: 20.r,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: ColorResources.COLOR_A4A2A2,
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              item.fullName,
                                              style: AppText.text14.copyWith(
                                                color:
                                                    ColorResources.COLOR_464647,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(
                                              height: 12,
                                              width: 1,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8.w),
                                              color: Colors.black,
                                            ),
                                            Text(
                                              item.phone,
                                              style: AppText.text14.copyWith(
                                                color:
                                                    ColorResources.COLOR_A4A2A2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          item.fullAddress,
                                          style: AppText.text12.copyWith(
                                            color: ColorResources.COLOR_464647,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Get.toNamed(AppRoute.EDIT_ADDRESS,
                                        arguments: item);
                                    controller.getAddress(isRefresh: true);
                                  },
                                  child: Text(
                                    'address_003'.tr,
                                    style: AppText.text14.copyWith(
                                      color: ColorResources.COLOR_0095E9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 0,
                          thickness: 0.3.h,
                          color: ColorResources.COLOR_A4A2A2,
                          indent:
                              20.r + 18.w + IZISizeUtil.PADDING_HORIZONTAL_HOME,
                        );
                      },
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: IZISizeUtil.SPACE_6X,
              left: IZISizeUtil.PADDING_HORIZONTAL,
              right: IZISizeUtil.PADDING_HORIZONTAL,
              top: 12,
            ),
            child: CustomButton(
              label: 'address_002'.tr,
              callBack: () async {
                await Get.toNamed(AppRoute.ADD_ADDRESS);
                controller.getAddress(isRefresh: true);
              },
              backgroundColor: ColorResources.COLOR_3B71CA,
            ),
          ),
        ],
      ),
    );
  }
}
