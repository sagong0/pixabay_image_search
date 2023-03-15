import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search/data/data_source/result.dart';

class PixaBayApi {
  final http.Client client;

  PixaBayApi({
    required this.client,
  });

  static const baseUrl = "https://pixabay.com/api/";
  static const API_KEY = "34258470-cd6b660418d71d69ad9e635e5";

  Future<Result<List>> fetch(String val) async {
    try {
      final response = await client.get(
        Uri.parse("$baseUrl?key=$API_KEY&q=$val&image_type=photo&pretty=true"),
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      List hits = jsonResponse['hits'];

      return Result.success(hits);
    } catch (e) {
      return Result.error('네트워크 에러 : ${e.toString()}');
    }
  }
}
