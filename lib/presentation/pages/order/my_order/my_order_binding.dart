import 'package:get/get.dart';
import 'package:template/presentation/pages/order/my_order/my_order_controller.dart';

class MyOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderController>(() => MyOrderController());
  }
}