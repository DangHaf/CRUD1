import 'package:get/get.dart';
import 'package:template/presentation/pages/cart/transaction/other_payment/other_payment_controller.dart';

  class OtherPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherPaymentController>(() => OtherPaymentController());
  }
}
