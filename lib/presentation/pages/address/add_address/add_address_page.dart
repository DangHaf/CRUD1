import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/presentation/pages/address/add_address/add_address_controller.dart';
import 'package:template/presentation/pages/address/widgets/dialog_city.dart';
import 'package:template/presentation/pages/address/widgets/dialog_state.dart';
import 'package:template/presentation/pages/auth/widgets/auth_input.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class AddAddressPage extends GetView<AddAddressController> {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: controller.ignoring.value,
        child: Scaffold(
          backgroundColor: ColorResources.BACK_GROUND_2,
          appBar: BaseAppBar(
            title: 'address_004'.tr,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    vertical: 25.h,
                  ),
                  child: Column(
                    children: [
                      AuthInput(
                        label: 'account_024'.tr,
                        controller: controller.name,
                        hintText: 'account_025'.tr,
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        controller: controller.phoneNumber,
                        hintText: 'account_030'.tr,
                        label: 'account_029'.tr,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        prefixIcon: IntrinsicHeight(
                          child: _buildPrefixPhoneInput(),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        controller: controller.stateController,
                        hintText: 'account_021'.tr,
                        label: 'account_045'.tr,
                        readOnly: true,
                        isSelect: true,
                        onTap: () {
                          Get.dialog(
                            DialogState(
                              callBack: (state) {
                                controller.onChangeState(state);
                              },
                              initValue: controller.state,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        controller: controller.cityController,
                        hintText: 'account_021'.tr,
                        label: 'account_046'.tr,
                        readOnly: true,
                        isSelect: true,
                        onTap: () {
                          if (controller.state == null) {
                            IZIAlert().error(message: 'account_047'.tr);
                            return;
                          }
                          Get.dialog(
                            DialogCity(
                              callBack: (value) {
                                controller.onChangeCity(value);
                              },
                              initValueCity: controller.city,
                              initValueState: controller.state,
                              listCity: controller.listCity,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        label: 'account_033'.tr,
                        controller: controller.addressController,
                        hintText: 'account_034'.tr,
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
                  label: 'address_002'.tr,
                  callBack: () {
                    controller.createAddress();
                  },
                  backgroundColor: ColorResources.COLOR_3B71CA,
                ),
              ),
            ],
          ),
        ),
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
