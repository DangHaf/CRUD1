import 'package:get/get.dart';
import 'package:template/presentation/pages/auth/otp/otp_controller.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPController>(() => OTPController());
  }
}
