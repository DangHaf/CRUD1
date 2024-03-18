class CartPaymentRequest {
  String idStore;
  String idUser;
  String? idVoucher;
  List<ProductPaymentRequest> products;

  CartPaymentRequest({
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

class VoucherWithProductRequest {
  String idStore;
  String? idUser;
  List<ProductPaymentRequest> products;

  VoucherWithProductRequest({
    required this.idStore,
    this.idUser,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idStore': idStore,
      if (idUser != null && idUser!.isNotEmpty) 'idUser': idUser,
      'products': products.map((v) => v.toJson()).toList(),
    };
  }
}

class ProductPaymentRequest {
  String idProduct;
  String idOptionProduct;
  int quantity;

  ProductPaymentRequest({
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

class CartRequest {
  String idStore;
  String idProduct;
  String idOptionProduct;
  int quantity;

  CartRequest({
    required this.idStore,
    required this.idProduct,
    required this.idOptionProduct,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idStore': idStore,
      'idProduct': idProduct,
      'idOptionProduct': idOptionProduct,
      'quantity': quantity,
    };
  }
}
