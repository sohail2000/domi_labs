import 'dart:convert';

import 'package:domi_labs/utilities/api_endpoint.dart';
import 'package:domi_labs/utilities/error_handler.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

class MapRepository {
  final ErrorHandler _errorHandler = ErrorHandler();

  Future<List<LatLng>> buildingOutline(LatLng latLng) async {
    return _errorHandler.handleErrorAsync<List<LatLng>>(function: () async {
      final url = ApiEndpoint.getBuildingOutlineUrl(latLng);
      // print(url.replaceAll('\n', ' ').trim());
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final elements = data['elements'];

        Map<int, LatLng> nodeIdToLatLng = {};
        List<LatLng> polygonPoints = [];

        for (var element in elements) {
          if (element['type'] == 'node') {
            int nodeId = element['id'];
            double lat = element['lat'];
            double lon = element['lon'];
            nodeIdToLatLng[nodeId] = LatLng(lat, lon);
          }
        }

        for (var element in elements) {
          if (element['type'] == 'way' &&
              element['tags']['building'] == 'yes') {
            for (var nodeId in element['nodes']) {
              if (nodeIdToLatLng.containsKey(nodeId)) {
                polygonPoints.add(nodeIdToLatLng[nodeId]!);
              }
            }
          }
        }

        return polygonPoints;
      } else {
        return [];
      }
    });
  }

  Future<String> addressFromLatlong(LatLng latLng) {
    return _errorHandler.handleErrorAsync<String>(function: () async {
      final url = ApiEndpoint.getAddressUrl(latLng);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['display_name'];
      } else {
        return 'No address found';
      }
    });
  }
}

//providers
final mapProvider = Provider<MapRepository>((_) => MapRepository());
