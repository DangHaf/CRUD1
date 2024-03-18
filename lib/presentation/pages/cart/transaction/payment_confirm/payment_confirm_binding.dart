import 'package:get/get.dart';
import 'package:template/presentation/pages/cart/transaction/payment_confirm/payment_confirm_controller.dart';

class PaymentConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentConfirmController>(() => PaymentConfirmController());
  }
}
