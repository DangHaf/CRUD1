import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/core/utils/app_constants.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/bank_account/bank_account_model.dart';
import 'package:template/data/model/cart/cart_model.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/model/transaction/transaction_request.dart';
import 'package:template/data/repositories/bank_account_repository.dart';
import 'package:template/data/repositories/order_repository.dart';
import 'package:template/data/repositories/transaction_repository.dart';
import 'package:template/presentation/pages/cart/cart_controller.dart';
import 'package:template/presentation/pages/cart/transaction/widgets/dialog_confirm_transaction.dart';

class PaymentMethodController extends GetxController {
  final TransactionRepository _transactionRepository =
      GetIt.I.get<TransactionRepository>();
  final OrderRepository _orderRepository = GetIt.I.get<OrderRepository>();
  final BankAccountRepository _bankAccountRepository =
      GetIt.I.get<BankAccountRepository>();

  Rx<BankAccountModel> bankAccount = BankAccountModel(
    bankName: 'transaction_007'.tr,
  ).obs;
  RxBool isIgnore = false.obs;
  RxBool paymentWithVisa = false.obs;
  RxBool paymentWithPaypal = false.obs;
  late String idTransaction;

  BankAccountResponse? bankAccountResponse;
  BankAccountModel? bankAccountPaypal;

