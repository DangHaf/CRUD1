import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/Bai5/bai5_controller.dart';

class Bai5Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Bai5Controller>(() => Bai5Controller());
  }
}
