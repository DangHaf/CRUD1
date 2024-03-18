class VoucherParam {
  int page;
  int limit;
  String? sort;
  String? populate;
  String? fields;
  String? slug;

  VoucherParam({
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