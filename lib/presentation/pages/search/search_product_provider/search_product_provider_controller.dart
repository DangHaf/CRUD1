import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/product/product_param.dart';
import 'package:template/data/repositories/product_repository.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchProductProviderController extends GetxController {
  final ProductRepository _productRepository = GetIt.I.get<ProductRepository>();
  final RefreshController refreshController = RefreshController();
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  RxList<ProductModel> listProduct = <ProductModel>[].obs;
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingMore = false.obs;

  bool get isLoadingMore => _isLoadingMore.value;
  int _totalRecord = 0;

  bool get isLoadMore => _totalRecord > listProduct.length;

  RxString searchKey = ''.obs;
  Timer? _debounce;
  ProductParam productParam = ProductParam();

  String idStore = '';

  @override
  void onInit() {
    idStore = Get.arguments as String;
    productParam.idStore = idStore;
    focusNode.requestFocus();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: searchController.text.length),
        );
      }
    });
    onSearch();
    super.onInit();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onChangeSearch() {
    searchKey.value = searchController.text;
    onSearch();
  }

  void onSearch() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      initSearch();
    });
  }

  Future<void> initSearch() async {
    String searchTerm =
        TiengViet.parse(searchController.text.trim().toLowerCase());
    searchTerm = searchTerm.replaceAll(' ', '-');
    searchTerm = searchTerm.replaceAllMapped(RegExp(r"[!@#\$%^&*()-_=+\[\]{}|;:\',.<>?/~`]"), (match){
      return '\\\\${match.group(0)}';
    });

    productParam.slug = searchTerm;
    listProduct.clear();
    _isLoading.value = true;
    productParam.page = 1;
    await getListProduct();
    _isLoading.value = false;
  }

  Future<void> getListProduct({bool isLoadMore = false}) async {
    if (isLoadMore) {
      _isLoadingMore.value = true;
    }
    await _productRepository.getProducts(
      productParam: productParam,
      onSuccess: (data) {
        if (!isLoadMore) {
          listProduct.clear();
        }
        listProduct.addAll(data.result);
        _totalRecord = data.totalResults;
        productParam.page++;
      },
      onError: (error) {},
    );
    if (isLoadMore) {
      _isLoadingMore.value = false;
    }
    refreshController.loadComplete();
  }
}
