import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taguig_tourism_mobile_app/services/user_info.dart';

class FirestoreServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //  Creating users
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

  Future<UserInformation?> getUserData(String userID) async {
    try {
      DocumentSnapshot doc = await users.doc(userID).get();

      // Check if document exists and print the data
      print("Document here: ${doc.exists}");
      print("Raw document data: ${doc.data()}"); // Add this to see the raw data

      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;

        // Print individual fields for more clarity
        print("First Name: ${data['first_name']}");
        print("Last Name: ${data['last_name']}");

        return UserInformation.fromMap(data);
      } else {
        return null; // Document doesn't exist or is empty
      }
    } catch (e) {
      print('Error getting user: $e');
    }

    return null;
  }
}
