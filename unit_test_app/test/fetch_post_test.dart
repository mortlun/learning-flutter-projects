import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:unit_test_app/post.dart';
import 'package:matcher/matcher.dart' as matcher;

class MockClient extends Mock implements http.Client {}

void main() {
  group('fetchPost', () {
    test('Returns a post if the http client call completes successfully',
        () async {
      final client = MockClient();

      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
      expect(await fetchPost(client), const matcher.TypeMatcher<Post>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchPost(client), throwsException);
    });
  });
}
