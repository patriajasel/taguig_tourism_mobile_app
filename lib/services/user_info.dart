class UserInformation {
  final String firstName;
  final String lastName;
  final String email;
  final int age;
  final String gender;

  UserInformation({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.gender,
  });

  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? 'Unknown',
      age: map['age'] ?? '',
      gender: map['gender'] ?? 'Unknown',
    );
  }
}