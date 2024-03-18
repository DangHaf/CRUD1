import 'package:get/get.dart';
import 'package:template/presentation/pages/provider/provider_detail_controller.dart';

class ProviderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderDetailController>(() => ProviderDetailController());
  }
}
