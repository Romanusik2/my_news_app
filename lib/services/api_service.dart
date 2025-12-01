import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ApiService {
  final String apiKey = '7cd2cab6f65449e3b430be883623242e';

  Future<List<Article>> fetchNews() async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
