import 'package:forest_brewery_test/core/exceptions/location_exception.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentPosition() async {
    try {
      final permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        final result = await Geolocator.requestPermission();
        if (result == LocationPermission.denied) {
          throw LocationException('Location permission denied by user');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
        throw LocationException(
          'Location permission denied permanently. '
          'Please enable it in app settings.',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return position;
    } catch (e) {
      if (e is LocationException) {
        rethrow;
      }
      throw LocationException('GPS error: $e');
    }
  }
}
