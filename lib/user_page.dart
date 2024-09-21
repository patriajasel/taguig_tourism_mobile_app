import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/user_history_tab.dart';
import 'package:taguig_tourism_mobile_app/user_profile_tab.dart';
import 'package:taguig_tourism_mobile_app/user_settings_tab.dart';
import 'util/constants/sizes.dart';
import 'package:taguig_tourism_mobile_app/explore_page.dart';
import 'package:taguig_tourism_mobile_app/traffic_page.dart';
import 'package:taguig_tourism_mobile_app/weather_page.dart';

void main() => runApp(const UserPage());

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<Widget> screens = [
    const TrafficPage(),
    const ExplorePage(),
    const WeatherPage(),

  ];

  int selectedNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // User Profile
          Container(
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
            height: 80,
            child: ListTile(
              leading: Image.asset("lib/assets/logo/app_logo/city_of_taguig_logo.png", // UserImage
              width: 50,
              height: 50),
              title: const Text('Username', // Username
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.fontSizeLg
              )), 
              subtitle: const Text('Username@gmail.com', // Email
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.fontSizeSm
              )), 
              trailing: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.edit, 
                color: Colors.white,)
              ),
            )
          ),
          
          // Container(
          //   color: Colors.grey,
          //   height: 120,
          //   child: Theme(
          //     data: ThemeData(
          //       navigationBarTheme: const NavigationBarThemeData(
          //         backgroundColor: Colors.white,
          //         indicatorColor: Colors.red,
          //         labelTextStyle: WidgetStatePropertyAll(
          //           TextStyle(
          //             color: Colors.black, fontFamily: "Arvo", fontSize: 12.0
          //           )
          //         ),
          //         iconTheme: WidgetStatePropertyAll(
          //           IconThemeData(color: Colors.white, size: 50),
          //         ),
                  
                  
          //         indicatorShape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          //       )
          //     ), 
          //       child: NavigationBar(
          //         selectedIndex: selectedNavIndex,
          //           onDestinationSelected: (index) {
          //             setState(() {
          //               selectedNavIndex = index;
          //             });
          //           },
          //         destinations: const [
          //           NavigationDestination(icon: Icon(Icons.person), label: 'Person'),
          //           NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          //           NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
          //         ],
          //       ),
          //     ),
          // ),

          Container(
            height: 120,
            color: Colors.grey,
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 0,
                  bottom: const TabBar(

                    tabs: [
                      Tab(
                        text: 'Profile',
                        icon: Icon(Icons.person, size: 50),
                      ),
                      Tab(
                        text: 'History',
                        icon: Icon(Icons.history, size: 50)
                      ),
                      Tab(
                        text: 'Settings',
                        icon: Icon(Icons.settings, size: 50)
                      ),
                    ]),
                ),
                body: TabBarView(
                  children: [
                    Center(child: UserProfileTab()),
                    Center(child: UserHistoryTab()),
                    Center(child: UserSettingsTab()),
                  ]
                  ),
              )
            ),
          )
        ],
      ),
    );
  }
}
