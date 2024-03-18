import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class WidgetAddSubject extends StatefulWidget {
  final void Function(List<String>) saveListSubject;

  const WidgetAddSubject({super.key, required this.saveListSubject});

  @override
  State<WidgetAddSubject> createState() => _WidgetAddSubjectState();
}

class _WidgetAddSubjectState extends State<WidgetAddSubject> {
  List<String> listSubjects = [
    'history',
    'programming_techniques',
    'calculus_2',
    'linear_algebra',
    'general_physics'
  ];
  List<String> listSelected = [];

  void onSelected(bool selected, String dataName) {
    setState(() {
      if (selected == true) {
        listSelected.add(dataName);
      } else {
        listSelected.remove(dataName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 400),
      child: Container(
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'choose_subject'.tr,
                style: TextStyle(
                  color: ColorResources.COLOR_002184,
                  fontSize: IZISizeUtil.LABEL_SMALL_FONT_SIZE,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              buildListItemSubject(),
              const SizedBox(height: 20),
              buildButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItemSubject() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            childAspectRatio: 5,
            crossAxisSpacing: 5),
        itemCount: listSubjects.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            title: Text(
              listSubjects[index].tr,
              style: TextStyle(
                color: ColorResources.COLOR_EDAC02,
                fontSize: IZISizeUtil.BODY_MEDIUM_FONT_SIZE,
                fontWeight: FontWeight.w600, // Độ đậm
              ),
            ),
            checkColor: ColorResources.COLOR_EDAC02,
            activeColor: ColorResources.COLOR_EDAC02,
            controlAffinity: ListTileControlAffinity.leading,
            tileColor: ColorResources.COLOR_EDAC02,
            value: listSelected.contains(listSubjects[index]),
            onChanged: (val) {
              onSelected(val!, listSubjects[index]);
            },
          );
        },
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(
            label: 'save'.tr,
            width: 63,
            backgroundColor: ColorResources.COLOR_FFD566,
            style: TextStyle(
                color: ColorResources.COLOR_002184,
                fontWeight: FontWeight.w700,
                fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE),
            paddingHorizontal: 4,
            paddingVertical: 4,
            borderRadius: 12,
            callBack: () {
              widget.saveListSubject(listSelected);
              Get.back();
            },
          ),
          const SizedBox(width: 20),
          CustomButton(
            label: 'cancel'.tr,
            width: 63,
            backgroundColor: Colors.white,
            colorBorder: Colors.white,
            style: TextStyle(
                color: ColorResources.COLOR_002184,
                fontWeight: FontWeight.w400,
                fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE),
            paddingHorizontal: 4,
            paddingVertical: 4,
            borderRadius: 12,
            callBack: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
