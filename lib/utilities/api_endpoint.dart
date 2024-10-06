import 'package:latlong2/latlong.dart';

class ApiEndpoint {
  static const String osmEndpoint =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

      
  static String getBuildingOutlineUrl(LatLng latLng) {
    return '''https://overpass-api.de/api/interpreter?data=[out:json];
  (
    way["building"](around:20,${latLng.latitude},${latLng.longitude});
  );
  out body;
  node(w); // Fetch node details
  out skel qt;
''';
  }

  static String getAddressUrl(LatLng latLng) =>
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLng.latitude}&lon=${latLng.longitude}&addressdetails=1';
}
