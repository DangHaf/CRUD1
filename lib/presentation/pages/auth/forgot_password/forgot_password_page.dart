import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/presentation/pages/auth/forgot_password/forgot_password_controller.dart';
import 'package:template/presentation/pages/auth/widgets/auth_input.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(
        () => IgnorePointer(
          ignoring: controller.ignoring.value,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: BaseAppBar(
              backgroundColor: Colors.transparent,
              leading: Container(
                margin: EdgeInsets.only(left: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorResources.COLOR_F6F6F7,
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18.sp,
                      color: ColorResources.COLOR_181313.withOpacity(0.37),
                    ),
                  ),
                ),
              ),
            ),
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child:
                      IZIImage(ImagesPath.imageForgot, width: Get.width * 0.7),
                ),
                const SizedBox(height: 30),
                Text(
                  'auth_031'.tr,
                  style: AppText.text30.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: IZISizeUtil.SPACE_3X),
                Text(
                  'auth_032'.tr,
                  style: AppText.text14.copyWith(
                    color: ColorResources.COLOR_464647,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: IZISizeUtil.SPACE_2X * 4),
                AuthInput(
                  controller: controller.phoneNumber,
                  hintText: 'auth_004'.tr,
                  fillColor: ColorResources.COLOR_EAEAEA.withOpacity(0.53),
                  prefixIcon: IntrinsicHeight(
                    child: _buildPrefixPhoneInput(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ],
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
            label: 'auth_033'.tr,
            callBack: () {
              controller.onContinue();
            },
            backgroundColor: ColorResources.COLOR_3B71CA,
          ),
        ),
      ],
    );
  }

  Widget _buildPrefixPhoneInput() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<Country>(
            customButton: Obx(
              () => Container(
                width: 95.w,
                padding:
                    const EdgeInsets.only(left: IZISizeUtil.SPACE_2X * 0.8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                      child: Center(
                          child: Image.asset(controller.country.flagUri)),
                    ),
                    const SizedBox(width: IZISizeUtil.SPACE_1X),
                    Expanded(
                      child: Text(
                        controller.country.dialCode.toString(),
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: ColorResources.GREY,
                      size: 25,
                    )
                  ],
                ),
              ),
            ),
            dropdownSearchData: DropdownSearchData(
              searchInnerWidgetHeight: 0.0,
              searchController: controller.searchDialCode,
              searchInnerWidget: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  controller: controller.searchDialCode,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 16,
                    ),
                    hintText: 'Search for a dial code...',
                    hintStyle: AppText.text12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: Get.height * 0.6,
              width: Get.width * 0.6,
            ),
            onChanged: (val) {
              controller.country = val!;
            },
            hint: const Text("Dial code"),
            value: controller.country,
            items: LookUpData.countryList
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: IZIImage(e.flagUri),
                          ),
                          const SizedBox(width: IZISizeUtil.SPACE_1X),
                          Text(
                            e.dialCode.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: VerticalDivider(
            thickness: 0.5,
            color: ColorResources.COLOR_A4A2A2.withOpacity(0.8),
            indent: 0,
            endIndent: 0,
            width: 0,
          ),
        ),
      ],
    );
  }
}
