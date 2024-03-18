class CartParam {
  int page;
  int limit;
  String? populate;

  CartParam({
    this.page = 1,
    this.limit = 10,
    this.populate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
      if (populate != null) 'populate': populate,
    };
  }
}
