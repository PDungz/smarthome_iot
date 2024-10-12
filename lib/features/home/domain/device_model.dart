// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Device {
  final String id;
  final String name;
  final String description;
  final String state;
  final String type;
  final String gate;
  final String roomID;
  final String userID;

  Device({
    required this.id,
    required this.name,
    required this.description,
    required this.state,
    required this.type,
    required this.gate,
    required this.roomID,
    required this.userID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'state': state,
      'type': type,
      'gate': gate,
      'roomID': roomID,
      'userID': userID,
    };
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      state: map['state'] as String,
      type: map['type'] as String,
      gate: map['gate'] as String,
      roomID: map['roomID'] as String,
      userID: map['userID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) =>
      Device.fromMap(json.decode(source) as Map<String, dynamic>);

  Device copyWith({
    String? id,
    String? name,
    String? description,
    String? state,
    String? type,
    String? gate,
    String? roomID,
    String? userID,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      state: state ?? this.state,
      type: type ?? this.type,
      gate: gate ?? this.gate,
      roomID: roomID ?? this.roomID,
      userID: userID ?? this.userID,
    );
  }
}
