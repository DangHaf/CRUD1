class TypeProductModel {
  final String id;
  final int position;
  final String title;
  final String icon;

  TypeProductModel({
    this.id = '',
    this.position = 0,
    this.title = '',
    this.icon = '',
  });

  factory TypeProductModel.fromJson(Map<String, dynamic> json) {
    return TypeProductModel(
      id: json['_id'] as String? ?? '',
      position: json['position'] as int? ?? 0,
      icon: json['icon'] as String? ?? '',
      title: json['title'] as String? ?? '',
    );
  }
}