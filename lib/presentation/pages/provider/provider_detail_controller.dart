import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/product/product_param.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/repositories/product_repository.dart';
import 'package:template/data/repositories/provider_repository.dart';
import 'package:template/presentation/pages/home/widgets/dialog_login.dart';

class ProviderDetailController extends GetxController {
  final ProductRepository _productRepository = GetIt.I.get<ProductRepository>();
  final ProviderRepository _providerRepository =
      GetIt.I.get<ProviderRepository>();
  final RefreshController refreshControllerProduct = RefreshController();

  ///Declare variables
  final RxBool _isLoading = true.obs;
  late String providerId;
  Rx<ProviderModel> provider = ProviderModel().obs;

  bool get isLoading => _isLoading.value;

  /// Out standing
  final RefreshController refreshControllerOutStanding = RefreshController();
  final RxBool _isLoadingOutStanding = false.obs;

  bool get isLoadingOutStanding => _isLoadingOutStanding.value;
  int _totalRecordOutStanding = 0;

  bool get isLoadMoreOutStanding =>
      listOutStanding.length < _totalRecordOutStanding;

  RxList<ProductModel> listOutStanding = <ProductModel>[].obs;

  ProductParam productOutStandingParam = ProductParam(isHasVoucher: true);

  /// product
  final RxBool _isLoadingProduct = false.obs;

  bool get isLoadingProduct => _isLoadingProduct.value;
  int _totalRecordProduct = 0;

  bool get isLoadMoreProduct => listProduct.length < _totalRecordProduct;

  RxList<ProductModel> listProduct = <ProductModel>[].obs;

  ProductParam productParam = ProductParam();

  @override
  void onInit() {
    providerId = Get.arguments as String;
    productOutStandingParam.idStore = providerId;
    productParam.idStore = providerId;
    initData();
    super.onInit();
  }

  @override
  void onClose() {
    _isLoadingOutStanding.close();
    super.onClose();
  }

  Future<void> initData({bool isRefresh = false}) async {
    await Future.wait([
      getProviderDetail(isRefresh: isRefresh),
      initDataOutStanding(isRefresh: isRefresh),
      initDataProducts(isRefresh: isRefresh),
    ]);

    refreshControllerProduct.refreshCompleted();
  }

  Future<void> getProviderDetail({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoading.value = true;
    }
    await _providerRepository.getProviderById(
      id: providerId,
      onSuccess: (data) {
        provider.value = data;
      },
      onError: (error) {
        IZIAlert().error(message: '$error');
        Get.back();
      },
    );
    _isLoading.value = false;
  }

  /// Out standing
  Future<void> initDataOutStanding({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingOutStanding.value = true;
      productOutStandingParam.page = 1;
    } else {
      productOutStandingParam.page = 1;
    }
    await getOutStanding();
    if (isRefresh) {
      refreshControllerOutStanding.refreshCompleted();
    } else {
      _isLoadingOutStanding.value = false;
    }
  }

  Future<void> getOutStanding({bool isLoadMore = false}) async {
    await _productRepository.getProductOutStandingOfProvider(
        idStore: providerId,
        productParam: productOutStandingParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listOutStanding.clear();
          }
          listOutStanding.addAll(data.result);
          _totalRecordOutStanding = data.totalResults;
          productOutStandingParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerOutStanding.loadComplete();
    }
  }

  /// Product suggest
  Future<void> initDataProducts({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingProduct.value = true;
      productParam.page = 1;
    } else {
      productParam.page = 1;
    }
    await getProducts();
    if (isRefresh) {
      refreshControllerProduct.refreshCompleted();
    } else {
      _isLoadingProduct.value = false;
    }
  }

  Future<void> getProducts({bool isLoadMore = false}) async {
    await _productRepository.getProducts(
        productParam: productParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listProduct.clear();
          }
          listProduct.addAll(data.result);
          _totalRecordProduct = data.totalResults;
          productParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerProduct.loadComplete();
    }
  }

  void onChangeIsLike() {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      Get.dialog(
        DialogLogin(onLogin: () {
          Get.toNamed(
            AuthRouters.LOGIN,
            arguments: {'route': AppRoute.DETAIL_PROVIDER},
          );
        }),
      );
      return;
    }
    if (!provider.value.isLike) {
      provider.value.likes.add(sl<SharedPreferenceHelper>().getIdUser);
      _providerRepository.setLike(
        idStore: provider.value.id!,
        idUser: sl<SharedPreferenceHelper>().getIdUser,
        onSuccess: (data) {},
        onError: (error) {
          provider.value.likes.remove(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    } else {
      provider.value.likes.remove(sl<SharedPreferenceHelper>().getIdUser);
      _providerRepository.setUnLike(
        idStore: provider.value.id!,
        idUser: sl<SharedPreferenceHelper>().getIdUser,
        onSuccess: (data) {},
        onError: (error) {
          provider.value.likes.add(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    }
    provider.refresh();
  }
}
