import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/repositories/address_repository.dart';

class AddressController extends GetxController {
  final AddressRepository _addressRepository = GetIt.I.get<AddressRepository>();
  final idUser = sl<SharedPreferenceHelper>().getIdUser;

  RxList<AddressModel> listAddress = <AddressModel>[].obs;
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  Rx<AddressModel> address = AddressModel().obs;

  @override
  void onInit() {
    address.value = Get.arguments as AddressModel;
    getAddress();
    super.onInit();
  }

  Future<void> getAddress({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoading.value = true;
    }
    await _addressRepository.paginateAddress(
      onSuccess: (data) {
        listAddress.clear();
        listAddress.addAll(data.result);
      },
      onError: (e) {},
    );
    _isLoading.value = false;
  }

  void onChangeAddress(int index) {
    address.value = listAddress[index];
    setAddressDefault(address.value.id);
    Get.back(result: address.value);
  }

  Future<void> setAddressDefault(String id) async {
    await _addressRepository.setDefaultAddress(
      id: id,
      onSuccess: () {},
      onError: (_) {},
    );
  }
}
