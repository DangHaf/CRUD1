import 'package:get/get.dart';
import 'package:template/presentation/pages/address/add_address/add_address_controller.dart';

class AddAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAddressController>(() => AddAddressController());
  }
}