import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class IndividualPlacePage extends StatelessWidget {
  IndividualPlacePage({super.key});

  final List<String> imgList = [
    'lib/assets/images/taguig_image1.png',
    'lib/assets/images/taguig_image2.png',
    'lib/assets/images/taguig_image3.png',
    'lib/assets/images/taguig_image4.png',
    'lib/assets/images/taguig_image5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        iconTheme: IconThemeData(
            color: Colors.white), // Set back button color to white
      ),
      body: Stack(
        children: [
          // Background Image that covers the AppBar
          Positioned(
            top: 0, // Start from the top
            left: 0,
            right: 0,
            child: Container(
              height:
                  260, // Set the height of the image container (adjust as needed)
              child: Image.asset(
                'lib/assets/images/taguig_nearby3.jpg',
                fit: BoxFit.cover, // Ensure the image covers the container
              ),
            ),
          ),
          // Card Content
          Positioned(
            top:
                200, // Adjust this value to position the card below the AppBar and background image
            left: 10,
            right: 10,
            bottom: 10, // Adjust bottom to give space for the button
            child: Card(
              color: Colors.white, // Make the card slightly transparent
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title aligned to the left
                    Container(
                      margin: EdgeInsets.all(8.0),
                      child: Text(
                        'SM Aura',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Address row with icon
                    Container(
                      margin: EdgeInsets.only(left: 8.0, bottom: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.pin_drop, color: Colors.blue),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '26th St. corner McKinley Parkway, Taguig, Metro Manila',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    // Scrollable Description with Carousel
                    Container(
                      height: 400,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SM Aura Premier is the 13th SM Supermall in Metro Manila and 47th SM Prime mall in the Philippines. The SM Aura name is derived from the two elements gold (which has the chemical symbol Au) and radium. '
                              'According to SM Prime, putting them together defines “luxury and elegance that emanates from within.',
                              textAlign: TextAlign
                                  .justify, // Changed from left to justify
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 4), // Add space after the text
                            GestureDetector(
                              onTap: () {
                                // Implement the action for booking appointment
                                print('Booking appointment...');
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'Book for appointment here',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                    decoration: TextDecoration
                                        .underline, // Makes it look like a hyperlink
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 50), // Add space after the hyperlink
                            Text(
                              'StreetView',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            // Centered Carousel
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    initialPage: 0,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    enlargeFactor: 0.3,
                                    height: 150,
                                    onPageChanged: (value, _) {},
                                  ),
                                  items: imgList.map((item) {
                                    return Container(
                                      margin: const EdgeInsets.all(8),
                                      width: 400,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          item,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Button positioned at the bottom
                    Positioned(
                      bottom: 20, // Adjust the bottom padding as needed
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .blue, // Set button background color to blue
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.map,
                                  color:
                                      Colors.white), // Icon color remains white
                              SizedBox(width: 12),
                              Text(
                                'View location on map',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors
                                        .white), // Text color remains white
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
