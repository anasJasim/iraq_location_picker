import 'dart:convert';

class IraqGovernorate {
  final String governorateCode;
  final String countryCode;
  final String name;

  const IraqGovernorate({
    required this.governorateCode,
    required this.countryCode,
    required this.name,
  });

  factory IraqGovernorate.fromJson(Map<String, dynamic> json) =>
      IraqGovernorate(
        governorateCode: json['governorateCode'] as String,
        countryCode: json['countryCode'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
    'governorateCode': governorateCode,
    'countryCode': countryCode,
    'name': name,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IraqGovernorate &&
          runtimeType == other.runtimeType &&
          governorateCode == other.governorateCode &&
          countryCode == other.countryCode &&
          name == other.name;

  @override
  int get hashCode => Object.hash(governorateCode, countryCode, name);

  @override
  String toString() =>
      'IraqGovernorate(governorateCode: $governorateCode, countryCode: $countryCode, name: $name)';
}

class IraqCountry {
  final String countryCode;
  final String name;
  final List<IraqGovernorate> cities;

  const IraqCountry({
    required this.countryCode,
    required this.name,
    required this.cities,
  });

  factory IraqCountry.fromJson(Map<String, dynamic> json) => IraqCountry(
    countryCode: json['countryCode'] as String,
    name: json['name'] as String,
    cities: (json['governorates'] as List)
        .map(
          (governorateJson) =>
              IraqGovernorate.fromJson(governorateJson as Map<String, dynamic>),
        )
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'countryCode': countryCode,
    'name': name,
    'governorates': cities.map((governorate) => governorate.toJson()).toList(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IraqCountry &&
          runtimeType == other.runtimeType &&
          countryCode == other.countryCode &&
          name == other.name &&
          _listEquals(cities, other.cities);

  @override
  int get hashCode => Object.hash(countryCode, name, Object.hashAll(cities));

  @override
  String toString() =>
      'IraqCountry(countryCode: $countryCode, name: $name, cities: $cities)';

  // Helper method for list equality
  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}

class IraqLocationData {
  final List<IraqCountry> countries;

  const IraqLocationData({required this.countries});

  factory IraqLocationData.fromJson(Map<String, dynamic> json) =>
      IraqLocationData(
        countries: (json['countries'] as List)
            .map(
              (countryJson) =>
                  IraqCountry.fromJson(countryJson as Map<String, dynamic>),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'countries': countries.map((country) => country.toJson()).toList(),
  };

  factory IraqLocationData.fromJsonString(String jsonString) =>
      IraqLocationData.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );

  String toJsonString() => json.encode(toJson());

  // Convenience getter to get all Iraqi cities
  List<IraqGovernorate> get iraqGovernorates {
    final iraqCountry = countries.firstWhere(
      (country) => country.countryCode == 'IRQ',
      orElse: () => const IraqCountry(countryCode: '', name: '', cities: []),
    );
    return iraqCountry.cities;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IraqLocationData &&
          runtimeType == other.runtimeType &&
          IraqCountry._listEquals(countries, other.countries);

  @override
  int get hashCode => Object.hashAll(countries);

  @override
  String toString() => 'IraqLocationData(countries: $countries)';
}
