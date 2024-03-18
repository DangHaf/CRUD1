import 'package:get/get.dart';
import 'package:template/presentation/pages/order/review/review_controller.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController());
  }
}
