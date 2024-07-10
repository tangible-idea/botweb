// Providers
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomTagProvider = StateProvider<String>((ref) => "399451340753056");
final messageProvider = StateProvider<String>((ref) => "");

// API call function
Future<String> sendMessage(String roomTag, String message) async {

  final url = Uri.parse("http://ec2-3-36-78-0.ap-northeast-2.compute.amazonaws.com:8000/chat/sendkakao");
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: json.encode({
      "message": message,
      "roomTag": roomTag,
    }),
  );

  if (response.statusCode == 200) {
    var successMesage= "Message sent successfully";
    print(successMesage);
    return successMesage;
  } else {
    var failedMessage= "Failed to send message. Status code: ${response.statusCode}";
    print(failedMessage);
    return failedMessage;
  }
}