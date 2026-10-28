import 'dart:convert';

import 'package:apipi/article_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Article>> fetchArticles() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=apple&from=2026-10-21&to=2026-10-21&sortBy=popularity&apiKey=a0fa2a6c6bf34652a0d5557bb954ceda',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List articles = json['articles'];

      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil berita');
    }
  }
}