import 'dart:async';
import 'package:domi_labs/features/home/presentation/map_topbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'; 
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

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

  LatLng? _selectedLocation;
  String? _locationImageUrl;

  final String _googleApiKey = 'AIzaSyC32uvja8hok5Yn4MqwMRkVQokOYLz8I2M';

  // Function to fetch the place photo using Google Places API
  Future<void> _fetchPlacePhoto(LatLng location) async {
    String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${location.latitude},${location.longitude}'
        '&radius=1500'
        '&key=$_googleApiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        final place = data['results'][0]; // Get the first nearby place
        if (place['photos'] != null && place['photos'].isNotEmpty) {
          final photoReference = place['photos'][0]['photo_reference'];
          setState(() {
            _locationImageUrl = _getPlacePhotoUrl(photoReference);
          });
        } else {
          setState(() {
            _locationImageUrl = null;
          });
        }
      }
    }
  }

  // Function to generate Google Places Photo URL
  String _getPlacePhotoUrl(String photoReference) {
    return 'https://maps.googleapis.com/maps/api/place/photo'
        '?maxwidth=400'
        '&photoreference=$photoReference'
        '&key=$_googleApiKey';
  }



Future<BitmapDescriptor> createCustomPinMarker(String assetPath) async {
  // Load the image from the asset
  // final ByteData imageData = await rootBundle.load(assetPath);
  final ByteData imageData = await rootBundle.load('assets/images/car01.png');
  final Uint8List imageBytes = imageData.buffer.asUint8List();

  // Decode the image to get its dimensions
  final ui.Codec codec = await ui.instantiateImageCodec(imageBytes, targetWidth: 120, targetHeight: 150); // Pin marker size
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  final ui.Image image = frameInfo.image;

  // Create a canvas to draw the custom marker
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  // Pin marker settings
  const double circleRadius = 50.0;
  const double pinHeight = 150.0;
  const double pinWidth = 120.0;
  final Paint borderPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8;

  // Draw the pin shape (optional background pin shape to resemble default marker)
  final Paint pinPaint = Paint()..color = Colors.red; // Color of the pin

  Path pinPath = Path();
  pinPath.moveTo(pinWidth / 2, pinHeight); // Bottom point of pin
  pinPath.lineTo(pinWidth / 2 - 40, circleRadius + 40); // Left curve
  pinPath.arcTo(
    Rect.fromCircle(center: Offset(pinWidth / 2, circleRadius + 40), radius: circleRadius),
    3.14, // Start angle
    -3.14, // Sweep angle
    false,
  ); // Top circular part of the pin
  pinPath.lineTo(pinWidth / 2 + 40, circleRadius + 40); // Right curve
  pinPath.close();

  // Draw the pin background
  canvas.drawPath(pinPath, pinPaint);

  // Draw a circular image (centered) and the black border
  final Rect circleRect = Rect.fromCircle(center: Offset(pinWidth / 2, circleRadius + 40), radius: circleRadius);
  canvas.clipPath(Path()..addOval(circleRect)); // Clip the image inside a circular area
  canvas.drawImageRect(image, Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), circleRect, Paint());
  canvas.drawCircle(Offset(pinWidth / 2, circleRadius + 40), circleRadius, borderPaint); // Draw the black border

  // Create the custom image for the marker
  final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(pinWidth.toInt(), pinHeight.toInt());
  final ByteData? byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);

  if (byteData != null) {
    return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
  }

  return BitmapDescriptor.defaultMarker;
}


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
              _setMapStyle();
            },
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            padding: const EdgeInsets.only(left: 20, bottom: 30),
            markers: markers,
            polygons: polygons, // Display polygons on the map
            onTap: _onMapTap,
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: MapTopBar(),
          ),
          // const MapBottomSheet()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.my_location,
          size: 30,
        ),
        onPressed: _onFabClick,
      ),
    );
  }

  void _onFabClick() async {
    // Getting the current position of the user
    Position position = await currentPosition();

    // Animating the camera to the user's current position
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 17,
        ),
      ),
    );

    // Clearing existing markers
    markers.clear();

    final BitmapDescriptor customIcon = await createCustomPinMarker("assests/images/car01.png");
    // Adding a new marker at the user's current position
    markers.add(
      Marker(
        icon: customIcon,
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
      ),
    );

    // Refreshing the state to update the UI with new markers
    setState(() {});
  }

  void _onMapTap(LatLng tappedLocation) async {
    // Get address details from the lat and long
    String address = await getAddressFromLatLng(tappedLocation);
    print(address);

    setState(() {
      _selectedLocation = tappedLocation;
      _locationImageUrl = null; // Clear previous image
    });
    _fetchPlacePhoto(tappedLocation);

    print(_locationImageUrl);

    // Clear existing markers and polygons
    markers.clear();
    polygons.clear();

    // Add marker at tapped location
    markers.add(
      Marker(
        markerId: MarkerId(tappedLocation.toString()),
        position: tappedLocation,
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet: address,
        ),
      ),
    );

    // Fetch the boundary coordinates of the building using OSM
    // List<LatLng> boundaryCoordinates =
    //     await getBuildingBoundary(tappedLocation);
    List<LatLng> boundaryCoordinates =
        await _createPolygonPoints(tappedLocation);

    // Highlight the area with a transparent polygon
    polygons.add(
      Polygon(
        polygonId: PolygonId('selectedArea'),
        points: boundaryCoordinates,
        strokeColor: Colors.yellow,
        strokeWidth: 2,
        fillColor:
            Colors.yellow.withOpacity(0.5), // Semi-transparent yellow fill
      ),
    );

    // Update the UI with new markers and polygons
    setState(() {});
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    googleMapController.setMapStyle(style);
  }

  // Reverse geocoding to get address details from lat and long
  Future<String> getAddressFromLatLng(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      final Placemark place = placemarks.first;
      return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    }
    return "Unknown location";
  }

  // Function to create polygon points around the tapped location
  List<LatLng> _createPolygonPoints(LatLng center) {
    double offset = 0.0001; // Small offset for a building-size area
    return [
      LatLng(center.latitude + offset, center.longitude + offset),
      LatLng(center.latitude + offset, center.longitude - offset),
      LatLng(center.latitude - offset, center.longitude - offset),
      LatLng(center.latitude - offset, center.longitude + offset),
    ];
  }

  // Function to determine the user's current position
  Future<Position> currentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Checking if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    // Checking the location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  // Fetch building boundary coordinates from OpenStreetMap (Overpass API)
  // Future<List<LatLng>> getBuildingBoundary(LatLng location) async {
  //   // Define Overpass API query to get building boundaries
  //   String overpassQuery = """
  //   [out:json];
  //   (
  //     way["building"](around:50,${location.latitude},${location.longitude});
  //   );
  //   out body;
  //   >;
  //   out skel qt;
  //   """;

  //   // Make a POST request to the Overpass API
  //   var response = await http.post(
  //     Uri.parse('https://overpass-api.de/api/interpreter'),
  //     headers: {"Content-Type": "application/x-www-form-urlencoded"},
  //     body: overpassQuery,
  //   );

  //   print("response");
  //   print(response);

  //   // Parse the response from Overpass API
  //   var data = json.decode(response.body);
  //   print("data");
  //   print(data);
  //   if (data['elements'] != null && data['elements'].isNotEmpty) {
  //     // Extract points from the response
  //     List<LatLng> boundaryCoordinates = [];
  //     for (var element in data['elements']) {
  //       if (element['type'] == 'way') {
  //         List<LatLng> points = [];
  //         for (var node in element['geometry']) {
  //           points.add(LatLng(node['lat'], node['lon']));
  //         }
  //         boundaryCoordinates.addAll(points);
  //       }
  //     }
  //     return boundaryCoordinates;
  //   }

  //   // If no result, return a simple default square polygon
  //   return _createPolygonPoints(location);
  // }
}
