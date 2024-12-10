// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreDestinations {
  final String siteName;
  final String siteAddress;
  final String siteInfo;
  final String siteContact;
  final String siteLinks;
  final LatLng siteLatLng;
  final String siteLatitude;
  final String siteLongitude;
  final String siteBanner;
  final String siteMarker;

  ExploreDestinations({
    required this.siteName,
    required this.siteAddress,
    required this.siteInfo,
    required this.siteContact,
    required this.siteLinks,
    required this.siteLatLng,
    required this.siteLatitude,
    required this.siteLongitude,
    required this.siteBanner,
    required this.siteMarker,
  });

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
        siteInfo: snapshot['site_info'] ?? '',
        siteContact: snapshot['site_contact'] ?? '',
        siteLinks: snapshot['site_link'] ?? '',
        siteLatLng: LatLng(latitude, longitude),
        siteLatitude: snapshot['site_latitude'] ?? '',
        siteLongitude: snapshot['site_longitude'] ?? '',
        siteBanner: snapshot['site_banner'] ?? '',
        siteMarker: snapshot['site_marker'] ?? '',
      );
    } catch (e) {
      print("Error parsing snapshot: $e");
      throw e;
    }
  }

  String? get siteDescription => null;
}
