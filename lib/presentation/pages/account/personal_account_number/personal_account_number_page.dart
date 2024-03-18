import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/presentation/pages/account/personal_account_number/personal_account_number_controller.dart';
import 'package:template/presentation/pages/auth/widgets/auth_input.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class PersonalAccountNumberPage
    extends GetView<PersonalAccountNumberController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: controller.ignoring.value,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: BaseAppBar(
              title: 'account_057'.tr,
            ),
            body: Obx(
              () => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            AuthInput(
                              label: 'account_051'.tr,
                              fillColor: ColorResources.COLOR_F6F6F7,
                              controller: controller.bankName,
                              hintText: 'Zelle',
                              onChange: (value) {
                                controller.bankAccount.bankName = value;
                              },
                            ),
                            SizedBox(height: 12.h),
                            AuthInput(
                              controller: controller.accountNumber,
                              hintText: 'account_030'.tr,
                              label: 'account_029'.tr,
                              fillColor: ColorResources.COLOR_F6F6F7,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              prefixIcon: IntrinsicHeight(
                                child: _buildPrefixPhoneInput(),
                              ),
                              onChange: (value) {
                                controller.bankAccount.accountNumber = value;
                              },
                            ),
                            SizedBox(height: 12.h),
                            AuthInput(
                              label: 'account_031'.tr,
                              fillColor: ColorResources.COLOR_F6F6F7,
                              controller: controller.accountName,
                              hintText: 'account_032'.tr,
                              onChange: (value) {
                                controller.bankAccount.accountName = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            bottomNavigationBar: Obx(
              () => Container(
                height: 84.h,
                color: ColorResources.WHITE,
                padding: EdgeInsets.only(
                  right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  top: 12.h,
                  bottom: 22.h,
                ),
                child: CustomButton(
                  label: controller.buttonStatus
                      ? 'account_058'.tr
                      : 'account_035'.tr,
                  callBack: () {
                    controller.updateUserAccountNumberInfo();
                  },
                  backgroundColor: ColorResources.COLOR_3B71CA,
                  paddingVertical: 10.h,
                ),
              ),
            )),
      ),
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
              controller.onChangeCountry(val!);
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
