import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iraq_location_picker/models/geojson_models.dart';
import 'package:iraq_location_picker/models/governorate_models.dart';
import 'package:iraq_location_picker/pages/interactive_map_page.dart';
import 'package:iraq_location_picker/utils/location_constants.dart';
import 'package:iraq_location_picker/utils/theme_utils.dart';
import 'package:iraq_location_picker/widgets/iraq_governorate_dropdown.dart';

/// A location picker widget with dropdown and interactive map functionality for Iraqi governorates
class IraqGovernoratePicker extends StatefulWidget {
  final Function(IraqGovernorate? governorate)? onGovernorateSelected;
  final IraqGovernorate? selectedGovernorate;
  final String hintText;
  final String labelText;
  final bool showMapButton;

  const IraqGovernoratePicker({
    super.key,
    this.onGovernorateSelected,
    this.selectedGovernorate,
    this.hintText = 'Select Iraqi Governorate',
    this.labelText = 'Iraqi Governorate',
    this.showMapButton = true,
  });

  @override
  State<IraqGovernoratePicker> createState() => _IraqGovernoratePickerState();
}

class _IraqGovernoratePickerState extends State<IraqGovernoratePicker> {
  IraqGovernorate? selectedGovernorate;
  List<IraqGovernorate> governorates = [];
  bool isLoadingGovernorates = true;

  @override
  void initState() {
    super.initState();
    selectedGovernorate = widget.selectedGovernorate;
    _loadGovernorates();
  }

  @override
  void didUpdateWidget(IraqGovernoratePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedGovernorate != widget.selectedGovernorate) {
      selectedGovernorate = widget.selectedGovernorate;
    }
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
    widget.onGovernorateSelected?.call(governorate);
  }

  @override
  Widget build(BuildContext context) {
    return IraqGovernorateDropdown(
      selectedGovernorate: selectedGovernorate,
      onGovernorateSelected: _onGovernorateSelected,
      governorates: governorates,
      isLoading: isLoadingGovernorates,
      hintText: widget.hintText,
      labelText: widget.labelText,
      trailingIcon: widget.showMapButton
          ? IconButton(
              icon: const Icon(Icons.map_outlined),
              onPressed: _openInteractiveMap,
              tooltip: 'Open interactive map',
            )
          : null,
    );
  }
}
