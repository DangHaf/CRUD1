import 'package:get/get.dart';
import 'package:template/presentation/pages/cart/transaction/payment_method/payment_method_controller.dart';

class PaymentMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodController>(() => PaymentMethodController());
  }
}
