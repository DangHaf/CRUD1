import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/data/model/student/student_model.dart';
import 'package:template/presentation/pages/student_management/student_management_controller.dart';
import 'package:template/presentation/pages/student_management/dialog/dialog_delete_student.dart';
import 'package:template/presentation/pages/student_management/widgets/widget_header.dart';
import 'package:template/presentation/pages/student_management/widgets/widget_loading.dart';
import 'package:template/presentation/pages/student_management/widgets/widget_search.dart';

class StudentManagementPage extends GetView<StudentManagementController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 20),
          child: Column(
            children: [
              const Stack(
                children: [
                  WidgetSearch(),
                  WidgetHeader(),
                ],
              ),
              const SizedBox(height: 15),
              buildListTab(),
              const SizedBox(height: 10),
              buildTittleTab(context),
              const SizedBox(height: 20),
              buildBody(),
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoading,
            child: const WidgetLoading(),
          ),
        )
      ],
    );
  }

  Widget buildListTab() {
    return Obx(() => Row(
          children: List.generate(
            controller.tabList.length,
            (index) => GestureDetector(
              onTap: () {
                controller.selectTab(index);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: controller.selectedIndex.value == index
                        ? ColorResources.COLOR_002184
                        : ColorResources.COLOR_F3F4F6,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    controller.tabList[index],
                    style: TextStyle(
                      color: controller.selectedIndex.value == index
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildBody() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: controller.listStudents.length,
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return buildItemList(context, controller.listStudents[index]);
          },
        ),
      ),
    );
  }

  Widget buildItemList(BuildContext context, StudentModel student) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 15),
              child: Container(
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorResources.COLOR_F3F4F6,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 220,
                          child: Text(
                            student.fullName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorResources.COLOR_002184,
                              fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                student.classInfo,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ColorResources.COLOR_002184,
                                  fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 160,
                              child: Text(
                                "- ${student.contactInfo.email}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ColorResources.COLOR_002184,
                                  fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.EDIT_STUDENT, arguments: student);
                      },
                      child: Container(
                          width: 30,
                          height: 30,
                          color: Colors.transparent,
                          child: Center(
                              child: SvgPicture.asset(ImagesPath.icEdit))),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.dialog(
                            DialogDeleteStudent(
                              onConfirm: () {
                                controller.deleteStudent(student.id);
                              },
                            ),
                          );
                        },
                        child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.transparent,
                            child: Center(
                                child: SvgPicture.asset(ImagesPath.icDelete)))),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Container(
            width: 26,
            height: 23,
            decoration: BoxDecoration(
              color: ColorResources.COLOR_002184,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                student.averageScore.toString(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: IZISizeUtil.BODY_SMALL_FONT_SIZE,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTittleTab(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
          "list_student".tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: IZISizeUtil.LABEL_SMALL_FONT_SIZE,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.ADD_STUDENT);
          },
          child: Container(
            width: 30,
            color: Colors.transparent,
            child: SvgPicture.asset(ImagesPath.icAdd),
          ),
        ),
        const Spacer(),
        Text(
          'view_all'.tr,
          style: TextStyle(
            color: ColorResources.COLOR_EDAC02,
            fontSize: IZISizeUtil.BODY_SMALL_FONT_SIZE,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        SvgPicture.asset(ImagesPath.icArroundDown),
      ],
    );
  }
}
