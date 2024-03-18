import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/enums/enum_date_type.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/point_history_model.dart';
import 'package:template/data/repositories/point_repository.dart';

class PointController extends GetxController {
  final PointRepository _pointRepository = GetIt.I.get<PointRepository>();
  final RxBool _ignoring = false.obs;

  bool get ignoring => _ignoring.value;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  List<DateTime> rangeDate = [];

  RxString displayFilter = DateType.OTHER.stringValue.obs;
  DateType dateType = DateType.OTHER;

  final RefreshController refreshController = RefreshController();
  int pageNo = 1;
  int pageSize = 10;
  int _totalRecord = 0;

  bool get isLoadMore => _totalRecord > listPointHistory.length;

  RxList<PointHistoryModel> listPointHistory = <PointHistoryModel>[].obs;

  RxInt totalPoint = 0.obs;

  final RxBool _isLoadingPackage = false.obs;

  bool get isLoadingPackage => _isLoadingPackage.value;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void onChangeDate(DateType value) {
    dateType = value;
    displayFilter.value = dateType.stringValue;
    if (dateType.stringFilter != null && dateType != DateType.PERIOD) {
      initDataPoint();
    }
  }

  void onChangeRangeDate(List<DateTime?> data) {
    rangeDate.clear();
    for (final element in data) {
      if (element != null) {
        rangeDate.add(element);
      }
    }

    if (rangeDate.isNotEmpty) {
      if (rangeDate.length == 1) {
        displayFilter.value = DateFormat('MM/dd/yyyy').format(rangeDate.first);
      } else {
        displayFilter.value =
            '${DateFormat('MM/dd/yyyy').format(rangeDate.first)} - ${DateFormat('MM/dd/yyyy').format(rangeDate.last)}';
      }
    }
    initDataPoint();
  }

  Future<void> initData() async {
    getTotalPoints();
    initDataPoint();
  }

  Future<void> getTotalPoints() async {
    await _pointRepository.getTotalPoint(
      idUser: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (data) {
        totalPoint.value = data;
      },
      onError: (e) {},
    );
  }

  Future<void> initDataPoint({bool isRefresh = false}) async {
    if (!isRefresh) {
      pageNo = 1;
      _isLoading.value = true;
    } else {
      pageNo = 1;
    }
    await getListPointHistory();
    if (isRefresh) {
      refreshController.refreshCompleted();
    } else {
      _isLoading.value = false;
    }
  }

  Future<void> getListPointHistory({bool isLoadMore = false}) async {
    await _pointRepository.getPointHistory(
      filter: stringFilter,
      pageNo: pageNo,
      pageSize: pageSize,
      onSuccess: (data) async {
        if (!isLoadMore) {
          listPointHistory.clear();
        }
        listPointHistory.addAll(data.result);
        _totalRecord = data.totalResults;
        pageNo++;
      },
      onError: (e) {},
    );
    if (isLoadMore) {
      refreshController.loadComplete();
    }
  }

  String? get stringFilter {
    if (dateType.stringFilter != null) {
      return dateType.stringFilter!;
    } else if (dateType == DateType.OTHER) {
      final DateTime now = DateTime.now();
      final int _startTime = DateTime(
        now.year,
        now.month,
        now.day,
      ).millisecondsSinceEpoch;

      return 'historyDate>$_startTime';
    } else {
      if (rangeDate.isNotEmpty) {
        final int _startTime = DateTime(
          rangeDate.first.year,
          rangeDate.first.month,
          rangeDate.first.day,
        ).millisecondsSinceEpoch;
        final int _endTime = DateTime(
          rangeDate.last.year,
          rangeDate.last.month,
          rangeDate.last.day,
          23,
          59,
        ).millisecondsSinceEpoch;

        return 'historyDate>$_startTime&historyDate<$_endTime';
      }
    }

    return null;
  }
}
