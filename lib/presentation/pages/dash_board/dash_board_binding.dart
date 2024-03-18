import 'package:get/get.dart';
import 'package:template/presentation/pages/account/account_controller.dart';
import 'package:template/presentation/pages/cart/cart_controller.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/favorite/favorite_controller.dart';
import 'package:template/presentation/pages/home/home_controller.dart';
import 'package:template/presentation/pages/intern/Bai5/bai5_controller.dart';
import 'package:template/presentation/pages/intern/bai1/bai1_controller.dart';
import 'package:template/presentation/pages/intern/bai2/bai2_controller.dart';
import 'package:template/presentation/pages/intern/bai3/bai3_controller.dart';
import 'package:template/presentation/pages/message/message_controller.dart';
import 'package:template/presentation/pages/student_management/student_management_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashBoardController>(DashBoardController());
    Get.put<HomeController>(HomeController());
    Get.put<FavoriteController>(FavoriteController());
    Get.put<MessageController>(MessageController());
    Get.put<CartController>(CartController());
    Get.put<AccountController>(AccountController());
    Get.put<StudentManagementController>(StudentManagementController());
    Get.put<Bai5Controller>(Bai5Controller());
    Get.put<Bai3Controller>(Bai3Controller());
    Get.put<Bai1Controller>(Bai1Controller());
    Get.put<Bai2Controller>(Bai2Controller());


  }
}
