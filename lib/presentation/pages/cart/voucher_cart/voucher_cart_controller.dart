import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/voucher/voucher_model.dart';
import 'package:template/data/repositories/voucher_repository.dart';

class VoucherCartController extends GetxController {
  final VoucherRepository _voucherRepository = GetIt.I.get<VoucherRepository>();

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  RxList<VoucherModel> listVoucher = <VoucherModel>[].obs;
  Rx<VoucherModel> voucherSelected = VoucherModel().obs;

  late VoucherWithProductRequest cartVoucherRequest;

  String? idVoucher;

  num totalPrice = 0;

  @override
  void onInit() {
    if(Get.arguments != null && Get.arguments['cartVoucherRequest'] != null){
      cartVoucherRequest = Get.arguments['cartVoucherRequest'] as VoucherWithProductRequest;
    }
    if(Get.arguments != null && Get.arguments['idVoucher'] != null){
      idVoucher = Get.arguments['idVoucher'] as String;
    }
    if(Get.arguments != null && Get.arguments['totalPrice'] != null){
      totalPrice = Get.arguments['totalPrice'] as num;
    }
    getCartVoucher();
    super.onInit();
  }

  Future<void> getCartVoucher() async {
    _isLoading.value = true;
    await _voucherRepository.getVoucherWithProduct(
      voucherRequest: cartVoucherRequest,
      onSuccess: (data) {
        listVoucher.addAll(data);
        if(idVoucher != null){
          for(int i  = 0; i < listVoucher.length; i++){
            if(listVoucher[i].id == idVoucher){
              voucherSelected.value = listVoucher[i];
              break;
            }
          }
        }
      },
      onError: (_) {},
    );
    _isLoading.value = false;
  }

  void onChangeSelected(int index) {
    voucherSelected.value = listVoucher[index];
    voucherSelected.refresh();
  }

  void onApply() {
    if (voucherSelected.value.id.isEmpty) {
      IZIAlert().error(message: 'cart_021'.tr);
      return;
    }
    Get.back(result: voucherSelected.value);
  }
}
