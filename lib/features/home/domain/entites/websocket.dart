import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Websocket {
  final double gasValue;
  final double humidity;
  final double temperature;
  final String ip;

  Websocket({
    required this.gasValue,
    required this.humidity,
    required this.temperature,
    required this.ip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gasValue': gasValue,
      'humidity': humidity,
      'temperature': temperature,
      'ip': ip,
    };
  }

  factory Websocket.fromMap(Map<String, dynamic> map) {
    return Websocket(
      gasValue: map['gas_value'] as double,
      humidity: map['humidity'] as double,
      temperature: map['temperature'] as double,
      ip: map['ip'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Websocket.fromJson(String source) =>
      Websocket.fromMap(json.decode(source) as Map<String, dynamic>);
}
