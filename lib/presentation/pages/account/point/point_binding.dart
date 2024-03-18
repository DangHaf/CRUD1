import 'package:get/get.dart';
import 'package:template/presentation/pages/account/point/point_controller.dart';

class PointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PointController>(() => PointController());
  }
}