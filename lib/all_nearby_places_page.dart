import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/individual_place_page.dart'; // Import IndividualPlacePage
import 'package:taguig_tourism_mobile_app/services/explore_info.dart';

class AllNearbyPlacesPage extends StatefulWidget {
  final List<ExploreDestinations> nearbyPlaces;

  const AllNearbyPlacesPage({
    super.key,
    required this.nearbyPlaces,
  });

  @override
  State<AllNearbyPlacesPage> createState() => _AllNearbyPlacesPage();
}

class _AllNearbyPlacesPage extends State<AllNearbyPlacesPage> {
  late List<ExploreDestinations> nearbyPlaces;

  @override
  void initState() {
    super.initState();
    setState(() {
      nearbyPlaces = widget.nearbyPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Nearby Places",
          style: TextStyle(color: Colors.white), // Title color set to white
        ),
        backgroundColor:
            Colors.transparent, // Make AppBar background transparent
        elevation: 0, // Remove shadow
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.redAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Back button color set to white
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: nearbyPlaces.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator(), // Show loading while fetching data
            )
          : ListView.builder(
              itemCount: nearbyPlaces.length,
              itemBuilder: (context, index) {
                final place = nearbyPlaces[index];

                return Container(
                  height: screenHeight * 0.2,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenHeight * 0.01,
                      vertical: screenHeight * 0.005),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight * 0.015),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              "lib/assets/places/default_banner.png",
                              height: screenHeight * 0.15,
                              width: screenHeight * 0.15,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: screenHeight * 0.02),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  place.siteName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  place.siteAddress,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.017,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: screenHeight * 0.03,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndividualPlacePage(
                                    banner:
                                        "lib/assets/places/default_banner.png",
                                    name: place.siteName,
                                    address: place.siteAddress,
                                    info: place.siteInfo,
                                    contact: place.siteContact,
                                    links: place.siteLinks,
                                    latitude: place.siteLatitude,
                                    longitude: place.siteLongitude,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
