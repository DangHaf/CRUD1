import 'package:get/get.dart';
import 'package:template/presentation/pages/account/personal_information/personal_information_controller.dart';

class PersonalInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInformationController>(() => PersonalInformationController());
  }
}
