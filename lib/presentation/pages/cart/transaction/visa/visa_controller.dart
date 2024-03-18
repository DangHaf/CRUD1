import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/data/model/bank_account/bank_account_model.dart';
import 'package:template/data/repositories/bank_account_repository.dart';

class VisaController extends GetxController {
  final BankAccountRepository provider = GetIt.I.get<BankAccountRepository>();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvcController = TextEditingController();

  String? idBankAccount;
  RxBool ignoring = false.obs;

  @override
  void onInit() {
    _callAPIGetVisaAccount();
    super.onInit();
  }

  Future<void> _callAPIGetVisaAccount() async {
    _isLoading.value = true;
    await provider.paginate(
      page: 1,
      limit: 1,
      type: 'VISA',
      onSuccess: (data) {
        if (data.isNotEmpty) {
          idBankAccount = data.first.id.toString();

          if (data.first.accountNumber != null) {
            cardNumberController.text = data.first.accountNumber.toString();
          }
          if (data.first.accountName != null) {
            fullNameController.text = data.first.accountName.toString();
          }
          if (data.first.expirationDate != null) {
            expirationDateController.text =
                data.first.expirationDate.toString();
          }
          if (data.first.ccv != null) {
            cvcController.text = data.first.ccv.toString();
          }
        }
      },
      onError: (e) {},
    );

    _isLoading.value = false;
  }

  bool _validateSaveVisaAccount() {
    if (cardNumberController.text.isEmpty ||
        cardNumberController.text.length < 16) {
      IZIAlert().error(message: 'Invalid card number.');
      return false;
    }
    if (fullNameController.text.isEmpty) {
      IZIAlert().error(message: 'Invalid full name.');
      return false;
    }
    if (expirationDateController.text.isEmpty ||
        expirationDateController.text.length < 5) {
      IZIAlert().error(message: 'Invalid expiration date.');
      return false;
    }
    if (cvcController.text.isEmpty || cvcController.text.length < 3) {
      IZIAlert().error(message: 'Invalid CVC/CVV.');
      return false;
    }
    return true;
  }

  ///
  /// Save visa account.
  ///
  Future<void> saveVisaAccount() async {
    if (_validateSaveVisaAccount()) {
      final BankAccountResponse _bankAccountResponse = BankAccountResponse();
      bool isSuccess = false;
      if (!ignoring.value) {
        ignoring.value = true;
        EasyLoading.show(status: 'Loading...');
        _bankAccountResponse.accountNumber = cardNumberController.text;
        _bankAccountResponse.expirationDate = expirationDateController.text;
        _bankAccountResponse.ccv = cvcController.text;
        _bankAccountResponse.accountName = fullNameController.text;
        _bankAccountResponse.type = 'VISA';
        if (idBankAccount == null) {
          _bankAccountResponse.bankName = 'Visa';
          _bankAccountResponse.owner = sl<SharedPreferenceHelper>().getIdUser;
          await provider.add(
            data: _bankAccountResponse,
            onSuccess: (val) {
              EasyLoading.dismiss();
              IZIAlert().success(message: 'transaction_030'.tr);
              isSuccess = true;
            },
            onError: (e) {
              EasyLoading.dismiss();
            },
          );
        } else {
          await provider.update(
            id: idBankAccount!,
            data: _bankAccountResponse,
            onSuccess: (val) {
              EasyLoading.dismiss();
              IZIAlert().success(message: 'transaction_031'.tr);
              isSuccess = true;
            },
            onError: (e) {
              EasyLoading.dismiss();
            },
          );
        }
      }
      ignoring.value = false;
      if(isSuccess){
        Get.back(result: _bankAccountResponse);
      }
    }
  }
}
