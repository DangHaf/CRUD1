import 'package:get/get.dart';
import 'package:template/presentation/pages/cart/transaction/visa/visa_controller.dart';

class VisaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisaController>(() => VisaController());
  }
}
