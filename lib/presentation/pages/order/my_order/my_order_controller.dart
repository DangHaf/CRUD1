import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/data/model/order/order_param.dart';
import 'package:template/data/repositories/cart_repository.dart';
import 'package:template/data/repositories/order_repository.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';

class MyOrderController extends GetxController {
  final OrderRepository _orderRepository = GetIt.I.get<OrderRepository>();
  final CartRepository _cartRepository = GetIt.I.get<CartRepository>();
  final Rx<OrderTap> _orderTap = OrderTap.WAIT_FOR_CONFIRMATION.obs;

  OrderTap get orderTap => _orderTap.value;

  final RefreshController refreshController = RefreshController();
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  int _totalRecord = 0;

  bool get isLoadMore => listOrder.length < _totalRecord;

  RxList<OrderModel> listOrder = <OrderModel>[].obs;

  OrderParam orderParam = OrderParam();

  RxBool ignoring = false.obs;

  final autoScrollController = AutoScrollController(
    viewportBoundaryGetter: () => const Rect.fromLTRB(0, 0, 0, 0),
    axis: Axis.horizontal,
  );

  @override
  void onInit() {
    if (Get.arguments != null) {
      final type = Get.arguments as OrderTap;
      _orderTap.value = type;
      if(orderTap == OrderTap.CONFIRMED){
        scrollToIndex(1);
      }
      if(orderTap == OrderTap.PACKING){
        scrollToIndex(2);
      }
      if(orderTap == OrderTap.DELIVERING){
        scrollToIndex(3);
      }
    }
    initData();
    super.onInit();
  }

  void onChangeTap(OrderTap tap, int index) {
    if (tap == orderTap) {
      return;
    }
    scrollToIndex(index);
    _orderTap.value = tap;
    initData();
  }

  Future<void> initData({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoading.value = true;
      orderParam.page = 1;
    } else {
      orderParam.page = 1;
    }
    await getListOrder();
    if (isRefresh) {
      refreshController.refreshCompleted();
    } else {
      _isLoading.value = false;
    }
  }

  Future<void> getListOrder({bool isLoadMore = false}) async {
    await _orderRepository.getListOrder(
        orderParam: orderParam,
        status: status,
        onSuccess: (data) {
          if (!isLoadMore) {
            listOrder.clear();
          }
          listOrder.addAll(data.result);
          _totalRecord = data.totalResults;
          orderParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshController.loadComplete();
    }
  }

  Future<void> onCancelOrder(int index) async {
    ignoring.value = true;
    EasyLoading.show(status: 'order_035'.tr);
    await _orderRepository.cancelOrder(
      id: listOrder[index].id,
      onSuccess: () {
        IZIAlert().success(message: 'order_036'.tr);
        initData(isRefresh: true);
      },
      onError: (e) {
        IZIAlert().error(message: e.toString());
      },
    );
    EasyLoading.dismiss();
    ignoring.value = false;
  }

  Future<void> onChangeStatusReceived(int index) async {
    ignoring.value = true;
    EasyLoading.show(status: 'order_037'.tr);
    await _orderRepository.receivedOrder(
      id: listOrder[index].id,
      onSuccess: () {
        IZIAlert().success(message: 'order_038'.tr);
        initData(isRefresh: true);
      },
      onError: (e) {
        IZIAlert().error(message: e.toString());
      },
    );
    EasyLoading.dismiss();
    ignoring.value = false;
  }

  Future<void> navigateReview(int index) async {
    await Get.toNamed(
      AppRoute.REVIEW,
      arguments: {
        'purchase': listOrder[index].purchaseDetails,
        'idStore': listOrder[index].idStore,
        'idOrder': listOrder[index].id,
      },
    );
    initData(isRefresh: true);
  }

  /// Add cart
  Future<void> addCart(int index) async {
    ignoring.value = true;
    EasyLoading.show(status: 'order_040'.tr);
    await _cartRepository.addCartWithMany(
      cartRequest: getCartRequest(listOrder[index]),
      onSuccess: (data) {
        Navigator.popUntil(
          Get.context!,
          (route) => route.settings.name == AuthRouters.DASH_BOARD,
        );
        final List<String> idBuyBack = [];
        for (int i = 0; i < listOrder[index].purchaseDetails.length; i++) {
          idBuyBack.add(
              listOrder[index].purchaseDetails[i].idOptionProduct?.id ?? '');
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

  List<CartRequest> getCartRequest(OrderModel order) {
    final List<CartRequest> cartRequest = [];
    for (int i = 0; i < order.purchaseDetails.length; i++) {
      cartRequest.add(
        CartRequest(
          idStore: order.idStore,
          quantity: order.purchaseDetails[i].quantity,
          idProduct: order.purchaseDetails[i].idOptionProduct!.product!.id!,
          idOptionProduct: order.purchaseDetails[i].idOptionProduct!.id!,
        ),
      );
    }
    return cartRequest;
  }

  String get status {
    if (orderTap == OrderTap.RETURN) {
      return '$RETURN&status=$ACCEPT_RETURN&status=$REFUSE_RETURN';
    }
    if (orderTap == OrderTap.CANCELED) {
      return '$CUSTOMER_CANCELED&status=$STORE_CANCELED';
    }
    return orderTap.name;
  }

  Future scrollToIndex(int index) async {
    await autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
  }
}
