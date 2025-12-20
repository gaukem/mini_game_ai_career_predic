import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  /// Suggests a major/career based on user's name and description
  /// 
  /// Parameters:
  /// - [name]: The person's name
  /// - [description]: Description of the person's characteristics, interests, skills
  /// 
  /// Returns: A String suggestion for an ideal job/major
  /// 
  /// Throws: Exception if the API call fails
  static Future<String> suggestMajor({
    required String name,
    required String description,
  }) async {
    // List of models to try in order of preference
    final modelsToTry = [
      'models/gemini-2.5-flash',
      'models/gemini-2.5-pro',
      'models/gemini-pro',
      'gemini-2.5-flash',
      'gemini-2.5-pro',
      'gemini-pro',
    ];

    for (final modelName in modelsToTry) {
      try {
        // Initialize the Gemini model
        final model = GenerativeModel(
          model: modelName,
          apiKey: _apiKey,
        );

        // Create the prompt
        final prompt = '''
Bạn là một chuyên gia tư vấn nghề nghiệp. Dựa trên thông tin sau, hãy gợi ý một nghề nghiệp hoặc chuyên ngành phù hợp:

Tên: $name
Đặc điểm: $description

Hãy đưa ra một gợi ý ngắn gọn (khoảng 1-2 câu) về nghề nghiệp hoặc chuyên ngành phù hợp nhất cho người này, giải thích ngắn gọn tại sao.
''';

        // Call the API with timeout
        final content = [Content.text(prompt)];
        final response = await model.generateContent(content).timeout(
          const Duration(seconds: 25),
        );

        // Extract the text from the response
        if (response.text != null && response.text!.isNotEmpty) {
          return response.text!.trim();
        } else {
          throw Exception('Không nhận được phản hồi từ AI');
        }
      } catch (e) {
        // If this model failed, try the next one
        print('Model $modelName failed: $e');
        continue;
      }
    }

    // If all models failed, throw the last error
    throw Exception('Tất cả các model đều không khả dụng. Vui lòng kiểm tra API key và kết nối mạng.');
  }

  //daryl-test
  static Future<void> testApiKeyForModels(String apiKey) async {
    final modelsToTry = [
      'models/gemini-1.5-flash',
      'models/gemini-1.5-pro',
      'models/gemini-pro',
      'gemini-1.5-flash',
      'gemini-1.5-pro',
      'gemini-pro',
    ];

    for (final modelName in modelsToTry) {
      try {
        final model = GenerativeModel(model: modelName, apiKey: apiKey);
        final resp = await model
            .generateContent([Content.text('Test: availability check')])
            .timeout(const Duration(seconds: 15));
        final text = resp.text ?? '<no text>';
        print('✅ $modelName: OK — ${text.substring(0, min(120, text.length))}');
      } catch (e) {
        print('❌ $modelName: ERROR — $e');
      }
    }
  }


}
