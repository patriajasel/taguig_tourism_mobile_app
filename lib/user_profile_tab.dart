import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blueAccent.shade700,
                  Colors.redAccent.shade700,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                shape: BoxShape.circle),
            child: Padding(
              // This padding will be the border size
              padding: const EdgeInsets.all(3.0),
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
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "${userInfo?.firstName} ${userInfo?.lastName}",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              userInfo!.email,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                width: double.infinity,
                child: Card(
                  color: Colors.blueAccent.shade100,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: 40, 
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, 
                            crossAxisAlignment:
                                CrossAxisAlignment.center, 
                            children: [
                              Text(
                                "Age",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                userInfo!.age.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: 40, 
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, 
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Gender",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                userInfo!.gender,
                                style: TextStyle(
                                  fontSize: 12,
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
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                width: double.infinity,
                child: Card(
                  color: Colors.blueAccent.shade100,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: 40, // Adjust height as needed
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between leading and trailing
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Center vertically
                            children: [
                              Text(
                                "Change Email Address",
                                style: TextStyle(fontSize: 14),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_right))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: 40, // Adjust height as needed
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between leading and trailing
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Center vertically
                            children: [
                              Text(
                                "Change Password",
                                style: TextStyle(fontSize: 14),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_right))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: 40, // Adjust height as needed
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between leading and trailing
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Center vertically
                            children: [
                              Text(
                                "Change Mobile Number",
                                style: TextStyle(fontSize: 14),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                child: GenerateWidget().generateElevatedButton(
                    context,
                    "Sign out",
                    Colors.blueAccent.shade700, Colors.white, signOutButton,
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
