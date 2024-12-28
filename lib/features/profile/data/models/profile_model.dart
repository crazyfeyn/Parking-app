class ProfileModel {
  final String surname;
  final String name;
  final String email;
  final String phoneNumber;
  ProfileModel({
    required this.surname,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  // Factory constructor for creating an instance from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      surname: json['surname'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  // Equality operator and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileModel &&
        other.surname == surname &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return surname.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode;
  }

  // CopyWith method for creating modified copies
  ProfileModel copyWith({
    String? surname,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return ProfileModel(
      surname: surname ?? this.surname,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
