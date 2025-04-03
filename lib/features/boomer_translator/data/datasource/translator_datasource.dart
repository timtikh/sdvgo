import 'package:dio/dio.dart';

class TranslatorDatasource {
  TranslatorDatasource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<String> translate(String boomerMessage) async {
    const apiKey = 'sk-QJb5B7AxURVsBQGKoJH1gAQ6HHN2tK1N';
    const apiUrl = 'https://api.proxyapi.ru/openai/v1/responses';

    try {
      final response = await _dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: {
          'model': 'gpt-4o',
          'input': '''
            привет. я буду писать тебе текст написанный на обычном языке, 
            а ты будешь "переводить его на зумерский": делать его супер 
            кринжовым, использовать смайлики и современные зумерские слова и сленг.
            Не добавляй пояснений. Текст: "$boomerMessage"
          ''',
          'temperature': 0.9,
        },
      );

      if (response.statusCode == 200) {
        return response.data['output'][0]['content'][0]['text'];
      } else {
        throw Exception('Ошибка API: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Ошибка: ${e.response!.statusCode} — ${e.response!.data}');
      } else {
        throw Exception('Сетевая ошибка: ${e.message}');
      }
    }
  }
}
