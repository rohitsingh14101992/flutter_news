import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatefulWidget {
  String url;

  NewsDetails({@required this.url});

  @override
  _NewsDetailsState createState() => _NewsDetailsState(url: url);
}

class _NewsDetailsState extends State<NewsDetails> {
  String url;
  bool isLoading = true;

  _NewsDetailsState({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finished) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
