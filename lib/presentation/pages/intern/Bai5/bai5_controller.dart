import 'package:get/get.dart';
import 'package:template/presentation/pages/intern/Bai5/Bai5_model.dart';

class Bai5Controller extends GetxController {
  RxList<NoteModel> listNote = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void addNote(NoteModel note) {
    listNote.add(note);
  }

  void removeNoteById(String id) {
    listNote.removeWhere((note) => note.id == id);
  }

  // void updateNoteById(String id, String newTitle, String newNote) {
  //   print('2222_${id}');
  //   print('2222_${newTitle}');
  //   print('2222_${newNote}');
  //
  //   final noteIndex = listNote.indexWhere((note) => note.id == id);
  //   if (noteIndex != -1) {
  //     listNote[noteIndex].tittle = newTitle;
  //     listNote[noteIndex].note = newNote;
  //   }
  // }

}
