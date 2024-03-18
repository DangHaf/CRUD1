import 'package:get/get.dart';
import 'package:template/presentation/pages/search/search_provider/search_provider_controller.dart';

class SearchProviderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchProviderController>(() => SearchProviderController());
  }
}