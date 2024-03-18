import 'package:get/get.dart';
import 'package:template/presentation/pages/provider/leading_provider/leading_provider_controller.dart';

class LeadingProviderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadingProviderController>(() => LeadingProviderController());
  }
}
