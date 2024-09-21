import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  static const taguigCity = LatLng(14.520445, 121.053886);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
          buildingsEnabled: true,
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(target: taguigCity, zoom: 15)),
    );
  }
}
