// ignore_for_file: public_member_api_docs, sort_constructors_first
class Room {
  final String id;
  final String name;
  final String description;
  final String userID;
  final DateTime createdAt;
  final DateTime updatedAt;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.userID,
    required this.createdAt,
    required this.updatedAt,
  });
}
