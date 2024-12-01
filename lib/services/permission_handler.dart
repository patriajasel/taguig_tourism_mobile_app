import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  /// Check and request location permission
  static Future<bool> checkLocationPermission() async {
    // Check the current status of the permission
    PermissionStatus permission = await Permission.locationWhenInUse.status;

    // Handle different cases based on the permission status
    switch (permission) {
      case PermissionStatus.denied:
        // First-time denial or not yet requested
        final newPermission = await Permission.locationWhenInUse.request();
        return newPermission.isGranted;

      case PermissionStatus.permanentlyDenied:
        // Permanently denied: Open app settings for the user to enable
        final opened = await openAppSettings();
        return opened; // Returns true if the user opened the settings

      case PermissionStatus.granted:
      case PermissionStatus.limited:
        // Permission already granted
        return true;

      case PermissionStatus.restricted:
        // Restricted permission (not applicable on all platforms)
        return false;

      default:
        return false;
    }
  }
}