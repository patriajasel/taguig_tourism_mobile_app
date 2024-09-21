import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'lib/assets/images/taguig_image1.png',
    'lib/assets/images/taguig_image2.png',
    'lib/assets/images/taguig_image3.png',
    'lib/assets/images/taguig_image4.png',
    'lib/assets/images/taguig_image5.png'
  ];

  final List<String> nearbyList = [
    'lib/assets/images/taguig_nearby1.jpg',
    'lib/assets/images/taguig_nearby2.jpg',
    'lib/assets/images/taguig_nearby3.jpg',
    'lib/assets/images/taguig_nearby4.jpg',
  ];

  final List<String> nearbyNames = [
    'Heritage Park',
    'Bonifacio High Tree',
    'SM Aura',
    'Market Market',
  ];

  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * User Info Section
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.shade700,
                    Colors.redAccent.shade700,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      // ! This widget will be changed to ImageAsset once there is a function for uploading pictures
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // * Main Body Here

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: const Text(
                            "Popular Destinations",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          trailing: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.menu))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CarouselSlider(
                          items: imgList
                              .map((e) => Center(
                                    child: Image.asset(
                                      e,
                                      fit: BoxFit.fill,
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
                              }),
                        ),
                      ),
                      carouselIndicator()
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipOval(
                                    child: Material(
                                      elevation: 10,
                                      color: Colors.blueAccent.shade700,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          getIconForIndex(index),
                                          color: Colors.white,
                                          size: 35, // Icon size
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    getTextForIndex(index),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Nearby Places",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blueAccent.shade700,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child: Image.asset(
                                          nearbyList[index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      nearbyNames[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
          )
      ],
    );
  }

  // Function to return different icons based on index
  IconData getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.local_cafe;
      case 1:
        return Icons.local_mall;
      case 2:
        return Icons.hotel;
      case 3:
        return Icons.store;
      case 4:
        return Icons.account_balance;
      case 5:
        return Icons.local_taxi;
      case 6:
        return Icons.local_hospital;
      case 7:
        return Icons.church;
      case 8:
        return Icons.local_police;
      case 9:
        return Icons.location_city;
      default:
        return Icons.help_outline; // Default icon if the index is out of range
    }
  }

// Function to return different text labels based on index
  String getTextForIndex(int index) {
    switch (index) {
      case 0:
        return "Diners";
      case 1:
        return "Malls";
      case 2:
        return "Hotels";
      case 3:
        return "Stores";
      case 4:
        return "ATMs";
      case 5:
        return "Terminals";
      case 6:
        return "Hospitals";
      case 7:
        return "Churches";
      case 8:
        return "Police";
      case 9:
        return "LGUs";
      default:
        return "Unknown"; // Default text if index is out of range
    }
  }
}
