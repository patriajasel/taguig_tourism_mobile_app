import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/chage_password_page.dart';
import 'package:taguig_tourism_mobile_app/change_email_page.dart';
import 'package:taguig_tourism_mobile_app/services/auth_services.dart';
import 'package:taguig_tourism_mobile_app/services/user_info.dart';
import 'package:taguig_tourism_mobile_app/widgets/widget_generator.dart';

class UserProfileTab extends StatefulWidget {
  final UserInformation userInformation;
  const UserProfileTab({super.key, required this.userInformation});

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  UserInformation? userInfo;

  @override
  void initState() {
    userInfo = widget.userInformation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(screenHeight * 0.01315),
            height: screenHeight * 0.15789,
            width: screenHeight * 0.15789,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blueAccent.shade700,
                  Colors.redAccent.shade700,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                shape: BoxShape.circle),
            child: Padding(
              // This padding will be the border size
              padding: EdgeInsets.all(screenHeight * 0.00394),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://i.ibb.co/rkG8cCs/112921315-gettyimages-876284806.jpg"),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.00657),
            child: Text(
              "${userInfo?.firstName} ${userInfo?.lastName}",
              style: TextStyle(
                  fontSize: screenHeight * 0.01578,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.00657),
            child: Text(
              userInfo!.email,
              style: TextStyle(fontSize: screenHeight * 0.01842),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.03289,
                    vertical: screenHeight * 0.01315),
                width: double.infinity,
                child: Card(
                  color: Colors.blueAccent.shade100,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenHeight * 0.02631,
                            screenHeight * 0.02631,
                            screenHeight * 0.02631,
                            screenHeight * 0.01315),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: screenHeight * 0.05263,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.01973),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Age",
                                style:
                                    TextStyle(fontSize: screenHeight * 0.01842),
                              ),
                              Text(
                                userInfo!.age.toString(),
                                style: TextStyle(
                                  fontSize: screenHeight * 0.01578,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenHeight * 0.02631,
                            screenHeight * 0.01315,
                            screenHeight * 0.02631,
                            screenHeight * 0.02631),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: screenHeight * 0.05263,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.01973),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Gender",
                                style:
                                    TextStyle(fontSize: screenHeight * 0.01842),
                              ),
                              Text(
                                userInfo!.gender,
                                style: TextStyle(
                                  fontSize: screenHeight * 0.01578,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: screenHeight * 0.03289),
                width: double.infinity,
                child: Card(
                  color: Colors.blueAccent.shade100,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenHeight * 0.02631,
                            screenHeight * 0.02631,
                            screenHeight * 0.02631,
                            screenHeight * 0.01315),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height:
                              screenHeight * 0.05263, // Adjust height as needed
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.01973),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between leading and trailing
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Center vertically
                            children: [
                              Text(
                                "Change Email Address",
                                style:
                                    TextStyle(fontSize: screenHeight * 0.01842),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChangeEmailPage(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenHeight * 0.02631,
                            screenHeight * 0.01315,
                            screenHeight * 0.02631,
                            screenHeight * 0.01315),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height:
                              screenHeight * 0.05263, // Adjust height as needed
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.01973),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between leading and trailing
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Center vertically
                            children: [
                              Text(
                                "Change Password",
                                style:
                                    TextStyle(fontSize: screenHeight * 0.01842),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChangePassPage(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenHeight * 0.02631,
                            screenHeight * 0.01315,
                            screenHeight * 0.02631,
                            screenHeight * 0.02631),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height:
                              screenHeight * 0.05263, // Adjust height as needed
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.01973),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between leading and trailing
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Center vertically
                            children: [
                              Text(
                                "Change Mobile Number",
                                style:
                                    TextStyle(fontSize: screenHeight * 0.01842),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_right))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.13157,
                    vertical: screenHeight * 0.02631),
                child: GenerateWidget().generateElevatedButton(
                    context,
                    "Sign out",
                    Colors.blueAccent.shade700,
                    Colors.white,
                    signOutButton,
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  void signOutButton() {
    AuthenticationServices().signOut(context: context);
  }
}
