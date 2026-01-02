import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/NewsHome/newshomepage.dart';

class NewsListView extends StatefulWidget {
  final String category;

  NewsListView({required this.category});

  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  List<dynamic> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  void didUpdateWidget(NewsListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      fetchNews();
    }
  }

  Future<void> fetchNews() async {
    setState(() {
      isLoading = true;
    });

    String category = widget.category == 'all' ? 'general' : widget.category;
    if (widget.category == 'recent') category = 'general';
    if (widget.category == 'india') category = 'general';

    String url = 'https://newsapi.org/v2/everything?q=tesla&from=2025-12-02&sortBy=publishedAt=$category&apiKey=60688457832946d491ba5b2db9258845';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    setState(() {
      articles = data['articles'] ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article['urlToImage'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  child: Image.network(
                    article['urlToImage'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title'] ?? 'No Title',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      article['description'] ?? 'No Description',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      article['source']['name'] ?? 'Unknown Source',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}