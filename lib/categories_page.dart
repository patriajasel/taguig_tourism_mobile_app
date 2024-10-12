import 'package:flutter/material.dart';
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
        itemCount: 8,
        itemBuilder: (container, index) {
          return Container(
            height: 146,
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
                          child: Image.asset(
                            'lib/assets/images/taguig_nearby3.jpg',
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
                                'SM Aura',
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
                                      '26th Street, Corner McKinley Pkwy, Taguig, 1630 Metro Manila',
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
                                      2), // Spacing between text and buttons
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
                                              IndividualPlacePage(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .blueAccent.shade700, // Button color
                                      foregroundColor:
                                          Colors.white, // Text color
                                    ),
                                    icon:
                                        Icon(Icons.info, size: 14), // Info icon
                                    label: Text(
                                      'View Info',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5), // Space between buttons
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .blueAccent.shade700, // Button color
                                      foregroundColor:
                                          Colors.white, // Text color
                                    ),
                                    icon: Icon(Icons.map, size: 14), // Map icon
                                    label: Text(
                                      'See on Maps',
                                      style: TextStyle(
                                        fontSize: 10,
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
                    top: 8,
                    right: 8,
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
