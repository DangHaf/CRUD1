import 'package:get/get.dart';
import 'package:template/presentation/pages/voucher/voucher_controller.dart';

class VoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherController>(() => VoucherController());
  }
}
