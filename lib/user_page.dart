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

          Expanded(
            child: Container(
              color: Colors.grey,
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 0,
                    bottom: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      labelStyle: const TextStyle(
                        fontFamily: 'Arvo',
                        fontSize: Sizes.fontSizeSm,
                      ),
                      isScrollable: false,
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.redAccent,
                      indicatorPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      indicator: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      tabs: const[
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
