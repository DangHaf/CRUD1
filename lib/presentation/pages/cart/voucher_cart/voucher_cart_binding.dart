import 'package:get/get.dart';
import 'package:template/presentation/pages/cart/voucher_cart/voucher_cart_controller.dart';

class VoucherCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherCartController>(() => VoucherCartController());
  }
}