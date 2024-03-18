import 'package:get/get.dart';
import 'package:template/presentation/pages/order/detail_order/detail_order_controller.dart';

class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOrderController>(() => DetailOrderController());
  }
}