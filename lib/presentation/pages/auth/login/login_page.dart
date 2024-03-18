import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/presentation/pages/auth/login/login_controller.dart';
import 'package:template/presentation/pages/auth/login/widgets/item_tap.dart';
import 'package:template/presentation/pages/auth/widgets/auth_input.dart';
import 'package:template/presentation/pages/auth/widgets/button_login_social.dart';
import 'package:template/presentation/widgets/custom_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.COLOR_F6F6F7,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(
          () => IgnorePointer(
            ignoring: controller.ignoring.value,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: IZISizeUtil.SPACE_2X * 5,
              ),
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: 90.h),
                          _buildHeader(),
                          const SizedBox(height: IZISizeUtil.SPACE_2X * 3.0),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorResources.COLOR_F6F6F7,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                              topRight: Radius.circular(30.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: Get.width,
                                      height: 1,
                                      color: ColorResources.COLOR_D8F1FF,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          IZISizeUtil.PADDING_HORIZONTAL,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ItemTap(
                                            title: 'auth_064'.tr,
                                            isSelected:
                                                controller.currentTab == 0,
                                            callback: () =>
                                                controller.onChangeTab(0),
                                          ),
                                        ),
                                        Expanded(
                                          child: ItemTap(
                                            title: 'auth_065'.tr,
                                            isSelected:
                                                controller.currentTab == 1,
                                            callback: () =>
                                                controller.onChangeTab(1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: IZISizeUtil.PADDING_HORIZONTAL,
                                ),
                                child: Column(
                                  children: [
                                    _buildLoginWithSocial(),
                                    SizedBox(height: 10.h),
                                    _buildLoginWithPhone(),
                                    const SizedBox(
                                        height: IZISizeUtil.SPACE_2X * 2.8),
                                    CustomButton(
                                      label: 'auth_007'.tr,
                                      callBack: () {
                                        controller.onLoginWithPhone();
                                      },
                                      backgroundColor:
                                          ColorResources.COLOR_3B71CA,
                                    ),
                                    const SizedBox(
                                        height: IZISizeUtil.SPACE_3X),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AuthRouters.FORGOT_PASSWORD,
                                            arguments: {
                                              'country': controller.country,
                                              'phoneNumber': controller
                                                  .phoneNumber.text
                                                  .trim(),
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6),
                                        child: Text(
                                          'auth_006'.tr,
                                          style: AppText.text14.copyWith(
                                            color: ColorResources.COLOR_1255B9,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: IZISizeUtil.SPACE_2X),
                                    Text.rich(
                                      TextSpan(children: [
                                        WidgetSpan(
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(AuthRouters.REGISTER);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: Text('${'auth_008'.tr} ',
                                                  style:
                                                      AppText.text14.copyWith(
                                                    color: ColorResources
                                                        .COLOR_464647,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ),
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(AuthRouters.REGISTER);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: Text(
                                                'auth_009'.tr,
                                                style: AppText.text14.copyWith(
                                                  color: ColorResources
                                                      .COLOR_1255B9,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginWithSocial() {
    return Column(
      children: [
        ButtonLoginSocial(
          icon: ImagesPath.iconGoogle,
          callBack: () {
            controller.onLoginWithGoogle();
          },
          label: 'auth_011'.tr,
        ),
        if (Platform.isIOS)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: IZISizeUtil.SPACE_2X),
              ButtonLoginSocial(
                icon: ImagesPath.iconApple,
                callBack: () {
                  controller.onLoginWithApple();
                },
                label: 'auth_012'.tr,
              ),
            ],
          ),
        //TODO: open with facebook accept account
        // const SizedBox(height: IZISizeUtil.SPACE_2X),
        // ButtonLoginSocial(
        //   icon: ImagesPath.iconFacebook,
        //   callBack: () {
        //     controller.onLoginWithFacebook();
        //   },
        //   label: 'auth_013'.tr,
        // ),
      ],
    );
  }

  Widget _buildLoginWithPhone() {
    return Column(
      children: [
        AuthInput(
          controller: controller.phoneNumber,
          hintText: 'auth_004'.tr,
          prefixIcon: IntrinsicHeight(
            child: _buildPrefixPhoneInput(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onNext: () {
            controller.focusNodePassword.requestFocus();
          },
          focusNode: controller.focusNodePhone,
        ),
        const SizedBox(height: IZISizeUtil.SPACE_2X),
        AuthInput(
          isPassword: true,
          controller: controller.password,
          hintText: 'auth_003'.tr,
          focusNode: controller.focusNodePassword,
          prefixIcon: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 95.w,
                  alignment: Alignment.center,
                  child: Image.asset(ImagesPath.icPassword,
                      width: 25.w, height: 25.h),
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
            ),
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

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: IZISizeUtil.PADDING_HORIZONTAL,
      ),
      child: Column(
        children: [
          Center(
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: 'NAIL',
                  style: AppText.text36.copyWith(
                    color: ColorResources.COLOR_1255B9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: 'SUPPLY',
                  style: AppText.text36.copyWith(
                    color: ColorResources.COLOR_FFD600,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(height: IZISizeUtil.SPACE_2X),
          Text(
            'auth_001'.tr,
            style: AppText.text22.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: IZISizeUtil.SPACE_2X * 0.8),
          Text(
            'auth_002'.tr,
            style: AppText.text16.copyWith(
              color: ColorResources.COLOR_464647,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
