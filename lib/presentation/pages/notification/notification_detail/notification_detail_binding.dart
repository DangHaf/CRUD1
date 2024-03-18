import 'package:get/get.dart';
import 'package:template/presentation/pages/notification/notification_detail/notification_detail_controller.dart';

class NotificationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationDetailController>(() => NotificationDetailController());
  }
}
