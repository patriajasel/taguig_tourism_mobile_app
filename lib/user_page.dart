import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/user_history_tab.dart';
import 'package:taguig_tourism_mobile_app/user_profile_tab.dart';
import 'package:taguig_tourism_mobile_app/user_settings_tab.dart';
import 'util/constants/sizes.dart';

void main() => runApp(const UserPage());

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // final List<Widget> screens = [
  //   const TrafficPage(),
  //   const ExplorePage(),
  //   const WeatherPage(),
  // ];

  // int selectedNavIndex = 0;
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
              leading: const CircleAvatar(
                child: Icon(Icons.person, size: 30),
              ),
              title: const Text('Username', // Username
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.fontSizeLg,
                  fontWeight: FontWeight.bold
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

          Expanded(
            child: Container(
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
                          icon: Icon(Icons.person, size: 40)
                        ),
                        Tab(
                          text: 'History',
                          icon: Icon(Icons.history, size: 40)
                        ),
                        Tab(
                          text: 'Settings',
                          icon: Icon(Icons.settings, size: 40)
                        ),
                      ]
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      UserProfileTab(),
                      UserHistoryTab(),
                      UserSettingsTab(),
                    ]
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
