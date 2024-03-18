class OrderRequest {
  String idAddress;
  String idTransaction;
  List<OrderPurchasesRequest> purchases;

  OrderRequest({
    required this.idAddress,
    required this.idTransaction,
    required this.purchases,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idAddress': idAddress,
      'idTransaction': idTransaction,
      'purchases': purchases.map((v) => v.toJson()).toList(),
    };
  }
}

class OrderPurchasesRequest {
  String idStore;
  String idUser;
  String? idVoucher;
  List<ProductOrderRequest> products;

  OrderPurchasesRequest({
    required this.idStore,
    required this.idUser,
    this.idVoucher,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idStore': idStore,
      'idUser': idUser,
      'products': products.map((v) => v.toJson()).toList(),
      if (idVoucher != null) 'idVoucher': idVoucher,
    };
  }
}

class ProductOrderRequest {
  String idProduct;
  String idOptionProduct;
  int quantity;

  ProductOrderRequest({
    required this.idProduct,
    required this.idOptionProduct,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idProduct': idProduct,
      'idOptionProduct': idOptionProduct,
      'quantity': quantity,
    };
  }
}

class OrderReturnRequest {
  String status;
  String cancelationReason;
  String? descriptionReason;
  String? video;
  List<String> images;

  OrderReturnRequest({
    this.status = 'RETURN',
    required this.cancelationReason,
    this.descriptionReason,
    this.video,
    this.images = const [],
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'cancelationReason': cancelationReason,
      if (descriptionReason != null && descriptionReason!.isNotEmpty)
        'descriptionReason': descriptionReason,
      if (video != null && video!.isNotEmpty) 'video': video,
      'images': images,
    };
  }
}
