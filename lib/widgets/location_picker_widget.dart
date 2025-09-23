import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iraq_location_picker/models/geojson_models.dart';
import 'package:iraq_location_picker/models/governorate_models.dart';
import 'package:iraq_location_picker/pages/interactive_map_page.dart';
import 'package:iraq_location_picker/utils/location_constants.dart';
import 'package:iraq_location_picker/utils/theme_utils.dart';
import 'package:iraq_location_picker/widgets/governorate_dropdown.dart';

/// Main location picker widget that combines dropdown and interactive map
class LocationPickerWidget extends StatefulWidget {
  final Function(String? governorateCode)? onLocationSelected;

  const LocationPickerWidget({super.key, this.onLocationSelected});

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  IraqGovernorate? selectedGovernorate;
  List<IraqGovernorate> governorates = [];
  bool isLoadingGovernorates = true;

  @override
  void initState() {
    super.initState();
    _loadGovernorates();
  }

  Future<void> _loadGovernorates() async {
    try {
      final String jsonString = await rootBundle.loadString(
        LocationAssets.iraqGovernoratesJson,
      );
      final IraqLocationData data = IraqLocationData.fromJsonString(jsonString);
      if (mounted) {
        setState(() {
          governorates = data.iraqGovernorates;
          isLoadingGovernorates = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingGovernorates = false;
        });
      }
      debugPrint('Error loading governorates: $e');
    }
  }

  /// Opens the interactive map for governorate selection
  Future<void> _openInteractiveMap() async {
    try {
      // Load GeoJSON data
      final String jsonString = await rootBundle.loadString(
        LocationAssets.iraqGeoJson,
      );
      final data = GeoJsonData.fromJsonString(jsonString);

      // Convert GeoJSON to map polygons
      final List<Polygon> polygons = data.features.map((feature) {
        final coordinates = feature.geometry.coordinates[0];

        final List<GeoLocation> points = coordinates.map((coord) {
          return GeoLocation(coord[0], coord[1]);
        }).toList();

        return Polygon(
          points: points,
          borderColor: primaryGreenColor,
          borderStrokeWidth: 3,
          color: primaryGreenColor.withAlpha((0.4 * 255).toInt()),
          label: feature.properties.governorateName,
          hitValue: feature.properties.governorateCode,
        );
      }).toList();

      // Show interactive map
      if (mounted) {
        await showInteractiveMap(
          context,
          initialLocation: centerOfIraq,
          initialZoom: 6.5,
          polygons: polygons,
          title: 'Select Iraqi Governorate',
          onPolygonHit: (hitValues) {
            if (hitValues != null && hitValues.isNotEmpty) {
              final governorateCode = hitValues[0] as String;
              final governorate = governorates
                  .where((g) => g.governorateCode == governorateCode)
                  .firstOrNull;
              if (governorate != null) {
                _onGovernorateSelected(governorate);
              }
              Navigator.of(context).pop();
            }
          },
        );
      }
    } catch (e) {
      debugPrint('Error loading map data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error loading map data'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onGovernorateSelected(IraqGovernorate? governorate) {
    setState(() {
      selectedGovernorate = governorate;
    });
    widget.onLocationSelected?.call(governorate?.governorateCode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.location_on, size: 64, color: Colors.green),
        const SizedBox(height: 20),
        const Text(
          'Iraq Location Picker',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Enhanced location picker with interactive map',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),

        // Governorate dropdown with map button
        SizedBox(
          width: 300,
          child: GovernorateDropdown(
            selectedGovernorate: selectedGovernorate,
            onGovernorateSelected: _onGovernorateSelected,
            governorates: governorates,
            isLoading: isLoadingGovernorates,
            trailingIcon: IconButton(
              icon: const Icon(Icons.map_outlined),
              onPressed: _openInteractiveMap,
              tooltip: 'Open interactive map',
            ),
          ),
        ),

        // Selected governorate display
        if (selectedGovernorate != null) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text(
                      'Selected Governorate:',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      selectedGovernorate!.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Code: ${selectedGovernorate!.governorateCode}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
