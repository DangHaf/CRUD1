import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/home/banner_model.dart';
import 'package:template/data/model/home/news_model.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/product/product_param.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/provider/provider_param.dart';
import 'package:template/data/repositories/account_repository.dart';
import 'package:template/data/repositories/home_repository.dart';
import 'package:template/data/repositories/notification_repository.dart';
import 'package:template/data/repositories/product_repository.dart';
import 'package:template/data/repositories/provider_repository.dart';

class HomeController extends GetxController {
  final NotificationRepository _notificationRepository =
  GetIt.I.get<NotificationRepository>();
  final AccountRepository _accountRepository = GetIt.I.get<AccountRepository>();
  final HomeRepository _homeRepository = GetIt.I.get<HomeRepository>();
  final ProductRepository _productRepository = GetIt.I.get<ProductRepository>();
  final ProviderRepository _providerRepository =
  GetIt.I.get<ProviderRepository>();

  /// Notification
  final RxInt _countNotification = 0.obs;

  int get countNotification => _countNotification.value;

  /// User
  final Rx<UserModel> _user = UserModel().obs;

  UserModel get user => _user.value;

  String currentUser = sl<SharedPreferenceHelper>().getIdUser;

  /// 0 -> product, 1 -> provider
  final RxInt _currentAction = 0.obs;

  int get currentAction => _currentAction.value;

  /// Load data
  RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxBool _isLoadingBanner = false.obs;

  bool get isLoadingBanner => _isLoadingBanner.value;

  /// Out standing
  final RefreshController refreshControllerOutStanding = RefreshController();
  final RxBool _isLoadingOutStanding = false.obs;

  bool get isLoadingOutStanding => _isLoadingOutStanding.value;
  int _totalRecordOutStanding = 0;

  bool get isLoadMoreOutStanding =>
      listOutStanding.length < _totalRecordOutStanding;

  RxList<ProductModel> listOutStanding = <ProductModel>[].obs;

  ProductParam productOutStandingParam = ProductParam(isHasVoucher: true);

  /// Saving focus
  final RefreshController refreshControllerSavingFocus = RefreshController();
  final RxBool _isLoadingSavingFocus = false.obs;

  bool get isLoadingSavingFocus => _isLoadingSavingFocus.value;
  int _totalRecordSavingFocus = 0;

  bool get isLoadMoreSavingFocus =>
      listSavingFocus.length < _totalRecordSavingFocus;

  RxList<ProductModel> listSavingFocus = <ProductModel>[].obs;
  ProductParam productSavingParam = ProductParam();

  /// New point
  final RefreshController refreshControllerNewPoint = RefreshController();
  final RxBool _isLoadingNewPoint = false.obs;

  bool get isLoadingNewPoint => _isLoadingNewPoint.value;
  int _totalRecordNewPoint = 0;

  bool get isLoadMoreNewPoint => listNewPoint.length < _totalRecordNewPoint;

  RxList<ProductModel> listNewPoint = <ProductModel>[].obs;
  ProductParam productNewPointParam = ProductParam();

  /// For you
  final RefreshController refreshControllerForYou = RefreshController();
  final RxBool _isLoadingForYou = false.obs;

  bool get isLoadingForYou => _isLoadingForYou.value;
  int _totalRecordForYou = 0;

  bool get isLoadMoreForYou => listForYou.length < _totalRecordForYou;

  RxList<ProductModel> listForYou = <ProductModel>[].obs;
  ProductParam productForYouParam = ProductParam();

  /// Product
  final RefreshController refreshControllerProduct = RefreshController();
  final RxBool _isLoadingProduct = false.obs;

  bool get isLoadingProduct => _isLoadingProduct.value;
  int _totalRecordProduct = 0;

  bool get isLoadMoreProduct => listProduct.length < _totalRecordProduct;

  RxList<ProductModel> listProduct = <ProductModel>[].obs;

  ProductParam productParam = ProductParam();

  /// Best seller
  final RefreshController refreshControllerBestSeller = RefreshController();
  final RxBool _isLoadingBestSeller = false.obs;

  bool get isLoadingBestSeller => _isLoadingBestSeller.value;
  int _totalRecordBestSeller = 0;

  bool get isLoadMoreBestSeller =>
      listBestSeller.length < _totalRecordBestSeller;

  RxList<ProductModel> listBestSeller = <ProductModel>[].obs;
  ProductParam productBestSellerParam = ProductParam(sort: '-totalSold');

  /// Leading provider
  final RefreshController refreshControllerLeadingProvider =
  RefreshController();
  final RxBool _isLoadingLeadingProvider = false.obs;

