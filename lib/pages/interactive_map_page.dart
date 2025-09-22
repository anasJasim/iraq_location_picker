import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iraq_location_picker/utils/location_constants.dart';

const double defaultMapZoom = 12;

/// Value notifier for handling polygon hit detection
final LayerHitNotifier _hitNotifier = ValueNotifier(null);

/// Type definitions for cleaner code
typedef HitResult = List<Object>?;
typedef OnPolygonHit = Function(HitResult);

/// Interactive map page that displays Iraq governorates as clickable polygons
class InteractiveMapPage extends StatefulWidget {
  final GeoLocation initialLocation;
  final String title;
  final List<Polygon> polygons;
  final double initialZoom;
  final OnPolygonHit? onPolygonHit;

  const InteractiveMapPage({
    super.key,
    required this.initialLocation,
    required this.polygons,
    this.title = 'Iraq Location Picker',
    this.initialZoom = defaultMapZoom,
    this.onPolygonHit,
  });

  @override
  State<InteractiveMapPage> createState() => _InteractiveMapPageState();
}

class _InteractiveMapPageState extends State<InteractiveMapPage> {
  final MapController mapController = MapController();
  late GeoLocation currentLocation;

  @override
  void initState() {
    super.initState();
    currentLocation = widget.initialLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentLocation,
          initialZoom: widget.initialZoom,
        ),
        children: [
          // OpenStreetMap tile layer
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.iraq_location_picker',
          ),

          // Location marker
          MarkerLayer(
            markers: [
              Marker(
                point: currentLocation,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 32,
                ),
              ),
            ],
          ),

          // Interactive polygon layer
          if (widget.onPolygonHit != null)
            MouseRegion(
              hitTestBehavior: HitTestBehavior.deferToChild,
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  widget.onPolygonHit!(_hitNotifier.value?.hitValues);
                },
                child: PolygonLayer(
                  polygons: widget.polygons,
                  hitNotifier: _hitNotifier,
                ),
              ),
            ),

          // Non-interactive polygon layer
          if (widget.onPolygonHit == null)
            PolygonLayer(polygons: widget.polygons, hitNotifier: _hitNotifier),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     mapController.move(currentLocation, widget.initialZoom);
      //   },
      //   tooltip: 'Reset to initial location',
      //   child: const Icon(Icons.my_location),
      // ),
    );
  }
}

/// Helper function to navigate to the interactive map page
Future<void> showInteractiveMap(
  BuildContext context, {
  required GeoLocation initialLocation,
  String? title,
  required List<Polygon> polygons,
  double? initialZoom,
  OnPolygonHit? onPolygonHit,
}) async {
  if (!context.mounted) return;

  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => InteractiveMapPage(
        initialLocation: initialLocation,
        title: title ?? 'Iraq Location Picker',
        polygons: polygons,
        initialZoom: initialZoom ?? defaultMapZoom,
        onPolygonHit: onPolygonHit,
      ),
    ),
  );
}