  List<CartModel> listCart = [];
  Rx<CartModel> cartModel = CartModel().obs;
  late AddressModel address;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    listCart = Get.arguments['listCart'] as List<CartModel>;
    address = Get.arguments['address'] as AddressModel;
    cartModel.value = listCart.first;
    super.onInit();
  }

  void onReset() {
    bankAccount.value = BankAccountModel(
      bankName: 'transaction_007'.tr,
    );
    paymentWithVisa.value = false;
    paymentWithPaypal.value = false;
    if (listCart.isNotEmpty) {
      listCart.removeAt(0);
    }
    if (donePayment) {
      Navigator.popUntil(
        Get.context!,
        (route) => route.settings.name == AuthRouters.DASH_BOARD,
      );
      Get.find<CartController>().initData(isRefresh: true);
      Get.toNamed(AppRoute.MY_ORDER);
      return;
    }
    cartModel.value = listCart.first;
  }

  Future<void> onConfirm() async {
    if (bankAccount.value.id.isEmpty &&
        !paymentWithVisa.value &&
        !paymentWithPaypal.value) {
      IZIAlert().error(message: 'transaction_033'.tr);
      return;
    }
    if (paymentWithVisa.value) {
      Get.dialog(
        DialogConfirmTransaction(
          content: 'transaction_032'.tr,
          onConfirm: () {
            createTransactionVISA();
          },
        ),
      );
      return;
    }

    if (paymentWithPaypal.value) {
      await getPaypalAccount();
      if (bankAccountPaypal == null) {
        IZIAlert().error(message: 'transaction_040'.tr);
        return;
      }
      Get.dialog(
        DialogConfirmTransaction(
          content: 'transaction_032'.tr,
          onConfirm: () {
            createTransactionWithPaypal();
          },
        ),
      );

      return;
    }

    final res = await Get.toNamed(
      AppRoute.PAYMENT_CONFIRM,
      arguments: {
        'totalMoney': cartModel.value.totalMoney,
        'bankAccount': bankAccount.value,
        'content': address.phone,
      },
    );
    if (res != null) {
      idTransaction = res as String;
      final data = await createOrder(
        idTransaction: idTransaction,
        cart: cartModel.value,
      );
      if (data) {
        onReset();
      }
    }
  }

  Future<void> chooseOtherPayment() async {
    final res = await Get.toNamed(AppRoute.OTHER_PAYMENT,
        arguments: cartModel.value.idStore?.id);
    if (res != null) {
      paymentWithVisa.value = false;
      paymentWithPaypal.value = false;
      bankAccount.value = res as BankAccountModel;
    }
  }

  Future<void> gotoVisa() async {
    Get.toNamed(AppRoute.VISA_PAYMENT)?.then((value) {
      if (value != null) {
        bankAccountResponse = value as BankAccountResponse;
        paymentWithVisa.value = true;
        paymentWithPaypal.value = false;
      }
    });
  }

  Future<void> onPaymentWithPaypal() async {
    paymentWithVisa.value = false;
    paymentWithPaypal.value = true;
  }

  Future<void> createTransactionVISA() async {
    if (!isIgnore.value) {
      final TransactionRequest transactionRequest = TransactionRequest();
      transactionRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
      transactionRequest.totalMoney = cartModel.value.totalMoney;
      transactionRequest.content = 'Payment via VISA/MC/JCB';
      transactionRequest.method = VISA;
      transactionRequest.unitMoney = '\$';
      transactionRequest.status = CHECKING;
      transactionRequest.type = PAYMENT;
      transactionRequest.ccv = bankAccountResponse?.ccv;
      transactionRequest.expirationDate = bankAccountResponse?.expirationDate;
      transactionRequest.accountNumber = bankAccountResponse?.accountNumber;
      transactionRequest.accountName = bankAccountResponse?.accountName;
      transactionRequest.bankName = bankAccountResponse?.bankName;
      try {
        isIgnore.value = true;
        EasyLoading.show(status: 'transaction_035'.tr);
        await _transactionRepository.create(
          transactionRequest: transactionRequest,
          onSuccess: (data) async {
            EasyLoading.dismiss();
            isIgnore.value = false;
            idTransaction = data;
            final res = await createOrder(
              idTransaction: idTransaction,
              cart: cartModel.value,
            );
            if (res) {
              onReset();
            }
          },
          onError: (err) {
            IZIAlert().error(message: err.toString());
            EasyLoading.dismiss();
            isIgnore.value = false;
          },
        );
      } catch (e) {
        EasyLoading.dismiss();
        isIgnore.value = false;
      }
    }
  }

  Future<void> createTransactionWithPaypal() async {
    if (!isIgnore.value) {
      final TransactionRequest transactionRequest = TransactionRequest();
      transactionRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
      transactionRequest.totalMoney = cartModel.value.totalMoney;
      transactionRequest.content = 'Payment via Paypal.';
      transactionRequest.method = PAYPAL;
      transactionRequest.unitMoney = '\$';
      transactionRequest.status = FAILURE;
      transactionRequest.type = PAYMENT;
      try {
        isIgnore.value = true;
        EasyLoading.show(status: 'transaction_035'.tr);
        await _transactionRepository.create(
          transactionRequest: transactionRequest,
          onSuccess: (data) async {
            idTransaction = data;
            EasyLoading.dismiss();
            isIgnore.value = false;
            _payPalPayment(data);
          },
          onError: (err) {
            IZIAlert().error(message: err.toString());
            EasyLoading.dismiss();
            isIgnore.value = false;
          },
        );
      } catch (e) {
        isIgnore.value = false;
      }
    }
  }

  void _payPalPayment(String idTransaction) {
    Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: bankAccountPaypal?.clientId,
          secretKey: bankAccountPaypal?.secretKey,
          transactions: [
            {
              "amount": {
                "total": cartModel.value.totalMoney,
                "currency": bankAccountPaypal?.currency,
              },
              "description": bankAccountPaypal?.description,
              "item_list": const {
                "items": [],
              }
            }
          ],
          note: bankAccountPaypal?.note,
          onSuccess: (Map params) async {
            Navigator.pop(context);
            _transactionRepository.success(
              id: idTransaction,
              onSuccess: () async {},
              onError: (e) {},
            );
            final res = await createOrder(
              idTransaction: idTransaction,
              cart: cartModel.value,
            );
            if (res) {
              onReset();
            }
          },
          onError: (error) {
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  bool get donePayment {
    return listCart.isEmpty;
  }

  Future<void> getPaypalAccount() async {
    isIgnore.value = true;
    EasyLoading.show(status: 'transaction_041'.tr);
    await _bankAccountRepository.getAll(
      idStore: cartModel.value.idStore?.id ?? '',
      type: 'PAYPAL',
      onSuccess: (data) {
        if (data.isNotEmpty) {
          bankAccountPaypal = data.first;
        }
      },
      onError: (err) {},
    );
    EasyLoading.dismiss();
    isIgnore.value = false;
  }

  Future<bool> createOrder(
      {required String idTransaction, required CartModel cart}) async {
    final OrderRequest orderRequest = OrderRequest(
      idAddress: address.id,
      idTransaction: idTransaction,
      purchases: orderPurchasesRequest(cart),
    );
    bool isSuccess = false;
    isIgnore.value = true;
    EasyLoading.show(status: 'transaction_036'.tr);
    await _orderRepository.createOrder(
      orderRequest: orderRequest,
      onSuccess: () {
        IZIAlert().success(
          message: 'transaction_037'.trParams(
            {'store': cartModel.value.idStore?.name ?? ''},
          ),
        );
        isSuccess = true;
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
        isSuccess = false;
      },
    );
    EasyLoading.dismiss();
    isIgnore.value = false;
    return isSuccess;
  }

  List<OrderPurchasesRequest> orderPurchasesRequest(CartModel cart) {
    final List<OrderPurchasesRequest> request = [];
    request.add(
      OrderPurchasesRequest(
        idUser: sl<SharedPreferenceHelper>().getIdUser,
        idStore: cart.idStore!.id!,
        idVoucher: cart.idVoucher,
        products: productOrderRequest(cart),
      ),
    );
    return request;
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
}
