import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/news_page_single_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> imgList = [
    'lib/assets/images/taguig_image1.png',
    'lib/assets/images/taguig_image2.png',
    'lib/assets/images/taguig_image3.png',
    'lib/assets/images/taguig_image4.png',
    'lib/assets/images/taguig_image5.png'
  ];

  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      // To make the whole page scrollable
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "News",
              style: TextStyle(
                  fontFamily: "Arvo",
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          CarouselSlider(
            items: imgList
                .map((e) => ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15.0), // Rounded corners
                      child: Stack(
                        children: [
                          Image.asset(
                            e,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: screenHeight *
                                0.4, // Set a fixed height for the image
                          ),
                          Positioned(
                            bottom: 80.0,
                            left: 10.0,
                            right: 10.0,
                            child: Text(
                              '6 hours ago',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(
                                        1.5, 1.5), // Position of the shadow
                                    blurRadius: 3.0, // Blur radius
                                    color: Colors.black54, // Shadow color
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20.0,
                            left: 10.0,
                            right: 10.0,
                            child: Container(
                              color: Colors
                                  .black26, // Background color for readability
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                'Your Text Here That Might Be Too Long',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2, // Restrict to 2 lines
                                overflow: TextOverflow
                                    .ellipsis, // Add ellipsis if text is too long
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              initialPage: 0,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (value, _) {
                setState(() {
                  currentSlide = value;
                });
              },
            ),
          ),
          carouselIndicator(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Recommendations",
              style: TextStyle(
                  fontFamily: "Arvo",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // The ListView should have a fixed height or be inside an Expanded widget
          SizedBox(
            height: screenHeight * 0.4, // Adjust based on your layout
            child: ListView.builder(
              itemCount:
                  10, // Set this to the length of your recommendation list
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: screenHeight * 0.15, // Increase height of the card
                    padding: EdgeInsets.all(10.0), // Padding inside the card
                    child: Row(
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'lib/assets/images/taguig_image1.png', // Path to your image
                            width: 100, // Set the width of the image
                            height: 100, // Set the height of the image
                            fit: BoxFit
                                .cover, // Ensure the image fits well inside the space
                          ),
                        ),
                        SizedBox(
                            width: 10), // Space between the image and ListTile
                        // Expanded ListTile to take up remaining space
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical:
                                    10.0), // Adjust padding inside the tile
                            title: Text(
                              "Your Text Here That Might Be Too Long",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight
                                      .bold), // Optional: Increase text size
                            ),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "May 28, 2022",
                                style: TextStyle(
                                    fontSize:
                                        14), // Optional: Increase subtitle text size
                              ),
                            ),
                            onTap: () {
                              // Handle tap on the item
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => SingleNewsPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Carousel indicator at the bottom
  carouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < imgList.length; i++)
          Container(
            margin: const EdgeInsets.all(5),
            height: i == currentSlide ? 7 : 5,
            width: i == currentSlide ? 7 : 5,
            decoration: BoxDecoration(
                color: i == currentSlide
                    ? Colors.blueAccent.shade700
                    : Colors.blueAccent.shade100,
                shape: BoxShape.circle),
          ),
      ],
    );
  }
}
