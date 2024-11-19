// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/customer_support_page.dart';
import 'package:taguig_tourism_mobile_app/explore_page.dart';
import 'package:taguig_tourism_mobile_app/home_page.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';
import 'package:taguig_tourism_mobile_app/services/user_info.dart';
import 'package:taguig_tourism_mobile_app/news_page.dart';
import 'package:taguig_tourism_mobile_app/user_page.dart';
import 'package:taguig_tourism_mobile_app/weather_page.dart';

class AppNavigation extends StatefulWidget {
  final String userID;
  const AppNavigation({super.key, required this.userID});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int selectedNavIndex = 0;

  UserInformation? userInfo;
  bool isLoading = true;

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  void _fetchUserData() async {
    try {
      UserInformation? fetchedUser =
          await FirestoreServices().getUserData(widget.userID);
      setState(() {
        userInfo = fetchedUser;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // If user data is null, show an error message
    if (userInfo == null) {
      return Center(child: Text('User data not found.'));
    }

    final searchController = TextEditingController();

    final List<Widget> screens = [
      HomePage(
        userInformation: userInfo!,
      ),
      const NewsPage(),
      const ExplorePage(),
      const WeatherPage(),
      UserPage(
        userInformation: userInfo!,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.shade700,
                Colors.redAccent.shade700,
              ], // Define your gradient colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "lib/assets/logo/app_logo/city_of_taguig_logo.png",
            fit: BoxFit.fill,
            height: 50,
            width: 50,
          ),
        ),
        title: CupertinoSearchTextField(
          controller: searchController,
          backgroundColor: Colors.white,
          style: const TextStyle(
            fontFamily: "Arvo",
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.support_agent,
                  color: Colors.yellow.shade900,
                ),
                alignment: Alignment.center,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ChatSupportPage()));
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.redAccent.shade700,
            indicatorColor: Colors.redAccent.shade100,
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(
                  color: Colors.white, fontFamily: "Arvo", fontSize: 12.0),
            ),
            iconTheme: WidgetStateProperty.all(
              const IconThemeData(color: Colors.white),
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedNavIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedNavIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.newspaper), label: "News"),
            NavigationDestination(icon: Icon(Icons.explore), label: "Explore"),
            NavigationDestination(icon: Icon(Icons.cloud), label: "Weather"),
            NavigationDestination(icon: Icon(Icons.person), label: "User"),
          ],
        ),
      ),
      body: IndexedStack(
        index: selectedNavIndex,
        children: screens,
      ),
    );
  }
}
