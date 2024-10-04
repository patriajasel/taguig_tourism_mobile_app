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
    // Log the received map to check if all fields are present
    print("Mapping data: $map");

    // Ensure fields are properly assigned and avoid null issues
    return UserInformation(
      firstName: map['first_name'] ?? '', // Default to empty if missing
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? 'Unknown', // Default values for nulls
      age: map['age'] ?? '',
      gender: map['gender'] ?? 'Unknown',
    );
  }
}
