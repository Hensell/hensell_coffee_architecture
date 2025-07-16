import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('https://dummy.test'));
  });

  late MockHttpClient mockHttp;
  late CoffeeRemoteDataSource dataSource;

  setUp(() {
    mockHttp = MockHttpClient();
    dataSource = CoffeeRemoteDataSource(
      client: mockHttp,
    );
  });

  test('returns image url when status code is 200', () async {
    when(() => mockHttp.get(any())).thenAnswer(
      (_) async => http.Response(jsonEncode({'file': 'img.png'}), 200),
    );

    final url = await dataSource.fetchRandomCoffeeImageUrl();

    expect(url, 'img.png');
    verify(() => mockHttp.get(any())).called(1);
  });

  test('throws exception when status code is not 200', () async {
    when(() => mockHttp.get(any())).thenAnswer(
      (_) async => http.Response('error', 500),
    );

    expect(
      () => dataSource.fetchRandomCoffeeImageUrl(),
      throwsA(isA<Exception>()),
    );
    verify(() => mockHttp.get(any())).called(1);
  });
}
