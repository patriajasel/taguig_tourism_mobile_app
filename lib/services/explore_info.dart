// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreDestinations {
  final String siteName;
  final String siteAddress;
  final LatLng siteLatLng;
  final String siteBanner;
  final String siteMarker;
  final String siteInfo;

  ExploreDestinations(
      {required this.siteName,
      required this.siteAddress,
      required this.siteLatLng,
      required this.siteBanner,
      required this.siteMarker,
      required this.siteInfo});

  factory ExploreDestinations.fromSnapshot(Map<String, dynamic> snapshot) {
    print("Snapshot here: $snapshot");

    try {
      double latitude = snapshot['site_latitude'] != null
          ? double.parse(snapshot['site_latitude'])
          : 0.0;
      double longitude = snapshot['site_longitude'] != null
          ? double.parse(snapshot['site_longitude'])
          : 0.0;

      return ExploreDestinations(
          siteName: snapshot['site_name'] ?? '',
          siteAddress: snapshot['site_address'] ?? '',
          siteLatLng: LatLng(latitude, longitude),
          siteBanner: snapshot['site_banner'] ?? '',
          siteMarker: snapshot['site_marker'] ?? '',
          siteInfo: snapshot['site_info'] ?? '');
    } catch (e) {
      print("Error parsing snapshot: $e");
      throw e;
    }
  }
}
