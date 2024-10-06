import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Marker userLocationMarker(LatLng point) {
  return Marker(
    point: point,
    width: 60,
    height: 60,
    child: Stack(
      children: [
        const Icon(
          size: 60,
          Icons.location_history,
          color: Colors.black,
        ),
        Positioned(
          top: 8,
          left: 11,
          child: ClipOval(
            child: Image.asset(
              'assets/images/car03.png',
              width: 38,
              height: 38,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );
}


Marker selectedLocationMarker(LatLng point) {
  return Marker(
    point: point,
    width: 60,
    height: 60,
    child: Stack(
      children: [
        const Icon(
          size: 60,
          Icons.location_history,
          color: Colors.black,
        ),
        Positioned(
          top: 8,
          left: 11,
          child: ClipOval(
            child: Image.asset(
              'assets/images/car05.png',
              width: 38,
              height: 38,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );
}