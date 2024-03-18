import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/cart/cart_model.dart';
import 'package:template/data/model/cart/cart_param.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/voucher/voucher_model.dart';
import 'package:template/data/repositories/address_repository.dart';
import 'package:template/data/repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final AddressRepository _addressRepository = GetIt.I.get<AddressRepository>();
  final RefreshController refreshController = RefreshController();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final CartParam cartParam = CartParam(populate: 'idStore');

  RxList<CartModel> listCart = <CartModel>[].obs;

  int _totalRecord = 0;

  bool get isLoadMore => _totalRecord > listCart.length;

  Rx<num> totalPrice = 0.obs;
  Rx<num> totalQuantity = 0.obs;

  AddressModel addressModel = AddressModel();
  String? idCart;
  List<String> idBuyBack = [];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData({
    bool isRefresh = false,
    String? idCart,
    List<String> idBuyBack = const [],
  }) async {
    this.idCart = idCart;
    this.idBuyBack = idBuyBack;
    getAddressDefault();
    if (!isRefresh) {
      cartParam.page = 1;
      _isLoading.value = true;
    } else {
      cartParam.page = 1;
    }
    await getListCart();
    if (isRefresh) {
      refreshController.refreshCompleted();
    } else {
      _isLoading.value = false;
    }
  }

  Future<void> getListCart({bool isLoadMore = false}) async {
    await _cartRepository.getCart(
      cartParam: cartParam,
      onSuccess: (data) async {
        if (!isLoadMore) {
          listCart.clear();
        }
        listCart.addAll(data.result);
        _totalRecord = data.totalResults;
        cartParam.page++;

        /// Auto check item with repurchase
        try {
          for (int i = 0; i < listCart.length; i++) {
            if (listCart[i].id == idCart) {
              for (int j = 0; j < idBuyBack.length; j++) {
                for (int k = 0; k < listCart[i].products.length; k++) {
                  if (idBuyBack[j] == listCart[i].products[k].idOptionProduct?.id) {
                    listCart[i].products[k].checked = true;
                    break;
                  }
                }
              }
              break;
            }
          }
        } catch (_) {}

        totalPrice.value = totalPriceCart;
        totalQuantity.value = totalQuantityBuy;
      },
      onError: (e) {},
    );
    if (isLoadMore) {
      refreshController.loadComplete();
    }
  }

  void onIncrease(int indexCart, int indexProduct) {
    listCart[indexCart].products[indexProduct].quantity++;
    listCart[indexCart].idVoucher = null;
    listCart[indexCart].voucher = null;
    listCart.refresh();
    listCart.refresh();
    totalPrice.value = totalPriceCart;
    totalQuantity.value = totalQuantityBuy;
  }

  void onReduce(int indexCart, int indexProduct) {
    listCart[indexCart].products[indexProduct].quantity--;
    listCart[indexCart].idVoucher = null;
    listCart[indexCart].voucher = null;
    listCart.refresh();
    listCart.refresh();
    totalPrice.value = totalPriceCart;
    totalQuantity.value = totalQuantityBuy;
  }

  void onRemove(int indexCart, int indexProduct) {
    listCart[indexCart].products.removeAt(indexProduct);
    listCart[indexCart].idVoucher = null;
    listCart[indexCart].voucher = null;
    listCart.refresh();
    listCart.refresh();
    totalPrice.value = totalPriceCart;
    totalQuantity.value = totalQuantityBuy;
    if (listCart[indexCart].products.isEmpty) {
      deleteCart(listCart[indexCart]);
    } else {
      updateCart(listCart[indexCart]);
    }
  }

  void onCheckProduct(int indexCart, int indexProduct) {
    listCart[indexCart].products[indexProduct].checked =
        !listCart[indexCart].products[indexProduct].checked;
    listCart.refresh();
    totalPrice.value = totalPriceCart;
    totalQuantity.value = totalQuantityBuy;
    listCart[indexCart].idVoucher = null;
    listCart[indexCart].voucher = null;
    listCart.refresh();
  }

  void onCheckAll(int indexCart, bool value) {
    for (int i = 0; i < listCart[indexCart].products.length; i++) {
      listCart[indexCart].products[i].checked = value;
    }
    listCart[indexCart].idVoucher = null;
    listCart[indexCart].voucher = null;
    listCart.refresh();
    listCart.refresh();
    totalPrice.value = totalPriceCart;
    totalQuantity.value = totalQuantityBuy;
  }

  void onChangeType(
      int indexCart, int indexProduct, OptionProductModel type, int quantity) {
    listCart[indexCart].products[indexProduct].idOptionProduct = type;
    listCart[indexCart].products[indexProduct].quantity = quantity;
    totalPrice.value = totalPriceCart;
    totalQuantity.value = totalQuantityBuy;
    listCart[indexCart].idVoucher = null;
    listCart[indexCart].voucher = null;
    listCart.refresh();
  }

  num get totalPriceCart {
    num total = 0;
    for (int i = 0; i < listCart.length; i++) {
      total += listCart[i].totalPriceUI;
    }
    return total;
  }

  int get totalQuantityBuy {
    int total = 0;
    for (int i = 0; i < listCart.length; i++) {
      total += listCart[i].totalQuantity;
    }
    return total;
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

  Future<void> getVoucherCart(int indexCart) async {
    final cartVoucherRequest = VoucherWithProductRequest(
      idUser: sl<SharedPreferenceHelper>().getIdUser,
      idStore: listCart[indexCart].idStore!.id!,
      products: productPaymentRequest(listCart[indexCart]),
    );
    final res = await Get.toNamed(AppRoute.VOUCHER_CART, arguments: {
      'cartVoucherRequest': cartVoucherRequest,
      'idVoucher': listCart[indexCart].idVoucher,
      'totalPrice': listCart[indexCart].totalPriceUI,
    });
    if (res != null) {
      final voucher = res as VoucherModel;
      listCart[indexCart].idVoucher = voucher.id;
      listCart[indexCart].voucher = voucher;
      listCart.refresh();
    }
  }

  List<ProductPaymentRequest> productPaymentRequest(CartModel cart) {
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

  List<CartModel> get listCartHasProduct {
    final List<CartModel> list = [];
    for (int i = 0; i < listCart.length; i++) {
      if (listCart[i].hasProduct) {
        list.add(listCart[i]);
      }
    }
    return list;
  }

  Future<void> updateCart(CartModel cart) async {
    _cartRepository.updateCart(
      products: productUpdateRequest(cart),
      idCart: cart.id,
      onSuccess: () {},
      onError: (_) {},
    );
  }

  Future<void> deleteCart(CartModel cart) async {
    _cartRepository.deleteCart(
      idCart: cart.id,
      onSuccess: () {},
      onError: (_) {},
    );
  }

  List<ProductPaymentRequest> productUpdateRequest(CartModel cart) {
    final List<ProductPaymentRequest> request = [];
    for (int i = 0; i < cart.products.length; i++) {
      request.add(
        ProductPaymentRequest(
          idOptionProduct: cart.products[i].idOptionProduct!.id!,
          idProduct: cart.products[i].idProduct!.id!,
          quantity: cart.products[i].quantity,
        ),
      );
    }
    return request;
  }
}
