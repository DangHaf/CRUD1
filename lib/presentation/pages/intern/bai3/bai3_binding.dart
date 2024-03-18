import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/bai3/bai3_controller.dart';

class Bai3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Bai3Controller>(() => Bai3Controller());
  }
}
