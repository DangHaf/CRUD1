class NewsResponse {
  final List<NewsModel> result;
  final int totalResults;
  final int totalPages;

  NewsResponse({
    this.result = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      result: (json['results'] as List<dynamic>?)
              ?.map((dynamic e) =>
          NewsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalResults: json['totalResults'] as int? ?? 0,
    );
  }
}

class NewsModel {
  final String? id;
  final String? thumbnail;

  NewsModel({
    this.id,
    this.thumbnail,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );
  }
}
