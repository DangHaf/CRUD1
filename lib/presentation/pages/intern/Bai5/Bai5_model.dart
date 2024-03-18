class NoteModel {
  final String id;
  final String tittle;
  final String note;

  NoteModel({
    required this.id,
    this.tittle = '',
    this.note = '',
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      tittle: json['tittle'] as String,
      note: json['note'] as String,
    );
  }
}
