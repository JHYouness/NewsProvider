import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = 'a449205244554ba39befb5ca6329300a';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<CategoryClase> categories = [
    CategoryClase(icon: FontAwesomeIcons.building, name: 'business'),
    CategoryClase(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    CategoryClase(icon: FontAwesomeIcons.addressCard, name: 'general'),
    CategoryClase(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    CategoryClase(icon: FontAwesomeIcons.vials, name: 'science'),
    CategoryClase(icon: FontAwesomeIcons.volleyball, name: 'sports'),
    CategoryClase(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadLines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this.getArticlesByCategory(valor);

    notifyListeners();
  }

  getTopHeadLines() async {
    final url = '$_URL_NEWS/top-headlines?country=us&apiKey=$_API_KEY';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewSResponse.fromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    final url =
        '$_URL_NEWS/top-headlines?country=us&apiKey=$_API_KEY&category=$selectedCategory';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewSResponse.fromJson(resp.body);

    categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory];
}
