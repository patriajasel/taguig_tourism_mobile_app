import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/explore_page.dart';
import 'package:taguig_tourism_mobile_app/home_page.dart';
import 'package:taguig_tourism_mobile_app/traffic_page.dart';
import 'package:taguig_tourism_mobile_app/user_page.dart';
import 'package:taguig_tourism_mobile_app/weather_page.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  final List<Widget> screens = [
    const HomePage(),
    const TrafficPage(),
    const ExplorePage(),
    const WeatherPage(),
    const UserPage()
  ];

  int selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
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
              fontFamily: "Arvo", fontSize: 16, letterSpacing: 1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(
                  Icons.support_agent,
                  color: Colors.black,
                ),
                alignment: Alignment.center,
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.red,
            indicatorColor: Colors.red.shade300,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                  color: Colors.white, fontFamily: "Arvo", fontSize: 12.0),
            ),
            iconTheme: MaterialStateProperty.all(
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
            NavigationDestination(icon: Icon(Icons.traffic), label: "Traffic"),
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
