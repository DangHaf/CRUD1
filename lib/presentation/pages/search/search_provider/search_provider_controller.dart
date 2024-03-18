import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/provider/provider_param.dart';
import 'package:template/data/repositories/provider_repository.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchProviderController extends GetxController {
  final ProviderRepository _providerRepository =
      GetIt.I.get<ProviderRepository>();
  final RefreshController refreshController = RefreshController();
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  RxList<ProviderModel> listProvider = <ProviderModel>[].obs;
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingMore = false.obs;

  bool get isLoadingMore => _isLoadingMore.value;
  int _totalRecord = 0;

  bool get isLoadMore => _totalRecord > listProvider.length;

  RxString searchKey = ''.obs;
  Timer? _debounce;
  ProviderParam param = ProviderParam(
    populate: 'idOwner',
    fields: 'name,businessPhone,idOwner.fullName,thumbnail,address,city,state',
  );

  @override
  void onInit() {
    searchKey.value = Get.arguments as String;
    searchController.text = Get.arguments as String;
    focusNode.requestFocus();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: searchController.text.length),
        );
      }
    });
    initSearch();
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

    param.slug = searchTerm;
    listProvider.clear();
    _isLoading.value = true;
    param.page = 1;
    await getListProvider();
    _isLoading.value = false;
  }

  Future<void> getListProvider({bool isLoadMore = false}) async {
    if (isLoadMore) {
      _isLoadingMore.value = true;
    }
    await _providerRepository.getProvider(
      providerParam: param,
      onSuccess: (data) {
        if (!isLoadMore) {
          listProvider.clear();
        }
        listProvider.addAll(data.result);
        _totalRecord = data.totalResults;
        param.page++;
      },
      onError: (error) {},
    );
    if (isLoadMore) {
      _isLoadingMore.value = false;
    }
    refreshController.loadComplete();
  }
}
