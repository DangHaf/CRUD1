import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/student_management/add_student/add_student_controller.dart';
import 'package:template/presentation/pages/student_management/widgets/widget_add_subject.dart';
import 'package:template/presentation/pages/student_management/widgets/widget_header.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class AddStudentPage extends GetView<AddStudentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 135),
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorResources.COLOR_002184,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'add_student'.tr,
                        style: TextStyle(
                          color: ColorResources.COLOR_96C0FF,
                          fontSize: IZISizeUtil.LABEL_LARGE_FONT_SIZE,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          buildAllInputText(),
                          const SizedBox(height: 10),
                          buildListSubject(),
                          const SizedBox(height: 10),
                          buildButtonAddSubject(context),
                          const SizedBox(height: 30),
                          buildButton(),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40, left: 8, right: 22, bottom: 20),
              child: WidgetHeader(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAllInputText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextInput('full_name'.tr, null, controller.fullnameController),
        Row(
          children: [
            buildTextInput('class'.tr, 175, controller.classController),
            const Spacer(),
            buildTextInput(
                'student_id'.tr, 131, controller.studentIdController),
          ],
        ),
        Row(
          children: [
            buildTextInput('email'.tr, 199, controller.emailController),
            const Spacer(),
            buildTextInput('date_of_birth'.tr, 110, controller.dateController),
          ],
        ),
        Row(
          children: [
            buildTextInput('address'.tr, 191, controller.addressController),
            const Spacer(),
            buildTextInput('phone_number'.tr, 117, controller.phoneController),
          ],
        ),
        buildTextInput('avarage_mark'.tr, null, controller.averageController),
        const SizedBox(height: 10),
        Text(
          'list_subject'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: IZISizeUtil.LABEL_SMALL_FONT_SIZE,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => Visibility(
            visible: controller.listSelectedSubject.isEmpty,
            child: Text(
              'This student doesn’t have any classes yet. Click here to add new subject!',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: -0.5,
                fontSize: IZISizeUtil.BODY_SMALL_FONT_SIZE,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildTextInput(
      String? tittle, double? width, TextEditingController editController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tittle?.tr ?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: IZISizeUtil.LABEL_SMALL_FONT_SIZE,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: width ?? Get.width,
            height: 39,
            decoration: BoxDecoration(
              color: ColorResources.COLOR_F3F4F6,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: editController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 16,
                ),
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListSubject() {
    return Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.listSelectedSubject.map((course) {
            return buildItemSubject(course);
          }).toList(),
        ));
  }

  Widget buildItemSubject(String nameSubject) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Text(
          nameSubject.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildButtonAddSubject(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return FractionallySizedBox(
                heightFactor: 0.8,
                child: WidgetAddSubject(
                  saveListSubject: (saveSelectedSubjects) {
                    controller.saveSelectedSubjects(saveSelectedSubjects);
                  },
                ));
          },
        );
      },
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        child: Center(
          child: Image.asset(
            ImagesPath.icPlus,
            width: 15.r,
            height: 15.r,
            color: ColorResources.COLOR_002184,
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
          label: 'save'.tr,
          width: 76,
          backgroundColor: ColorResources.COLOR_EDAC02,
          style: TextStyle(
              color: ColorResources.COLOR_002184,
              fontWeight: FontWeight.w700,
              fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE),
          paddingHorizontal: 8,
          paddingVertical: 8,
          borderRadius: 20,
          callBack: () {
            controller.addStudent();
            Get.back();
          },
        ),
        const SizedBox(width: 20),
        CustomButton(
          label: 'cancel'.tr,
          width: 76,
          backgroundColor: ColorResources.COLOR_002184,
          colorBorder: Colors.white,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE),
          paddingHorizontal: 8,
          paddingVertical: 8,
          borderRadius: 20,
          callBack: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
