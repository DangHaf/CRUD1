import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetAddNote extends StatefulWidget {
  final Function(String, String) onSave;
  const WidgetAddNote({Key? key, required this.onSave}) : super(key: key);

  @override
  State<WidgetAddNote> createState() => _WidgetAddNoteState();
}

class _WidgetAddNoteState extends State<WidgetAddNote> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Tiêu đề',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: null, // Cho phép nhập nhiều dòng
              decoration: InputDecoration(
                hintText: 'Nội dung',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onSave(_titleController.text, _contentController.text);
                Get.back();
              },
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}
