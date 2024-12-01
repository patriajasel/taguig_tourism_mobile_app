import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IndividualPlacePage extends StatefulWidget {
  final String banner;
  final String name;
  final String address;
  final String info;
  final String contact;
  final String links;
  final String latitude;
  final String longitude;

  const IndividualPlacePage({
    super.key,
    required this.banner,
    required this.name,
    required this.address,
    required this.info,
    required this.contact,
    required this.links,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<IndividualPlacePage> createState() => _IndividualPlacePageState();
}

class _IndividualPlacePageState extends State<IndividualPlacePage> {
  final List<String> imgList = [
    'lib/assets/images/taguig_image1.png',
    'lib/assets/images/taguig_image2.png',
    'lib/assets/images/taguig_image3.png',
    'lib/assets/images/taguig_image4.png',
    'lib/assets/images/taguig_image5.png',
  ];

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(widget.links);
    if (!await launchUrl(url)) {
      throw 'Could not launch ${widget.links}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        foregroundColor: Colors.white, // Set back button color to white
      ),
      body: Stack(
        children: [
          // Background Image that covers the AppBar
          Positioned(
            top: 0, // Start from the top
            left: 0,
            right: 0,
            child: SizedBox(
              height:
                  260, // Set the height of the image container (adjust as needed)
              child: Image.network(
                widget.banner,
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
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title aligned to the left
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Text(
                            maxLines: 2,
                            widget.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Address row with icon
                        Container(
                          margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.pin_drop, color: Colors.blue),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  widget.address,
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
                        SizedBox(height: 10),
                        // Scrollable Description with Carousel
                        SizedBox(
                          height: 300,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.info,
                                  textAlign: TextAlign
                                      .justify, // Changed from left to justify
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                    height: 20), // Add space after the text
                                Text(
                                  "Bookings or Links",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Website Link: ",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      GestureDetector(
                                        onTap: widget.links == "Not Available"
                                            ? null
                                            : _launchURL,
                                        child: Text(
                                          widget.links,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                widget.links == "Not Available"
                                                    ? null
                                                    : Colors.blueAccent,
                                            decoration: widget.links ==
                                                    "Not Available"
                                                ? null
                                                : TextDecoration
                                                    .underline, // Makes it look like a hyperlink
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: 20), // Add space after the text
                                Text(
                                  "Contact Information",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  widget.contact,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                    height:
                                        20), // Add space after the hyperlink
                                Text(
                                  'Street View',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Centered Carousel
                                Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                      ],
                    ),
                    // Button positioned at the bottom
                    Positioned(
                      bottom: 0,
                      right: 30,
                      left: 30,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .blue, // Set button background color to blue
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 6),
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
                                  color:
                                      Colors.white), // Text color remains white
                            ),
                          ],
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
