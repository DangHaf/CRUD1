import 'dart:io';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/repositories/product_repository.dart';

class SearchImageController extends GetxController {
  final ProductRepository _productRepository = GetIt.I.get<ProductRepository>();
  RxString filePath = ''.obs;
  String image = '';

  RxList<ProductModel> listProduct = <ProductModel>[].obs;
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  Future<void> pickImageGallery() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result == null) return;
    filePath.value = result.path;
    getProduct();
  }

  Future<void> pickImageCamera() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );

    if (result == null) return;
    filePath.value = result.path;
    getProduct();
  }

  Future<void> getProduct() async {
    listProduct.clear();
    _isLoading.value = true;
    await _productRepository.getProductSearchImage(
      image: File(filePath.value),
      onSuccess: (data) {
        listProduct.addAll(data);
      },
      onError: (e) {},
    );
    _isLoading.value = false;
  }
}
