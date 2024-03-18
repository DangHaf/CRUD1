import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/provider/provider_param.dart';
import 'package:template/data/repositories/provider_repository.dart';
import 'package:template/presentation/pages/home/widgets/dialog_login.dart';

class LeadingProviderController extends GetxController {
  final ProviderRepository _providerRepository =
      GetIt.I.get<ProviderRepository>();

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  int _totalRecordLeadingProvider = 0;
  bool get isLoadMoreLeadingProvider =>
      listLeadingProvider.length < _totalRecordLeadingProvider;

  final RefreshController refreshControllerLeadingProvider =
      RefreshController();

  RxList<ProviderModel> listLeadingProvider = <ProviderModel>[].obs;
  ProviderParam leadingParam = ProviderParam();

  @override
  void onInit() {
    initDataLeadingProvider();
    super.onInit();
  }

  /// Leading provider
  Future<void> initDataLeadingProvider({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoading.value = true;
      leadingParam.page = 1;
    } else {
      leadingParam.page = 1;
    }
    await getLeadingProvider();
    if (isRefresh) {
      refreshControllerLeadingProvider.refreshCompleted();
    } else {
      _isLoading.value = false;
    }
  }

  Future<void> getLeadingProvider({bool isLoadMore = false}) async {
    await _providerRepository.getLeadingProvider(
        providerParam: leadingParam,
        onSuccess: (data) {
          if (!isLoadMore) {
            listLeadingProvider.clear();
          }
          listLeadingProvider.addAll(data.result);
          _totalRecordLeadingProvider = data.totalResults;
          leadingParam.page++;
        },
        onError: (error) {});
    if (isLoadMore) {
      refreshControllerLeadingProvider.loadComplete();
    }
  }

  void onChangeIsLike(ProviderModel provider) {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      Get.dialog(
        DialogLogin(onLogin: () {
          Get.toNamed(
            AuthRouters.LOGIN,
            arguments: {'route': AppRoute.DETAIL_PROVIDER},
          );
        }),
      );
      return;
    }
    if (!provider.isLike) {
      provider.likes.add(sl<SharedPreferenceHelper>().getIdUser);
      _providerRepository.setLike(
        idStore: provider.id!,
        idUser: sl<SharedPreferenceHelper>().getIdUser,
        onSuccess: (data) {},
        onError: (error) {
          provider.likes.remove(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    } else {
      provider.likes.remove(sl<SharedPreferenceHelper>().getIdUser);
      _providerRepository.setUnLike(
        idStore: provider.id!,
        idUser: sl<SharedPreferenceHelper>().getIdUser,
        onSuccess: (data) {},
        onError: (error) {
          provider.likes.add(sl<SharedPreferenceHelper>().getIdUser);
        },
      );
    }
  }
}
