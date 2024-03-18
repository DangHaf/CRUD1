class AddressResponse {
  final List<AddressModel> result;
  final int totalResults;
  final int totalPages;

  AddressResponse({
    this.result = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      result: (json['results'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  AddressModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalResults: json['totalResults'] as int? ?? 0,
    );
  }
}

class AddressModel {
  final String id;
  final StateModel? idState;
  final CityModel? idCity;
  final String phone;
  final String fullName;
  final String idUser;
  final String addressDetail;
  final bool isDefault;

  AddressModel({
    this.id = '',
    this.addressDetail = '',
    this.phone = '',
    this.fullName = '',
    this.idUser = '',
    this.idState,
    this.idCity,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      idUser: json['idUser'] as String? ?? '',
      addressDetail: json['addressDetail'] as String? ?? '',
      isDefault: json['isDefault'] as bool? ?? false,
      idState: json['idState'] != null
          ? StateModel.fromJson(json['idState'] as Map<String, dynamic>)
          : null,
      idCity: json['idCity'] != null
          ? CityModel.fromJson(json['idCity'] as Map<String, dynamic>)
          : null,
    );
  }

  String get fullAddress {
    return '$addressDetail, ${idCity?.name}, ${idState?.name}';
  }
}

class CityModel {
  final String id;
  final String name;
  final String idState;

  CityModel({
    this.id = '',
    this.name = '',
    this.idState = '',
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['_id'] as String? ?? '',
      idState: json['idState'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}

class StateModel {
  final String id;
  final String name;

  StateModel({
    this.id = '',
    this.name = '',
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}
