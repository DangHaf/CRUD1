import 'package:get/get.dart';
import 'package:template/presentation/pages/connectivity/connectivity_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectivityController>(ConnectivityController());
  }
}
