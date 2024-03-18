import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/notification/notification_model.dart';
import 'package:template/data/repositories/notification_repository.dart';

class NotificationDetailController extends GetxController {
  final NotificationRepository _notificationRepository =
      GetIt.I.get<NotificationRepository>();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  String idNotification = Get.arguments as String;
  final Rx<NotificationModel> _notification = NotificationModel().obs;

  NotificationModel get notification => _notification.value;

  @override
  void onInit() {
    getDetailNotification();
    super.onInit();
  }

  Future<void> getDetailNotification() async {
    _isLoading.value = true;
    await _notificationRepository.getDetailNotification(
        id: idNotification,
        onSuccess: (data) {
          _notification.value = data;
        },
        onError: (error) {
          IZIAlert().error(message: error.toString());
          Get.back();
        });
    _isLoading.value = false;
  }
}
