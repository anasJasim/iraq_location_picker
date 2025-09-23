import 'package:latlong2/latlong.dart';

/// Type alias for geographical coordinates using LatLng from latlong2 package
typedef GeoLocation = LatLng;

/// Center coordinates of Iraq for map initialization
const GeoLocation centerOfIraq = GeoLocation(33.34058, 44.40088);

/// Asset paths for location data
class LocationAssets {
  static const String iraqGeoJson =
      'packages/iraq_location_picker/lib/data/iraq_geo_location_adm1.json';
  static const String iraqGovernoratesJson =
      'packages/iraq_location_picker/lib/data/iraq_governorates.json';
}
