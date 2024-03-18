import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/bank_account/bank_account_model.dart';
import 'package:template/data/repositories/bank_account_repository.dart';

class OtherPaymentController extends GetxController {
  final BankAccountRepository repository = GetIt.I.get<BankAccountRepository>();

  List<BankAccountModel> listBankAccount = [];

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  String idStore = Get.arguments as String;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    _isLoading.value = true;
    await repository.getAll(
      idStore: idStore,
      type: 'BANK',
      onSuccess: (data) {
        listBankAccount.addAll(data);
      },
      onError: (err) {},
    );
    _isLoading.value = false;
  }
}
