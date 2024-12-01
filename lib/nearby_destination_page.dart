import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'news_page_single_page.dart';

class NearbyDestinationPage extends StatefulWidget {
  const NearbyDestinationPage({super.key});

  @override
  State<NearbyDestinationPage> createState() => _NearbyDestinationPageState();
}

class _NearbyDestinationPageState extends State<NearbyDestinationPage> {
  String _locationMessage = "Fetching location...";
  // List<Map<String, dynamic>> _sortedPoints = [];

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _getCurrentLocation();
  }

  /// Check and request location permission
  Future<void> _checkLocationPermission() async {
    PermissionStatus permission = await Permission.locationWhenInUse.status;

    // if (permission.isGranted) {
    //   _getCurrentLocation();
    // } else {
    //   // Request location permission
    //   permission = await Permission.locationWhenInUse.request();

    //   if (permission.isGranted) {
    //     _getCurrentLocation();
    //   } else if (permission.isDenied) {
    //     setState(() {
    //       _locationMessage = "Location permission denied";
    //     });
    //   } else if (permission.isPermanentlyDenied) {
    //     setState(() {
    //       _locationMessage = "Permission permanently denied. Open settings to enable.";
    //     });
    //     await openAppSettings();
    //   }
    // }
    if (permission.isDenied) {
      permission = await Permission.locationWhenInUse.request();
    } else if (permission.isGranted) {
      _getCurrentLocation();
    }
    else if (permission.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  /// Fetch the current location and calculate distances
  Future<void> _getCurrentLocation() async {
    try {
      // Get the device's current position
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      // Define multiple points of interest
      List<Map<String, double>> pointsOfInterest = [
        {"latitude": position.latitude + 0.05, "longitude": position.longitude + 0.05},
        {"latitude": position.latitude - 0.03, "longitude": position.longitude - 0.03},
        {"latitude": position.latitude + 0.1, "longitude": position.longitude + 0.1},
        // Add more points here
      ];

      double radiusInKilometers = 5.0; // Set a radius of 5 km
      List<Map<String, dynamic>> pointsWithDistances = [];

      // Loop through the points of interest to calculate distances
      for (var point in pointsOfInterest) {
        double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          point["latitude"]!,
          point["longitude"]!,
        ) /
            1000; // Convert meters to kilometers

        pointsWithDistances.add({
          "latitude": point["latitude"],
          "longitude": point["longitude"],
          "distance": distance,
          "withinRadius": distance <= radiusInKilometers,
        });
      }

      // Sort points by distance (nearest to farthest)
      pointsWithDistances.sort((a, b) => a["distance"].compareTo(b["distance"]));

      // Update the location message
      setState(() {
        _locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        // _sortedPoints = pointsWithDistances;
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Failed to get location: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.03948),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
              Padding(
              padding: EdgeInsets.all(screenHeight * 0.01053),
              child: Text(
                "Nearby Places",
                style: TextStyle(
                  fontSize: screenHeight * 0.02369,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Text(
              _locationMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenHeight * 0.0125
                  ),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.0125),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(screenHeight * 0.0125),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'lib/assets/images/taguig_image1.png',
                            width: screenHeight * 0.125,
                            height: screenHeight * 0.125,
                            fit: BoxFit.cover,
                          ),
                        ),
      
                        SizedBox(width: screenHeight * 0.0125),
      
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "Your Text Here That Might Be Too Long",
                              style: TextStyle(
                                fontSize: screenHeight * 0.0175,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0125),
                              child: Text(
                                "May 28, 2022",
                                style: TextStyle(fontSize: screenHeight * 0.015),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => SingleNewsPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}