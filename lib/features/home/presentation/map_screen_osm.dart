import 'dart:async';
import 'package:domi_labs/features/home/controller/map_controller.dart';
import 'package:domi_labs/features/home/presentation/map_bottom_sheet.dart';
import 'package:domi_labs/styling/app_colors.dart';
import 'package:domi_labs/utilities/custom_marker.dart';
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
  String _inviteAddress = "";
  Marker? _selectedLocationMarker;
  bool _showInviteDialog = false;

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
    if (_showInviteDialog) return;

    //get selected location addresss
    final _inviteAddress = await ref
        .read(mapScreenControllerProvider.notifier)
        .addressFromLatlong(latLng);

    List<LatLng> buildingPolygon = await ref
        .read(mapScreenControllerProvider.notifier)
        .bulidingOutline(latLng);
    _polygons.clear();
    if (buildingPolygon.isNotEmpty) {
      //clear previous markers, if any
      _selectedLocationMarker = null;

      _polygons.add(
        Polygon(
          points: buildingPolygon,
          color: Colors.yellow.withOpacity(0.3),
          borderColor: Colors.yellow,
          borderStrokeWidth: 3,
        ),
      );
    } else {
      // Show marker if building outline is not received from Overpass API
      _selectedLocationMarker = selectedLocationMarker(latLng);
    }

    _showInviteDialog = true;
    setState(() {});
  }

  removeInviteDialog() {
    _showInviteDialog = false;
    _polygons.clear();
    _selectedLocationMarker = null;
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
              initialZoom: 17,
              onTap: (tapPosition, latLng) {
                _handleTap(latLng);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: ApiEndpoint.osmEndpoint,
                tileBuilder: darkTileBuilder,
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
          _showInviteDialog
              ? Container(
                  color: AppColor.blue.withOpacity(0.2),
                  child: InviteDialogBox(
                    inviteAddress: _inviteAddress,
                    removeDialog: () => removeInviteDialog(),
                  ),
                )
              : const MapBottomSheet(),
        ],
      ),
    );
  }
}

Widget darkTileBuilder(
  BuildContext context,
  Widget tileWidget,
  TileImage tile,
) {
  return ColorFiltered(
    colorFilter: const ColorFilter.matrix([
      -0.7,
      0,
      0,
      0,
      255,
      0,
      -0.7,
      0,
      0,
      255,
      0,
      0,
      -0.7,
      0,
      255,
      0,
      0,
      0,
      1,
      0,
    ]),
    child: tileWidget,
  );
}
