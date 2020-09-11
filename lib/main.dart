import 'package:demo/details/news_details.dart';
import 'package:demo/repository/news_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [
          Provider<NewsRepository>(create: (context) => NewsRepositoryImpl(),),
        ],
     child: MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Home(),
    ));
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('DemoApp')),
      body: NewsList(),
    );
  }
}

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    var newsRepository = Provider.of<NewsRepository>(context);
    return FutureBuilder(
        future: newsRepository.getNews(),
        builder: (BuildContext context, AsyncSnapshot<NewsResponse> data) {
          if (data.hasData) {
            return Container(
              margin: EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: data.data.articles.length,
                  itemBuilder: (BuildContext context, int index) {
                    var article = data.data.articles[index];
                    return ArticleWidget(
                      imageUrl: article.urlToImage,
                      title: article.title,
                      description: article.description,
                      newsUrl: article.url,
                    );
                  }),
            );
          } else if (data.hasError) {
            return Container(
              child: Text('Something Went Wrong'),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class ArticleWidget extends StatelessWidget {
  final String imageUrl, title, description, newsUrl;

  ArticleWidget(
      {@required this.imageUrl,
      @required this.title,
      @required this.description, @required this.newsUrl});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(url: newsUrl)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: size.width,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              description,
              style: TextStyle(color: Colors.black54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