  bool get isLoadingLeadingProvider => _isLoadingLeadingProvider.value;
  int _totalRecordLeadingProvider = 0;

  bool get isLoadMoreLeadingProvider =>
      listLeadingProvider.length < _totalRecordLeadingProvider;

  RxList<ProviderModel> listLeadingProvider = <ProviderModel>[].obs;
  ProviderParam leadingParam = ProviderParam(
    populate: 'idOwner',
    fields:
    'name,businessPhone,idOwner.fullName,thumbnail,address,city,state,averagePointSupplier,totalRateSupplier',
  );

  /// Provider
  final RefreshController refreshControllerProvider = RefreshController();
  final RxBool _isLoadingProvider = false.obs;

  bool get isLoadingProvider => _isLoadingProvider.value;
  int _totalRecordProvider = 0;

  bool get isLoadMoreProvider => listProvider.length < _totalRecordProvider;

  RxList<ProviderModel> listProvider = <ProviderModel>[].obs;

  ProviderParam providerParam = ProviderParam(
    populate: 'idOwner',
    fields: 'name,businessPhone,idOwner.fullName,thumbnail,address,city,state',
  );

  /// NEWS
  final RefreshController refreshControllerNews = RefreshController();
  final RxBool _isLoadingNews = false.obs;

  bool get isLoadingNews => _isLoadingNews.value;
  int _totalRecordNews = 0;

  int pageNoNew = 0;
  int pageSizeNew = 10;

  bool get isLoadMoreNews => listNews.length < _totalRecordNews;

  RxList<NewsModel> listNews = <NewsModel>[].obs;

  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerProvider = ScrollController();
  RxBool isShowButtonScroll = false.obs;

