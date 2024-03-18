import 'package:get/get.dart';
import 'package:template/presentation/pages/search/search_product_provider/search_product_provider_controller.dart';

class SearchProductProviderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchProductProviderController>(() => SearchProductProviderController());
  }
}