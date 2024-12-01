import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taguig_tourism_mobile_app/services/explore_info.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';

class NearbyPlaces extends StatefulWidget {
  const NearbyPlaces({super.key});

  @override
  State<NearbyPlaces> createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {

  final List<String> collectionList = ["diners", "tourist spots", "malls"];

  List<List<ExploreDestinations>> nearbyCollection = [];
  List<LatLng> placesLatLng = [];

  @override
  void initState() {
    getNearbyCollection();
    super.initState();
  }

  Future<void> getNearbyCollection() async {
    List<List<ExploreDestinations>>? collection =
        await FirestoreServices().getPlacesForNearby(collectionList);

    nearbyCollection = collection!;

    for (var col in collection) {
      for (var c in col) {
        setState(() {
          placesLatLng.add(c.siteLatLng);
        });
      }
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
                "Nearby Collection",
                style: TextStyle(
                  fontSize: screenHeight * 0.02369,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: nearbyCollection.length,
              itemBuilder: (context, index) {
                final collection = nearbyCollection[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenHeight * 0.0125,
                  ),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.0125),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(screenHeight * 0.0125),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Collection: ${collectionList[index]}",
                          style: TextStyle(
                            fontSize: screenHeight * 0.0175,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.00658),
                        ...collection.map((place) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.00658,
                              ),
                              child: Text(
                                "- ${place.siteName}, Latitude: ${place.siteLatitude} Longitude: ${place.siteLongitude}", // Replace 'name' with the actual field in your model
                                style: TextStyle(
                                  fontSize: screenHeight * 0.015,
                                ),
                              ),
                            )
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