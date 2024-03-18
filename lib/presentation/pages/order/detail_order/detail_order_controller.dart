import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/data/repositories/cart_repository.dart';
import 'package:template/data/repositories/order_repository.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';

class DetailOrderController extends GetxController {
  final OrderRepository _orderRepository = GetIt.I.get<OrderRepository>();
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final idOrder = Get.arguments as String;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final Rx<OrderDetailModel> _order = OrderDetailModel().obs;

  OrderDetailModel get order => _order.value;

  RxBool ignoring = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    await getOrderDetail();
    await Future.delayed(const Duration(milliseconds: 100));
    if (order.status == DELIVERED ||
        order.status == RECEIVED ||
        order.isTimeLineReturn) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
    super.onInit();
  }

  Future<void> getOrderDetail({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoading.value = true;
    }
    await _orderRepository.getDetailOrder(
      idOrder: idOrder,
      onSuccess: (data) {
        _order.value = data;
      },
      onError: (e) {
        IZIAlert().error(message: e.toString());
        Get.back();
      },
    );
    _isLoading.value = false;
  }

  Future<void> onCancelOrder() async {
    ignoring.value = true;
    EasyLoading.show(status: 'order_035'.tr);
    await _orderRepository.cancelOrder(
      id: order.id,
      onSuccess: () {
        IZIAlert().success(message: 'order_036'.tr);
        getOrderDetail(isRefresh: true);
      },
      onError: (e) {
        IZIAlert().error(message: e.toString());
      },
    );
    EasyLoading.dismiss();
    ignoring.value = false;
  }

  Future<void> onChangeStatusReceived() async {
    ignoring.value = true;
    EasyLoading.show(status: 'order_037'.tr);
    await _orderRepository.receivedOrder(
      id: order.id,
      onSuccess: () {
        IZIAlert().success(message: 'order_038'.tr);
        getOrderDetail(isRefresh: true);
      },
      onError: (e) {
        IZIAlert().error(message: e.toString());
      },
    );
    EasyLoading.dismiss();
    ignoring.value = false;
  }

  Future<void> navigateReturnOrder() async {
    await Get.toNamed(
      AppRoute.RETURN_ORDER,
      arguments: order,
    );
    getOrderDetail(isRefresh: true);
  }

  Future<void> navigateReview() async {
    await Get.toNamed(
      AppRoute.REVIEW,
      arguments: {
        'purchase': order.purchaseDetails,
        'idStore': order.idStore?.id,
        'idOrder': idOrder,
      },
    );
    getOrderDetail(isRefresh: true);
  }

  /// Add cart
  Future<void> addCart() async {
    ignoring.value = true;
    EasyLoading.show(status: 'order_040'.tr);
    await _cartRepository.addCartWithMany(
      cartRequest: getCartRequest,
      onSuccess: (data) {
        Navigator.popUntil(
          Get.context!,
          (route) => route.settings.name == AuthRouters.DASH_BOARD,
        );
        final List<String> idBuyBack = [];
        for (int i = 0; i < order.purchaseDetails.length; i++) {
          idBuyBack.add(order.purchaseDetails[i].idOptionProduct?.id ?? '');
        }
        Get.find<DashBoardController>().onChangeDashboardPage(
          index: 1,
          idCart: data,
          idBuyBack: idBuyBack,
        );
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    EasyLoading.dismiss();
    ignoring.value = false;
  }

  List<CartRequest> get getCartRequest {
    final List<CartRequest> cartRequest = [];
    for (int i = 0; i < order.purchaseDetails.length; i++) {
      cartRequest.add(
        CartRequest(
          idStore: order.idStore!.id!,
          quantity: order.purchaseDetails[i].quantity,
          idProduct: order.purchaseDetails[i].idOptionProduct!.product!.id!,
          idOptionProduct: order.purchaseDetails[i].idOptionProduct!.id!,
        ),
      );
    }
    return cartRequest;
  }
}
