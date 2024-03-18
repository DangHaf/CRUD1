import 'package:get/get.dart';
import 'package:template/presentation/pages/comment/comment_product/comment_product_controller.dart';

class CommentProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentProductController>(() => CommentProductController());
  }
}
