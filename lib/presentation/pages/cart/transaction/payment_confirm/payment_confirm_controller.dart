import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/core/utils/app_constants.dart';
import 'package:template/data/model/bank_account/bank_account_model.dart';
import 'package:template/data/model/image/image_response.dart';
import 'package:template/data/model/transaction/transaction_request.dart';
import 'package:template/data/repositories/image_upload_repositories.dart';
import 'package:template/data/repositories/transaction_repository.dart';

class PaymentConfirmController extends GetxController {
  final ImageUploadRepository _imageUploadRepository =
      GetIt.I.get<ImageUploadRepository>();
  final TransactionRepository _transactionRepository =
      GetIt.I.get<TransactionRepository>();

  RxString imagePath = "".obs;

  bool isIgnore = false;

  late num totalMoney;
  late BankAccountModel bankAccount;
  String content = '';

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments['totalMoney'] != null) {
      totalMoney = Get.arguments['totalMoney'] as num;
    }

    if (Get.arguments != null && Get.arguments['bankAccount'] != null) {
      bankAccount = Get.arguments['bankAccount'] as BankAccountModel;
    }

    if (Get.arguments != null && Get.arguments['content'] != null) {
      content = Get.arguments['content'] as String;
    }

    super.onInit();
  }

  Future<void> onPickImage() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;
      imagePath.value = images.path;
    } catch (_) {}
  }

  Future<void> onCompleted() async {
    try {
      isIgnore = true;
      EasyLoading.show(status: 'transaction_035'.tr);
      final List<UrlImageResponse> _imageConfirm =
          await _imageUploadRepository.addImages([File(imagePath.value)]);

      if (_imageConfirm.isEmpty) {
        EasyLoading.dismiss();
        isIgnore = false;
        IZIAlert().error(message: 'news_082'.tr);
        return;
      }
      final TransactionRequest transactionRequest = TransactionRequest();
      transactionRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
      transactionRequest.totalMoney = totalMoney;
      transactionRequest.content = 'Bank transfer to buy package';
      transactionRequest.method = TRANSFER;
      transactionRequest.unitMoney = '\$';
      transactionRequest.type = WITHDRAW_MONEY;
      transactionRequest.status = CHECKING;
      transactionRequest.image = _imageConfirm.first.mediumImage;
      transactionRequest.accountNumber = bankAccount.accountNumber;
      transactionRequest.accountName = bankAccount.accountName;
      transactionRequest.bankName = bankAccount.bankName;
      await _transactionRepository.create(
        transactionRequest: transactionRequest,
        onSuccess: (data) async {
          EasyLoading.dismiss();
          isIgnore = false;
          Get.back();
          Get.back(result: data);
        },
        onError: (err) {
          IZIAlert().error(message: err.toString());
          EasyLoading.dismiss();
          isIgnore = false;
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      isIgnore = false;
    }
  }

  void copyData({required String content}) {
    Clipboard.setData(ClipboardData(text: content));
    IZIAlert().info(message: 'transaction_017'.tr);
  }
}
