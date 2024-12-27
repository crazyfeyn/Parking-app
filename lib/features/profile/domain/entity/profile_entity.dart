// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class ProfileEntity {
  int id;
  String email;
  String first_name;
  String last_name;
  bool owns_parking;
  ProfileEntity({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.owns_parking,
  });
}
