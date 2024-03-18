import 'package:get/get.dart';
import 'package:template/presentation/pages/provider/product_hot/product_hot_controller.dart';

class ProductHotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductHotController>(() => ProductHotController());
  }
}
