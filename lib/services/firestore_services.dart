// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taguig_tourism_mobile_app/services/explore_info.dart';
import 'package:taguig_tourism_mobile_app/services/user_info.dart';

class FirestoreServices {
  // This is the variable for accessing the users collection on firestore database
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //  This function is for creating new users
  Future<void> addUsers(String uid, String firstName, String lastName,
      String email, int age, String gender) {
    return users.doc(uid).set({
      'user_id': uid,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'age': age,
      'gender': gender,
    });
  }

  // This function is for getting the user's details after login
  Future<UserInformation?> getUserData(String userID) async {
    try {
      DocumentSnapshot doc = await users.doc(userID).get();

      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;

        return UserInformation.fromMap(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
    }

    return null;
  }

  // This function is for getting the destinations based on filters
  Future<List<ExploreDestinations>?> getDestinationIds(
      String collectionName) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);
      QuerySnapshot querySnapshot = await collection.get();

      List<ExploreDestinations> destinations = [];

      for (var doc in querySnapshot.docs) {
        try {
          DocumentSnapshot documentSnapshot =
              await collection.doc(doc.id).get();
          var data = documentSnapshot.data() as Map<String, dynamic>;

          if (data.isNotEmpty) {
            destinations.add(ExploreDestinations.fromSnapshot(data));
          }
        } catch (e) {
          print("Error processing document ${doc.id}: $e");
        }
      }
      return destinations.isNotEmpty ? destinations : null;
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }

    return null;
  }

  Future<List<List<ExploreDestinations>>?> getPlacesForNearby(
    List<String> collectionNames) async {
  try {
    List<List<ExploreDestinations>> collectionList = [];

    for (var collectionName in collectionNames) {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot querySnapshot = await collectionReference.get();

      List<ExploreDestinations> destinationList = [];

      for (var doc in querySnapshot.docs) {
        try {
          DocumentSnapshot documentSnapshot =
              await collectionReference.doc(doc.id).get();

          var data = documentSnapshot.data() as Map<String, dynamic>;

          if (data.isNotEmpty) {
            destinationList.add(ExploreDestinations.fromSnapshot(data));
          }
        } catch (e) {
          print("Error processing document ${doc.id}: $e");
        }
      }

      // Add each collection's destination list to the collectionList
      if (destinationList.isNotEmpty) {
        collectionList.add(destinationList);
      }
    }

    return collectionList.isNotEmpty ? collectionList : null;
  } catch (e) {
    print("Error fetching data from Firestore: $e");
    return null;
  }
}


  // Function to get the image download URL
  Future<String> getImageUrl(String imagePath) async {
    print("imagePath URL: $imagePath");
    String downloadURL =
        await FirebaseStorage.instance.ref(imagePath).getDownloadURL();

    print("Download URL: $downloadURL");
    return downloadURL;
  }

  Future<List<Map<String, dynamic>>> getCommuteGuideCollection(
      String baranggay, String destination) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("commute guide");

      QuerySnapshot querySnapshot = await collection
          .where("destination", isEqualTo: destination)
          .where("baranggays", arrayContains: baranggay)
          .get();

      List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      print("Collection captured: $data");
      return data;
    } catch (e) {
      print("Error: $e"); // Log errors for debugging
      return [];
    }
  }
}
