import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/product/product_param.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/provider/provider_param.dart';
import 'package:template/data/repositories/product_repository.dart';
import 'package:template/data/repositories/provider_repository.dart';

class FavoriteController extends GetxController {
  final ProductRepository _productRepository = GetIt.I.get<ProductRepository>();
  final ProviderRepository _providerRepository =
      GetIt.I.get<ProviderRepository>();

  /// Product
  final RefreshController refreshControllerProduct = RefreshController();
  final RxBool _isLoadingFavoriteProduct = false.obs;

  bool get isLoadingFavoriteProduct => _isLoadingFavoriteProduct.value;
  int _totalRecordFavoriteProduct = 0;

  bool get isLoadMoreFavoriteProduct =>
      listFavoriteProduct.length < _totalRecordFavoriteProduct;

  RxList<ProductModel> listFavoriteProduct = <ProductModel>[].obs;

  ProductParam productParam = ProductParam();

  /// Provider
  final RefreshController refreshControllerProvider = RefreshController();
  final RxBool _isLoadingFavoriteProvider = false.obs;

  bool get isLoadingFavoriteProvider => _isLoadingFavoriteProvider.value;
  int _totalRecordFavoriteProvider = 0;

  bool get isLoadMoreFavoriteProvider =>
      listFavoriteProvider.length < _totalRecordFavoriteProvider;

  RxList<ProviderModel> listFavoriteProvider = <ProviderModel>[].obs;

  ProviderParam providerParam = ProviderParam();

  /// 0 -> Product tab, 1 -> Provider tab
  final RxInt _currentIndexTab = 0.obs;

  int get currentIndexTab => _currentIndexTab.value;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void initData() {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      return;
    }
    initDataProducts();
    initDataProviders();
  }

  /// Products
  Future<void> initDataProducts({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingFavoriteProduct.value = true;
      productParam.page = 1;
    } else {
      productParam.page = 1;
    }
    await getFavoriteProduct();
    if (isRefresh) {
      refreshControllerProduct.refreshCompleted();
    } else {
      _isLoadingFavoriteProduct.value = false;
    }
  }

  Future<void> getFavoriteProduct({bool isLoadMore = false}) async {
    await _productRepository.getFavoriteProducts(
      productParam.page,
      productParam.limit,
      onSuccess: (data) {
        if (!isLoadMore) {
          listFavoriteProduct.clear();
        }
        listFavoriteProduct.addAll(data.result);
        _totalRecordFavoriteProduct = data.totalResults;
        productParam.page++;
      },
      onError: (error) {},
    );
    if (isLoadMore) {
      refreshControllerProduct.loadComplete();
    }
  }

  /// Providers
  Future<void> initDataProviders({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingFavoriteProvider.value = true;
      providerParam.page = 1;
    } else {
      providerParam.page = 1;
    }
    await getFavoriteProvider();
    if (isRefresh) {
      refreshControllerProvider.refreshCompleted();
    } else {
      _isLoadingFavoriteProvider.value = false;
    }
  }

  Future<void> getFavoriteProvider({bool isLoadMore = false}) async {
    await _providerRepository.getFavoriteProviders(
      providerParam.page,
      providerParam.limit,
      onSuccess: (data) {
        if (!isLoadMore) {
          listFavoriteProvider.clear();
        }
        listFavoriteProvider.addAll(data.result);
        _totalRecordFavoriteProvider = data.totalResults;
        providerParam.page++;
      },
      onError: (error) {},
    );
    if (isLoadMore) {
      refreshControllerProvider.loadComplete();
    }
  }

  void onChangeFavoriteTab({required int index}) {
    if (index == currentIndexTab) return;

    _currentIndexTab.value = index;
    if (currentIndexTab == 0) {
      initDataProducts();
    } else {
      initDataProviders();
    }
  }

  void onHeartClicked(ProviderModel provider) {
    listFavoriteProvider.remove(provider);
    _providerRepository.setUnLike(
      idStore: provider.id!,
      idUser: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (data) {},
      onError: (error) {
        listFavoriteProvider.add(provider);
      },
    );
    listFavoriteProvider.refresh();
  }
}
