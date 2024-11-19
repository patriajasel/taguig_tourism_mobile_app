// ignore_for_file: unused_element
// ignore_for_file: avoid_print

import 'dart:math';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:taguig_tourism_mobile_app/individual_place_page.dart';
import 'package:taguig_tourism_mobile_app/services/explore_info.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final String googleMapsAPIKey = "";
  static const taguigCity = LatLng(14.520445, 121.053886);

  bool isNavigating = false;

  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  final locationController = Location();

  LatLng? usersLatLng;

  Set<Marker> marker = {};

  List<ExploreDestinations>? destinations = [];
  List<BitmapDescriptor> bitmapIcons = [];
  Map<PolylineId, Polyline> polylines = {};

  List<String> filters = [
    "XDiners",
    "Malls",
    "Hotels",
    "XStores",
    "Banks",
    "XTerminals",
    "Hospitals",
    "Churches",
    "Police",
    "LGU"
  ];

  String selectedFilter = "Diners";

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => _fetchLocationUpdate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: taguigCity, zoom: 15),
            markers: marker,
            polylines: Set<Polyline>.of(polylines.values),
            trafficEnabled: true,
            onMapCreated: (controller) {
              customInfoWindowController.googleMapController = controller;
            },
            onTap: (location) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 200,
            width: 160,
            offset: 50,
          ),
          Positioned(
              right: 10,
              top: 10,
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  height: 55,
                  width: 175,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          selectedFilter,
                          style: TextStyle(fontSize: 16, letterSpacing: 2),
                        ),
                      ),
                      FocusScope(
                        canRequestFocus: false,
                        child: PopupMenuButton(
                          onSelected: (value) {
                            setState(() {
                              selectedFilter = value;
                            });
                            customInfoWindowController.hideInfoWindow;
                            _getLocationsByFilter(selectedFilter);
                          },
                          itemBuilder: (context) {
                            return filters.map((String item) {
                              return PopupMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ],
                  ))),
          if (isNavigating) ...[
            Positioned(
                bottom: 10,
                left: 50,
                right: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.blueAccent.shade700),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      setState(() {
                        customInfoWindowController.hideInfoWindow;
                        destinations!.clear();
                        marker.clear();
                        polylines = {};
                        isNavigating = false;

                        CameraUpdate cameraUpdate =
                            CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: taguigCity, // Focus on the first point
                            zoom: 15.0, // Apply the calculated bearing
                          ),
                        );

                        // Animate the camera to this position
                        customInfoWindowController.googleMapController
                            ?.animateCamera(cameraUpdate);
                      });

                      _getLocationsByFilter(selectedFilter);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Icon(
                            Icons.directions_off,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Cancel Navigation",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )))
          ]
        ],
      ),
    );
  }

  // This is for getting the destinations data from firestore and storing them in a list
  Future<void> _getLocationsByFilter(String filter) async {
    List<ExploreDestinations>? places =
        await FirestoreServices().getDestinationIds(filter.toLowerCase());

    destinations?.clear();
    bitmapIcons.clear();
    marker.clear();

    destinations = places;

    await _createBitMapIcon();
    _setCustomMarker();
  }

  // This is for setting custom markers for the user
  Future<void> _setCustomMarkerForUser() async {
    BitmapDescriptor userIcon = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(50, 50)),
        "lib/assets/images/user_marker.png");

    Marker userCustomMarker = Marker(
        markerId: MarkerId("user_marker"),
        position: usersLatLng!,
        icon: userIcon,
        infoWindow: InfoWindow(title: "Your current location"));

    setState(() {
      marker.add(userCustomMarker);
    });
  }

  // This is for setting the custom markers of the places based on the filter
  Future<void> _setCustomMarker() async {
    for (int i = 0; i < destinations!.length; i++) {
      print("imagePath URL: ${destinations![i].siteBanner}");
      Marker customMarker = Marker(
          markerId: MarkerId("marker_${destinations![i].siteLatLng}"),
          position: destinations![i].siteLatLng,
          icon: bitmapIcons[i],
          onTap: () async {
            customInfoWindowController.addInfoWindow!(
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            await FirestoreServices()
                                .getImageUrl(destinations![i].siteBanner),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () async {
                            String image = await FirestoreServices()
                                .getImageUrl(destinations![i].siteBanner);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => IndividualPlacePage(
                                    banner: image,
                                    name: destinations![i].siteName,
                                    address: destinations![i].siteAddress,
                                    info: destinations![i].siteInfo,
                                    contact: destinations![i].siteContact,
                                    links: destinations![i].siteLinks)));
                          },
                          child: Text(
                            textAlign: TextAlign.center,
                            destinations![i].siteName,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.blueAccent.shade700),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)))),
                            onPressed: () async {
                              await _fetchLocationUpdate();
                              setState(() {
                                isNavigating = true;
                                ExploreDestinations userDestination =
                                    destinations![i];
                                marker.clear();
                                destinations!.clear();

                                customInfoWindowController.hideInfoWindow;

                                destinations?.add(userDestination);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Icon(
                                    Icons.directions,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                                Text("Get Directions",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white)),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                destinations![i].siteLatLng);
          });

      setState(() {
        marker.add(customMarker);
      });
    }
  }

  // This is for converting the images in firebase storage into bitmap descriptors
  Future<BitmapDescriptor> createBitmapFromUrl(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        return BitmapDescriptor.bytes(bytes, width: 50, height: 50);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Error loading image: $e');
    }
  }

  // This is for creating the custom marker's icon
  Future<void> _createBitMapIcon() async {
    for (var i = 0; i < destinations!.length; i++) {
      String imageUrl =
          await FirestoreServices().getImageUrl(destinations![i].siteMarker);

      BitmapDescriptor customIcon = await createBitmapFromUrl(imageUrl);

      setState(() {
        bitmapIcons.add(customIcon);
      });
    }
  }

  // This is for getting the current location of the user and updating the camera
  Future<void> _fetchLocationUpdate() async {
    bool serviceEnabled;

    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        if (isNavigating) {
          usersLatLng =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);

          final coordinates = await _fetchPolylinePoints();

          setState(() {
            _generatePolylineFromPoints(coordinates);
            _setCustomMarkerForUser();
            _updateCameraPositionWithBearing(coordinates);
          });
        }
      }
    });
  }

  // This is for fetching if there is a valid route between the current location and destination
  Future<List<LatLng>> _fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleMapsAPIKey,
        request: PolylineRequest(
            origin: PointLatLng(usersLatLng!.latitude, usersLatLng!.longitude),
            destination: PointLatLng(destinations!.first.siteLatLng.latitude,
                destinations!.first.siteLatLng.longitude),
            mode: TravelMode.driving));

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
      return [];
    }
  }

  Future<void> _generatePolylineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const polylineId = PolylineId('polyline');

    final polyline = Polyline(
        geodesic: true,
        jointType: JointType.bevel,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        polylineId: polylineId,
        color: Colors.blueAccent,
        points: polylineCoordinates,
        width: 10);

    setState(() {
      polylines[polylineId] = polyline;
    });
  }

  // This function calculates the bearing between two LatLng points
  double calculateBearing(LatLng start, LatLng end) {
    double startLat = start.latitude * (pi / 180.0); // Convert to radians
    double startLng = start.longitude * (pi / 180.0);
    double endLat = end.latitude * (pi / 180.0);
    double endLng = end.longitude * (pi / 180.0);

    double dLng = endLng - startLng;

    double y = sin(dLng) * cos(endLat);
    double x =
        cos(startLat) * sin(endLat) - sin(startLat) * cos(endLat) * cos(dLng);

    double bearing = atan2(y, x) * (180.0 / pi); // Convert to degrees

    return (bearing + 360.0) % 360.0; // Normalize to 0-360 degrees
  }

  // Updates the camera position with the bearing based on the polyline direction
  void _updateCameraPositionWithBearing(List<LatLng> polylineCoordinates) {
    if (polylineCoordinates.length >= 2) {
      LatLng start = polylineCoordinates.first;
      LatLng end =
          polylineCoordinates[1]; // Using the next point in the polyline

      double bearing = calculateBearing(start, end);

      // Update the camera position with the calculated bearing
      CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(
        CameraPosition(
          target: start, // Focus on the first point
          zoom: 19.0,
          tilt: 45.0,
          bearing: bearing, // Apply the calculated bearing
        ),
      );

      // Animate the camera to this position
      customInfoWindowController.googleMapController
          ?.animateCamera(cameraUpdate);
    }
  }
}
