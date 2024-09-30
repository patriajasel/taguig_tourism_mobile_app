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
  void initState() {
    super.initState();

    WeatherPage();
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

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
                onPressed: () {},
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
