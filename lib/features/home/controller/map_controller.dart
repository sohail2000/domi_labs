import 'package:domi_labs/features/home/application/location_service.dart';
import 'package:domi_labs/features/home/data/map_repository.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_controller.g.dart';

@riverpod
class MapScreenController extends _$MapScreenController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<List<LatLng>> bulidingOutline(LatLng latLng) async {
    MapRepository mapRepository = ref.read(mapProvider);
    return await mapRepository.buildingOutline(latLng);
  }

  Future<String> addressFromLatlong(LatLng latLng) async {
    MapRepository mapRepository = ref.read(mapProvider);
    return await mapRepository.addressFromLatlong(latLng);
  }

  Future<LatLng?> userLocation() async {
    LatLng? location;
    await AsyncValue.guard(
      () async {
        LocationService locationService = ref.read(locationServiceProvider);
        location = await locationService.userLocation();
        
      },
    );
    return location;
  }
}
