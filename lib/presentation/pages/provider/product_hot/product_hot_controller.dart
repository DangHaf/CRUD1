import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/product/product_param.dart';
import 'package:template/data/repositories/product_repository.dart';

class ProductHotController extends GetxController {
  final ProductRepository _productRepository = GetIt.I.get<ProductRepository>();

  String providerId = Get.arguments as String;
  /// Out standing
  final RefreshController refreshControllerOutStanding = RefreshController();
  final RxBool _isLoadingOutStanding = false.obs;

  bool get isLoadingOutStanding => _isLoadingOutStanding.value;
  int _totalRecordOutStanding = 0;

  bool get isLoadMoreOutStanding =>
      listOutStanding.length < _totalRecordOutStanding;

  RxList<ProductModel> listOutStanding = <ProductModel>[].obs;

  ProductParam productOutStandingParam = ProductParam(isHasVoucher: true);

  @override
  void onInit() {
    initDataOutStanding();
    super.onInit();
  }

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
}
