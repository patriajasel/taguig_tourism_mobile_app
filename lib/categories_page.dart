import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taguig_tourism_mobile_app/app_navigation.dart';
import 'package:taguig_tourism_mobile_app/explore_page.dart';
import 'package:taguig_tourism_mobile_app/services/explore_info.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';
import 'individual_place_page.dart'; // Ensure the correct import

class CategoriesPage extends StatefulWidget {
  final String headline;
  const CategoriesPage({super.key, required this.headline});

  @override
  State<CategoriesPage> createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  // Track the like status for each card
  List<bool> likedItems = List.generate(8, (index) => false);
  List<ExploreDestinations>? categoryTitle = [];
  List<String> destinationImage = [];

  bool isLoading = true;

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  Future<void> getCategory() async {
    categoryTitle!.clear();
    destinationImage.clear();
    List<ExploreDestinations>? category = await FirestoreServices()
        .getDestinationIds(widget.headline.toLowerCase());

    if (category != null) {
      categoryTitle = category;
      for (int i = 0; i < category.length; i++) {
        String image =
            await FirestoreServices().getImageUrl(categoryTitle![i].siteBanner);
        destinationImage.add(image);
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      // Make sure to update the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.headline,
          style: TextStyle(color: Colors.white), // Title color set to white
        ),
        backgroundColor:
            Colors.transparent, // Make AppBar background transparent
        elevation: 0, // Remove shadow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.shade700,
                Colors.redAccent.shade700,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Back button color set to white
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: categoryTitle!.length,
              itemBuilder: (container, index) {
                return Container(
                  height: screenHeight * 0.214,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenHeight * 0.01,
                      vertical: screenHeight * 0.003), // Add margin for spacing
                  child: Card(
                    elevation: 10,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenHeight * 0.015),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  destinationImage[index],
                                  height: screenHeight * 0.125,
                                  width: screenHeight *
                                      0.125, // Provide explicit width and height
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                  width: screenHeight *
                                      0.01), // Add spacing between the image and text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: screenHeight * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            categoryTitle![index].siteName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.pin_drop,
                                          color: Colors.blue,
                                          size: screenHeight *
                                              0.0175, // Icon size
                                        ),
                                        SizedBox(
                                            width: screenHeight *
                                                0.005), // Space between icon and text
                                        Expanded(
                                          child: Text(
                                            categoryTitle![index].siteAddress,
                                            style: TextStyle(
                                                fontSize: screenHeight * 0.015),
                                            overflow: TextOverflow
                                                .ellipsis, // Prevents overflow
                                            maxLines:
                                                2, // Limits the text to two lines
                                          ),
                                        ),
                                      ],
                                    ), // Spacing between text and buttons
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            // Navigate to IndividualPlacePage
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    IndividualPlacePage(
                                                  address: categoryTitle![index]
                                                      .siteAddress,
                                                  name: categoryTitle![index]
                                                      .siteName,
                                                  banner:
                                                      destinationImage[index],
                                                  info: categoryTitle![index]
                                                      .siteInfo,
                                                  contact: categoryTitle![index]
                                                      .siteContact,
                                                  links: categoryTitle![index]
                                                      .siteLinks,
                                                  latitude:
                                                      categoryTitle![index]
                                                          .siteLatitude,
                                                  longitude:
                                                      categoryTitle![index]
                                                          .siteLongitude,
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(
                                                0,
                                                screenHeight *
                                                    0.04), // Reduced button height
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    screenHeight * 0.02),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            backgroundColor: Colors.blueAccent
                                                .shade700, // Button color
                                            foregroundColor:
                                                Colors.white, // Text color
                                          ),
                                          icon: Icon(
                                            Icons.info,
                                            size: screenHeight *
                                                0.015, // Adjusted icon size for smaller button
                                          ),
                                          label: Text(
                                            'View Info',
                                            style: TextStyle(
                                              fontSize: screenHeight *
                                                  0.0125, // Smaller font size
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            width: screenHeight *
                                                0.0125), // Space between buttons
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              initialLocation = LatLng(
                                                  double.parse(
                                                      categoryTitle![index]
                                                          .siteLatitude),
                                                  double.parse(
                                                      categoryTitle![index]
                                                          .siteLongitude));
                                            });

                                            String uid = FirebaseAuth
                                                .instance.currentUser!.uid;
                                            String userEmail = FirebaseAuth
                                                .instance.currentUser!.email!;

                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AppNavigation(
                                                  userID: uid,
                                                  index: 2,
                                                  email: userEmail,
                                                ),
                                              ),
                                              (route) =>
                                                  false, // Removes all previous routes
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(
                                                0,
                                                screenHeight *
                                                    0.04), // Reduced button height
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    screenHeight * 0.02),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            backgroundColor: Colors.blueAccent
                                                .shade700, // Button color
                                            foregroundColor:
                                                Colors.white, // Text color
                                          ),
                                          icon: Icon(
                                            Icons.map,
                                            size: screenHeight *
                                                0.015, // Adjusted icon size for smaller button
                                          ),
                                          label: Text(
                                            'See on Maps',
                                            style: TextStyle(
                                              fontSize: screenHeight *
                                                  0.0125, // Smaller font size
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
