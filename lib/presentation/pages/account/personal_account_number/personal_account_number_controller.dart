import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/bank_account/bank_account_model.dart';
import 'package:template/data/model/bank_account/bank_account_request.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/data/repositories/auth_repository.dart';
import 'package:template/data/repositories/bank_account_repository.dart';

class PersonalAccountNumberController extends GetxController {
  final BankAccountRepository account = GetIt.I.get<BankAccountRepository>();
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();

  final RxBool _isLoading = true.obs;

  bool get isLoading => _isLoading.value;

  final RxBool _buttonStatus = true.obs;

  bool get buttonStatus => _buttonStatus.value;

  final Rx<Country> _country = LookUpData.country.obs;

  Country get country => _country.value;
  TextEditingController searchDialCode = TextEditingController();

  final Rx<BankAccountResponse> _bankAccountResponse =
      BankAccountResponse().obs;

  BankAccountResponse get bankAccount => _bankAccountResponse.value;

  TextEditingController bankName = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();

  PhoneCountry? phoneCountry;
  RxBool ignoring = false.obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    getBankAccountInfo();
  }

  Future<void> getBankAccountInfo() async {
    _isLoading.value = true;
    await account.paginateTypeBank(
      page: 1,
      limit: 1,
      type: BANK,
      onSuccess: (data) {
        if (data.isNotEmpty) {
          if (data.first.accountNumber != null) {
            accountNumber.text = data.first.accountNumber.toString();
            _buttonStatus.value = false;
          }
          if (data.first.accountName != null) {
            accountName.text = data.first.accountName.toString();
            _buttonStatus.value = false;
          }
          if (data.first.bankName != null) {
            bankName.text = data.first.bankName.toString();
            _buttonStatus.value = false;
          }
          _bankAccountResponse.value = data.first;

          if (bankAccount.countryCode != null) {
            try {
              for (int i = 0; i < LookUpData.countryList.length; i++) {
                if (LookUpData.countryList[i].alpha2Code ==
                    bankAccount.countryCode) {
                  _country.value = LookUpData.countryList[i];
                  break;
                }
              }
              _authRepository.checkPhone(
                phoneNumber: accountNumber.text,
                country: bankAccount.countryCode!,
                onSuccess: (data) async {
                  if (data.isValid && data.phoneNational != null) {
                    accountNumber.text = data.phoneNational!;
                  }
                },
                onError: (_) {},
              );
            } catch (_) {}
          }
        }
      },
      onError: (e) {},
    );
    _isLoading.value = false;
  }

  Future<void> addNewBankAccount() async {
    await account.addBankAccount(
      data: BankAccountRequest(
        bankName: bankAccount.bankName!,
        accountNumber: bankAccount.accountNumber!,
        accountName: bankAccount.accountName!,
        type: BANK,
        countryCode: country.alpha2Code!,
      ),
      onSuccess: (val) {
        EasyLoading.dismiss();
        IZIAlert().success(message: 'account_064'.tr);
        Get.back();
      },
      onError: (e) {
        EasyLoading.dismiss();
        IZIAlert().error(message: e.toString());
      },
    );
  }

  Future<void> updateBankAccount() async {
    await account.updateBankAccount(
      id: bankAccount.id!,
      data: BankAccountRequest(
        bankName: bankAccount.bankName!,
        accountNumber: bankAccount.accountNumber!,
        accountName: bankAccount.accountName!,
        countryCode: country.alpha2Code!,
        type: BANK,
      ),
      onSuccess: (val) {
        IZIAlert().success(message: 'account_037'.tr);
        Get.back();
      },
      onError: (e) {
        IZIAlert().error(message: e.toString());
      },
    );
  }

  Future<void> updateUserAccountNumberInfo() async {
    if (!isValidUpdate) {
      return;
    }
    await _checkPhone();
    if (phoneCountry == null || !phoneCountry!.isValid) {
      IZIAlert().error(message: 'auth_047'.tr);
      return;
    }
    if (phoneCountry != null && phoneCountry!.isValid) {
      _bankAccountResponse.value.phone = phoneCountry!.phoneNumber;
    }
    ignoring.value = true;
    EasyLoading.show();
    if (buttonStatus) {
      await addNewBankAccount();
    } else {
      await updateBankAccount();
    }
    EasyLoading.dismiss();
    ignoring.value = false;
  }

  void onChangeCountry(Country country) {
    _country.value = country;
    _bankAccountResponse.value.countryCode = country.dialCode;
  }

  bool get isValidUpdate {
    if (bankName.text.trim().isEmpty) {
      IZIAlert().error(message: 'auth_069'.tr);
      return false;
    }
    if (accountNumber.text.isEmpty) {
      IZIAlert().error(message: 'auth_049'.tr);
      return false;
    }
    if (accountName.text.isEmpty) {
      IZIAlert().error(message: 'auth_066'.tr);
      return false;
    }
    if (accountName.text.trim().isNotEmpty &&
        !EmailValidator.validate(accountName.text.trim())) {
      IZIAlert().error(message: 'auth_056'.tr);
      return false;
    }
    return true;
  }

  Future<void> _checkPhone() async {
    ignoring.value = true;
    EasyLoading.show(status: 'auth_048'.tr);
    await _authRepository.checkPhone(
      phoneNumber: accountNumber.text.trim(),
      country: country.alpha2Code!,
      onSuccess: (data) {
        phoneCountry = data;
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    EasyLoading.dismiss();
    ignoring.value = false;
  }
}
