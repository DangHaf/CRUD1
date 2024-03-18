class ProviderParam {
  int page;
  int limit;
  String? sort;
  String? populate;
  String? fields;
  String? slug;

  ProviderParam({
    this.page = 1,
    this.limit = 10,
    this.sort,
    this.populate,
    this.fields,
    this.slug,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
      if (sort != null) 'sort': sort,
      if (populate != null) 'populate': populate,
      if (fields != null) 'fields': fields,
      if (slug != null && slug!.isNotEmpty) 'slug': '/$slug/i',
    };
  }
}

class StoreParam {
  int page;
  int limit;
  bool isHasProduct;
  String? slug;

  StoreParam({
    this.page = 1,
    this.limit = 10,
    this.isHasProduct = true,
    this.slug,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
      'isHasProduct': isHasProduct,
      if (slug != null && slug!.isNotEmpty) 'slug': '/$slug/i',
    };
  }
}
