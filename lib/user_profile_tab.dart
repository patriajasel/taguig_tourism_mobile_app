import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/change_password_page.dart';
import 'package:taguig_tourism_mobile_app/change_email_page.dart';
import 'package:taguig_tourism_mobile_app/services/auth_services.dart';
import 'package:taguig_tourism_mobile_app/services/user_info.dart';
import 'package:taguig_tourism_mobile_app/widgets/widget_generator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfileTab extends StatefulWidget {
  final UserInformation userInformation;
  const UserProfileTab({super.key, required this.userInformation});

  @override
  State<UserProfileTab> createState() => _UserProfileTabState();
}

class _UserProfileTabState extends State<UserProfileTab> {
  UserInformation? userInfo;
  final ImagePicker _imagePicker = ImagePicker();
  String? profileImageURL;
  bool isLoading = false;

  Future<void> pickImage() async {
    try {
      XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (res != null) {
        setState(() => isLoading = true); // Add a loading flag
        await uploadImgToFirebase(File(res.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to pick images: $e"),
        ),
      );
    } finally {
      setState(() => isLoading = false); // Reset loading flag
    }
  }

  Future<void> uploadImgToFirebase(File image) async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("profile_images/${userInfo?.userID}/custom_profile.png");
      await reference.putFile(image);
      String downloadURL = await reference.getDownloadURL();
      setState(() => profileImageURL = downloadURL);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          content: Text("The profile image was uploaded successfully."),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to upload image: $e"),
        ),
      );
    }
  }

  @override
  void initState() {
    userInfo = widget.userInformation;
    _fetchProfileImage(); // Fetch the profile image on initialization
    super.initState();
  }

  Future<void> _fetchProfileImage() async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("profile_images/${userInfo?.userID}/custom_profile.png");
      String downloadURL = await reference.getDownloadURL();
      setState(() {
        profileImageURL = downloadURL; // Set the fetched URL
      });
    } catch (e) {
      // Log or handle the error if the image doesn't exist
      print("Failed to fetch profile image: $e");
    }
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
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: screenHeight * 0.075,
                      child: isLoading
                          ? CircularProgressIndicator()
                          : profileImageURL != null
                              ? SizedBox(
                                  height: screenHeight * 0.15,
                                  child: ClipOval(
                                    child: Image.network(
                                      profileImageURL!,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, progress) {
                                        return progress == null
                                            ? child
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(
                                          Icons.broken_image,
                                          size: screenHeight * 0.075,
                                          color: Colors.red,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: screenHeight * 0.075,
                                  color: Colors.grey,
                                ),
                    ),
                  ),
                ),
                Positioned(
                  right: screenHeight * 0.008,
                  top: screenHeight * 0.008,
                  child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Icon(Icons.camera_alt,
                          color: Colors.black, size: screenHeight * 0.025)),
                )
              ]),
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
                                "Tourist Type",
                                style:
                                    TextStyle(fontSize: screenHeight * 0.01842),
                              ),
                              Text(
                                userInfo!.touristType,
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
