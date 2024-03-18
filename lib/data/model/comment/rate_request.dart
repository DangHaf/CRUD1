class RateRequest {
  String idProduct;
  String idUser;
  String idStore;
  List<String> idOptionProducts;
  String idPurchase;
  String? content;
  int point;

  RateRequest({
    required this.idProduct,
    required this.idPurchase,
    required this.idUser,
    required this.idStore,
    required this.idOptionProducts,
    required this.point,
    this.content,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idProduct': idProduct,
      'idUser': idUser,
      'idPurchase': idPurchase,
      'idStore': idStore,
      'idOptionProducts': idOptionProducts,
      'point': point,
      if (content != null && content!.isNotEmpty) 'content': content,
    };
  }
}