  @override
  void onInit() {
    getCountNotification();
    getUser();
    getBanner();
    initProducts();
    initProvider();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= 100) {
        isShowButtonScroll.value = true;
      } else {
        isShowButtonScroll.value = false;
      }
    });
    scrollControllerProvider.addListener(() {
      if (scrollControllerProvider.position.pixels >= 100) {
        isShowButtonScroll.value = true;
      } else {
        isShowButtonScroll.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    if (currentUser != sl<SharedPreferenceHelper>().getIdUser) {
      getCountNotification();
      getUser();
      currentUser = sl<SharedPreferenceHelper>().getIdUser;
    }
    super.onReady();
  }

  Future<void> onRefreshData() async {
    getCountNotification();
    getUser();
    getBanner();
  }

  Future<void> getCountNotification() async {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      return;
    }
    await _notificationRepository.getCountNotification(
      onSuccess: (data) {
        _countNotification.value = data;
      },
      onError: (error) {},
    );
  }

  Future<void> getUser() async {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      return;
    }
    await _accountRepository.getUser(
      onSuccess: (data) {
        _user.value = data;
      },
      onError: (error) {},
    );
  }

  void updateCountNotification() {
    _countNotification.value = 0;
  }

  void onChangeCurrentAction(int index) {
    if (index == currentAction) {
      return;
    }
    _currentAction.value = index;
    if (index == 0) {
      initProducts();
    } else {
      initProvider();
    }
  }

  Future<void> initProducts() async {
    onRefreshData();
    await Future.wait([
      initDataOutStanding(),
      initDataSavingFocus(),
      initDataNewPoint(),
      if (sl<SharedPreferenceHelper>().getIdUser.isNotEmpty)
        initDataForYou(),
      initDataProducts(),
    ]);

    refreshControllerProduct.refreshCompleted();
  }

  Future<void> initProvider() async {
    onRefreshData();
    await Future.wait([
      initDataNews(),
      initDataBestSeller(),
      initDataLeadingProvider(),
      initDataProvider(),
    ]);

    refreshControllerProvider.refreshCompleted();
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
    await _productRepository.getProductOutStanding(
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

  /// Saving focus
  Future<void> initDataSavingFocus({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingSavingFocus.value = true;
      productSavingParam.page = 1;
    } else {
      productSavingParam.page = 1;
    }
    await getSavingFocus();
    if (isRefresh) {
      refreshControllerSavingFocus.refreshCompleted();
    } else {
      _isLoadingSavingFocus.value = false;
    }
  }

  Future<void> getSavingFocus({bool isLoadMore = false}) async {
    await _productRepository.getProductHighlightSaving(
        productParam: productSavingParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listSavingFocus.clear();
          }
          listSavingFocus.addAll(data.result);
          _totalRecordSavingFocus = data.totalResults;
          productSavingParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerSavingFocus.loadComplete();
    }
  }

  /// New point
  Future<void> initDataNewPoint({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingNewPoint.value = true;
      productNewPointParam.page = 1;
    } else {
      productNewPointParam.page = 1;
    }
    await getNewPoint();
    if (isRefresh) {
      refreshControllerNewPoint.refreshCompleted();
    } else {
      _isLoadingNewPoint.value = false;
    }
  }

  Future<void> getNewPoint({bool isLoadMore = false}) async {
    await _productRepository.getProductNewPoint(
        productParam: productNewPointParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listNewPoint.clear();
          }
          listNewPoint.addAll(data.result);
          _totalRecordNewPoint = data.totalResults;
          productNewPointParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerNewPoint.loadComplete();
    }
  }

  /// For you
  Future<void> initDataForYou({bool isRefresh = false}) async {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      listForYou.clear();
      return;
    }
    if (!isRefresh) {
      _isLoadingForYou.value = true;
      productForYouParam.page = 1;
    } else {
      productForYouParam.page = 1;
    }
    await getForYou();
    if (isRefresh) {
      refreshControllerForYou.refreshCompleted();
    } else {
      _isLoadingForYou.value = false;
    }
  }

  Future<void> getForYou({bool isLoadMore = false}) async {
    await _productRepository.getProductForYou(
        productParam: productForYouParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listForYou.clear();
          }
          listForYou.addAll(data.result);
          _totalRecordForYou = data.totalResults;
          productForYouParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerForYou.loadComplete();
    }
  }

  /// Products
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

  /// Best seller
  Future<void> initDataBestSeller({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingBestSeller.value = true;
      productBestSellerParam.page = 1;
    } else {
      productBestSellerParam.page = 1;
    }
    await getBestSeller();
    if (isRefresh) {
      refreshControllerBestSeller.refreshCompleted();
    } else {
      _isLoadingBestSeller.value = false;
    }
  }

  Future<void> getBestSeller({bool isLoadMore = false}) async {
    await _productRepository.getProducts(
        productParam: productBestSellerParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listBestSeller.clear();
          }
          listBestSeller.addAll(data.result);
          _totalRecordBestSeller = data.totalResults;
          productBestSellerParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerBestSeller.loadComplete();
    }
  }

  /// Leading provider
  Future<void> initDataLeadingProvider({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingLeadingProvider.value = true;
      leadingParam.page = 1;
    } else {
      leadingParam.page = 1;
    }
    await getLeadingProvider();
    if (isRefresh) {
      refreshControllerLeadingProvider.refreshCompleted();
    } else {
      _isLoadingLeadingProvider.value = false;
    }
  }

  Future<void> getLeadingProvider({bool isLoadMore = false}) async {
    await _providerRepository.getLeadingProvider(
        providerParam: leadingParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listLeadingProvider.clear();
          }
          listLeadingProvider.addAll(data.result);
          _totalRecordLeadingProvider = data.totalResults;
          leadingParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerLeadingProvider.loadComplete();
    }
  }

  /// Provider
  Future<void> initDataProvider({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingProvider.value = true;
      providerParam.page = 1;
    } else {
      providerParam.page = 1;
    }
    await getProvider();
    if (isRefresh) {
      refreshControllerProvider.refreshCompleted();
    } else {
      _isLoadingProvider.value = false;
    }
  }

  Future<void> getProvider({bool isLoadMore = false}) async {
    await _providerRepository.getProvider(
        providerParam: providerParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listProvider.clear();
          }
          listProvider.addAll(data.result);
          _totalRecordProvider = data.totalResults;
          providerParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerProvider.loadComplete();
    }
  }

  Future<void> getBanner() async {
    _isLoadingBanner.value = true;
    await _homeRepository.getBanners(
      onSuccess: (data) {
        banners.clear();
        banners.addAll(data);
      },
      onError: (error) {},
    );
    _isLoadingBanner.value = false;
  }

  /// News
  Future<void> initDataNews({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingNews.value = true;
      pageNoNew = 1;
    } else {
      pageNoNew = 1;
    }
    await getNews();
    if (isRefresh) {
      refreshControllerNews.refreshCompleted();
    } else {
      _isLoadingNews.value = false;
    }
  }

  Future<void> getNews({bool isLoadMore = false}) async {
    await _homeRepository.getNews(
        pageNo: pageNoNew,
        pageSize: pageSizeNew,
        onSuccess: (data) {
          if (!isLoadMore) {
            listNews.clear();
          }
          listNews.addAll(data.result);
          _totalRecordNews = data.totalResults;
          pageNoNew++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerNews.loadComplete();
    }
  }

  void onScrollTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    scrollControllerProvider.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
