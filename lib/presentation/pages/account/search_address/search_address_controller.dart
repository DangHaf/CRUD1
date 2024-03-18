import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_validate.dart';
import 'package:template/core/utils/app_constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchAddressController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final uuid = const Uuid();
  final RxString _sessionToken = ''.obs;
  final RxList _placeList = [].obs;
  Timer? _debounce;

  List get placeList => _placeList;
  RxBool isLoadingFirst = false.obs;

  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    getArg();
    searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _onChanged();
      });
    });
    focusNode.requestFocus();
  }

  @override
  void onClose() {
    super.onClose();
    _sessionToken.close();
    _placeList.close();
    searchController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    focusNode.dispose();
  }

  ///
  /// Lấy đối số
  ///
  void getArg() {
    if (Get.arguments != null && (Get.arguments as String).isNotEmpty) {
      searchController.text = Get.arguments as String;
      isLoadingFirst.value = true;
      getSuggestion();
    }
  }

  ///
  /// Thay đổi
  ///
  void _onChanged() {
    if (IZIValidate.nullOrEmpty(_sessionToken.value)) {
      _sessionToken.value = uuid.v4();
    }
    getSuggestion();
  }

  ///
  /// Gợi ý.
  ///
  Future<void> getSuggestion() async {
    // ignore: prefer_final_locals
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    // ignore: prefer_final_locals
    String request =
        '$baseURL?input=${searchController.text}&key=$MAP_KEY&sessiontoken=$_sessionToken&language=vi';
    final response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      _placeList.value =
          json.decode(response.body)['predictions'] as List<dynamic>;
      isLoadingFirst.value = false;
    } else {
      isLoadingFirst.value = false;
      throw Exception('Failed to load predictions');
    }
  }

  void selectAddress(String value) {
    Get.back(result: value);
  }
}
