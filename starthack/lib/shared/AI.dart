import 'package:flutter/material.dart';
import './apikeys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> summarize(String name) async {
  return generateResponse("Summarize information about the Stock/Company: $name in 2 sentences.");
}

Future<String> generateResponse(String prompt) async {
  const apiKey = openAIKey;

  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json', "Authorization": "Bearer $apiKey"},
    body: json.encode({
      "model": "text-davinci-003",
      "prompt": prompt,
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );

  // Do something with the response
  Map<String, dynamic> newresponse = jsonDecode(response.body);

  return newresponse['choices'][0]['text'];
}
