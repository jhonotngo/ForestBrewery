import 'dart:math';

class Haversine {
  static const double earthRadiusKm = 6371.0;

  static double calculateDistance({
    required double userLat,
    required double userLng,
    required double breweryLat,
    required double breweryLng,
  }) {
    final dLat = _toRadians(breweryLat - userLat);
    final dLng = _toRadians(breweryLng - userLng);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(userLat)) *
            cos(_toRadians(breweryLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = earthRadiusKm * c;

    return distance;
  }

  static double _toRadians(double degrees) {
    return degrees * pi / 180.0;
  }
}
