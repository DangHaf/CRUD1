import 'package:get/get.dart';
import 'package:template/presentation/pages/address/address/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
  }
}