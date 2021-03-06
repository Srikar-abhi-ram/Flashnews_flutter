import 'dart:convert';
import 'package:flashnews/models/ArticleModel.dart';
import "package:http/http.dart" as http;
import 'package:flashnews/use/category_news.dart';

class News{

  List<ArticleModel> news =[];
  Future<void> getNews() async{

    String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=9d752c718f9c4e218d40bb1bca24341b";
    var response =await http.get(Uri.parse(url));
    var jsonData =jsonDecode(response.body);
    if (jsonData['status']=="ok") {
      jsonData["articles"].forEach((element){

          if(element["urlToImage"] != null && element['description'] != null){
            ArticleModel articleModel = ArticleModel(
           title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['context']
            );
            news.add(articleModel);
          }

      });
    }
  }
}

class NewsForCategorie {

  List<ArticleModel> news =[];
  Future<void> getNewsForCategory (String category) async{

    String url = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9d752c718f9c4e218d40bb1bca24341b";
    var response =await http.get(Uri.parse(url));
    var jsonData =jsonDecode(response.body);
    if (jsonData['status']=="ok") {
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['context']
          );
          news.add(articleModel);
        }

      });
    }
  }
}