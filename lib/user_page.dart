import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/services/user_info.dart';
import 'package:taguig_tourism_mobile_app/user_history_tab.dart';
import 'package:taguig_tourism_mobile_app/user_profile_tab.dart';
import 'package:taguig_tourism_mobile_app/user_settings_tab.dart';

class UserPage extends StatefulWidget {
  final UserInformation userInformation;
  const UserPage({super.key, required this.userInformation});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserInformation? userInfo;

  @override
  void initState() {
    userInfo = widget.userInformation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenHeight * 0.01315),
                    labelStyle: TextStyle(
                      fontFamily: 'Arvo',
                      fontSize: screenHeight * 0.01578,
                    ),
                    isScrollable: false,
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.redAccent,
                    indicatorPadding: EdgeInsets.symmetric(
                        horizontal: screenHeight * 0.01973,
                        vertical: screenHeight * 0.013157),
                    indicator: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    tabs: [
                      Tab(
                          text: 'Profile',
                          icon:
                              Icon(Icons.person, size: screenHeight * 0.03289)),
                      Tab(
                          text: 'History',
                          icon: Icon(Icons.history,
                              size: screenHeight * 0.03289)),
                      Tab(
                          text: 'Settings',
                          icon: Icon(Icons.settings,
                              size: screenHeight * 0.03289)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        UserProfileTab(userInformation: userInfo!),
                        UserHistoryTab(),
                        UserSettingsTab(userInfo: userInfo!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
