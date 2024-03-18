// ignore_for_file: use_setters_to_change_properties

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/data/model/image/image_response.dart';
import 'package:template/data/repositories/account_repository.dart';
import 'package:template/data/repositories/auth_repository.dart';
import 'package:template/data/repositories/image_upload_repositories.dart';
import 'package:template/presentation/pages/account/account_controller.dart';
import 'package:template/presentation/pages/home/home_controller.dart';

class PersonalInformationController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final AccountRepository _accountRepository = GetIt.I.get<AccountRepository>();
  final ImageUploadRepository _imageUploadRepository =
      GetIt.I.get<ImageUploadRepository>();
  TextEditingController name = TextEditingController();
  TextEditingController nameEnglish = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  final Rx<Country> _country = LookUpData.country.obs;

  Country get country => _country.value;
  TextEditingController searchDialCode = TextEditingController();

  final Rx<UserModel> _user = (Get.arguments as UserModel).obs;

  UserModel get user => _user.value;

  RxBool ignoring = false.obs;

  PhoneCountry? phoneCountry;
  String currentPhone = '';

  @override
  void onInit() {
    final user = Get.arguments as UserModel;
    initData(user);
    super.onInit();
  }

  Future<void> initData(UserModel user) async {
    _user.value = UserModel(
      id: user.id,
      idState: user.idState,
      idCity: user.idCity,
      address: user.address,
      fullName: user.fullName,
      gender: user.gender,
      countryCode: user.countryCode,
      phone: user.phone,
      avatar: user.avatar,
      avatarFile: user.avatarFile,
      dateOfBirth: user.dateOfBirth,
      email: user.email,
      nickName: user.nickName,
      otherAddress: user.otherAddress,
    );
    name.text = user.fullName ?? '';
    nameEnglish.text = user.nickName ?? '';
    email.text = user.email ?? '';
    if (user.gender == MALE) {
      gender.text = 'account_042'.tr;
    }
    if (user.gender == FEMALE) {
      gender.text = 'account_043'.tr;
    }
    if (user.gender == OTHER) {
      gender.text = 'account_044'.tr;
    }
    if (user.dateOfBirth != null) {
      dateOfBirth.text = DateFormat('MM/dd/yyyy').format(user.dateOfBirth!);
    }
    phoneNumber.text = user.phone ?? '';
    if (user.countryCode != null) {
      try {
        for (int i = 0; i < LookUpData.countryList.length; i++) {
          if (LookUpData.countryList[i].alpha2Code == user.countryCode) {
            _country.value = LookUpData.countryList[i];
            break;
          }
        }
        await _authRepository.checkPhone(
          phoneNumber: phoneNumber.text,
          country: user.countryCode!,
          onSuccess: (data) async {
            if (data.isValid && data.phoneNational != null) {
              phoneNumber.text = data.phoneNational!;
            }
          },
          onError: (_) {},
        );
      } catch (_) {}
    }
  }

  void onChangeName(String value) {
    _user.value.fullName = value;
  }

  void onChangePhone(String value) {
    _user.value.phone = value;
  }

  void onChangeNickname(String value) {
    _user.value.nickName = value;
  }

  void onChangeEmail(String value) {
    _user.value.email = value;
  }

  void onChangeCountry(Country country) {
    _country.value = country;
    _user.value.countryCode = country.dialCode;
  }

  void onChangeGender(String gender) {
    _user.value.gender = gender;
    if (user.gender == MALE) {
      this.gender.text = 'account_042'.tr;
    }
    if (user.gender == FEMALE) {
      this.gender.text = 'account_043'.tr;
    }
    if (user.gender == OTHER) {
      this.gender.text = 'account_044'.tr;
    }
  }

  void onChangeDayOfBirth(DateTime dayOfBirth) {
    _user.value.dateOfBirth = dayOfBirth;
    dateOfBirth.text = DateFormat('MM/dd/yyyy').format(user.dateOfBirth!);
  }

  Future<void> pickAvatarGallery() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result == null) return;
    _user.value.avatarFile = File(result.path);
    _user.refresh();
  }

  Future<void> pickAvatarCamera() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );

    if (result == null) return;
    _user.value.avatarFile = File(result.path);
    _user.refresh();
  }

  Future<void> updateUser() async {
    if (!isValidRegister) {
      return;
    }
    ignoring.value = true;
    if (currentPhone != phoneNumber.text.trim()) {
      await _checkPhone();
      if (phoneCountry != null && phoneCountry!.isValid) {
        _user.value.phone = phoneCountry!.phoneNumber;
      }
    }
    EasyLoading.show(status: 'account_036'.tr);
    if (user.avatarFile != null) {
      await _uploadImage(user.avatarFile!);
    }
    await _accountRepository.updateUser(
      user: user,
      onSuccess: () {
        IZIAlert().success(message: 'account_037'.tr);
        Get.find<AccountController>().getUser();
        Get.find<HomeController>().getUser();
        Get.back();
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    ignoring.value = false;
    EasyLoading.dismiss();
  }

  Future<void> _uploadImage(File file) async {
    final File rotatedImage =
        await FlutterExifRotation.rotateImage(path: file.path);
    final List<UrlImageResponse> _imageConfirm =
        await _imageUploadRepository.addImages([rotatedImage]);
    if (_imageConfirm.isNotEmpty) {
      _user.value.avatar = _imageConfirm.first.mediumImage;
    }
  }

  Future<void> _checkPhone() async {
    EasyLoading.show(status: 'auth_048'.tr);
    await _authRepository.checkPhone(
      phoneNumber: phoneNumber.text.trim(),
      country: country.alpha2Code!,
      onSuccess: (data) {
        phoneCountry = data;
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    EasyLoading.dismiss();
  }

  bool get isValidRegister {
    if (name.text.trim().isEmpty) {
      IZIAlert().error(message: 'auth_053'.tr);
      return false;
    }
    if (phoneNumber.text.isEmpty) {
      IZIAlert().error(message: 'auth_049'.tr);
      return false;
    }
    if (email.text.trim().isNotEmpty &&
        !EmailValidator.validate(email.text.trim())) {
      IZIAlert().error(message: 'auth_056'.tr);
      return false;
    }
    return true;
  }
}
