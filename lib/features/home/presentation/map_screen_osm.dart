import 'dart:async';
import 'package:domi_labs/features/home/controller/map_controller.dart';
import 'package:domi_labs/features/home/presentation/bottom_sheet.dart';
import 'package:domi_labs/features/home/presentation/custom_marker.dart';
import 'package:domi_labs/features/home/presentation/inivite_dialog_box.dart';
import 'package:domi_labs/features/home/presentation/map_topbar.dart';
import 'package:domi_labs/utilities/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapScreenOsm extends ConsumerStatefulWidget {
  const MapScreenOsm({super.key});

  @override
  ConsumerState<MapScreenOsm> createState() => _MapScreenOsmState();
}

class _MapScreenOsmState extends ConsumerState<MapScreenOsm> {
  final List<Polygon> _polygons = [];
  LatLng? _currentLocation;
  String _currentAddress = "";
  Marker? _selectedLocationMarker;
  bool _isInviteDialogOpen = false;

  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LatLng userLocation =
        await ref.read(mapScreenControllerProvider.notifier).userLocation();
    String address = await ref
        .read(mapScreenControllerProvider.notifier)
        .addressFromLatlong(userLocation);
    setState(() {
      _currentLocation = userLocation;
      _currentAddress = address;
    });
    _mapController.move(userLocation, 17);
  }

  Future<void> _handleTap(LatLng latLng) async {
    List<LatLng> buildingPolygon = await ref
        .read(mapScreenControllerProvider.notifier)
        .bulidingOutline(latLng);
    if (buildingPolygon.isNotEmpty) {
      _polygons.clear();
      _selectedLocationMarker = null;
      _polygons.add(
        Polygon(
          points: buildingPolygon,
          color: Colors.blue.withOpacity(0.3),
          borderColor: Colors.blue,
          borderStrokeWidth: 3,
        ),
      );
    } else {
      _polygons.clear();
      _selectedLocationMarker = selectedLocationMarker(latLng);
    }

    showDialog(
      context: context,
      builder: (context) {
        return const InviteDialogBox();
      },
    ).then((value) {
      _isInviteDialogOpen = false;
      _polygons.clear();
      _selectedLocationMarker = null;
      setState(() {});
    });

    _isInviteDialogOpen = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              onTap: (tapPosition, latLng) {
                _handleTap(latLng);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: ApiEndpoint.osmEndpoint,
                userAgentPackageName: 'com.example.domi_labs',
              ),
              PolygonLayer(polygons: _polygons),
              MarkerLayer(markers: [
                if (_currentLocation != null)
                  userLocationMarker(_currentLocation!),
                if (_selectedLocationMarker != null) _selectedLocationMarker!,
              ]),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: MapTopBar(
                address:
                    _currentAddress.isEmpty ? "Loading..." : _currentAddress),
          ),
          if (!_isInviteDialogOpen) const MapBottomSheet()
        ],
      ),
    );
  }
}
