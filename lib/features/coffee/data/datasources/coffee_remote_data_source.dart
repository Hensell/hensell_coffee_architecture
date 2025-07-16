import 'dart:convert';
import 'package:http/http.dart' as http;

class CoffeeRemoteDataSource {
  CoffeeRemoteDataSource({
    http.Client? client,
    String? baseUrl,
  }) : _client = client ?? http.Client(),
       _baseUrl = baseUrl ?? 'https://coffee.alexflipnote.dev/random.json';

  final http.Client _client;
  final String _baseUrl;

  Future<String> fetchRandomCoffeeImageUrl() async {
    final response = await _client.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['file'] as String;
    } else {
      throw Exception('Error fetching coffee image');
    }
  }
}
