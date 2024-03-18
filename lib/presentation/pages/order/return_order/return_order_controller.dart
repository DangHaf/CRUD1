import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/data/model/image/image_response.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/repositories/image_upload_repositories.dart';
import 'package:template/data/repositories/order_repository.dart';

class ReturnOrderController extends GetxController {
  final OrderRepository _orderRepository = GetIt.I.get<OrderRepository>();
  final ImageUploadRepository _imageUploadRepository =
      GetIt.I.get<ImageUploadRepository>();
  OrderDetailModel order = Get.arguments as OrderDetailModel;
  TextEditingController descriptionController = TextEditingController();

  Rx<ReturnReasonModel> reasonReturn =
      ReturnReasonModel(id: -1, name: 'return_004'.tr).obs;

  RxList<XFile> files = <XFile>[].obs;
  List<File> listImage = [];

  RxBool ignoring = false.obs;

  void onChangeReason(ReturnReasonModel reason) {
    reasonReturn.value = reason;
  }

  Future<void> pickImage() async {
    final result = await ImagePicker().pickMultiImage(
      imageQuality: 70,
      maxWidth: 1440,
    );
    if (files.length >= 5) {
      IZIAlert().error(message: 'return_021'.tr);
      return;
    }
    if (result.isNotEmpty) {
      files.addAll(result);
    }
    if(files.length > 5){
      IZIAlert().error(message: 'return_021'.tr);
    }
    files.value = files.sublist(0, 5);
  }

  Future<void> takeAPhoto() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );

    if (result == null) return;
    if (files.length >= 5) {
      IZIAlert().error(message: 'return_021'.tr);
      return;
    }
    files.add(result);
  }

  void onRemoveFile(int index) {
    files.removeAt(index);
    files.refresh();
  }

  Future<void> returnOrder() async {
    if (!isValid) {
      return;
    }
    listImage.clear();
    for (int i = 0; i < files.length; i++) {
      listImage.add(File(files[i].path));
    }
    ignoring.value = true;
    EasyLoading.show(status: 'order_044'.tr);
    List<String> images = [];
    if (listImage.isNotEmpty) {
      images = await _uploadImage();
    }
    await _orderRepository.returnOrder(
      id: order.id,
      returnRequest: orderReturnRequest(images),
      onSuccess: () {
        Get.back();
      },
      onError: (e) {
        IZIAlert().error(message: e.toString());
      },
    );
    EasyLoading.dismiss();
    ignoring.value = false;
  }

  bool get isValid {
    if (reasonReturn.value.id == -1) {
      IZIAlert().error(message: 'return_019'.tr);
      return false;
    }
    return true;
  }

  OrderReturnRequest orderReturnRequest(List<String> images) {
    return OrderReturnRequest(
      cancelationReason: reasonReturn.value.name,
      images: images,
      descriptionReason: descriptionController.text,
    );
  }

  Future<List<String>> _uploadImage() async {
    List<String> imageUrls = [];
    final List<File> listRotatedImage = [];

    for (int i = 0; i < listImage.length; i++) {
      final File rotatedImage =
          await FlutterExifRotation.rotateImage(path: listImage[i].path);
      listRotatedImage.add(rotatedImage);
    }

    final List<UrlImageResponse> _imageConfirm =
        await _imageUploadRepository.addImages(listRotatedImage);
    if (_imageConfirm.isNotEmpty) {
      final List<String> images = [];
      for (int i = 0; i < _imageConfirm.length; i++) {
        images.add(_imageConfirm[i].mediumImage!);
      }
      imageUrls = images;
    }
    return imageUrls;
  }
}

class ReturnReasonModel {
  final int id;
  final String name;

  ReturnReasonModel({required this.id, required this.name});
}
