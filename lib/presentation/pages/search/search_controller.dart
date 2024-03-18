import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/core/utils/app_constants.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/product/product_param.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/type_product.dart';
import 'package:template/data/repositories/product_repository.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchAppController extends GetxController {
  final ProductRepository _productRepository = GetIt.I.get<ProductRepository>();
  final RefreshController refreshController = RefreshController();
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  RxList<String> historySearch = <String>[].obs;

  Rx<FilterSortModel> filterSort = FilterSortModel().obs;
  Rx<TypeProductModel> filterGroupProduct =
      TypeProductModel().obs;

  List<FilterSortModel> listFilterSort = [
    FilterSortModel(
      id: 1,
      name: 'search_011'.tr,
    ),
    FilterSortModel(id: 2, name: 'search_012'.tr, type: NEW),
    FilterSortModel(id: 3, name: 'search_013'.tr, type: SAVING),
    FilterSortModel(id: 4, name: 'search_014'.tr, type: OUTSTANDING),
    FilterSortModel(id: 5, name: 'search_015'.tr, type: FOR_YOU),
    FilterSortModel(id: 6, name: 'search_016'.tr, type: HOT_SELL),
  ];

  List<FilterSortModel> listFilterSortNoLogin = [
    FilterSortModel(
      id: 1,
      name: 'search_011'.tr,
    ),
    FilterSortModel(id: 2, name: 'search_012'.tr, type: NEW),
    FilterSortModel(id: 3, name: 'search_013'.tr, type: SAVING),
    FilterSortModel(id: 4, name: 'search_014'.tr, type: OUTSTANDING),
    FilterSortModel(id: 6, name: 'search_016'.tr, type: HOT_SELL),
  ];

  List<TypeProductModel> listFilterGroupProduct = [
    TypeProductModel(title: 'search_011'.tr, position: -1),
    ...LookUpData.typeProduct,
  ];

  final idUser = sl<SharedPreferenceHelper>().getIdUser;
  Timer? _debounce;
  ProductParam param = ProductParam();
  RxList<ProductModel> listProduct = <ProductModel>[].obs;
  RxList<ProductModel> listProductData = <ProductModel>[].obs;
  Rxn<ProviderModel> provider = Rxn<ProviderModel>();
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingMore = false.obs;

  bool get isLoadingMore => _isLoadingMore.value;
  int _totalRecord = 0;

  bool get isLoadMore => _totalRecord > listProduct.length;

  RxBool isSearch = false.obs;

  RxString searchKey = ''.obs;

  bool isFocus = false;

  @override
  void onInit() {
    filterSort.value = listFilterSort.first;
    filterGroupProduct.value = listFilterGroupProduct.first;
    if (Get.arguments != null && Get.arguments['filterSort'] != null) {
      filterSort.value = Get.arguments['filterSort'] as FilterSortModel;
    }
    if (Get.arguments != null && Get.arguments['filterGroupProduct'] != null) {
      filterGroupProduct.value =
          Get.arguments['filterGroupProduct'] as TypeProductModel;
    }
    if (Get.arguments != null && Get.arguments['isFocus'] != null) {
      isFocus = Get.arguments['isFocus'] as bool;
    }
    if (isFocus) {
      focusNode.requestFocus();
    } else {
      isSearch.value = true;
      initSearch();
    }
    if (sl<SharedPreferenceHelper>().getIdUser.isNotEmpty) {
      historySearch.addAll(sl<SharedPreferenceHelper>().getListHistorySearch);
    } else {
      initSearch();
    }
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: searchController.text.length),
        );
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onApplySort(FilterSortModel value1, TypeProductModel value2) {
    filterSort.value = value1;
    filterGroupProduct.value = value2;
    initSearch();
  }

  // ignore: use_setters_to_change_properties
  void onChangeFilterSort(FilterSortModel value) {
    if (filterSort.value.id == value.id) {
      return;
    }
    filterSort.value = value;
    initSearch();
  }

  // ignore: use_setters_to_change_properties
  void onChangeFilterGroupProduct(TypeProductModel value) {
    if (filterGroupProduct.value.id == value.id) {
      return;
    }
    filterGroupProduct.value = value;
    initSearch();
  }

  /// Handle history search
  Future<void> saveHistorySearch() async {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      return;
    }
    await sl<SharedPreferenceHelper>().setListHistorySearch(historySearch);
  }

  void onRemoveItemHistorySearch(int index) {
    historySearch.removeAt(index);
    historySearch.refresh();
    sl<SharedPreferenceHelper>().setListHistorySearch(historySearch);
  }

  void onSearchAction() {
    if (searchController.text.trim().isNotEmpty) {
      historySearch.insert(0, searchController.text.trim());
    }
  }

  void onClearHistorySearch() {
    historySearch.clear();
    historySearch.refresh();
    sl<SharedPreferenceHelper>().setListHistorySearch(historySearch);
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
    param.type = filterGroupProduct.value.id;
    param.sortType = filterSort.value.type;
    param.idUser = sl<SharedPreferenceHelper>().getIdUser;
    _handelIsSearch();
    listProduct.clear();
    _isLoading.value = true;
    param.page = 1;
    await getListProduct();
    _isLoading.value = false;
  }

  Future<void> getListProduct({bool isLoadMore = false}) async {
    if (isLoadMore) {
      _isLoadingMore.value = true;
    }
    await _productRepository.getProducts(
      productParam: param,
      onSuccess: (data) {
        if (!isLoadMore) {
          listProduct.clear();
          listProductData.clear();
        }
        provider.value = data.store;
        listProduct.addAll(data.result);
        if(filterSort.value.type == HOT_SELL){
          for (int i = 0; i < data.result.length; i++) {
            if (data.result[i].totalSold == 0) {
              continue;
            }
            listProductData.add(data.result[i]);
          }
        }else{
          listProductData.addAll(data.result);
        }
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

  void _handelIsSearch() {
    if (param.sort != null ||
        (param.sortType != null && param.sortType!.isNotEmpty) ||
        (param.type != null && param.type!.isNotEmpty) ||
        (param.slug != null && param.slug!.isNotEmpty)) {
      isSearch.value = true;
      return;
    }
    isSearch.value = false;
  }

  void onTapItemHistorySearch(String value) {
    searchController.text = value;
    searchKey.value = searchController.text.trim();
    initSearch();
  }
}

class FilterSortModel {
  int id;
  String name;
  String type;

  FilterSortModel({
    this.id = -1,
    this.name = '',
    this.type = '',
  });
}
