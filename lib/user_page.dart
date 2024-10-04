import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/services/user_info.dart';
import 'package:taguig_tourism_mobile_app/user_history_tab.dart';
import 'package:taguig_tourism_mobile_app/user_profile_tab.dart';
import 'package:taguig_tourism_mobile_app/user_settings_tab.dart';
import 'util/constants/sizes.dart';

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    labelStyle: const TextStyle(
                      fontFamily: 'Arvo',
                      fontSize: Sizes.fontSizeSm,
                    ),
                    isScrollable: false,
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.redAccent,
                    indicatorPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    indicator: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    tabs: const [
                      Tab(text: 'Profile', icon: Icon(Icons.person, size: 25)),
                      Tab(text: 'History', icon: Icon(Icons.history, size: 25)),
                      Tab(
                          text: 'Settings',
                          icon: Icon(Icons.settings, size: 25)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        UserProfileTab(userInformation: userInfo!,),
                        UserHistoryTab(),
                        UserSettingsTab(),
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
