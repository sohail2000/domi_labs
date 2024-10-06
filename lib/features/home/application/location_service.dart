import 'package:domi_labs/utilities/app_exception.dart';
import 'package:domi_labs/utilities/error_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class LocationService {
  final ErrorHandler _errorHandler = ErrorHandler();

  Future<LatLng> userLocation() async {
    return await _errorHandler.handleErrorAsync(function: () async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw LocationServiceDisableException();

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationPermDeniedException();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationPermDeniedPermanentlyException();
      }

      final position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    });
  }
}

//providers
final locationServiceProvider =
    Provider<LocationService>((_) => LocationService());
