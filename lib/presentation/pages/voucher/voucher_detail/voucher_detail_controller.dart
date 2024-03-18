import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/voucher/voucher_model.dart';
import 'package:template/data/repositories/voucher_repository.dart';

class VoucherDetailController extends GetxController {
  final VoucherRepository _repo = GetIt.I.get<VoucherRepository>();

  final RxBool _isLoadingVoucherDetail = false.obs;

  bool get isLoadingVoucherDetail => _isLoadingVoucherDetail.value;

  Rx<VoucherModel> voucher = VoucherModel().obs;

  String voucherId = '';

  @override
  void onInit() {
    super.onInit();
    voucherId = Get.arguments;
    getDetailVoucher();
  }

  Future<void> getDetailVoucher() async {
    _isLoadingVoucherDetail.value = true;
    await _repo.getDetailById(voucherId, onSuccess: (VoucherModel data) {
      voucher.value = data;
    }, onError: (error) {
      IZIAlert().error(message: error.toString());
      Get.back();
    });
    _isLoadingVoucherDetail.value = false;
  }

  @override
  void onClose() {
    _isLoadingVoucherDetail.close();
    voucher.close();
    super.onClose();
  }
}
