import 'package:flutter/material.dart';
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

      // Make sure to update the UI
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: categoryTitle!.length,
        itemBuilder: (container, index) {
          return Container(
            height: 160,
            margin: EdgeInsets.all(8), // Add margin for spacing
            child: Card(
              elevation: 10,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            destinationImage[index],
                            height: 100,
                            width: 100, // Provide explicit width and height
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the image and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 13),
                              Text(
                                categoryTitle![index].siteName,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: Colors.blue,
                                    size: 14, // Icon size
                                  ),
                                  SizedBox(
                                      width: 4), // Space between icon and text
                                  Expanded(
                                    child: Text(
                                      categoryTitle![index].siteAddress,
                                      style: TextStyle(fontSize: 11.5),
                                      overflow: TextOverflow
                                          .ellipsis, // Prevents overflow
                                      maxLines:
                                          2, // Limits the text to two lines
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      5), // Spacing between text and buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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
                                            name:
                                                categoryTitle![index].siteName,
                                            banner: destinationImage[index],
                                            info:
                                                categoryTitle![index].siteInfo,
                                            contact: categoryTitle![index]
                                                .siteContact,
                                            links:
                                                categoryTitle![index].siteLinks,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      backgroundColor: Colors
                                          .blueAccent.shade700, // Button color
                                      foregroundColor:
                                          Colors.white, // Text color
                                    ),
                                    icon:
                                        Icon(Icons.info, size: 10), // Info icon
                                    label: Text(
                                      'View Info',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10), // Space between buttons
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      backgroundColor: Colors
                                          .blueAccent.shade700, // Button color
                                      foregroundColor:
                                          Colors.white, // Text color
                                    ),
                                    icon: Icon(Icons.map, size: 10), // Map icon
                                    label: Text(
                                      'See on Maps',
                                      style: TextStyle(
                                        fontSize: 8,
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
                  Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      icon: Icon(
                        likedItems[index]
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: likedItems[index] ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          likedItems[index] = !likedItems[index];
                        });
                      },
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
