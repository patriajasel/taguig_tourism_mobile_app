// ignore_for_file: avoid_print

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taguig_tourism_mobile_app/categories_page.dart';
import 'package:taguig_tourism_mobile_app/individual_place_page.dart';
import 'package:taguig_tourism_mobile_app/models/events.dart';
import 'package:taguig_tourism_mobile_app/events_page_single_page.dart';
import 'package:taguig_tourism_mobile_app/navigation_state.dart';
import 'package:taguig_tourism_mobile_app/services/explore_info.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';
import 'package:taguig_tourism_mobile_app/services/permission_handler.dart';
import 'package:taguig_tourism_mobile_app/services/user_info.dart';

class HomePage extends StatefulWidget {
  final UserInformation userInformation;
  const HomePage({super.key, required this.userInformation});

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

  final List<String> popular = [
    "tourist spots",
    "malls",
  ];

  final List<String> collectionList = [
    "churches",
    "diners",
    "tourist spots",
    "malls",
    "lgu"
  ];

  bool isLoading = true;

  List<ExploreDestinations> popularDestinations = [];
  List<String> popularURL = [];

  List<List<ExploreDestinations>> nearbyCollection = [];
  List<ExploreDestinations> allPlaces = [];
  List<ExploreDestinations> nearbyPlaces = [];

  List<LatLng> placesLatLng = [];

  int currentSlide = 0;

  UserInformation? userInfo;

  List<Events> eventList = [];
  List<String> imageDirectory = [];
  List<String> nearbyImageURL = [];

  Position? userPosition;

  Timer? _timer;

  @override
  void initState() {
    userInfo = widget.userInformation;
    _initialize();
    getAllEvents();
    getPopularPlaceCollection();

    // Set up the Timer
    _timer = Timer.periodic(Duration(minutes: 30), (timer) {
      _initialize();
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _initialize() async {
    final hasPermission = await PermissionHandler.checkLocationPermission();
    if (hasPermission) {
      await _getCurrentLocation();
      await getNearbyCollection();
      await compareUserToPlaces();
      setState(() {
        isLoading = false; // Set loading to false after data fetching completes
      });
    } else {
      print(
          "Location permission is required. Please enable it in the app settings.");
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        setState(() {
          print("Location services are disabled. Please enable them.");
        });
        return;
      }
      // Get the device's current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        userPosition = position;
      });

      // Update the location message
    } catch (e) {
      print(e);
    }
  }

  void getAllEvents() async {
    List<Events>? events = await FirestoreServices().getAllEvents();

    if (events != null) {
      List<String> imageUrls = [];

      // Fetch image URLs for each event
      for (var event in events) {
        String imageUrl =
            await FirestoreServices().getImageUrl(event.imageDirectory);
        if (imageUrl.isNotEmpty) {
          imageUrls.add(imageUrl);
        } else {
          imageUrls.add(
              ""); // Add empty string or a default value for missing images
        }
      }

      // Now that we have both event list and image URLs, update the state
      setState(() {
        eventList = events;
        imageDirectory = imageUrls; // Populate imageDirectory
      });
    }
  }

  Future<void> getPopularPlaceCollection() async {
    // Fetch from the new touristMallsList (tourist spots and malls)
    for (var collectionName in popular) {
      List<ExploreDestinations>? popularPlaces =
          await FirestoreServices().getPopularPlaces(collectionName);
      if (popularPlaces != null) {
        for (var popular in popularPlaces) {
          String imageURL =
              await FirestoreServices().getImageUrl(popular.siteBanner);

          setState(() {
            popularDestinations.add(popular);
            popularURL.add(imageURL);
          });
        }
      }
    }
  }

  Future<void> getNearbyCollection() async {
    List<List<ExploreDestinations>>? collection =
        await FirestoreServices().getPlacesForNearby(collectionList);

    if (collection != null) {
      for (var col in collection) {
        for (var c in col) {
          placesLatLng.add(c.siteLatLng);
          allPlaces.add(c);
        }
      }
      setState(() {
        nearbyCollection = collection;
      });
    }
    print("placesLatLng Length: ${placesLatLng.length}");
  }

  Future<void> compareUserToPlaces() async {
    print("Comparing position to places");

    if (placesLatLng.isNotEmpty) {
      for (var latlng in placesLatLng) {
        if (isWithin1Km(userPosition!, latlng.latitude, latlng.longitude)) {
          nearbyPlaces.add(allPlaces[placesLatLng.indexOf(latlng)]);
          print("Nearby place added");
        }
      }
    }

    // Fetch images for all nearby places
    for (var place in nearbyPlaces) {
      try {
        String url = await FirestoreServices().getImageUrl(place.siteBanner);
        if (url.isNotEmpty) {
          nearbyImageURL.add(url); // Add valid URL
        }
      } catch (e) {
        print("Error fetching image URL: $e");
      }
    }

    setState(() {
      // Ensures the UI rebuilds with updated data
    });
  }

  bool isWithin1Km(Position userPosition, double targetLat, double targetLng) {
    double distanceInMeters = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      targetLat,
      targetLng,
    );
    return distanceInMeters <= 1000; // Change threshold to 1000 meters
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final navigationState = NavigationState.of(context);

