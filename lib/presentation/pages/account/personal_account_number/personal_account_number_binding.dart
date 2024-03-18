import 'package:get/get.dart';
import 'package:template/presentation/pages/account/personal_account_number/personal_account_number_controller.dart';

class PersonalAccountNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalAccountNumberController>(() => PersonalAccountNumberController());
  }
}
