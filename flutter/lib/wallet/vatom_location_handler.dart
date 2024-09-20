import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:location/location.dart';

class VatomLocationHandler {
  Location location = Location();
  bool serviceEnabled = false;

  Future<bool> handleLocationPermission() async {
    try {
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return false;
        }
      }

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }

      return true;
    } catch (e) {
      print("handleLocationPermission.Error: $e");
      return false;
    }
  }

  Future<Position?> getCurrentPosition() async {
    try {
      var permission = await handleLocationPermission();

      if (!permission) {
        return null;
      }

      serviceEnabled = await location.serviceEnabled();
      final position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      print("getCurrentPosition.Error: $e");
      return null;
    }
  }

  Future<GeolocationPermissionsResponse> handleAndroidPermission(
      request) async {
    try {
      var result = await handleLocationPermission();
      return GeolocationPermissionsResponse(allow: result, retain: false);
    } catch (e) {
      print("handleAndroidPermission.Error: $e");
      return GeolocationPermissionsResponse(allow: false, retain: false);
    }
  }

  Future<Object> responseMessage() async {
    try {
      return getCurrentPosition().then((value) {
        if (value != null) {
          return {
            "coords": {"latitude": value.latitude, "longitude": value.longitude}
          };
        }
        return {};
      });
    } catch (e) {
      print("responseMessage.Error: $e");
      return {};
    }
  }
}
