import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // * Creating users
  Future<void> addUsers(String uid, String firstName, String lastName,
      String email, int age, String gender) {
    return users.add({
      'user_id': uid,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'age': age,
      'gender': gender,
    });
  }

  // * Reading user database
  Stream<QuerySnapshot> getUserInformation() {
    final userStream = users.snapshots();

    return userStream;
  }
}