    return isLoading
        ? Center(child: CircularProgressIndicator()) // Show loading indicator
        : PopScope(
            canPop: false,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // This is where the user's name and profile picture is displayed
                    Container(
                      height: screenHeight * 0.125,
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
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(screenHeight * 0.02632),
                            child: GestureDetector(
                              onTap: () {
                                navigationState?.onChangeScreen(4);
                              },
                              child: CircleAvatar(
                                // ! This widget will be changed to ImageAsset once there is a function for uploading pictures
                                child: Icon(
                                  Icons.person,
                                  size: screenHeight * 0.03948,
                                ),
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
                                    fontSize: screenHeight * 0.02369,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                userInfo!.firstName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenHeight * 0.02105,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    // Main Content starts here!

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // This is where the popular destination carousel is displayed
                        Container(
                          margin: EdgeInsets.fromLTRB(screenHeight * 0.03948, 0,
                              screenHeight * 0.03948, screenHeight * 0.01316),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                  title: Text(
                                    "Popular Destinations",
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.02369,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.menu))),
                              Padding(
                                padding: EdgeInsets.all(screenHeight * 0.01053),
                                child: CarouselSlider(
                                  items: popularURL
                                      .map((e) => GestureDetector(
                                            onTap: () {
                                              int index = popularURL.indexOf(e);
                                              if (index >= 0 &&
                                                  index <
                                                      popularDestinations
                                                          .length) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return IndividualPlacePage(
                                                        banner: popularURL[
                                                            index],
                                                        name: popularDestinations[
                                                                index]
                                                            .siteName,
                                                        address:
                                                            popularDestinations[
                                                                    index]
                                                                .siteAddress,
                                                        info:
                                                            popularDestinations[
                                                                    index]
                                                                .siteInfo,
                                                        contact:
                                                            popularDestinations[
                                                                    index]
                                                                .siteContact,
                                                        links:
                                                            popularDestinations[
                                                                    index]
                                                                .siteLinks,
                                                        latitude:
                                                            popularDestinations[
                                                                    index]
                                                                .siteLatitude,
                                                        longitude:
                                                            popularDestinations[
                                                                    index]
                                                                .siteLongitude);
                                                  },
                                                ));
                                              }
                                            },
                                            child: Image.network(
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.02632),
                          child: Divider(),
                        ),

                        // This is where the categories is displayed
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.03948),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(screenHeight * 0.01053),
                                child: Text(
                                  "Categories",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02369,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(screenHeight * 0.00658),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 11,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(
                                          child: Material(
                                            elevation: 10,
                                            color: Colors.blueAccent.shade700,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            CategoriesPage(
                                                                headline:
                                                                    getTextForIndex(
                                                                        index))));
                                              },
                                              icon: Icon(
                                                getIconForIndex(index),
                                                color: Colors.white,
                                                size: screenHeight *
                                                    0.03948, // Icon size
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.01316,
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          getTextForIndex(index),
                                          style: TextStyle(
                                              fontSize: screenHeight * 0.01579),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.02632),
                          child: Divider(),
                        ),

                        // This is where the nearby places is being displayed
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.03948),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(screenHeight * 0.01053),
                                child: Text(
                                  "Nearby Places",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02369,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(screenHeight * 0.00658),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: nearbyPlaces.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(
                                          screenHeight * 0.00658),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    Colors.blueAccent.shade700,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox(
                                                height: screenHeight * 0.13158,
                                                width: screenHeight * 0.26315,
                                                child: Image.network(
                                                  nearbyImageURL[index],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: screenHeight * 0.00658),
                                            child: Text(
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              nearbyPlaces[index].siteName,
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

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.02632),
                          child: Divider(),
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.03948),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(screenHeight * 0.01053),
                                child: Text(
                                  "Events",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02369,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: eventList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.01),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          screenHeight * 0.0125),
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(screenHeight * 0.0125),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: Image.network(
                                              imageDirectory[index],
                                              width: screenHeight * 0.125,
                                              height: screenHeight * 0.125,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                              width: screenHeight * 0.0125),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                eventList[index].eventName,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize:
                                                      screenHeight * 0.0175,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        screenHeight * 0.0125),
                                                child: Text(
                                                  DateFormat('MMMM dd, yyyy')
                                                      .format(eventList[index]
                                                          .eventDate
                                                          .toDate()),
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenHeight * 0.015),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (builder) =>
                                                        SingleEventPage(
                                                      event: eventList[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  // This is the function where the carousel slider is being handled
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

  // This is the function that returns the icon for the categories
  IconData getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.flag;
      case 1:
        return Icons.local_cafe;
      case 2:
        return Icons.local_mall;
      case 3:
        return Icons.hotel;
      case 4:
        return Icons.store;
      case 5:
        return Icons.account_balance;
      case 6:
        return Icons.local_taxi;
      case 7:
        return Icons.local_hospital;
      case 8:
        return Icons.church;
      case 9:
        return Icons.local_police;
      case 10:
        return Icons.location_city;

      default:
        return Icons.help_outline;
    }
  }

// This is the function that returns the text for the categories
  String getTextForIndex(int index) {
    switch (index) {
      case 0:
        return "Tourist Spots";
      case 1:
        return "Diners";
      case 2:
        return "Malls";
      case 3:
        return "Hotels";
      case 4:
        return "Convenience Stores";
      case 5:
        return "Banks";
      case 6:
        return "Terminals";
      case 7:
        return "Hospitals";
      case 8:
        return "Churches";
      case 9:
        return "Police";
      case 10:
        return "LGU";

      default:
        return "Unknown";
    }
  }
}
