
class CommentQuantity {
  final CommentQuantityModel? totalRate;
  final CommentQuantityModel? content;
  final CommentQuantityModel? nearest;
  final CommentQuantityModel? tallest;
  final CommentQuantityModel? shortest;

  CommentQuantity({
    this.totalRate,
    this.content,
    this.nearest,
    this.tallest,
    this.shortest,
  });

  factory CommentQuantity.fromJson(Map<String, dynamic> json) {
    return CommentQuantity(
      totalRate: json['totalRate'] != null
          ? CommentQuantityModel.fromJson(
              json['totalRate'] as Map<String, dynamic>)
          : null,
      content: json['content'] != null
          ? CommentQuantityModel.fromJson(
              json['content'] as Map<String, dynamic>)
          : null,
      nearest: json['nearest'] != null
          ? CommentQuantityModel.fromJson(
              json['nearest'] as Map<String, dynamic>)
          : null,
      tallest: json['tallest'] != null
          ? CommentQuantityModel.fromJson(
              json['tallest'] as Map<String, dynamic>)
          : null,
      shortest: json['shortest'] != null
          ? CommentQuantityModel.fromJson(
              json['shortest'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CommentQuantityModel {
  final int? totalRate;
  final int? content;
  final int? nearest;
  final int? tallest;
  final int? shortest;
  final String? type;

  CommentQuantityModel({
    this.type,
    this.totalRate,
    this.content,
    this.nearest,
    this.tallest,
    this.shortest,
  });

  factory CommentQuantityModel.fromJson(Map<String, dynamic> json) {
    return CommentQuantityModel(
      totalRate: json['totalRate'] as int? ?? 0,
      content: json['content'] as int? ?? 0,
      nearest: json['nearest'] as int? ?? 0,
      tallest: json['tallest'] as int? ?? 0,
      shortest: json['shortest'] as int? ?? 0,
      type: json['type'] as String,
    );
  }
}