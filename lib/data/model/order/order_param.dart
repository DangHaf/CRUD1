class OrderParam {
  int page;
  int limit;
  String populate;

  OrderParam({
    this.page = 1,
    this.limit = 10,
    this.populate = 'purchaseDetails.idOptionProduct,purchaseDetails.idOptionProduct.idProduct',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
      'populate': populate,
    };
  }
}
