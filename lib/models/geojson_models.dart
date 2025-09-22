import 'dart:convert';

/// GeoJSON geometry for polygon shapes
class GeoJsonGeometry {
  final String type;
  final List<List<List<double>>> coordinates;

  const GeoJsonGeometry({required this.type, required this.coordinates});

  factory GeoJsonGeometry.fromJson(Map<String, dynamic> json) =>
      GeoJsonGeometry(
        type: json['type'] as String,
        coordinates: (json['coordinates'] as List)
            .map(
              (ring) => (ring as List)
                  .map(
                    (coord) => (coord as List)
                        .map((point) => (point as num).toDouble())
                        .toList(),
                  )
                  .toList(),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {'type': type, 'coordinates': coordinates};
}

/// Properties for each Iraq governorate
class GeoJsonProperties {
  final String governorateName;
  final String governorateCode;

  const GeoJsonProperties({
    required this.governorateName,
    required this.governorateCode,
  });

  factory GeoJsonProperties.fromJson(Map<String, dynamic> json) =>
      GeoJsonProperties(
        governorateName: json['governorateName'] as String,
        governorateCode: json['governorateCode'] as String,
      );

  Map<String, dynamic> toJson() => {
    'governorateName': governorateName,
    'governorateCode': governorateCode,
  };
}

/// Individual GeoJSON feature representing a governorate
class GeoJsonFeature {
  final String type;
  final GeoJsonGeometry geometry;
  final GeoJsonProperties properties;

  const GeoJsonFeature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  factory GeoJsonFeature.fromJson(Map<String, dynamic> json) => GeoJsonFeature(
    type: json['type'] as String,
    geometry: GeoJsonGeometry.fromJson(
      json['geometry'] as Map<String, dynamic>,
    ),
    properties: GeoJsonProperties.fromJson(
      json['properties'] as Map<String, dynamic>,
    ),
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'geometry': geometry.toJson(),
    'properties': properties.toJson(),
  };
}

/// Complete GeoJSON response containing all Iraq governorates
class GeoJsonData {
  final List<GeoJsonFeature> features;

  const GeoJsonData({required this.features});

  factory GeoJsonData.fromJson(Map<String, dynamic> json) => GeoJsonData(
    features: (json['features'] as List)
        .map(
          (featureJson) =>
              GeoJsonFeature.fromJson(featureJson as Map<String, dynamic>),
        )
        .toList(),
  );

  factory GeoJsonData.fromJsonString(String jsonString) =>
      GeoJsonData.fromJson(json.decode(jsonString) as Map<String, dynamic>);

  Map<String, dynamic> toJson() => {
    'features': features.map((feature) => feature.toJson()).toList(),
  };

  String toJsonString() => json.encode(toJson());
}
