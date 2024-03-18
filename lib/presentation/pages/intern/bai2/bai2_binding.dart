import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/bai2/bai2_controller.dart';

class Bai2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Bai2Controller>(() => Bai2Controller());
  }
}