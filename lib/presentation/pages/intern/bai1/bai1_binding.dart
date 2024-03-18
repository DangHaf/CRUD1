import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/bai1/bai1_controller.dart';

class Bai1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Bai1Controller>(() => Bai1Controller());
  }
}
