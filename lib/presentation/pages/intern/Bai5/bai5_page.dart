import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/intern/Bai5/Bai5_model.dart';
import 'package:template/presentation/pages/intern/Bai5/bai5_controller.dart';
import 'package:template/presentation/pages/intern/Bai5/widgets/dialog_delete.dart';
import 'package:template/presentation/pages/intern/Bai5/widgets/widget_add_note.dart';
import 'package:template/presentation/pages/intern/Bai5/widgets/widget_edit_note.dart';

class Bai5Page extends GetView<Bai5Controller> {
  const Bai5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "GHI CHU",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: IZISizeUtil.LABEL_LARGE_FONT_SIZE,
              fontWeight: FontWeight.w700,
            ),
          ),
          buildButtonAdd(context),
          buildBody(),
        ],
      ),
    );
  }

  buildButtonAdd(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return FractionallySizedBox(
                heightFactor: 0.8,
                child: WidgetAddNote(
                  onSave: (txtTittle, txtNote) {
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    NoteModel noteModel =
                        NoteModel(tittle: txtTittle, note: txtNote, id: id);
                    controller.addNote(noteModel);
                  },
                ));
          },
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              "Them",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: IZISizeUtil.LABEL_LARGE_FONT_SIZE,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(ImagesPath.icEdit),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Obx(() => Expanded(
          child: ListView.builder(
            itemCount: controller.listNote.length,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return buildItemList(context, controller.listNote[index]);
            },
          ),
        ));
  }

  Widget buildItemList(BuildContext context, NoteModel noteModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 15),
          child: Container(
            width: Get.width,
            height: 100,
            decoration: BoxDecoration(
              color: ColorResources.COLOR_F3F4F6,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tieu de : ${noteModel.tittle}",
                      style: TextStyle(
                        color: ColorResources.COLOR_002184,
                        fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      noteModel.note,
                      style: TextStyle(
                        color: ColorResources.COLOR_002184,
                        fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.8,
                          child: WidgetEditNote(
                              onSave: (txtTittle, txtNote) {
                                print('2222');
                                // controller.updateNoteById(
                                //     noteModel.id, txtTittle, txtNote);
                              },
                              initialTitle: noteModel.tittle,
                              initialContent: noteModel.note),
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(ImagesPath.icEdit),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      print('111111');
                      Get.dialog(DialogDelete(
                        onConfirm: () {
                          controller.removeNoteById(noteModel.id);
                        },
                        tittle: 'Ban co muon xoa ghi chu nay ?',
                      ));
                    },
                    child: SvgPicture.asset(ImagesPath.icDelete)),
                const SizedBox(width: 15),
              ],
            ),
          ),
        )
      ],
    );
  }
}
