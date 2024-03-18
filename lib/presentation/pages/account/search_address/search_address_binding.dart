import 'package:get/get.dart';
import 'package:template/presentation/pages/account/search_address/search_address_controller.dart';


class SearchAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchAddressController());
  }
}
