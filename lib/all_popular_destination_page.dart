import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/individual_place_page.dart'; // Import IndividualPlacePage
import 'package:taguig_tourism_mobile_app/services/explore_info.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart'; // Ensure you import the necessary services

class AllPopularDestinationPage extends StatefulWidget {
  const AllPopularDestinationPage({super.key});

  @override
  State<AllPopularDestinationPage> createState() =>
      _AllPopularDestinationPage();
}

class _AllPopularDestinationPage extends State<AllPopularDestinationPage> {
  List<ExploreDestinations> allPopularDestinations = [];
  List<String> allPopularURLs = [];

  final List<String> allPopular = [
    "tourist spots",
    "malls",
    "restaurants", // Add more categories if needed
  ];

  // Method to fetch data for all popular places
  Future<void> getAllPopularPlaceCollection() async {
    for (var collectionName in allPopular) {
      List<ExploreDestinations>? popularPlaces =
          await FirestoreServices().getPopularPlaces(collectionName);

      if (popularPlaces != null) {
        for (var popular in popularPlaces) {
          String imageURL =
              await FirestoreServices().getImageUrl(popular.siteBanner);

          setState(() {
            if (mounted) {
              allPopularDestinations.add(popular);
              allPopularURLs.add(imageURL);
            }
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAllPopularPlaceCollection();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Popular Destinations",
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
      body: allPopularDestinations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allPopularDestinations.length,
              itemBuilder: (context, index) {
                final popularDestination = allPopularDestinations[index];
                final imageURL = allPopularURLs[index];

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
                            child: Image.network(
                              imageURL,
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
                                  popularDestination.siteName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  popularDestination.siteAddress,
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
                                    banner: imageURL,
                                    name: popularDestination.siteName,
                                    address: popularDestination.siteAddress,
                                    info: popularDestination.siteInfo,
                                    contact: popularDestination.siteContact,
                                    links: popularDestination.siteLinks,
                                    latitude: popularDestination.siteLatitude,
                                    longitude: popularDestination.siteLongitude,
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
