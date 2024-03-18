import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/cart/cart_model.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/comment/comment_model.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/product/product_param.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/voucher/voucher_model.dart';
import 'package:template/data/repositories/cart_repository.dart';
import 'package:template/data/repositories/comment_repository.dart';
import 'package:template/data/repositories/product_repository.dart';
import 'package:template/data/repositories/voucher_repository.dart';
import 'package:template/data/repositories/address_repository.dart';
import 'package:template/presentation/pages/home/widgets/dialog_login.dart';

class ProductDetailController extends GetxController {
  /// Show maximun 2 vouchers on product detail page
  final int maximumVouchersShowed = 2;

  final ProductRepository _productRepository = GetIt.I.get<ProductRepository>();
  final VoucherRepository _voucherRepository = GetIt.I.get<VoucherRepository>();
  final CommentRepository _commentRepository = GetIt.I.get<CommentRepository>();
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final AddressRepository _addressRepository = GetIt.I.get<AddressRepository>();
  final ScrollController scrollController = ScrollController();
  CarouselController carouselController = CarouselController();

  late String productId;
  late String providerId;

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  int get currentIndexOption => currentIndex - product.images.length;

  OptionProductModel? get optionProduct => currentIndexOption >= 0
      ? product.idOptionProducts[currentIndexOption]
      : null;

  ///Declare variables
  int page = 1;
  int limit = 2;
  final RxBool _isLoading = true.obs;
  final RxBool _isLoadingRate = true.obs;
  final Rx<ProductModel> _product = ProductModel().obs;
  RxList<VoucherModel> vouchers = <VoucherModel>[].obs;
  RxList<CommentModel> comments = <CommentModel>[].obs;

  ///Getter

  bool get isLoading => _isLoading.value;

  bool get isLoadingRate => _isLoadingRate.value;

  ProviderModel get provider => _product.value.idStore!;

  ProductModel get product => _product.value;

  AddressModel addressModel = AddressModel();

  /// product
  final RxBool _isLoadingProduct = false.obs;

  bool get isLoadingProduct => _isLoadingProduct.value;

  RxList<ProductModel> listProduct = <ProductModel>[].obs;

  ProductParam productParam = ProductParam(limit: 100);

  RxInt countCart = 0.obs;

  int get itemReview =>
      isLoadingRate || comments.length > 2 ? 2 : comments.length;

  String get title {
    if (currentIndexOption < 0) {
      return '${product.idOptionProducts.length} ${'product_detail_001'.tr}';
    }
    return product.idOptionProducts[currentIndexOption].title;
  }
  RxBool ignoring = false.obs;

  @override
  void onInit() {
    productId = Get.arguments["productId"] as String;
    providerId = Get.arguments["providerId"] as String;
    initData();
    seenProduct();
    super.onInit();
  }

  @override
  void onClose() {
    _isLoading.close();
    super.onClose();
  }

