import 'package:flutter/material.dart';
import '../models/article_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(
      appBar: AppBar(title: Text("Article Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              article.urlToImage.isNotEmpty
                  ? Image.network(article.urlToImage)
                  : SizedBox.shrink(),
              SizedBox(height: 10),
              Text(article.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(article.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text(article.content),
            ],
          ),
        ),
      ),
    );
  }
}
