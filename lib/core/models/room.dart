// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Room {
  String nameIcon;
  String roomName;
  String imageUrl;
  String description;
  Room({
    required this.nameIcon,
    required this.roomName,
    required this.imageUrl,
    required this.description,
  });

  Room copyWith({
    String? nameIcon,
    String? roomName,
    String? imageUrl,
    String? description,
  }) {
    return Room(
      nameIcon: nameIcon ?? this.nameIcon,
      roomName: roomName ?? this.roomName,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameIcon': nameIcon,
      'roomName': roomName,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      nameIcon: map['nameIcon'] as String,
      roomName: map['roomName'] as String,
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Room(nameIcon: $nameIcon, roomName: $roomName, imageUrl: $imageUrl, description: $description)';
  }

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.nameIcon == nameIcon &&
        other.roomName == roomName &&
        other.imageUrl == imageUrl &&
        other.description == description;
  }

  @override
  int get hashCode {
    return nameIcon.hashCode ^
        roomName.hashCode ^
        imageUrl.hashCode ^
        description.hashCode;
  }
}
