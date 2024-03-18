import 'package:get/get.dart';
import 'package:template/presentation/pages/comment/comment_provider/comment_provider_controller.dart';

class CommentProviderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentProviderController>(() => CommentProviderController());
  }
}
