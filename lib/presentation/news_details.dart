import 'package:flutter/material.dart';
import 'package:news_app/models/headlines.dart';
import "package:url_launcher/url_launcher.dart";

class NewsDetails extends StatelessWidget {
  final Articles article;
  NewsDetails(this.article);

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Full Story"),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_left,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(8.0),
                      child: Image(
                        image: article.urlToImage == null
                            ? null
                            : NetworkImage(article.urlToImage),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Text(
                              article.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: article.content == null
                                ? Text(
                                    "Oops..No Content!! Sorry for the Inconvinience",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20.0),
                                  )
                                : Text(
                                    article.content,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20.0),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => Container(
                        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 40.0),
                        child: InkWell(
                          onTap: () async {
                            if (await canLaunch(article.url)) {
                              await launch(article.url);
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Some Error Occured')));
                            }
                            //await launch(article.url);
                          },
                          child: Text(
                            "Read More",
                            style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: 15.0),
                          ),
                        )),
                  )
                ],
              ),
            )));
  }
}
