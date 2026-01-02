import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/NewsHome/newslistview.dart';

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  int selectedIndex = 0;

  final List<String> categories = ['all', 'sports', 'recent', 'india'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        elevation: 2,
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index].toUpperCase(),
                        style: TextStyle(
                          color: selectedIndex == index ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: NewsListView(category: categories[selectedIndex]),
          ),
        ],
      ),
    );
  }
}