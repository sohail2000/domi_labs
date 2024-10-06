import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latlong2/latlong.dart';

class ApiEndpoint {
  static final String osmEndpoint =
  "https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=${dotenv.env['OSM_API_KEY']}";

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
