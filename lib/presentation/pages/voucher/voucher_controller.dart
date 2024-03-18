import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/voucher/voucher_model.dart';
import 'package:template/data/repositories/voucher_repository.dart';

class VoucherController extends GetxController {
  final VoucherRepository _voucherRepository = GetIt.I.get<VoucherRepository>();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  RxList<VoucherModel> listVoucher = <VoucherModel>[].obs;
  Rx<VoucherModel> voucherSelected = VoucherModel().obs;

  late VoucherWithProductRequest cartVoucherRequest;

  @override
  void onInit() {
    cartVoucherRequest = Get.arguments as VoucherWithProductRequest;
    getVoucherProduct();
    super.onInit();
  }

  Future<void> getVoucherProduct() async {
    _isLoading.value = true;
    await _voucherRepository.getVoucherWithProduct(
      voucherRequest: cartVoucherRequest,
      onSuccess: (data) {
        listVoucher.addAll(data);
      },
      onError: (_) {},
    );
    _isLoading.value = false;
  }
}
