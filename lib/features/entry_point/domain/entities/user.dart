// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String fullName;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  User({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });
}
