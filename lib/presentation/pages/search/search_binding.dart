import 'package:get/get.dart';
import 'package:template/presentation/pages/search/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchAppController>(() => SearchAppController());
  }
}
