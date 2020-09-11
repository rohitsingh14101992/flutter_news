import 'dart:convert';
import 'dart:io';
import 'package:demo/model/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class NewsRepository {
  Future<NewsResponse> getNews();
}

class NewsRepositoryImpl implements NewsRepository {
  final HttpClient httpClient;
  NewsRepositoryImpl({@required this.httpClient});

  @override
  Future<NewsResponse> getNews() async {
    final response =
        await http.get('http://newsapi.org/v2/everything?q=bitcoin&from=2020-08-11&sortBy=publishedAt&apiKey=');
    if (response.statusCode == 200) {
      return NewsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Something went Wrong');
    }
  }
}