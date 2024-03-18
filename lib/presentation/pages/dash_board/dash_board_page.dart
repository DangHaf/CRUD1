import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_lazy_index_stack.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/account/account_page.dart';
import 'package:template/presentation/pages/cart/cart_page.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/dash_board/default_page.dart';
import 'package:template/presentation/pages/favorite/favorite_page.dart';
import 'package:template/presentation/pages/home/home_page.dart';
import 'package:template/presentation/pages/intern/Bai4/Bai4.dart';
import 'package:template/presentation/pages/intern/Bai5/bai5_page.dart';
import 'package:template/presentation/pages/intern/bai1/bai1_page.dart';
import 'package:template/presentation/pages/intern/bai2/bai2_page.dart';
import 'package:template/presentation/pages/intern/bai3/bai3_page.dart';
import 'package:template/presentation/pages/message/message_page.dart';
import 'package:template/presentation/pages/student_management/student_management_page.dart';

class DashBoardPage extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() {
        return LazyIndexedStack(
            index: controller.currentIndex.value,
            children:  [
              const DefaultPage(),
              StudentManagementPage(),
              const DefaultPage(),
              const DefaultPage(),

            ]);
      }),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          color: ColorResources.COLOR_002184,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            controller.onChangeDashboardPage(index: 0);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImagesPath.icHomeNavi,
                color: controller.currentIndex.value == 0
                    ? ColorResources.COLOR_EDAC02
                    : Colors.white,
                width: 28.r,
                height: 28.r,
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.onChangeDashboardPage(index: 1);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImagesPath.icStudentManagement,
                color: controller.currentIndex.value == 1
                    ? ColorResources.COLOR_EDAC02
                    : Colors.white,
                width: 28.r,
                height: 28.r,
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.onChangeDashboardPage(index: 2);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImagesPath.icSetting,
                color: controller.currentIndex.value == 2
                    ? ColorResources.COLOR_EDAC02
                    : Colors.white,
                width: 28.r,
                height: 28.r,
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            controller.onChangeDashboardPage(index: 3);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImagesPath.icAccount,
                color: controller.currentIndex.value == 3
                    ? ColorResources.COLOR_EDAC02
                    : Colors.white,
                width: 28.r,
                height: 28.r,
              ),
              const SizedBox(height: 6),

            ],
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     controller.onChangeDashboardPage(index: 4);
        //   },
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Image.asset(
        //         ImagesPath.icAccount,
        //         color: controller.currentIndex.value == 4
        //             ? ColorResources.COLOR_EDAC02
        //             : Colors.white,
        //         width: 28.r,
        //         height: 28.r,
        //       ),
        //       const SizedBox(height: 6),
        //     ],
        //   ),
        // ),

      ],
    );
  }
}
