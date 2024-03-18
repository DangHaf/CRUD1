import 'package:get/get.dart';
import 'package:template/presentation/pages/order/return_order/return_order_controller.dart';

class ReturnOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnOrderController>(() => ReturnOrderController());
  }
}
