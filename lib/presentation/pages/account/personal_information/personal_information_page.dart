import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/theme/app_theme.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/presentation/pages/account/personal_information/personal_information_controller.dart';
import 'package:template/presentation/pages/account/widgets/bottom_change_avatar.dart';
import 'package:template/presentation/pages/account/widgets/bottom_change_gender.dart';
import 'package:template/presentation/pages/auth/widgets/auth_input.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class PersonalInformationPage extends GetView<PersonalInformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: 'account_019'.tr,
      ),
      body: Obx(
        () => IgnorePointer(
          ignoring: controller.ignoring.value,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    vertical: 18.h,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              BottomChangeAvatar(
                                callBackCamera: () {
                                  controller.pickAvatarCamera();
                                },
                                callBackGallery: () {
                                  controller.pickAvatarGallery();
                                },
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Obx(
                                () => ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: controller.user.avatarFile != null
                                      ? IZIImage.file(
                                          controller.user.avatarFile,
                                          width: 80.r,
                                          height: 80.r,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                controller.user.avatar ?? '',
                                            fadeOutDuration: Duration.zero,
                                            fadeInDuration: Duration.zero,
                                            width: 80.r,
                                            height: 80.r,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget: (context, url, error) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                  size: 50.sp,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Image.asset(
                                  ImagesPath.icCamera,
                                  width: 22.r,
                                  height: 22.r,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'account_023'.tr,
                        style: AppText.text12.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorResources.COLOR_3B71CA,
                        ),
                      ),
                      SizedBox(height: 28.h),
                      AuthInput(
                        label: 'account_024'.tr,
                        fillColor: ColorResources.COLOR_F6F6F7,
                        controller: controller.name,
                        hintText: 'account_025'.tr,
                        onChange: (value) {
                          controller.onChangeName(value);
                        },
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        isRequired: false,
                        label: 'account_026'.tr,
                        subLabel: 'account_027'.tr,
                        fillColor: ColorResources.COLOR_F6F6F7,
                        controller: controller.nameEnglish,
                        hintText: 'account_028'.tr,
                        onChange: (value) {
                          controller.onChangeNickname(value);
                        },
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        controller: controller.phoneNumber,
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
                          controller.onChangePhone(value);
                        },
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        isRequired: false,
                        label: 'account_031'.tr,
                        fillColor: ColorResources.COLOR_F6F6F7,
                        controller: controller.email,
                        hintText: 'account_032'.tr,
                        onChange: (value) {
                          controller.onChangeEmail(value);
                        },
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        isRequired: false,
                        label: 'account_020'.tr,
                        fillColor: ColorResources.COLOR_F6F6F7,
                        controller: controller.dateOfBirth,
                        hintText: 'account_021'.tr,
                        readOnly: true,
                        isSelect: true,
                        onTap: () async {
                          final res = await showDatePicker(
                            context: context,
                            lastDate: DateTime(5000),
                            firstDate: DateTime(1970),
                            initialDate:
                                controller.user.dateOfBirth ?? DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: AppTheme.light.copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: ColorResources.COLOR_3B71CA,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          ColorResources.COLOR_3B71CA,
                                      textStyle: AppText.text14.copyWith(
                                        color: ColorResources.COLOR_3B71CA,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  datePickerTheme:
                                      const DatePickerThemeData().copyWith(
                                    yearBackgroundColor:
                                        const MaterialStatePropertyAll(
                                            Colors.white),
                                    yearForegroundColor:
                                        const MaterialStatePropertyAll(
                                            Colors.black),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (res != null) {
                            if (res.isAfter(DateTime.now())) {
                              IZIAlert().error(
                                message: 'account_065'.tr,
                              );
                              return;
                            }
                            controller.onChangeDayOfBirth(res);
                          }
                        },
                      ),
                      SizedBox(height: 12.h),
                      AuthInput(
                        isRequired: false,
                        label: 'account_022'.tr,
                        fillColor: ColorResources.COLOR_F6F6F7,
                        controller: controller.gender,
                        hintText: 'account_021'.tr,
                        readOnly: true,
                        isSelect: true,
                        onTap: () {
                          Get.bottomSheet(
                            BottomChangeGender(
                              callBack: (gender) {
                                controller.onChangeGender(gender);
                              },
                              gender: controller.user.gender,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  vertical: 12,
                ),
                child: CustomButton(
                  label: 'account_035'.tr,
                  callBack: () {
                    controller.updateUser();
                  },
                  backgroundColor: ColorResources.COLOR_3B71CA,
                  paddingVertical: 12.h,
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
