import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:location/location.dart';

class VatomLocationHandler {
  Location location = Location();
  bool serviceEnabled = false;

  Future<bool> handleLocationPermission() async {
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
  }

  Future<Position?> getCurrentPosition() async {
    var permission = await handleLocationPermission();

    if (!permission) {
      return null;
    }

    serviceEnabled = await location.serviceEnabled();
    final position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<GeolocationPermissionsResponse> handleAndroidPermission(
      request) async {
    var result = await handleLocationPermission();
    return GeolocationPermissionsResponse(allow: result, retain: false);
  }

  Future<Object> responseMessage() async {
    return getCurrentPosition().then((value) {
      if (value != null) {
        return {
          "coords": {"latitude": value.latitude, "longitude": value.longitude}
        };
      }
      return {};
    });
  }
}
