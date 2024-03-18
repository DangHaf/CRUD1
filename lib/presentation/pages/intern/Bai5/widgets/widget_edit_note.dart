import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetEditNote extends StatefulWidget {
  final Function(String, String) onSave;
  final String initialTitle;
  final String initialContent;

  const WidgetEditNote({
    Key? key,
    required this.onSave,
    required this.initialTitle,
    required this.initialContent,
  }) : super(key: key);

  @override
  _WidgetEditNoteState createState() => _WidgetEditNoteState();
}

class _WidgetEditNoteState extends State<WidgetEditNote> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
