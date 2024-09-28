// Providers
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/screens/homepage.dart';

// API call function
Future<String> analyzeWholeMessage(String roomTag, String senderKey, String sender) async {

  final url = Uri.parse("http://ec2-3-36-78-0.ap-northeast-2.compute.amazonaws.com:8000/chat/personality");
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: json.encode({
      "roomTag": roomTag,
      "senderKey": senderKey,
      "sender": sender
    }),
  );

  if (response.statusCode == 200) {
    var successMesage= "200";
    print(successMesage);
    return successMesage;
  } else {
    var failedMessage= "Failed to send message. Status code: ${response.statusCode}";
    print(failedMessage);
    return failedMessage;
  }
}