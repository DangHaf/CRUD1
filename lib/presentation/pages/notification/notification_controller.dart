import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/notification/notification_model.dart';
import 'package:template/data/model/notification/notification_param.dart';
import 'package:template/data/repositories/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _notificationRepository =
      GetIt.I.get<NotificationRepository>();

  final RefreshController refreshController = RefreshController();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final NotificationParam notificationParam = NotificationParam(
    usersReceived: sl<SharedPreferenceHelper>().getIdUser,
    language: sl<SharedPreferenceHelper>().getLocale,
  );

  RxList<NotificationModel> listNotification = <NotificationModel>[].obs;

  int _totalRecord = 0;

  bool get isLoadMore => _totalRecord > listNotification.length;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData({bool isRefresh = false}) async {
    if (!isRefresh) {
      notificationParam.page = 1;
      _isLoading.value = true;
    } else {
      notificationParam.page = 1;
    }
    await getListNotification();
    if (isRefresh) {
      refreshController.refreshCompleted();
    } else {
      _isLoading.value = false;
    }
  }

  Future<void> getListNotification({bool isLoadMore = false}) async {
    await _notificationRepository.getListNotification(
      notificationParam: notificationParam,
      onSuccess: (data) async {
        if (!isLoadMore) {
          listNotification.clear();
        }
        listNotification.addAll(data.result);
        _totalRecord = data.totalResults;
        notificationParam.page++;
      },
      onError: (e) {},
    );
    if (isLoadMore) {
      refreshController.loadComplete();
    }
  }

  Future<void> readNotification(int index) async {
    listNotification[index].usersOpened.add(sl<SharedPreferenceHelper>().getIdUser);
    listNotification.refresh();
    await _notificationRepository.readNotification(
      idNotification: listNotification[index].id!,
      onSuccess: () {},
      onError: (error) {
        listNotification[index].usersOpened.remove(sl<SharedPreferenceHelper>().getIdUser);
        listNotification.refresh();
      },
    );
  }
}
