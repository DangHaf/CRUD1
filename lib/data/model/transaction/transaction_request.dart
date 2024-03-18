class TransactionRequest {
  String? idUser;
  String? type;
  String? method;
  String? status;
  String? entityType;
  String? title;
  String? bankName;
  String? bankBranch;
  String? accountName;
  String? accountNumber;
  String? image;
  String? content;
  num? totalMoney;
  String? unitMoney;
  String? ccv;
  String? expirationDate;

  TransactionRequest({
    this.idUser,
    this.type,
    this.method,
    this.status,
    this.entityType = 'PURCHASE',
    this.title,
    this.bankName,
    this.bankBranch,
    this.accountName,
    this.accountNumber,
    this.totalMoney,
    this.unitMoney,
    this.content,
    this.image,
    this.ccv,
    this.expirationDate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUser': idUser,
      'type': type,
      'method': method,
      'status': status,
      'entityType': entityType,
      'title': title,
      'bankName': bankName,
      'bankBranch': bankBranch,
      'accountName': accountName,
      'accountNumber': accountNumber,
      'totalMoney': totalMoney,
      'unitMoney': unitMoney,
      'content': content,
      'image': image,
      'ccv': ccv,
      'expirationDate': expirationDate,
    };
  }
}
