import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/cart/cart_model.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/model/voucher/voucher_model.dart';
import 'package:template/data/repositories/address_repository.dart';
import 'package:template/data/repositories/cart_repository.dart';
import 'package:template/presentation/pages/account/widgets/dialog_confirm.dart';
import 'package:template/presentation/pages/cart/cart_controller.dart';
import 'package:template/presentation/pages/product/product_detail_controller.dart';

class PaymentController extends GetxController {
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final AddressRepository _addressRepository = GetIt.I.get<AddressRepository>();
  RxList<CartModel> listCart = <CartModel>[].obs;
  RxList<CartPaymentResponse> listCartPayment = <CartPaymentResponse>[].obs;
  Rx<AddressModel> address = AddressModel().obs;

  @override
  void onInit() {
    listCart.addAll(Get.arguments['listCart'] as List<CartModel>);
    if (Get.arguments['address'] != null) {
      address.value = Get.arguments['address'] as AddressModel;
    }
    getCartPayment();
    super.onInit();
  }

  @override
  void onReady() {
    if (address.value.id.isNotEmpty) {
      return;
    }
    Get.dialog(
      barrierDismissible: false,
      DialogConfirm(
        icon: ImagesPath.icAddAddressDialog,
        isBackWithConfirm: false,
        title: 'cart_019'.tr,
        content: 'cart_020'.tr,
        onConfirm: () async {
          final res = await Get.toNamed(AppRoute.ADD_ADDRESS, arguments: true);
          if (res != null) {
            await _getAddressDefault(isBack: true);
            try {
              Get.find<CartController>().getAddressDefault();
              Get.find<ProductDetailController>().getAddressDefault();
            } catch (_) {}
          }
        },
        onBack: () {
          Get.back();
        },
      ),
    );
    super.onReady();
  }

  Future<void> getCartPayment() async {
    await _cartRepository.getCartPayment(
      cartRequest: cartPaymentRequest,
      onSuccess: (data) {
        listCartPayment.clear();
        listCartPayment.addAll(data);
        initTotalPrice();
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
        Get.back();
      },
    );
  }

  void initTotalPrice() {
    for (int i = 0; i < listCart.length; i++) {
      listCart[i].totalProductMoney = listCartPayment
          .firstWhere((_) => _.idStore == listCart[i].idStore?.id)
          .totalProductMoney;
      listCart[i].totalMoney = listCartPayment
          .firstWhere((_) => _.idStore == listCart[i].idStore?.id)
          .totalMoney;
      listCart.refresh();
    }
  }

  List<CartPaymentRequest> get cartPaymentRequest {
    final List<CartPaymentRequest> request = [];
    for (int i = 0; i < listCart.length; i++) {
      request.add(
        CartPaymentRequest(
          idUser: sl<SharedPreferenceHelper>().getIdUser,
          idStore: listCart[i].idStore!.id!,
          idVoucher: listCart[i].idVoucher,
          products: productPaymentRequest(listCart[i]),
        ),
      );
    }
    return request;
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

  Future<void> _getAddressDefault({bool isBack = false}) async {
    _addressRepository.getAddressDefault(
      onSuccess: (data) {
        if (data.result.isNotEmpty) {
          address.value = data.result.first;
        }
        if (isBack) {
          Get.back();
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
      getCartPayment();
      listCart.refresh();
      try {
        final cartController = Get.find<CartController>();
        cartController.listCart
            .firstWhere((_) => _.id == listCart[indexCart].id)
            .idVoucher = voucher.id;
        cartController.listCart
            .firstWhere((_) => _.id == listCart[indexCart].id)
            .voucher = voucher;
        cartController.listCart.refresh();
      } catch (_) {}
    }
  }

  Future<void> onChangeAddress() async {
    final res = await Get.toNamed(AppRoute.ADDRESS, arguments: address.value);
    if (res != null) {
      final data = res as AddressModel;
      address.value = data;
    }
  }

  List<ProductOrderRequest> productOrderRequest(CartModel cart) {
    final List<ProductOrderRequest> request = [];
    for (int i = 0; i < cart.products.length; i++) {
      if (cart.products[i].checked) {
        request.add(
          ProductOrderRequest(
            idOptionProduct: cart.products[i].idOptionProduct!.id!,
            idProduct: cart.products[i].idProduct!.id!,
            quantity: cart.products[i].quantity,
          ),
        );
      }
    }
    return request;
  }

  num get totalProductMoney {
    num totalProduct = 0;
    for (int i = 0; i < listCartPayment.length; i++) {
      totalProduct += listCartPayment[i].totalProductMoney;
    }
    return totalProduct;
  }

  num get totalTaxMoney {
    num totalTax = 0;
    for (int i = 0; i < listCartPayment.length; i++) {
      totalTax += listCartPayment[i].totalTaxMoney;
    }
    return totalTax;
  }

  num get totalShipMoney {
    num totalShip = 0;
    for (int i = 0; i < listCartPayment.length; i++) {
      totalShip += listCartPayment[i].totalShipMoney;
    }
    return totalShip;
  }

  num get totalReduceMoney {
    num totalReduce = 0;
    for (int i = 0; i < listCartPayment.length; i++) {
      totalReduce += listCartPayment[i].totalReduceMoney;
    }
    return totalReduce;
  }

  num get totalMoney {
    num total = 0;
    for (int i = 0; i < listCartPayment.length; i++) {
      total += listCartPayment[i].totalMoney;
    }
    return total;
  }

  List<CartModel> get listCartTransaction {
    final List<CartModel> listCartData = [];
    for (int i = 0; i < listCart.length; i++) {
      listCartData.add(listCart[i]);
    }
    return listCartData;
  }
}
