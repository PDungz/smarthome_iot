import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;

  late WebSocketChannel _channel; // Kênh WebSocket
  final String _url = 'wss://iot-ike5.onrender.com'; // URL của WebSocket server

  // Constructor riêng tư
  WebSocketService._internal();

  // Kết nối tới WebSocket server với userID
  void connect(String userID) {
    _channel = WebSocketChannel.connect(Uri.parse(_url));
    _registerDevice(userID);
  }

  // Đăng ký thiết bị với server
  void _registerDevice(String userID) {
    final Map<String, dynamic> registerData = {
      "type": "register",
      "device": "android", // Loại thiết bị
      "userID": userID // ID người dùng
    };
    _sendData(registerData);
  }

  // Cập nhật trạng thái thiết bị
  void updateDeviceState(
      String deviceType, String state, String gate, String ip) {
    final Map<String, dynamic> controlData = {
      "type": "control",
      "deviceType": deviceType,
      "state": state,
      "gate": gate,
      "ip": ip
    };
    _sendData(controlData);
  }

  // Gửi dữ liệu qua WebSocket
  void _sendData(Map<String, dynamic> data) {
    _channel.sink.add(jsonEncode(data));
  }

  // Stream để lắng nghe các thông điệp từ server
  Stream get stream => _channel.stream;

  // Ngắt kết nối với WebSocket server
  void disconnect() {
    _channel.sink.close();
  }
}
