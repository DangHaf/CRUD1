import 'package:get/get.dart';
import 'package:template/presentation/pages/voucher/voucher_detail/voucher_detail_controller.dart';

class VoucherDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherDetailController>(() => VoucherDetailController());
  }
}