  Future<void> seenProduct() async {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      return;
    }
    _productRepository.seenProduct(
      id: productId,
      onSuccess: () {},
      onError: (_) {},
    );
  }

  Future<void> initData({bool isRefresh = false}) async {
    await Future.wait([
      getProductDetail(isRefresh: isRefresh),
      getReview(isRefresh: isRefresh),
      initDataProducts(isRefresh: isRefresh),
      if (sl<SharedPreferenceHelper>().getIdUser.isNotEmpty)
        getAddressDefault(),
      if (sl<SharedPreferenceHelper>().getIdUser.isNotEmpty) _getCountCart(),
    ]);
  }

  /// Product detail
  Future<void> _getCountCart() async {
    await _cartRepository.getCountCart(
      onSuccess: (data) {
        countCart.value = data;
      },
      onError: (error) {},
    );
  }

  /// Product detail
  Future<void> getProductDetail({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoading.value = true;
    }
    await _productRepository.getProductById(
      id: productId,
      onSuccess: (ProductModel data) async {
        _product.value = data;
        await getVoucher();
        _isLoading.value = false;
      },
      onError: (error) {
        _isLoading.value = false;
        IZIAlert().error(message: '$error');
        Get.back();
      },
    );
  }

  /// Voucher
  Future<void> getVoucher() async {
    final voucherRequest = VoucherWithProductRequest(
      idStore: providerId,
      products: productPaymentRequest,
    );
    await _voucherRepository.getVoucherWithProduct(
      voucherRequest: voucherRequest,
      onSuccess: (List<VoucherModel> data) {
        vouchers.value = data;
      },
      onError: (error) {
        IZIAlert().error(message: '$error');
      },
    );
  }

  void navigateVoucher() {
    final voucherRequest = VoucherWithProductRequest(
      idStore: providerId,
      products: productPaymentRequest,
    );
    Get.toNamed(AppRoute.VOUCHER, arguments: voucherRequest);
  }

  List<ProductPaymentRequest> get productPaymentRequest {
    final List<ProductPaymentRequest> request = [];
    for (int i = 0; i < product.idOptionProducts.length; i++) {
      request.add(
        ProductPaymentRequest(
          idOptionProduct: product.idOptionProducts[i].id!,
          idProduct: product.id!,
          quantity: 0,
        ),
      );
    }
    return request;
  }

  /// Review
  Future<void> getReview({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoadingRate.value = true;
    }
    await _commentRepository.paginate(
      page,
      limit,
      filter: 'idProduct=$productId',
      onSuccess: (data) async {
        comments.clear();
        comments.addAll(data.result);
      },
      onError: (e) {},
    );
    _isLoadingRate.value = false;
  }

  /// Add cart
  Future<void> addCart(CartRequest cartRequest) async {
    await _cartRepository.addCart(
      cartRequest: cartRequest,
      onSuccess: () {
        IZIAlert().success(message: 'product_detail_025'.tr);
        _getCountCart();
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
  }

  Future<void> getAddressDefault() async {
    _addressRepository.getAddressDefault(
      onSuccess: (data) {
        if (data.result.isNotEmpty) {
          addressModel = data.result.first;
        } else {
          addressModel = AddressModel();
        }
      },
      onError: (e) {},
    );
  }

  void onChangeIndex(int index) {
    _currentIndex.value = index;
    carouselController.jumpToPage(index);
  }

  /// Product suggest
  Future<void> initDataProducts({bool isRefresh = false}) async {
    if (sl<SharedPreferenceHelper>().getIdUser.isNotEmpty) {
      productParam.idUser = sl<SharedPreferenceHelper>().getIdUser;
    }
    productParam.idProduct = productId;
    if (!isRefresh) {
      _isLoadingProduct.value = true;
      productParam.page = 1;
    } else {
      productParam.page = 1;
    }
    await getProducts();
    if (!isRefresh) {
      _isLoadingProduct.value = false;
    }
  }

  Future<void> getProducts({bool isLoadMore = false}) async {
    await _productRepository.getProductPropose(
        productParam: productParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listProduct.clear();
          }
          listProduct.addAll(data.result);
          productParam.page++;
        },
        onError: (error) {});
  }

  void onChangeIsLikedProduct() {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      Get.dialog(
        DialogLogin(onLogin: () {
          Get.toNamed(
            AuthRouters.LOGIN,
            arguments: {'route': AppRoute.DETAIL_PRODUCT},
          );
        }),
      );
      return;
    }
    if (!product.isLike) {
      product.likes.add(sl<SharedPreferenceHelper>().getIdUser);
      _productRepository.setLike(
        idProduct: productId,
        onSuccess: (data) {},
        onError: (error) {
          product.likes.remove(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    } else {
      product.likes.remove(sl<SharedPreferenceHelper>().getIdUser);
      _productRepository.setUnLike(
        idProduct: productId,
        onSuccess: (data) {},
        onError: (error) {
          product.likes.add(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    }
    _product.refresh();
  }

  void onTapLike({required CommentModel comment}) {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      Get.dialog(
        DialogLogin(onLogin: () {
          Get.toNamed(
            AuthRouters.LOGIN,
            arguments: {'route': AppRoute.DETAIL_PRODUCT},
          );
        }),
      );
      return;
    }
    if (!comment.isLike) {
      comment.userLikes.add(sl<SharedPreferenceHelper>().getIdUser);
      _commentRepository.setLike(
        idComment: comment.id!,
        onSuccess: () {},
        onError: (error) {
          comment.userLikes.remove(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    } else {
      comment.userLikes.remove(sl<SharedPreferenceHelper>().getIdUser);
      _commentRepository.setUnLike(
        idComment: comment.id!,
        onSuccess: () {},
        onError: (error) {
          comment.userLikes.add(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    }
    comments.refresh();
  }

  void onRefreshWithNewData(String productId, String providerId) {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    this.productId = productId;
    this.providerId = providerId;
    initData();
    seenProduct();
  }

  Future<void> checkPayment(List<CartModel> listCart) async {
    ignoring.value = true;
    EasyLoading.show(status: 'product_detail_026'.tr);
    await _cartRepository.getCartPayment(
      cartRequest: cartPaymentRequest(listCart),
      onSuccess: (data) {
        Get.toNamed(AppRoute.PAYMENT, arguments: {
          'listCart': listCart,
          'address': addressModel,
        });
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    ignoring.value = false;
    EasyLoading.dismiss();
  }

  List<CartPaymentRequest> cartPaymentRequest(List<CartModel> listCart) {
    final List<CartPaymentRequest> request = [];
    for (int i = 0; i < listCart.length; i++) {
      request.add(
        CartPaymentRequest(
          idUser: sl<SharedPreferenceHelper>().getIdUser,
          idStore: listCart[i].idStore!.id!,
          idVoucher: listCart[i].idVoucher,
          products: productPaymentRequestWithOption(listCart[i]),
        ),
      );
    }
    return request;
  }

  List<ProductPaymentRequest> productPaymentRequestWithOption(CartModel cart) {
    final List<ProductPaymentRequest> request = [];
    for (int i = 0; i < cart.products.length; i++) {
      if (cart.products[i].checked) {
        request.add(
          ProductPaymentRequest(
            idOptionProduct: cart.products[i].idOptionProduct!.id!,
            idProduct: cart.products[i].idProduct!.id!,
            quantity: cart.products[i].quantity,
          ),
        );
      }
    }
    return request;
  }
}
