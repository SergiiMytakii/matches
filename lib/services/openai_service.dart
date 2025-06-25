import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matches/features/matches/domain/models/match.dart';

class OpenAIService {
  static const String _apiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: '',
  );
  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> getMatchPrediction(MatchModel match) async {
    if (_apiKey.isEmpty) {
      return 'Error: API key is not set. Please provide it via --dart-define.';
    }

    final prompt =
        "Given Team A's last 5 results (W-W-L-D-W) and Team B's last 5 results (L-L-W-D-L), predict the winner for the match between ${match.teamA} and ${match.teamB}. Provide a brief prediction and a confidence percentage. Format your response as: Prediction: [Your Prediction] | Confidence: [Your Confidence]%";

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'max_tokens': 100,
          'temperature': 0.5,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Error fetching prediction: $e';
    }
  }
}
