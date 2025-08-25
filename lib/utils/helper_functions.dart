// import 'package:geolocator/geolocator.dart';
//
// int calculateAge(DateTime birthDate) {
//   final today = DateTime.now();
//   int age = today.year - birthDate.year;
//   if (today.month < birthDate.month ||
//       (today.month == birthDate.month && today.day < birthDate.day)) {
//     age--;
//   }
//   return age;
// }
//
// Future<String> calculateDistance(
//     double startLat, double startLng, double endLat, double endLng) async {
//   double distanceInMeters =
//       Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
//   double distanceInKm = distanceInMeters / 1000;
//   return "${distanceInKm.toStringAsFixed(1)} km away";
// }
