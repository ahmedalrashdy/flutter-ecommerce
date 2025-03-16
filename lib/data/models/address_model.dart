class AddressModel {
  final int? id;
  final String address;
  final String city;
  final double lang;
  final double lat;
  bool isDefault;

  AddressModel({
    this.id,
    required this.address,
    required this.city,
    required this.lang,
    required this.lat,
    this.isDefault = false,
  });

  AddressModel copyWith({
    int? id,
    String? address,
    String? city,
    double? lang,
    double? lat,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      address: address ?? this.address,
      city: city ?? this.city,
      lang: lang ?? this.lang,
      lat: lat ?? this.lat,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'lang': lang,
      'lat': lat,
      'is_default': isDefault,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
      address: map['address'],
      city: map['city'],
      lang: map['lang'],
      lat: map['lat'],
      isDefault: map['is_default'] ?? false,
    );
  }
  static List<AddressModel> fromListMap(List<dynamic> data) {
    return data.map((map) => AddressModel.fromMap(map)).toList();
  }

  @override
  String toString() {
    return 'Address(address: $address, city: $city, lang: $lang, lat: $lat, isDefault: $isDefault)';
  }
}
