import 'dart:convert';

import 'package:http/http.dart' as http;

class CoffeeRemoteDataSource {
  static const _baseUrl = 'https://coffee.alexflipnote.dev/random.json';

  Future<String> fetchRandomCoffeeImageUrl() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['file'] as String;
    } else {
      throw Exception('Error fetching coffee image');
    }
  }
}
