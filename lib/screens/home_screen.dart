import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/article_model.dart';

class HomeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Top Headlines")),
      body: FutureBuilder<List<Article>>(
        future: apiService.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: article.urlToImage.isNotEmpty
                      ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
                      : Icon(Icons.image_not_supported),
                  title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  subtitle: Text(article.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: article,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
