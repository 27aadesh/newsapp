import 'dart:convert';

import "package:flutter/material.dart";
import 'package:news_app/models/headlines.dart';
import "package:http/http.dart" as http;

import 'news_details.dart';

class HomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Articles> articles;
  List<Articles> articles1;

  @override
  void initState() {
    super.initState();
    getTopHeadlines();
  }

  void getTopHeadlines() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=79783d831f1a4fa0adbb4d71653beb19";
    http.Response response = await http.get(url);
    var mapOfHeadlines = json.decode(response.body);

    Headlines headlines = Headlines.fromJson(mapOfHeadlines);
    setState(() {
      articles = headlines.articles;
      print(articles.length);
      print(articles[0].title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        elevation: 10.0,
        title: Text("Top Headlines"),
        centerTitle: true,
      ),
      body: articles == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                Articles article = articles[index];
                return _getNewsTile(article);
              }),
    );
  }

  Widget _getNewsTile(Articles article) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
          child: ListTile(
        onTap: () {
          print("${article.title} Pressed");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => NewsDetails(article)));
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
            width: 1.0,
            color: Colors.white,
          ))),
          child: Icon(
            Icons.book,
            size: 30.0,
          ),
        ),
        title: article.title == null
            ? Text(
                "Title Not Found",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            : Text(
                article.title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
        // subtitle: article.author==null?Text(""):Text(article.author),
        trailing: Icon(Icons.arrow_right, size: 30.0),
      )),
    );
  }
}
