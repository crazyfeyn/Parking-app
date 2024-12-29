class ProfileModel {
  final String surname;
  final String name;
  final String email;
  final String phoneNumber;
  final bool ownsParking;
  
  ProfileModel({
    required this.surname,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.ownsParking,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      surname: json['surname'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      ownsParking: json['owns_parking'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'owns_parking': ownsParking,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileModel &&
        other.surname == surname &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.ownsParking == ownsParking;
  }

  @override
  int get hashCode {
    return Object.hash(
      surname,
      name,
      email,
      phoneNumber,
      ownsParking,
    );
  }

  ProfileModel copyWith({
    String? surname,
    String? name,
    String? email,
    String? phoneNumber,
    bool? ownsParking,
  }) {
    return ProfileModel(
      surname: surname ?? this.surname,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      ownsParking: ownsParking ?? this.ownsParking,
    );
  }
}
