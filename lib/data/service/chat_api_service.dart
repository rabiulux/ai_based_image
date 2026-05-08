import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/app_strings.dart';
import '../model/message_model.dart';

class ChatApiService {
  Future<String> fetchAssistantReply(List<MessageModel> messages) async {
    print(
      '[Chat] Sending request to: ${AppStrings.baseUrl}/v1/chat/completions',
    );
    print('[Chat] Model: ${AppStrings.model}');
    print('[Chat] Message count: ${messages.length}');

    final response = await http
        .post(
      Uri.parse('${AppStrings.baseUrl}/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppStrings.apiKey}',
      },
      body: jsonEncode({
        'model': AppStrings.model,
        'messages': [
          {"role": "system", "content": AppStrings.systemPrompt},
          ...messages.map((message) => message.toApiMap()),
        ],
      }),
    )
        .timeout(Duration(seconds: 30));

    print('[Chat] Status code: ${response.statusCode}');
    print('[Chat] Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch assistant reply: ${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body);
    return (data['choices'][0]['message']['content'] as String).trim();
  }
}