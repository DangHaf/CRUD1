class ProductParam {
  int page;
  int limit;
  bool? isHasVoucher;
  String? sort;
  String? slug;
  String? type;
  String? sortType;
  String populate;
  String? idProduct;
  String? idUser;
  String? idStore;

  ProductParam({
    this.page = 1,
    this.limit = 10,
    this.isHasVoucher,
    this.sort,
    this.slug,
    this.type,
    this.sortType,
    this.populate = 'idVoucher',
    this.idProduct,
    this.idUser,
    this.idStore,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
      'populate': populate,
      if (isHasVoucher != null) 'isHasVoucher': isHasVoucher,
      if (sort != null) 'sort': sort,
      if (type != null && type!.isNotEmpty) 'type': type,
      if (sortType != null && sortType!.isNotEmpty) 'sortType': sortType,
      if (slug != null && slug!.isNotEmpty) 'slug': '/$slug/i',
      if (idProduct != null && idProduct!.isNotEmpty) 'idProduct': idProduct,
      if (idUser != null && idUser!.isNotEmpty) 'idUser': idUser,
      if (idStore != null && idStore!.isNotEmpty) 'idStore': idStore,
    };
  }
}
