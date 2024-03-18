import 'package:get/get.dart';
import 'package:template/presentation/pages/address/edit_address/edit_address_controller.dart';

class EditAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAddressController>(() => EditAddressController());
  }
}