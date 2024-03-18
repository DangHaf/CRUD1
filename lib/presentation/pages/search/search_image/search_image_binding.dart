import 'package:get/get.dart';
import 'package:template/presentation/pages/search/search_image/search_image_controller.dart';

class SearchImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchImageController>(() => SearchImageController());
  }
}