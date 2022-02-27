import 'dart:math';

import 'package:news_app/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("FetchTopIds return a list of ids", () async {
    // //setup of test case
    // final sum = 1 + 3;
    // //expectation
    // expect(sum, 4);

    final newsApi = NewsApiProvider();
    //it inside of http package. check its testing of api
    //it call the api from NewsApiPrvider. It doesnt call the real api. it calls only inside of this app
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test("FetchTopIds return a list of ids", () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });
    final item = await newsApi.fetchItem(999);
    expect(item!.id, 123);
  });
}
