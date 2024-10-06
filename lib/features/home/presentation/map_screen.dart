import 'package:domi_labs/features/home/presentation/bottom_sheet.dart';
import 'package:domi_labs/features/home/presentation/map_topbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng _center =
      const LatLng(27.1751, 78.0421); // Initial camera position
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polygon> polygons = {}; // Set for polygons


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
              // _setMapStyle();
            },
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            padding: const EdgeInsets.only(left: 20, bottom: 30),
            markers: markers,
            polygons: polygons, // Display polygons on the map
            // onTap: _onMapTap,
          ),
          const Align(
            alignment: Alignment.topCenter,
            // child: MapTopBar(),
          ),

          const MapBottomSheet()


           
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        backgroundColor: Colors.white,
        // onPressed: _onFabClick,
        onPressed: null,
        child: Icon(
          Icons.my_location,
          size: 30,
        ),
      ),
    );
  }
}
